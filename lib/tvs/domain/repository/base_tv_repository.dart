import 'package:dartz/dartz.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:movies_pro/tvs/domain/entities/tv.dart';

abstract class BaseTVsRepository {
  Future<Either<ServerFailure, TVs>> getNowPlayingTVs();
  Future<Either<ServerFailure, TVs>> getPopularTVs();
  Future<Either<ServerFailure, TVs>> getTopRatedTVs();
}
