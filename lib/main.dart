import 'package:faith_plus/screens/dashboards/dashboard.dart';
import 'package:faith_plus/screens/dashboards/devotional.dart';
import 'package:faith_plus/screens/dashboards/fun_zone.dart';
import 'package:faith_plus/screens/dashboards/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Faith Plus',
      theme: ThemeData(),
      home: RootShell(),
    );
  }
}

class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  final _pages = const [
    FaithDashboardScreen(),
    DevotionalDashboardScreen(),
    FunZoneScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bubble_chart_outlined),
            label: 'Faith',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Devotions',
          ),
          NavigationDestination(
            icon: Icon(Icons.videogame_asset_outlined),
            label: 'Fun Zone',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
