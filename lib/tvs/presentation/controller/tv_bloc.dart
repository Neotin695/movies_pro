import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/core/error/error_network/repository/failure.dart';
import 'package:movies_pro/core/utils/tools/enum_state.dart';
import 'package:movies_pro/tvs/domain/entities/tv.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_event.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_state.dart';

import '../../domain/usecases/get_now_playing_tv_use_cases.dart';
import '../../domain/usecases/get_popular_tv_use_case.dart';
import '../../domain/usecases/get_top_rated_tv_use_case.dart';

class TVsBloc extends Bloc<TVsEvent, TVsState> {
  final GetNowPlayingTVsUseCase _getNowPlayingTVsUseCase;
  final GetPopularTVsUsecase _getPopularTVsUsecase;
  final GetTopRatedTVsUseCase _getTopRatedTVsUseCase;
  TVsBloc(
    this._getNowPlayingTVsUseCase,
    this._getPopularTVsUsecase,
    this._getTopRatedTVsUseCase,
  ) : super(const TVsState()) {
    on<GetNowPlayingTVsEvent>(_getNowPlayingTVs);

    on<GetPopularTVsEvent>(_getPopularTVs);

    on<GetTopRatedTVsEvent>(_getTopRatedTVs);
  }

  FutureOr<void> _getTopRatedTVs(event, emit) async {
    final result = await _getTopRatedTVsUseCase();

    handleResultAndEmit(result, emit);
  }

  FutureOr<void> _getPopularTVs(event, emit) async {
    final result = await _getPopularTVsUsecase();

    handleResultAndEmit(result, emit);
  }

  FutureOr<void> _getNowPlayingTVs(event, emit) async {
    final result = await _getNowPlayingTVsUseCase();

    handleResultAndEmit(result, emit);
  }

  void handleResultAndEmit(Either<ServerFailure, TVs> result, emit) {
    result.fold(
      (l) => emit(
        TVsState(errorMessage: l.message, tvState: RequestState.error),
      ),
      (r) => emit(
        TVsState(
          tv: r,
          tvState: RequestState.loaded,
        ),
      ),
    );
  }
}
