import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:khosousi_online/core/errors/failures.dart';

class RefreshAccountUseCase {
  Future<Either<Failure, Unit>> call() async {

   await Future.delayed(const Duration(seconds:5), () async {
      final res = await Future<Either<Failure, Unit>>.value(Right(unit));
      return res.fold((l) => Left(l), (r) => Right(r));
    });
    return Right(unit);
  }
}
