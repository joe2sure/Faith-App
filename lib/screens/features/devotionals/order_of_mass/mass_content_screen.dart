import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';

class MassContentScreen extends StatelessWidget {
  final String languageName;
  final String languageCode;

  const MassContentScreen({
    super.key,
    required this.languageName,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text("Order of Mass ($languageName)"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildMassSection(
            "Introductory Rites",
            [
              "Entrance Procession",
              "Greeting",
              "Penitential Act",
              "Kyrie",
              "Gloria",
              "Collect",
            ],
          ),
          const SizedBox(height: 20),
          _buildMassSection(
            "Liturgy of the Word",
            [
              "First Reading",
              "Responsorial Psalm",
              "Second Reading",
              "Gospel Acclamation",
              "Gospel Reading",
              "Homily",
              "Profession of Faith",
              "Universal Prayer",
            ],
          ),
          const SizedBox(height: 20),
          _buildMassSection(
            "Liturgy of the Eucharist",
            [
              "Preparation of the Gifts",
              "Prayer over the Offerings",
              "Eucharistic Prayer",
              "The Lord's Prayer",
              "Rite of Peace",
              "Fraction of the Bread",
              "Communion",
            ],
          ),
          const SizedBox(height: 20),
          _buildMassSection(
            "Concluding Rites",
            [
              "Final Blessing",
              "Dismissal",
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMassSection(String title, List<String> parts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.h3.copyWith(color: AppColors.primaryPurple),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: parts.asMap().entries.map((entry) {
              final index = entry.key;
              final part = entry.value;
              return Column(
                children: [
                  ListTile(
                    title: Text(
                      part,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_down, size: 20),
                    onTap: () {
                      // Expand to show specific prayers in the selected language
                    },
                  ),
                  if (index < parts.length - 1)
                    Divider(height: 1, color: Colors.black.withOpacity(0.05)),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
