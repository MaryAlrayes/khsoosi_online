// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/notification/domain/entities/notification_entity.dart';
import 'package:khosousi_online/features/teacher_balance/domain/entities/teacher_balance_entity.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';

import '../../../../core/api_service/base_repo.dart';
import '../../domain/repositories/notification_repo.dart';
import '../data_sources/notification_data_provider.dart';

class NotificationRepoImpl implements NotificationRepo {
final NotificationDataProvider notificationDataProvider;
  NotificationRepoImpl({
    required this.notificationDataProvider,
  });
  Future<Either<Failure,List< NotificationEntity>>> getNotification(
      {required String userId})async{
 final data = await BaseRepo.repoRequest(
      request: () async {
        return await notificationDataProvider.getNotification(userId: userId);
      },
    );
    return data.fold((f) => Left(f), (data) => Right(data));

      }
}
