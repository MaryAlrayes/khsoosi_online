import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/managers/endpoints_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/core/ui/widgets/custom_text_field.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:khosousi_online/core/utils/enums/enums.dart';
import 'package:khosousi_online/core/utils/helpers/date_formatter.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/assistence/presentation/bloc/get_support_messages_bloc.dart';

import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../widgets/send_message_support.dart';
import '../widgets/support_message.dart';

class PersonalAssistenceScreen extends StatelessWidget {
  static const routeName = 'personal_assistence_screen';
  const PersonalAssistenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.locator<GetSupportMessagesBloc>()
        ..add(FetchSupportMessagesEvent(
            refresh: true, userId: context.read<AuthRepo>().getUserId()!)),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('مساعدك الشخصي من خصوصي اونلاين'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  BlocBuilder<GetSupportMessagesBloc, GetSupportMessagesState>(
                builder: (context, state) {
                  switch (state.status) {
                    case GetSupportMessagesStatus.loading:
                      return _buildLoading();
                    case GetSupportMessagesStatus.loadingMore:
                    case GetSupportMessagesStatus.success:
                      return _buildContent(state, context);
                    case GetSupportMessagesStatus.offline:
                      return _buildOffline(context);
                    case GetSupportMessagesStatus.error:
                      return _buildError(state, context);
                  }
                },
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildLoadMoreBtn(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: TextButton(
            style: TextButton.styleFrom(foregroundColor: ColorManager.blue2),
            onPressed: () {
              context.read<GetSupportMessagesBloc>().add(
                  FetchSupportMessagesEvent(
                      userId: context.read<AuthRepo>().getUserId()!));
            },
            child: Text(
              'اعرض رسائل أقدم',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildContent(GetSupportMessagesState state, BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          reverse: true,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                !state.hasReachedMax
                    ? state.status == GetSupportMessagesStatus.success
                        ? _buildLoadMoreBtn(context)
                        : Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: const CircularProgressIndicator(),
                            ),
                          )
                    : Container(),
                SizedBox(
                  height: 8,
                ),
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  reverse: true,
                  itemBuilder: (context, index) {
                    return SupportMessage(
                      supportMessageEntity: state.data[index],
                      sendingNow: state.data[index].sendingNow,
                      submitStatus: state.submitStatus,
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16,
                  ),
                  itemCount: state.data.length,
                ),
              ],
            ),
          ),
        )),
        Divider(
          height: 1,
          color: ColorManager.gray4.withOpacity(0.2),
        ),
        SendMessageSupport()
      ],
    );
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  NetworkErrorWidget _buildError(
      GetSupportMessagesState state, BuildContext context) {
    return NetworkErrorWidget(
      message: state.errorMessage,
      onPressed: () {
        BlocProvider.of<GetSupportMessagesBloc>(context).add(
            FetchSupportMessagesEvent(
                refresh: true, userId: context.read<AuthRepo>().getUserId()!));
      },
    );
  }

  NoConnectionWidget _buildOffline(BuildContext context) {
    return NoConnectionWidget(
      onPressed: () {
        BlocProvider.of<GetSupportMessagesBloc>(context).add(
            FetchSupportMessagesEvent(
                refresh: true, userId: context.read<AuthRepo>().getUserId()!));
      },
    );
  }
}
