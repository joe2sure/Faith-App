import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  final List<Map<String, dynamic>> _challenges = const [
    {
      "title": "Gospel Quiz",
      "source": "Biblical",
      "duration": "Daily",
      "reward": "50 pts",
      "icon": Icons.menu_book,
      "color": Color(0xFF4A90E2),
    },
    {
      "title": "Saints Trivia",
      "source": "Catholic Faith",
      "duration": "Weekly",
      "reward": "200 pts",
      "icon": Icons.auto_awesome_outlined,
      "color": Color(0xFF9B7EBD),
    },
    {
      "title": "Bible Reading Streak",
      "source": "Biblical",
      "duration": "Monthly",
      "reward": "1000 pts",
      "icon": Icons.history_edu,
      "color": Color(0xFF7CB798),
    },
    {
      "title": "Faith & Life Quiz",
      "source": "Life of Saints",
      "duration": "Daily",
      "reward": "50 pts",
      "icon": Icons.volunteer_activism,
      "color": Color(0xFFD97687),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Challenges & Quizzes"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: _challenges.length,
        itemBuilder: (context, index) {
          final challenge = _challenges[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (challenge["color"] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(challenge["icon"], color: challenge["color"]),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(challenge["title"], style: AppTextStyles.h5),
                          Text(challenge["source"], style: AppTextStyles.caption),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        challenge["reward"],
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text(challenge["duration"], style: AppTextStyles.caption),
                      ],
                    ),
                    Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.share, size: 16),
                          label: const Text("Share"),
                          style: TextButton.styleFrom(foregroundColor: AppColors.primaryBlue),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: challenge["color"],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Start"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
