// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:khosousi_online/core/locator/service_locator.dart';
import 'package:khosousi_online/features/search/domain/entities/teacher_entity.dart';
import 'package:khosousi_online/features/teacher_details/domain/entities/teacher_details_entity.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/details_content_main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:khosousi_online/core/managers/assets_manager.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_expansion_tile.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_rating.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/ui/widgets/sliver_tabbar.dart';
import 'package:khosousi_online/features/teacher_details/presentation/bloc/get_teacher_details_bloc.dart';
import 'package:khosousi_online/features/teacher_details/presentation/screens/youtube_screen.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/about_teacher.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/certificates.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/courses.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/educational_services.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/rates.dart';
import 'package:khosousi_online/features/teacher_details/presentation/widgets/recorded_explanations.dart';

import '../widgets/teacher_details.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;

class TeacherDetailsScreen extends StatefulWidget {
  static const routeName = 'teacher_details_screen';
 final TeacherEntity teacherEntity;
  const TeacherDetailsScreen({
    Key? key,
    required this.teacherEntity,
  }) : super(key: key);

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen>
    {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _getBloc(),
      child: Builder(builder: (context) {
        return BlocBuilder<GetTeacherDetailsBloc, GetTeacherDetailsState>(
          builder: (context, state) {
            if (state is GetTeacherDetailsLoading ||
                state is GetTeacherDetailsInitial)
              return _buildLoading();
            else if (state is GetGetTeacherDetailsLoadedNoInternet) {
              return _buildOffline(context);
            } else if (state is GetGetTeacherDetailsLoadedNetworkError) {
              return _buildError(state, context);
            } else if (state is GetTeacherDetailsLoaded) {
              return _buildMainContent(state.teacherDetailsEntity);
            } else {
              return Container();
            }
          },
        );
      }),
    );
  }

  GetTeacherDetailsBloc _getBloc() => sl.locator<GetTeacherDetailsBloc>()..add(LoadTeacherDetails(id: widget.teacherEntity.id));

  Widget _buildLoading() {
    return Scaffold(
      appBar: AppBar(title: Text(widget.teacherEntity.name),),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildError(
      GetGetTeacherDetailsLoadedNetworkError state, BuildContext context) {
    return Scaffold(
           appBar: AppBar(title: Text(widget.teacherEntity.name),),
      body: Center(
        child: NetworkErrorWidget(
          message: state.message,
          onPressed: () {
            BlocProvider.of<GetTeacherDetailsBloc>(context)
                .add(LoadTeacherDetails(id: widget.teacherEntity.id));
          },
        ),
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Scaffold(
           appBar: AppBar(title: Text(widget.teacherEntity.name),),
      body: Center(
        child: NoConnectionWidget(
          onPressed: () {
            BlocProvider.of<GetTeacherDetailsBloc>(context)
                .add(LoadTeacherDetails(id: widget.teacherEntity.id));
          },
        ),
      ),
    );
  }
 Widget _buildMainContent(TeacherDetailsEntity teacherDetailsEntity) {
    return DetailsContentMain(teacherDetailsEntity: teacherDetailsEntity);

    }

}
