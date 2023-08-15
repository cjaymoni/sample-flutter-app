import 'package:flutter/material.dart';
import 'package:sample_report_app/app_components/bar_chart.dart';
import 'package:sample_report_app/app_components/bottom_nav.dart';
import 'package:sample_report_app/app_components/dashboard_card.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    const summaryCards = [
      DashboardCard(title: 'Total Assets', value: '43'),
      DashboardCard(title: 'Total Chairs', value: '23')
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.account_circle)),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Row(
            children: summaryCards
                .map<Widget>((card) => Expanded(child: card))
                .intersperse(const Gap(16))
                .toList(),
          ),
          const SizedBox(
            height: 30,
          ),
          const Row(children: [
            Expanded(child: BarChartSample()),
          ])
        ],
      )),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
