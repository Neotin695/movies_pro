import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/core/utils/tools/enum_state.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movies_pro/core/utils/services/service_locator.dart';
import 'package:movies_pro/movies/domain/entities/movie.dart';
import 'package:movies_pro/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_pro/movies/presentation/controller/movie_event.dart';
import 'package:movies_pro/movies/presentation/controller/movie_state.dart';

import '../../data/models/now_playing_movie_model.dart';

class TopRatedMovies extends StatelessWidget {
  const TopRatedMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return serviceLocator<MoviesBloc>()..add(GetTopRatedMoviesEvent());
      },
      child: BlocBuilder<MoviesBloc, MoviesState>(
        buildWhen: ((previous, current) =>
            previous.requestState != current.requestState),
        builder: (_, state) {
          switch (state.requestState) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              return SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: handleLength(state),
                  itemBuilder: (_, index) {
                    Results result = state.movie!.results[index];
                    return InkWell(
                      onTap: goToDetailsScreen,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                width: 120,
                                height: 170,
                                fit: BoxFit.cover,
                                imageUrl: MovieModel.backdropPathImage(
                                    result.backdropPath),
                                placeholder: (_, __) => Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170.0,
                                    width: 120.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(result.voteAverage.toString())
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            case RequestState.error:
              return const Text('something wont worng');
          }
        },
      ),
    );
  }

  void goToDetailsScreen() {}

  int handleLength(MoviesState state) {
    if (state.movie!.results.length >= 20) {
      return state.movie!.results.length - 10;
    } else {
      return state.movie!.results.length;
    }
  }
}
