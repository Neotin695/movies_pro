import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/core/utils/services/service_locator.dart';
import 'package:movies_pro/tvs/data/models/tv_model.dart';
import 'package:movies_pro/tvs/domain/entities/tv.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_bloc.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_event.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/utils/tools/enum_state.dart';

class TopRatedSeeMoreTVScreen extends StatelessWidget {
  const TopRatedSeeMoreTVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Rated')),
      body: BlocProvider(
        create: (_) {
          return serviceLocator<TVsBloc>()..add(GetNowPlayingTVsEvent());
        },
        child: BlocBuilder<TVsBloc, TVsState>(
          buildWhen: (previous, current) => previous.tvState != current.tvState,
          builder: (context, state) {
            switch (state.tvState) {
              case RequestState.loading:
                return const Center(child: CircularProgressIndicator());
              case RequestState.loaded:
                return ListView.builder(
                  itemCount: state.tv.results.length,
                  itemBuilder: (context, index) {
                    Results result = state.tv.results[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black,
                                  Colors.black,
                                  Colors.transparent
                                ],
                                stops: [0, 0, 0.3, 1],
                              ).createShader(
                                Rect.fromLTRB(
                                  0,
                                  0,
                                  0,
                                  bounds.height,
                                ),
                              );
                            },
                            blendMode: BlendMode.dstIn,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                imageUrl: getImage(result.backdropPath),
                                placeholder: (_, __) => Shimmer.fromColors(
                                  baseColor: Colors.grey[850]!,
                                  highlightColor: Colors.grey[800]!,
                                  child: Container(
                                    height: 170,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.red,
                                      ),
                                      child: Center(
                                          child: Text(
                                              result.firstAirDate.toString())),
                                    ),
                                    const SizedBox(width: 15),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(result.voteAverage.toString()),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  result.name,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              case RequestState.error:
                return const Center(
                  child: Text('somthing wont worng'),
                );
            }
          },
        ),
      ),
    );
  }

  String getImage(String? url) {
    return url != 'null'
        ? TVsModel.backdropPathImage(url!)!
        : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930';
  }
}
