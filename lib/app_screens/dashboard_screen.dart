import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_report_app/app_components/bar_chart.dart';
import 'package:sample_report_app/app_components/bottom_nav.dart';
import 'package:sample_report_app/app_components/dashboard_card.dart';
import 'package:gap/gap.dart';
import 'package:intersperse/intersperse.dart';
import 'package:provider/provider.dart';
import 'package:sample_report_app/app_components/pie_chart.dart';

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
  num totalFurnitureQuantity = 0;
  num totalAccessoriesQuantity = 0;
  num totalElectronicsQuantity = 0;
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
      totalFurnitureQuantity =
          _furnitureList.fold(0, (sum, item) => sum + (item['quantity'] ?? 0));
      totalAccessoriesQuantity = _accessoriesList.fold(
          0, (sum, item) => sum + (item['quantity'] ?? 0));
      totalElectronicsQuantity = _electronicsList.fold(
          0, (sum, item) => sum + (item['quantity'] ?? 0));
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
        title: 'Total Assets',
        value: _assetsList.length.toString(),
      ),
      DashboardCard(
        title: 'Total Electronics',
        value: _electronicsList.length.toString(),
        asset_type: 'electronics',
      ),
      DashboardCard(
        title: 'Total Accessories',
        value: _accessoriesList.length.toString(),
        asset_type: 'accessories',
      ),
      DashboardCard(
        title: 'Total Furniture',
        value: _furnitureList.length.toString(),
        asset_type: 'furniture',
      )
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 4 / 2,
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
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: PieChartSample(
                    totalAccessories: totalAccessoriesQuantity.toInt(),
                    totalElectronics: totalElectronicsQuantity.toInt(),
                    totalFurniture: totalFurnitureQuantity.toInt(),
                  ))
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          )
        ],
      ),
      bottomNavigationBar: authModel.loggedIn ? const BottomNav() : null,
    );
  }
}
