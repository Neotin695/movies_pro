import 'package:dartz/dartz.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';

abstract class BaseUseCases<T> {
  Future<Either<ServerFailure, T>> call();
}
