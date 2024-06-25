import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_expansion_tile.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/assistence/presentation/bloc/get_faq_bloc.dart';

class FAQScreen extends StatelessWidget {
  static const routeName = 'faq_screen';
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl.locator<GetFaqBloc>()..add(LoadFAQEvent(refresh: true)),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('الأسئلة الأكثر شيوعا'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<GetFaqBloc, GetFaqState>(
              builder: (context, state) {
                switch (state.status) {
                  case GetFaqStatus.loading:
                    return _buildLoading();
                  case GetFaqStatus.loadingMore:
                  case GetFaqStatus.success:
                    return _buildContent(state, context);
                  case GetFaqStatus.offline:
                    return _buildOffline(context);
                  case GetFaqStatus.error:
                    return _buildError(state, context);
                }
              },
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  NetworkErrorWidget _buildError(GetFaqState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetFaqBloc>(context).add(LoadFAQEvent(
          refresh: true,
        ));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetFaqBloc>(context).add(LoadFAQEvent(
          refresh: true,
        ));
      },
    );
  }

  Widget _buildLoadMoreBtn(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: TextButton(
            onPressed: () {
              context.read<GetFaqBloc>().add(
                    LoadFAQEvent(),
                  );
            },
            child: Text(
              'تحميل المزيد',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 70,
        )
      ],
    );
  }

  Widget _buildContent(GetFaqState state, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            itemCount: state.data.length,
            separatorBuilder: (context, index) => Divider(
              height: 4,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical:  8.0),
              child: CustomExpansionTile(
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    // CustomChipItem(
                    //   backgroundColor: ColorManager.green1,
                    //   foregroundColor: Colors.white,
                    //   label: state.data[index].type.getTextForDispalay(),
                    // ),
                    // SizedBox(
                    //   height:8,
                    // ),
                    Text(state.data[index].title,
                        style:
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                  ],
                ),
                children: [
                  CustomReadMoreText(
                    text: CustomHtmlParser.parseHtml(state.data[index].details),
                    trimLines: 4,
                  )
                ],
              ),
            ),
          ),
          !state.hasReachedMax
              ? state.status == GetFaqStatus.success
                  ? _buildLoadMoreBtn(context)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const CircularProgressIndicator(),
                      ),
                    )
              : Container()
        ],
      ),
    );
  }
}
