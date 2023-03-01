import 'package:dartz/dartz.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';
import 'package:movies_pro/movies/domain/repository/base_movies_repository.dart';

import '../../../core/error/error_network/repository/failure.dart';
import '../../../core/usecases/base_use_case.dart';

class GetTopRatedMoviesUseCase implements BaseUseCases<Movie> {
  final BaseMoviesRepository baseMoviesRepository;

  GetTopRatedMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<ServerFailure, Movie>> call() async {
    return await baseMoviesRepository.getTopRatedMovies();
  }
}
