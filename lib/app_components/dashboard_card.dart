import 'package:flutter/material.dart';
import 'package:sample_report_app/app_screens/asset_screens/assets_list_screen.dart';

import '../app_screens/report_screens/category_screen.dart';

class DashboardCard extends StatelessWidget {
  DashboardCard(
      {super.key, required this.title, required this.value, this.asset_type});

  final String title;
  final String value;
  final String? asset_type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          clipBehavior: Clip.hardEdge,
          color: Colors.white54,
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              if (asset_type == null) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AssetsList()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CategoryScreen(header: asset_type)));
              }
            },
            child: Container(
              width: 200,
              height: 80,
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
