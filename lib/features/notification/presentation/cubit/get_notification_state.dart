// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_notification_cubit.dart';

enum GetNotificationStatus { init, loading, loaded, noInternet, networkError }

class GetNotificationState extends Equatable {
  final List<NotificationEntity> notifications;
  final int newNotificationsNumber;
  final GetNotificationStatus status;
  final String errorMessage;
  const GetNotificationState({
    required this.notifications,
    required this.newNotificationsNumber,
    required this.status,
    required this.errorMessage,
  });
  factory GetNotificationState.empty() {
    return GetNotificationState(
        notifications: [],
        status: GetNotificationStatus.init,
        newNotificationsNumber:0,
        errorMessage: '');
  }

  @override
  List<Object> get props => [notifications, status,errorMessage,newNotificationsNumber];



  GetNotificationState copyWith({
    List<NotificationEntity>? notifications,
    int? newNotificationsNumber,
    GetNotificationStatus? status,
    String? errorMessage,
  }) {
    return GetNotificationState(
      notifications: notifications ?? this.notifications,
      newNotificationsNumber: newNotificationsNumber ?? this.newNotificationsNumber,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
