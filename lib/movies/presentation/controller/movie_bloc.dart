import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:movies_pro/core/utils/tools/enum_state.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';
import 'package:movies_pro/movies/domain/usecases/get_now_playing_usecases.dart';
import 'package:movies_pro/movies/domain/usecases/get_popular_usecase.dart';
import 'package:movies_pro/movies/domain/usecases/get_top_rated_movie_usecase.dart';
import 'package:movies_pro/movies/presentation/controller/movie_event.dart';
import 'movie_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final GetNowPlayingMoviesUseCase _getNowPlayingMoviesUseCase;
  final GetPopularMoviesUsecase _getPopularMoviesUsecase;
  final GetTopRatedMoviesUseCase _getTopRatedMoviesUseCase;
  MoviesBloc(
    this._getNowPlayingMoviesUseCase,
    this._getPopularMoviesUsecase,
    this._getTopRatedMoviesUseCase,
  ) : super(MoviesState(requestState: RequestState.loading)) {
    on<GetNowPlayingMoviesEvent>(_getNowPlayingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
  }

  FutureOr<void> _getTopRatedMovies(event, emit) async {
    final result = await _getTopRatedMoviesUseCase();

    handleResultAndEmit(result, emit);
  }

  FutureOr<void> _getPopularMovies(event, emit) async {
    final result = await _getPopularMoviesUsecase();

    handleResultAndEmit(result, emit);
  }

  FutureOr<void> _getNowPlayingMovies(event, emit) async {
    final result = await _getNowPlayingMoviesUseCase();

    handleResultAndEmit(result, emit);
  }

  void handleResultAndEmit(Either<ServerFailure, Movie> result, emit) {
    result.fold(
      (l) => emit(
        MoviesState(errorMessage: l.message, requestState: RequestState.error),
      ),
      (r) => emit(
        MoviesState(
          movie: r,
          requestState: RequestState.loaded,
        ),
      ),
    );
  }
}
