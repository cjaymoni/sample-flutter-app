import 'package:flutter/material.dart';

import '../app_screens/asset_screens/assets_list_screen.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white54,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => AssetsList()));
            },
            child: Container(
              width: 200,
              height: 75,
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.assessment),
                    title: Text(title),
                    subtitle: Text(value),
                  ),
                ],
              ),
            ),
          )
          // child: Column(
          //   children: <Widget>[
          //     ListTile(
          //       leading: const Icon(Icons.assessment),
          //       title: Text(title),
          //       subtitle: Text(value),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
