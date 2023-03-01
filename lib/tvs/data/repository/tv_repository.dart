import 'package:movies_pro/core/error/error_network/repository/server_exception.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_pro/tvs/data/datasource/base_remote_data_tv_source.dart';
import 'package:movies_pro/tvs/domain/entities/tv.dart';
import 'package:movies_pro/tvs/domain/repository/base_tv_repository.dart';

class TVsRepository implements BaseTVsRepository {
  final BaseRemoteTVsDataSource _baseRemoteTVsDataSource;

  TVsRepository(this._baseRemoteTVsDataSource);

  @override
  Future<Either<ServerFailure, TVs>> getNowPlayingTVs() async {
    final response = await _baseRemoteTVsDataSource.getNowPlayingTVs();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }

  @override
  Future<Either<ServerFailure, TVs>> getPopularTVs() async {
    final response = await _baseRemoteTVsDataSource.getPopularTVs();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }

  @override
  Future<Either<ServerFailure, TVs>> getTopRatedTVs() async {
    final response = await _baseRemoteTVsDataSource.getTopRatedTVs();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }
}
