import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/teacher_balance/domain/entities/teacher_balance_entity.dart';
import 'package:khosousi_online/features/teacher_courses/domain/entities/teacher_course_entity.dart';
import 'package:khosousi_online/features/teacher_services/domain/entities/teacher_service_entity.dart';

import '../entities/notification_entity.dart';

abstract class NotificationRepo {
 Future<Either<Failure,List< NotificationEntity>>> getNotification(
      {required String userId});
}
