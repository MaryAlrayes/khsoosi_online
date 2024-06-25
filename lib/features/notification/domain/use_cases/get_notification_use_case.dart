// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';
import '../repositories/notification_repo.dart';

class GetNotificationUseCase {
  final NotificationRepo notificationRepo;
  GetNotificationUseCase({
    required this.notificationRepo,
  });

  Future<Either<Failure, List<NotificationEntity>>> call(
      {required String userId}) async {
    final res = await notificationRepo.getNotification(userId: userId);
    return res.fold((f) => Left(f), (r) => Right(r));
  }
}
