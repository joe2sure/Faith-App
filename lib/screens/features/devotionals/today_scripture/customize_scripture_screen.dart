import 'package:flutter/material.dart';

class CustomizeScriptureScreen extends StatefulWidget {
  const CustomizeScriptureScreen({super.key});

  @override
  State<CustomizeScriptureScreen> createState() => _CustomizeScriptureScreenState();
}

class _CustomizeScriptureScreenState extends State<CustomizeScriptureScreen> {
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  
  String _selectedTime = "6:00 AM";
  final List<String> _selectedDays = ["Mon", "Tue", "Wed", "Thu", "Fri"];
  bool _enableNotifications = true;
  bool _enableAudioAutoplay = false;
  String _selectedTranslation = "New International Version (NIV)";
  int _readingDuration = 15;

  final List<String> _allDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
  final List<String> _translations = [
    "New International Version (NIV)",
    "King James Version (KJV)",
    "English Standard Version (ESV)",
    "New Living Translation (NLT)",
    "The Message (MSG)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Customize Scripture",
          style: TextStyle(
            color: _deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _savePreferences(),
            child: Text(
              "Save",
              style: TextStyle(
                color: _primaryBlue,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Schedule Section
            _buildSectionHeader("Reading Schedule"),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: [
                  _buildSettingRow(
                    icon: Icons.access_time,
                    title: "Preferred Time",
                    trailing: GestureDetector(
                      onTap: () => _selectTime(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _selectedTime,
                          style: TextStyle(
                            color: _primaryBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  _buildSettingRow(
                    icon: Icons.calendar_today,
                    title: "Reading Days",
                    trailing: const SizedBox(),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _allDays.map((day) {
                      final isSelected = _selectedDays.contains(day);
                      return GestureDetector(
                        onTap: () => setState(() {
                          if (isSelected) {
                            _selectedDays.remove(day);
                          } else {
                            _selectedDays.add(day);
                          }
                        }),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(colors: [_primaryBlue, _deepPurple])
                                : null,
                            color: isSelected ? null : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            day,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  _buildSettingRow(
                    icon: Icons.timer,
                    title: "Reading Duration",
                    trailing: Text(
                      "$_readingDuration min",
                      style: TextStyle(
                        color: _deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Slider(
                    value: _readingDuration.toDouble(),
                    min: 5,
                    max: 60,
                    divisions: 11,
                    activeColor: _primaryBlue,
                    label: "$_readingDuration min",
                    onChanged: (value) => setState(() => _readingDuration = value.toInt()),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Bible Translation Section
            _buildSectionHeader("Bible Translation"),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: _translations.map((translation) {
                  final isSelected = _selectedTranslation == translation;
                  return Column(
                    children: [
                      RadioListTile<String>(
                        value: translation,
                        groupValue: _selectedTranslation,
                        onChanged: (value) => setState(() => _selectedTranslation = value!),
                        title: Text(
                          translation,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? _deepPurple : Colors.grey.shade800,
                          ),
                        ),
                        activeColor: _primaryBlue,
                        contentPadding: EdgeInsets.zero,
                      ),
                      if (translation != _translations.last) const Divider(height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // Notification Settings
            _buildSectionHeader("Notifications & Audio"),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: [
                  SwitchListTile(
                    value: _enableNotifications,
                    onChanged: (value) => setState(() => _enableNotifications = value),
                    title: const Text("Daily Reminders"),
                    subtitle: const Text("Get notified at your preferred time"),
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _primaryBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.notifications, color: _primaryBlue),
                    ),
                    activeColor: _primaryBlue,
                    contentPadding: EdgeInsets.zero,
                  ),
                  const Divider(),
                  SwitchListTile(
                    value: _enableAudioAutoplay,
                    onChanged: (value) => setState(() => _enableAudioAutoplay = value),
                    title: const Text("Audio Autoplay"),
                    subtitle: const Text("Automatically play audio readings"),
                    secondary: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _deepPurple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.headphones, color: _deepPurple),
                    ),
                    activeColor: _primaryBlue,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Reading Plan
            _buildSectionHeader("Reading Plan"),
            const SizedBox(height: 12),
            _buildCard(
              child: Column(
                children: [
                  _buildPlanOption(
                    "Chronological",
                    "Read the Bible in historical order",
                    Icons.timeline,
                    Colors.blue,
                  ),
                  const Divider(),
                  _buildPlanOption(
                    "Canonical",
                    "Read from Genesis to Revelation",
                    Icons.menu_book,
                    Colors.green,
                  ),
                  const Divider(),
                  _buildPlanOption(
                    "Thematic",
                    "Focus on specific themes and topics",
                    Icons.category,
                    Colors.orange,
                  ),
                  const Divider(),
                  _buildPlanOption(
                    "Custom Plan",
                    "Create your own reading schedule",
                    Icons.edit_calendar,
                    _deepPurple,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: _deepPurple,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    required Widget trailing,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: _primaryBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
        trailing,
      ],
    );
  }

  Widget _buildPlanOption(String title, String subtitle, IconData icon, Color color) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: _primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked.format(context);
      });
    }
  }

  void _savePreferences() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Preferences saved successfully!"),
        backgroundColor: _primaryBlue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
    Navigator.pop(context);
  }
}