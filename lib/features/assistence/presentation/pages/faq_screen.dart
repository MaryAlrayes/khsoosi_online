import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/app_drop_down.dart';
import 'package:khosousi_online/core/ui/widgets/custom_chip_item.dart';
import 'package:khosousi_online/core/ui/widgets/custom_expansion_tile.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/ui/widgets/custom_read_text.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/ui/widgets/error_widget.dart';
import 'package:khosousi_online/core/ui/widgets/no_connection_widget.dart';
import 'package:khosousi_online/core/utils/extensions/extensions.dart';
import 'package:khosousi_online/core/utils/helpers/html_parser.dart';
import 'package:khosousi_online/features/assistence/presentation/bloc/get_faq_bloc.dart';

import '../../../../core/utils/enums/enums.dart';

class FAQScreen extends StatelessWidget {
  static const routeName = 'faq_screen';
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetFaqBloc>()..add(LoadFAQEvent()),
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
        BlocProvider.of<GetFaqBloc>(context).add(LoadFAQEvent());
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetFaqBloc>(context).add(LoadFAQEvent());
      },
    );
  }

  Widget _buildContent(GetFaqState state, BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: CustomTextField(
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.text,
                iconData: Icon(Icons.search),
                validator: (value) {},
                isObscure: false,
                hintText: 'ابحث عن السؤال...',
                onChanged: (value) {
                  BlocProvider.of<GetFaqBloc>(context)
                      .add(FilterQuestionBasedOnKeywordEvent(keyword: value));
                },
              ),
            ),
            SizedBox(
              width: 4,
            ),
            SizedBox(
              height: 55,
              width: 125,
              child: AppDropDown<FAQUserType>(
                  hintText: 'اختر',
                  items: FAQUserType.values
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FittedBox(
                                child: Text(
                                  e.getTextForDispalay(),
                                  style: TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  initSelectedValue: FAQUserType.both,
                  onChanged: (value) {
                    BlocProvider.of<GetFaqBloc>(context).add(
                        FilterQuestionBasedOnTypeEvent(faqUserType: value));
                  }),
            )
          ]),
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            primary: false,
            itemCount: state.filteredData.length,
            separatorBuilder: (context, index) => Divider(
              height: 4,
            ),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomExpansionTile(
                titleWidget: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(state.data[index].title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12)),
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
        ],
      ),
    );
  }
}
