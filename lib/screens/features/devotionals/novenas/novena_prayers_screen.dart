import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';

class NovenaPrayersScreen extends StatefulWidget {
  const NovenaPrayersScreen({super.key});

  @override
  State<NovenaPrayersScreen> createState() => _NovenaPrayersScreenState();
}

class _NovenaPrayersScreenState extends State<NovenaPrayersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _novenas = [
    {"name": "Holy Spirit", "time": "9:00 AM", "color": Color(0xFFB85C5C)},
    {"name": "Sacred Heart", "time": "12:00 PM", "color": Color(0xFFD97687)},
    {"name": "Divine Mercy", "time": "3:00 PM", "color": Color(0xFF4A90E2)},
    {"name": "Immaculate Heart", "time": "6:00 PM", "color": Color(0xFF50B5B0)},
    {"name": "Perpetual Help", "time": "7:00 AM", "color": Color(0xFF9B7EBD)},
    {"name": "Saint Joseph", "time": "8:00 AM", "color": Color(0xFFD4A574)},
    {"name": "Saint Jude", "time": "10:00 AM", "color": Color(0xFF6B5B95)},
    {"name": "Saint Anthony", "time": "11:00 AM", "color": Color(0xFF7CB798)},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _novenas.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Novena Prayers"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: _novenas.map((n) => Tab(text: n["name"])).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _novenas.map((n) => _buildNovenaView(n)).toList(),
      ),
    );
  }

  Widget _buildNovenaView(Map<String, dynamic> novena) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: (novena["color"] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: (novena["color"] as Color).withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: novena["color"]),
                const SizedBox(width: 12),
                Text(
                  "Prayer Time: ${novena["time"]}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: novena["color"]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text("Day 1: The Request", style: AppTextStyles.h4),
          const SizedBox(height: 16),
          const Text(
            "O Most Holy Spirit, come into my heart and fill it with Thy grace. I humbly ask for the following intention...",
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 24),
          const Text("Closing Prayer", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            "Glory be to the Father, and to the Son, and to the Holy Spirit. As it was in the beginning, is now, and ever shall be, world without end. Amen.",
            style: AppTextStyles.bodyMedium,
          ),
        ],
      ),
    );
  }
}
