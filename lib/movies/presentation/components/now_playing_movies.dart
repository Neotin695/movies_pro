import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/movies/data/models/now_playing_movie_model.dart';
import 'package:movies_pro/movies/presentation/controller/movie_bloc.dart';
import 'package:movies_pro/movies/presentation/controller/movie_event.dart';
import 'package:movies_pro/movies/presentation/controller/movie_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/tools/enum_state.dart';
import '../../../core/utils/services/service_locator.dart';

class NowPlayingMovies extends StatelessWidget {
  const NowPlayingMovies({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return serviceLocator<MoviesBloc>()..add(GetNowPlayingMoviesEvent());
      },
      child: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: ((previous, current) =>
              previous.requestState != current.requestState),
          builder: (_, state) {
            switch (state.requestState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 1.0,
                  ),
                  items: state.movie!.results.map((result) {
                    return Stack(
                      children: [
                        ShaderMask(
                          shaderCallback: (rect) {
                            return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                stops: [
                                  0,
                                  0.0,
                                  0.5,
                                  1
                                ]).createShader(
                              Rect.fromLTRB(
                                0,
                                0,
                                0,
                                rect.width,
                              ),
                            );
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            height: 400,
                            imageUrl: MovieModel.backdropPathImage(
                                result.backdropPath),
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 400.0,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.circle,
                                    color: Colors.redAccent,
                                    size: 16.0,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'NOW PLAYING',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, left: 15, bottom: 20, top: 10),
                                child: Text(
                                  result.originalTitle,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }).toList(),
                );
              case RequestState.error:
                return const Text('something wont worng');
            }
          }),
    );
  }
}
