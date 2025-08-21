import 'package:church_app/screens/dashbord.dart';
import 'package:church_app/screens/devotional_screen.dart';
import 'package:church_app/screens/games.dart';
import 'package:church_app/screens/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
      ),
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
    DevotionalsScreen(),
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
            label: 'Devotionals',
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

// -- Common UI bits ---------------------------------------------------------


// -- Screen 1: Faith Dashboard ----------------------------------------------


// -- Screen 2: Devotionals ---------------------------------------------------



// -- Screen 3: Fun Zone ------------------------------------------------------



// -- Screen 4: Profile -------------------------------------------------------

