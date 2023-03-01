import 'package:flutter/material.dart';

import 'package:movies_pro/tvs/presentation/components/now_playing_tv.dart';
import 'package:movies_pro/tvs/presentation/components/popular_tv.dart';
import 'package:movies_pro/tvs/presentation/components/top_rated_tv.dart';
import 'package:movies_pro/tvs/presentation/screens/popular_see_more_tv_screen.dart';
import 'package:movies_pro/tvs/presentation/screens/top_rated_see_more_tv_screen.dart';

class TvShow extends StatelessWidget {
  const TvShow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const NowPlayingTVS(),
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
          const PopularTVs(),
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
          const TopRatedTVs(),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  void goToSeeMoreTopRated(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const TopRatedSeeMoreTVScreen()));
  }

  void goToSeeMorePopular(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => const PopularSeeMoreTVScreen()));
  }
}
