import 'package:flutter/material.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
import 'mystery_detail_screen.dart';

class RosaryMysteriesScreen extends StatelessWidget {
  const RosaryMysteriesScreen({super.key});

  final List<Map<String, dynamic>> _mysteries = const [
    {
      "title": "Joyful Mysteries",
      "days": "Monday and Saturday",
      "color": Color(0xFF4A90E2),
      "icon": Icons.wb_sunny_outlined,
    },
    {
      "title": "Luminous Mysteries",
      "days": "Thursday",
      "color": Color(0xFFFFD700),
      "icon": Icons.light_mode_outlined,
    },
    {
      "title": "Sorrowful Mysteries",
      "days": "Tuesday, Friday",
      "color": Color(0xFFB85C5C),
      "icon": Icons.opacity,
    },
    {
      "title": "Glorious Mysteries",
      "days": "Wednesday, Sunday",
      "color": Color(0xFF9B7EBD),
      "icon": Icons.auto_awesome_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("The Holy Rosary"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: _mysteries.length,
        itemBuilder: (context, index) {
          final mystery = _mysteries[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MysteryDetailScreen(
                    title: mystery["title"],
                    color: mystery["color"],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (mystery["color"] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      mystery["icon"],
                      color: mystery["color"],
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    mystery["title"],
                    style: AppTextStyles.h5.copyWith(fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    mystery["days"],
                    style: AppTextStyles.caption,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
