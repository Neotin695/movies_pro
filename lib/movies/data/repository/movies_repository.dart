import 'package:movies_pro/core/error/error_network/repository/server_exception.dart';
import 'package:movies_pro/movies/data/datasource/base_remote_data_source.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_pro/movies/domain/repository/base_movies_repository.dart';

class MoviesRepository implements BaseMoviesRepository {
  final BaseRemoteMoviesDataSource baseRemoteMoviesDataSource;

  MoviesRepository(this.baseRemoteMoviesDataSource);

  @override
  Future<Either<ServerFailure, Movie>> getNowPlayingTVs() async {
    final response = await baseRemoteMoviesDataSource.getNowPlayingMovies();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }

  @override
  Future<Either<ServerFailure, Movie>> getPopularMovies() async {
    final response = await baseRemoteMoviesDataSource.getPopularMovies();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }

  @override
  Future<Either<ServerFailure, Movie>> getTopRatedMovies() async {
    final response = await baseRemoteMoviesDataSource.getTopRatedMovies();
    try {
      return Right(response);
    } on ServerExceptionRepository catch (failure) {
      return Left(ServerFailure(failure.errorMessage.statusMessage));
    }
  }
}
