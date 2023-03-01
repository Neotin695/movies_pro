import 'package:flutter/material.dart';

import 'package:movies_pro/movies/presentation/components/top_rated_movies.dart';
import 'package:movies_pro/movies/presentation/screens/popular_see_more_movie_screen.dart';
import 'package:movies_pro/movies/presentation/screens/top_rated_see_more_movie_screen.dart';

import 'now_playing_movies.dart';
import 'popular_movies.dart';

class Movies extends StatelessWidget {
  const Movies({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const NowPlayingMovies(),
          const SizedBox(height: 20),
          InkWell(
            onTap: () => goToSeeMorePopular(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Text(
                    'Popular',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text('see more'),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
          const PopularMovies(),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => goToSeeMoreTopRated(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: const [
                  Text(
                    'Top Rated',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text('see more'),
                  Icon(Icons.navigate_next)
                ],
              ),
            ),
          ),
          const TopRatedMovies(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  void goToSeeMoreTopRated(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const TopRatedSeeMoreMovieScreen()));
  }

  void goToSeeMorePopular(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PopularSeeMoreMovieScreen()));
  }
}
