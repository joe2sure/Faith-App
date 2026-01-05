import 'package:flutter/material.dart';
// import '../../../core/constants/app_colors.dart';
// import '../../../core/themes/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';
import 'mass_content_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  final List<Map<String, String>> languages = const [
    {"name": "English", "code": "en", "flag": "🇺🇸"},
    {"name": "Latin (Latinam)", "code": "la", "flag": "🇻🇦"},
    {"name": "Spanish (Español)", "code": "es", "flag": "🇪🇸"},
    {"name": "French (Français)", "code": "fr", "flag": "🇫🇷"},
    {"name": "Portuguese (Português)", "code": "pt", "flag": "🇵🇹"},
    {"name": "Italian (Italiano)", "code": "it", "flag": "🇮🇹"},
    {"name": "German (Deutsch)", "code": "de", "flag": "🇩🇪"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Select Language"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your language",
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                Text(
                  "Select your preferred language to view the Order of Mass content.",
                  style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: languages.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final lang = languages[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MassContentScreen(
                          languageName: lang["name"]!,
                          languageCode: lang["code"]!,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Text(
                          lang["flag"]!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          lang["name"]!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
