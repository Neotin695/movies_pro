import 'package:dartz/dartz.dart';
import 'package:movies_pro/core/usecases/base_use_case.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';
import 'package:movies_pro/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/error_network/repository/failure.dart';

class GetNowPlayingMoviesUseCase implements BaseUseCases<Movie> {
  final BaseMoviesRepository baseMoviesRepository;

  GetNowPlayingMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<ServerFailure, Movie>> call() async {
    return await baseMoviesRepository.getNowPlayingTVs();
  }
}
