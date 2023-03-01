// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:movies_pro/core/utils/tools/enum_state.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';

class MoviesState {
  final RequestState requestState;
  final Movie? movie;
  final String? errorMessage;
  MoviesState({
    required this.requestState,
    this.movie,
    this.errorMessage,
  });
}
