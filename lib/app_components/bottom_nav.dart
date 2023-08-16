import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentPageIndex = 0;

  final List<String> _routePaths = [
    '/dashboard',
    '/asset-list',
    '/reports'
  ]; // Add other routes if needed

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (int index) {
        setState(() {
          currentPageIndex = index;
          context.go(_routePaths[index]);
        });
      },
      currentIndex: currentPageIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory),
          label: 'Assets',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.summarize),
          label: 'Reports',
        ),
      ],
    );
  }
}
