// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/courses_services_portofolio_details/presentation/portofolio/bloc/get_portofolio_details_bloc.dart';

import '../../../../../core/ui/widgets/custom_chip_item.dart';
import '../../../../../core/ui/widgets/custom_image.dart';
import '../../../../../core/ui/widgets/custom_rating.dart';
import '../../../../../core/ui/widgets/custom_read_text.dart';
import '../../../../../core/ui/widgets/error_widget.dart';
import '../../../../../core/ui/widgets/no_connection_widget.dart';
import '../../../../../core/utils/helpers/date_formatter.dart';
import '../../../../teacher_details/presentation/widgets/youtube_section.dart';
import '../../../domain/entities/portofolio_details_entity.dart';
import '../widgets/like_dislike_buttons.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class PortofolioDetailsScreen extends StatelessWidget {
  final String id;
  static const routeName = 'poroflio_details_screen';

  const PortofolioDetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetPortofolioDetailsBloc>()
        ..add(
          GetDetailsEvent(
            id: id,
          ),
        ),
      child: Builder(builder: (context) {
        return BlocBuilder<GetPortofolioDetailsBloc, GetPortofolioDetailsState>(
          builder: (context, state) {
            if (state is GetPortofolioDetailsLoading ||
                state is GetPortofolioDetailsInitial)
              return _buildLoading();
            else if (state is GetPortofolioDetailsNoInternet) {
              return _buildOffline(context);
            } else if (state is GetPortofolioDetailsNetworkError) {
              return _buildError(state, context);
            } else if (state is GetPortofolioDetailsLoaded) {
              return _buildMainContent(state.portofolioDetailsEntity);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(
      GetPortofolioDetailsNetworkError state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NetworkErrorWidget(
          message: state.message,
          onPressed: () {
            BlocProvider.of<GetPortofolioDetailsBloc>(context).add(
              GetDetailsEvent(
                id: id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: NoConnectionWidget(
          onPressed: () {
            BlocProvider.of<GetPortofolioDetailsBloc>(context).add(
              GetDetailsEvent(
                id: id,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(PortofolioDetailsEntity portofolioDetailsEntity) {
    return Scaffold(
      appBar: AppBar(
        title: Text(portofolioDetailsEntity.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (portofolioDetailsEntity.videoLink.isNotEmpty)
                      _buildYoutube(portofolioDetailsEntity),
                    SizedBox(
                      height: 16,
                    ),
                    _buildTitle(portofolioDetailsEntity),
                    SizedBox(
                      height: 8,
                    ),
                    _buildDate(portofolioDetailsEntity),
                    SizedBox(
                      height: 16,
                    ),
                    _buildCategories(portofolioDetailsEntity),
                    SizedBox(
                      height: 16,
                    ),
                    _buildDescription(portofolioDetailsEntity),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(),
                    _buildTeacherName(portofolioDetailsEntity),
                    Divider(),
                    SizedBox(
                      height: 16,
                    ),
                    _buildLikesDislikes(portofolioDetailsEntity),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLikesDislikes(PortofolioDetailsEntity portofolioDetailsEntity) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('هل كان الشرح مفيد؟'),
          SizedBox(
            height: 16,
          ),
          LikeDislikeButtons(
              likes: portofolioDetailsEntity.likes,
              dislikes: portofolioDetailsEntity.dislikes)
        ],
      );

  CustomReadMoreText _buildDescription(
      PortofolioDetailsEntity portofolioDetailsEntity) {
    return CustomReadMoreText(
      text: CustomHtmlParser.parseHtml(
        portofolioDetailsEntity.description,
      ),
      trimLines: 5,
    );
  }

  Container _buildCategories(PortofolioDetailsEntity portofolioDetailsEntity) {
    return Container(
      height: 30,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) => getGrayChip(
            text: portofolioDetailsEntity.categories[i].nameAr +
                ' | ' +
                portofolioDetailsEntity.categories[i].nameEn),
        separatorBuilder: (context, index) => SizedBox(
          width: 8,
        ),
        itemCount: portofolioDetailsEntity.categories.length,
      ),
    );
  }

  Text _buildDate(PortofolioDetailsEntity portofolioDetailsEntity) =>
      Text(DateFormatter.getFormatedDate(portofolioDetailsEntity.date),
          style: TextStyle(fontSize: 12));

  Text _buildTitle(PortofolioDetailsEntity portofolioDetailsEntity) {
    return Text(
      portofolioDetailsEntity.title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Row _buildTeacherName(PortofolioDetailsEntity portofolioDetailsEntity) {
    return Row(
      children: [
        CustomImage(
          image: portofolioDetailsEntity.teacherImage,
          isCircle: true,
          radius: 25,
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(portofolioDetailsEntity.teacherName),
              SizedBox(
                height: 4,
              ),
              _buildRate(portofolioDetailsEntity)
            ],
          ),
        )
      ],
    );
  }

  YoutubeSection _buildYoutube(
      PortofolioDetailsEntity portofolioDetailsEntity) {
    return YoutubeSection(
      youtube: portofolioDetailsEntity.videoLink,
    );
  }

  Widget _buildRate(PortofolioDetailsEntity portofolioDetailsEntity) {
    return portofolioDetailsEntity.averageRate != null
        ? CustomRating(
            initRating: portofolioDetailsEntity.averageRate!,
            update: false,
            showRateText: true,
          )
        : Text(
            'لا يوجد تقييم',
            style: TextStyle(fontSize: 12, fontFamily: 'Roboto'),
          );
  }
}
