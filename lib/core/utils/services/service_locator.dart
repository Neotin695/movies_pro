import 'package:get_it/get_it.dart';
import 'package:movies_pro/movies/data/datasource/base_remote_data_source.dart';
import 'package:movies_pro/movies/data/repository/movies_repository.dart';
import 'package:movies_pro/movies/domain/repository/base_movies_repository.dart';
import 'package:movies_pro/movies/domain/usecases/get_popular_usecase.dart';
import 'package:movies_pro/movies/domain/usecases/get_top_rated_movie_usecase.dart';
import 'package:movies_pro/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_pro/tvs/domain/usecases/get_now_playing_tv_use_cases.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_bloc.dart';

import '../../../movies/domain/usecases/get_now_playing_usecases.dart';
import '../../../tvs/data/datasource/base_remote_data_tv_source.dart';
import '../../../tvs/data/repository/tv_repository.dart';
import '../../../tvs/domain/repository/base_tv_repository.dart';
import '../../../tvs/domain/usecases/get_popular_tv_use_case.dart';
import '../../../tvs/domain/usecases/get_top_rated_tv_use_case.dart';

final serviceLocator = GetIt.instance;

class ServiceLocator {
  void init() {
    serviceLocator.registerFactory(
        () => MoviesBloc(serviceLocator(), serviceLocator(), serviceLocator()));
    serviceLocator.registerFactory(
        () => TVsBloc(serviceLocator(), serviceLocator(), serviceLocator()));

    // movie use case
    serviceLocator.registerLazySingleton(
        () => GetNowPlayingMoviesUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetPopularMoviesUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton(
        () => GetTopRatedMoviesUseCase(serviceLocator()));

    // tv movie use vase
    serviceLocator
        .registerLazySingleton(() => GetNowPlayingTVsUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetPopularTVsUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetTopRatedTVsUseCase(serviceLocator()));

    //REPOSITORY
    serviceLocator.registerLazySingleton<BaseMoviesRepository>(
        () => MoviesRepository(serviceLocator()));

    //DATA SOURCE
    serviceLocator.registerLazySingleton<BaseRemoteMoviesDataSource>(
        () => MoviesRemoteDataSource());

    
    serviceLocator.registerLazySingleton<BaseTVsRepository>(
        () => TVsRepository(serviceLocator()));

    //DATA SOURCE
    serviceLocator.registerLazySingleton<BaseRemoteTVsDataSource>(
        () => TVsRemoteDataSource());
  }
}
