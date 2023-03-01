import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_pro/core/utils/tools/enum_state.dart';
import 'package:movies_pro/tvs/data/models/tv_model.dart';
import 'package:movies_pro/tvs/domain/entities/tv.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_bloc.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_event.dart';
import 'package:movies_pro/tvs/presentation/controller/tv_state.dart';
import 'package:shimmer/shimmer.dart';

import 'package:movies_pro/core/utils/services/service_locator.dart';

class TopRatedTVs extends StatelessWidget {
  const TopRatedTVs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return serviceLocator<TVsBloc>()..add(GetTopRatedTVsEvent());
      },
      child: BlocBuilder<TVsBloc, TVsState>(
        buildWhen: ((previous, current) => previous.tvState != current.tvState),
        builder: (_, state) {
          switch (state.tvState) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              return SizedBox(
                height: 170,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: handleLength(state),
                  itemBuilder: (_, index) {
                    Results result = state.tv.results[index];

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
                                imageUrl: getImage(result.backdropPath),
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

  int handleLength(TVsState state) {
    if (state.tv.results.length >= 20) {
      return state.tv.results.length - 10;
    } else {
      return state.tv.results.length;
    }
  }

  String getImage(String? url) {
    return url != 'null'
        ? TVsModel.backdropPathImage(url!)!
        : 'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930';
  }
}
