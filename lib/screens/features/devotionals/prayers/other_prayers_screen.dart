import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';

class OtherPrayersScreen extends StatelessWidget {
  const OtherPrayersScreen({super.key});

  final List<Map<String, dynamic>> _prayers = const [
    {"title": "Stations of the Cross", "type": "Devotional", "audio": true},
    {"title": "Divine Mercy Prayers", "type": "Devotional", "audio": true},
    {"title": "Angelus", "type": "Daily", "audio": true},
    {"title": "Regina Caeli", "type": "Seasonal", "audio": true},
    {"title": "Salve Regina", "type": "Marian", "audio": false},
    {"title": "Prayer to Guardian Angel", "type": "Protection", "audio": false},
    {"title": "Prayer to St. Michael", "type": "Protection", "audio": true},
    {"title": "Memorare", "type": "Marian", "audio": false},
    {"title": "Sub Tuum Praesidium", "type": "Marian", "audio": false},
    {"title": "Our Father", "type": "Basic", "audio": true},
    {"title": "Hail Mary", "type": "Basic", "audio": true},
    {"title": "Glory Be", "type": "Basic", "audio": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Other Prayers"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: _prayers.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final prayer = _prayers[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: AppColors.primaryBlue, size: 20),
              ),
              title: Text(prayer["title"], style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(prayer["type"], style: AppTextStyles.caption),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prayer["audio"] == true)
                    const Icon(Icons.headset, size: 18, color: AppColors.primaryPurple),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
                ],
              ),
              onTap: () {
                // Navigate to prayer detail
              },
            ),
          );
        },
      ),
    );
  }
}
