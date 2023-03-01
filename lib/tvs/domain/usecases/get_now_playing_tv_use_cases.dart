import 'package:dartz/dartz.dart';

import '../../../core/error/error_network/repository/failure.dart';
import '../../../core/usecases/base_use_case.dart';
import '../entities/tv.dart';
import '../repository/base_tv_repository.dart';

class GetNowPlayingTVsUseCase implements BaseUseCases<TVs> {
  final BaseTVsRepository baseTVsRepository;

  GetNowPlayingTVsUseCase(this.baseTVsRepository);

  @override
  Future<Either<ServerFailure, TVs>> call() async {
    return await baseTVsRepository.getNowPlayingTVs();
  }
}
