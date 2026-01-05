import 'package:flutter/material.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/common/reusable_widget.dart';
import 'package:faith_plus/common/constants.dart';

class CatechismQuizScreen extends StatelessWidget {
  const CatechismQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      "What are the four pillars of the Catechism?",
      "What is the first commandment?",
      "Who founded the Catholic Church?",
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const AppTopBar(title: 'Catechism Quiz'),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return FaithCard(
            title: "Question ${index + 1}",
            subtitle: questions[index],
            actions: [
              AppButton(text: "View Answer", onPressed: () {}, isPrimary: false),
            ],
          );
        },
      ),
    );
  }
}
