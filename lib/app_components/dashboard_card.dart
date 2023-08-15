import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard({super.key, required this.title, required this.value});

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
              print('Card tapped.');
            },
            child: Container(
              width: 300,
              height: 100,
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
