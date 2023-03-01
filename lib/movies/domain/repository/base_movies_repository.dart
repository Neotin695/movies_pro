import 'package:dartz/dartz.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';

abstract class BaseMoviesRepository {
  Future<Either<ServerFailure, Movie>> getNowPlayingTVs();
  Future<Either<ServerFailure, Movie>> getPopularMovies();
  Future<Either<ServerFailure, Movie>> getTopRatedMovies();
}
