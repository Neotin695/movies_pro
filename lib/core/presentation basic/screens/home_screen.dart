import 'package:flutter/material.dart';
import 'package:movies_pro/movies/presentation/components/movies.dart';
import 'package:movies_pro/tvs/presentation/components/tv_show.dart';

import '../components/home.dart';
import '../components/build_drawer.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  List<Widget> selectedScreen = [const Home(), const Movies(), const TvShow()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies app'),
      ),
      drawer: const BuildDrawer(),
      body: _buildBodyHomeScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: getSelectedItemIndex,
        elevation: 4,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TV Show')
        ],
      ),
    );
  }

  void getSelectedItemIndex(int index) => setState(() {
        selectedIndex = index;
      });

  _buildBodyHomeScreen() {
    return selectedScreen[selectedIndex];
  }
}
