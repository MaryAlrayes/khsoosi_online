// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:khosousi_online/core/errors/failures.dart';
import 'package:khosousi_online/features/accounts/domain/entities/teacher_contact_info_entity.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/accounts_repo.dart';
import 'package:khosousi_online/features/accounts/domain/repositories/auth_repo.dart';
import 'package:khosousi_online/features/location/domain/entities/coords_entity.dart';
import 'package:khosousi_online/features/location/domain/repositories/location_repo.dart';

class SubmitLocationUseCase {
  final LocationRepo locationRepo;
  final AuthRepo authRepo;

  SubmitLocationUseCase({
    required this.locationRepo,
    required this.authRepo,
  });

  Future<Either<Failure, Unit>> call(
      {required CoordsEntity coords, required String userId}) async {
    final res = await locationRepo.addLocation(coords: coords, userId: userId);
    return res.fold((f) => Left(f), (r) async {
      await authRepo.updateLocationState(lat: coords.lat, lng: coords.lng);
      return Right(r);
    });
  }
}
