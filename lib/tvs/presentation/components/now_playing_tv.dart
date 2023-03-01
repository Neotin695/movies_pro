import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/tvs/data/models/tv_model.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_bloc.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_event.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/tools/enum_state.dart';
import '../../../core/utils/services/service_locator.dart';

class NowPlayingTVS extends StatelessWidget {
  const NowPlayingTVS({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return serviceLocator<TVsBloc>()..add(GetNowPlayingTVsEvent());
      },
      child: BlocBuilder<TVsBloc, TVsState>(
          buildWhen: ((previous, current) =>
              previous.tvState != current.tvState),
          builder: (_, state) {
            switch (state.tvState) {
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
                  items: state.tv.results.map((result) {
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
                            imageUrl: getImage(result.backdropPath),
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
                                  result.name,
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

  String getImage(String? url) {
    return url != 'null'
        ? TVsModel.backdropPathImage(url!)!
        : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930';
  }
}
