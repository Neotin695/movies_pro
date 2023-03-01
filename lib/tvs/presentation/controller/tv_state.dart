import 'package:equatable/equatable.dart';

import '../../../core/utils/tools/enum_state.dart';
import '../../domain/entities/tv.dart';

class TVsState extends Equatable {
  final TVs tv;
  final RequestState tvState;
  final String errorMessage;
  const TVsState({
    this.tv = const TVs(results: []),
    this.tvState = RequestState.loading,
    this.errorMessage = '',
  });

  @override
  List<Object?> get props => [
        tv,
        tvState,
        errorMessage,
      ];
}
