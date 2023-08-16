import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_report_app/app_components/bar_chart.dart';
import 'package:sample_report_app/app_components/bottom_nav.dart';
import 'package:sample_report_app/app_components/dashboard_card.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../utils/sql_helper.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> _assetsList = [];
  List<Map<String, dynamic>> _furnitureList = [];
  List<Map<String, dynamic>> _accessoriesList = [];
  List<Map<String, dynamic>> _electronicsList = [];
  bool _isLoading = true;

  //fetch from db
  Future<void> _fetchAssets() async {
    setState(() {
      _isLoading = true;
    });
    //fetch from db
    final data = await SQLHelper.getAllAssets();

    setState(() {
      _assetsList = data;
      _isLoading = false;
      _accessoriesList = data
          .where((element) => element['asset_type'] == 'accessories')
          .toList();
      _electronicsList = data
          .where((element) => element['asset_type'] == 'electronics')
          .toList();
      _furnitureList = data
          .where((element) => element['asset_type'] == 'furniture')
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAssets(); //fetch the page loads
  }

  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    final summaryCards = [
      DashboardCard(
          title: 'Total Assets', value: _assetsList.length.toString()),
      DashboardCard(
          title: 'Total Electronics',
          value: _electronicsList.length.toString()),
      DashboardCard(
          title: 'Total Accessories',
          value: _accessoriesList.length.toString()),
      DashboardCard(
          title: 'Total Furniture', value: _furnitureList.length.toString())
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      child: TextButton(
                        onPressed: () {
                          authModel.logout();
                          context.go('/');
                        },
                        child: const Text('Logout'),
                      ),
                    )
                  ])
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 5 / 2,
                crossAxisSpacing: 9,
                mainAxisSpacing: 2),
            itemCount: summaryCards.length,
            itemBuilder: (context, index) {
              return summaryCards[index];
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Row(children: [
            Expanded(
                child: BarChartSample(
              electronicsData: _electronicsList.length.toDouble(),
              accessoriesData: _accessoriesList.length.toDouble(),
              furnitureData: _furnitureList.length.toDouble(),
            )),
          ])
        ],
      )),
      bottomNavigationBar: authModel.loggedIn ? const BottomNav() : null,
    );
  }
}
