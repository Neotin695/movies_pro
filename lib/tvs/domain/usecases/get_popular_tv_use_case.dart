import 'package:dartz/dartz.dart';
import 'package:movies_pro/core/usecases/base_use_case.dart';
import 'package:movies_pro/tvs/domain/repository/base_tv_repository.dart';

import '../../../core/error/error_network/repository/failure.dart';
import '../entities/tv.dart';

class GetPopularTVsUsecase implements BaseUseCases<TVs> {
  final BaseTVsRepository _baseTVsRepository;

  GetPopularTVsUsecase(this._baseTVsRepository);

  @override
  Future<Either<ServerFailure, TVs>> call() async {
    return await _baseTVsRepository.getPopularTVs();
  }
}
