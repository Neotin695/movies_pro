import 'package:flutter/material.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('mainDrawer'),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Container(
              color: Colors.amber,
            ),
          ),
          const ListTile(
            title: Text('Home'),
            trailing: Icon(Icons.navigate_next),
          ),
          const ListTile(
            title: Text('TV show'),
            trailing: Icon(Icons.navigate_next),
          ),
          const ListTile(
            title: Text('Movies'),
            trailing: Icon(Icons.navigate_next),
          ),
          const ListTile(
            title: Text('Settings'),
            trailing: Icon(Icons.navigate_next),
          ),
        ],
      ),
    );
  }
}
