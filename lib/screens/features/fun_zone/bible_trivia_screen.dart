import 'package:flutter/material.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/common/reusable_widget.dart';
import 'package:faith_plus/common/constants.dart';

class BibleTriviaScreen extends StatelessWidget {
  const BibleTriviaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const AppTopBar(title: 'Bible Trivia Challenge'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Difficulty", style: AppTextStyles.h4.copyWith(color: AppColors.primaryPurple)),
            const SizedBox(height: 20),
            _DifficultyCard(
              title: "Easy",
              subtitle: "Foundational biblical stories",
              color: AppColors.accentTeal,
              onTap: () => _startTrivia(context, "Easy"),
            ),
            const SizedBox(height: 16),
            _DifficultyCard(
              title: "Moderate",
              subtitle: "Prophets, Epistles & Parables",
              color: AppColors.accentGold,
              onTap: () => _startTrivia(context, "Moderate"),
            ),
            const SizedBox(height: 16),
            _DifficultyCard(
              title: "Hard",
              subtitle: "Deep theological & historical facts",
              color: AppColors.accentRose,
              onTap: () => _startTrivia(context, "Hard"),
            ),
          ],
        ),
      ),
    );
  }

  void _startTrivia(BuildContext context, String difficulty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Starting $difficulty Trivia..."))
    );
  }
}

class _DifficultyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DifficultyCard({required this.title, required this.subtitle, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      gradientColors: [color, color.withOpacity(0.7)],
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.h3.copyWith(color: Colors.white)),
              Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: Colors.white70)),
            ],
          ),
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
        ],
      ),
    );
  }
}
