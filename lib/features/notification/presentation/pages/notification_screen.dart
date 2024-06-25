import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:khosousi_online/core/managers/color_manager.dart';
import 'package:khosousi_online/core/ui/widgets/custom_app_bar.dart';
import 'package:khosousi_online/core/ui/widgets/custom_image.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/notification/presentation/cubit/get_notification_cubit.dart';
import 'package:khosousi_online/features/notification/presentation/widgets/notification_item1.dart';
import 'package:khosousi_online/core/locator/service_locator.dart' as sl;
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/ui/widgets/error_widget.dart';
import '../../../../core/ui/widgets/no_connection_widget.dart';
import '../../domain/entities/notification_entity.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppbar(context),
          body: SafeArea(
            child: BlocBuilder<GetNotificationCubit, GetNotificationState>(
              builder: (context, state) {
                if (state.status == GetNotificationStatus.loading ||
                    state.status== GetNotificationStatus.init)
                  return _buildLoading();
                else if (state.status == GetNotificationStatus.noInternet) {
                  return _buildOffline(context);
                } else if (state.status == GetNotificationStatus.networkError) {
                  return _buildError(state, context);
                } else if (state.status == GetNotificationStatus.loaded) {
                  return _buildContent(state.notifications, context);
                } else {
                  return Container();
                }
              },
            ),
          ));
    });
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(GetNotificationState state, BuildContext context) {
    return Center(
      child: NetworkErrorWidget(
        message: state.errorMessage,
        onPressed: () {
          BlocProvider.of<GetNotificationCubit>(context)
              .fetchNotification(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }

  Widget _buildOffline(BuildContext context) {
    return Center(
      child: NoConnectionWidget(
        onPressed: () {
          BlocProvider.of<GetNotificationCubit>(context)
              .fetchNotification(userId: context.read<AuthRepo>().getUserId()!);
        },
      ),
    );
  }
}

Widget _buildContent(
    List<NotificationEntity> notifications, BuildContext context) {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  return SmartRefresher(
    controller: _refreshController,
    enablePullDown: true,
    enablePullUp: true,
    header: WaterDropHeader(waterDropColor: ColorManager.orange,),
    onRefresh: () async {
      BlocProvider.of<GetNotificationCubit>(context)
          .fetchNotification(userId: context.read<AuthRepo>().getUserId()!);
      _refreshController.loadComplete();
    },
    child: ListView.separated(
        itemBuilder: (context, index) {
          return NotificationItem1(
            notificationEntity: notifications[index],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 0,
          );
        },
        itemCount: notifications.length),
  );
}

PreferredSizeWidget _buildAppbar(BuildContext context) {
  return getCustomAppBar(context: context);
}
