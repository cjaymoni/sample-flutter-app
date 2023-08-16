import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_report_app/app_components/data_table.dart';
import '../../app_components/bottom_nav.dart';
import '../../main.dart';
import 'package:provider/provider.dart';

class ReportsHome extends StatefulWidget {
  const ReportsHome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ReportsHomeState();
}

class _ReportsHomeState extends State<ReportsHome> {
  @override
  Widget build(BuildContext context) {
    final authModel = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
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
      body: const Center(
        child: DataTableWidget(),
      ),
      bottomNavigationBar: authModel.loggedIn ? const BottomNav() : null,
    );
  }
}
