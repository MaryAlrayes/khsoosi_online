import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/institute_details/domain/entities/institute_details_entity.dart';

abstract class InstituteDetailsRepo{
 Future<Either<Failure,InstituteDetailsEntity>> getInstituteDetails({required String id});

}
