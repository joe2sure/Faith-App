import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';


class LiturgicalCalendarScreen extends StatefulWidget {
  const LiturgicalCalendarScreen({super.key});

  @override
  State<LiturgicalCalendarScreen> createState() => _LiturgicalCalendarScreenState();
}

class _LiturgicalCalendarScreenState extends State<LiturgicalCalendarScreen> {
  DateTime _selectedDate = DateTime.now();

  final List<String> _months = [
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text("Liturgical Calendar"),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Vertical Calendar
          Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(right: BorderSide(color: Colors.grey.shade200)),
            ),
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (context, monthIndex) {
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      width: double.infinity,
                      color: AppColors.primaryPurple.withOpacity(0.1),
                      child: Text(
                        _months[monthIndex].substring(0, 3),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
                      ),
                    ),
                    ...List.generate(31, (dayIndex) {
                      final day = dayIndex + 1;
                      // Simple logic to skip invalid dates for short months
                      if (monthIndex == 1 && day > 28) return const SizedBox.shrink();
                      if ([3, 5, 8, 10].contains(monthIndex) && day > 30) return const SizedBox.shrink();
                      
                      final isSelected = _selectedDate.day == day && _selectedDate.month == monthIndex + 1;
                      
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _selectedDate = DateTime(DateTime.now().year, monthIndex + 1, day);
                          });
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primaryPurple : Colors.transparent,
                          ),
                          child: Text(
                            "$day",
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
          // Content for selected date
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${_months[_selectedDate.month - 1]} ${_selectedDate.day}, ${_selectedDate.year}",
                    style: AppTextStyles.h4,
                  ),
                  const SizedBox(height: 8),
                  const Text("Liturgy of the Day", style: AppTextStyles.subtitle),
                  const SizedBox(height: 24),
                  _buildOptionCard(
                    title: "Readings at Mass",
                    subtitle: "First Reading, Psalm, Gospel",
                    icon: Icons.menu_book,
                    color: AppColors.primaryBlue,
                    onTap: () => _showMassReadings(),
                  ),
                  const SizedBox(height: 16),
                  _buildOptionCard(
                    title: "Divine Office",
                    subtitle: "Liturgical hours of prayer",
                    icon: Icons.access_time,
                    color: AppColors.primaryPurple,
                    onTap: () => _showDivineOfficeOptions(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.h5),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }

  void _showMassReadings() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Readings at Mass", style: AppTextStyles.h4),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  _buildReadingSection("First Reading", "Is 55:10-11", "Thus says the LORD: Just as from the heavens rain and snow come down..."),
                  _buildReadingSection("Responsorial Psalm", "Ps 34", "The Lord delivers the just from all their chains."),
                  _buildReadingSection("Gospel", "Mt 6:7-15", "Jesus said to his disciples: 'In praying, do not babble like the pagans...'"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDivineOfficeOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Divine Office", style: AppTextStyles.h4),
            const SizedBox(height: 16),
            _buildOfficeTile("Morning Prayer (Lauds)", Icons.wb_sunny_outlined),
            _buildOfficeTile("Mid-day Prayer", Icons.wb_twilight),
            _buildOfficeTile("Evening Prayer (Vespers)", Icons.nightlight_round),
            _buildOfficeTile("Night Prayer (Compline)", Icons.bedtime),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficeTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryPurple),
      title: Text(title, style: AppTextStyles.bodyMedium),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        Navigator.pop(context);
        // Navigate to actual prayer text
      },
    );
  }

  Widget _buildReadingSection(String title, String reference, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
          Text(reference, style: AppTextStyles.caption),
          const SizedBox(height: 8),
          Text(content, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }
}
