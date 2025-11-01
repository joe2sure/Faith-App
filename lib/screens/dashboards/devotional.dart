import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'dart:async';

class DevotionalDashboardScreen extends StatefulWidget {
  const DevotionalDashboardScreen({super.key});

  @override
  State<DevotionalDashboardScreen> createState() => _DevotionalDashboardScreenState();
}

class _DevotionalDashboardScreenState extends State<DevotionalDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late AnimationController _cardsAnimationController;
  late AnimationController _floatingAnimationController;
  late AnimationController _progressAnimationController;
  
  late Animation<double> _headerSlideAnimation;
  late Animation<double> _cardsFadeAnimation;
  late Animation<double> _floatingAnimation;
  late Animation<double> _progressAnimation;

  int _currentDevotionalIndex = 0;
  Timer? _devotionalTimer;
  int _todayProgress = 65;
  int _streakDays = 12;

  // Harmonious color palette - Soft, calming religious theme
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  final Color _softTeal = const Color(0xFF50B5B0);
  final Color _warmGold = const Color(0xFFD4A574);
  final Color _roseRed = const Color(0xFFD97687);
  final Color _sageGreen = const Color(0xFF7CB798);

  final List<Map<String, dynamic>> _devotionalContent = [
    {
      "title": "Morning Prayer",
      "time": "6:00 AM",
      "duration": "10 min",
      "description": "Start your day with gratitude and surrender to God's will",
      "icon": Icons.wb_sunny,
      "colors": [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
    },
    {
      "title": "Scripture Reading",
      "time": "12:00 PM",
      "duration": "15 min",
      "description": "Dive deep into God's Word and find wisdom for today",
      "icon": Icons.menu_book,
      "colors": [const Color(0xFF4A90E2), const Color(0xFF3A7BC8)],
    },
    {
      "title": "Rosary",
      "time": "3:00 PM",
      "duration": "20 min",
      "description": "Meditate on the mysteries of Christ through Mary's eyes",
      "icon": Icons.circle_outlined,
      "colors": [const Color(0xFF9B7EBD), const Color(0xFF6B5B95)],
    },
    {
      "title": "Evening Reflection",
      "time": "8:00 PM",
      "duration": "10 min",
      "description": "Review your day and thank God for His blessings",
      "icon": Icons.nightlight_round,
      "colors": [const Color(0xFF5B7C99), const Color(0xFF3E5469)],
    },
  ];

  final List<Map<String, String>> _quickPrayers = [
    {"title": "Our Father", "duration": "2 min"},
    {"title": "Hail Mary", "duration": "1 min"},
    {"title": "Glory Be", "duration": "30 sec"},
    {"title": "Guardian Angel", "duration": "1 min"},
    {"title": "St. Michael", "duration": "2 min"},
    {"title": "Angelus", "duration": "3 min"},
  ];

  final List<Map<String, dynamic>> _devotionalCategories = [
    {"title": "Liturgy of Hours", "subtitle": "Daily Office", "icon": Icons.access_time, "count": "7 prayers", "color": const Color(0xFF4A90E2)},
    {"title": "Novenas", "subtitle": "9-Day Prayers", "icon": Icons.calendar_today, "count": "15 available", "color": const Color(0xFF6B5B95)},
    {"title": "Chaplets", "subtitle": "Divine Mercy & More", "icon": Icons.spa, "count": "8 chaplets", "color": const Color(0xFFD97687)},
    {"title": "Lectio Divina", "subtitle": "Sacred Reading", "icon": Icons.auto_stories, "count": "Daily guide", "color": const Color(0xFF50B5B0)},
    {"title": "Stations of the Cross", "subtitle": "Way of the Cross", "icon": Icons.add, "count": "14 stations", "color": const Color(0xFF8B7355)},
    {"title": "Marian Prayers", "subtitle": "Honoring Mary", "icon": Icons.favorite, "count": "20+ prayers", "color": const Color(0xFF7CB798)},
  ];

  final List<Map<String, dynamic>> _weeklyGoals = [
    {"title": "Daily Mass Attendance", "progress": 0.4, "current": 2, "target": 5, "icon": Icons.church, "color": const Color(0xFFE57373)},
    {"title": "Rosary Completion", "progress": 0.7, "current": 5, "target": 7, "icon": Icons.brightness_1, "color": const Color(0xFF64B5F6)},
    {"title": "Scripture Reading", "progress": 0.86, "current": 6, "target": 7, "icon": Icons.menu_book, "color": const Color(0xFF81C784)},
    {"title": "Acts of Charity", "progress": 0.6, "current": 3, "target": 5, "icon": Icons.volunteer_activism, "color": const Color(0xFFFFB74D)},
  ];

  final List<Map<String, dynamic>> _spiritualPractices = [
    {"title": "Eucharistic Adoration", "subtitle": "Spend time with Jesus", "duration": "30 min", "icon": Icons.wb_sunny_outlined, "color": const Color(0xFFFFCA28)},
    {"title": "Examination of Conscience", "subtitle": "Daily self-reflection", "duration": "15 min", "icon": Icons.psychology, "color": const Color(0xFF5C6BC0)},
    {"title": "Spiritual Reading", "subtitle": "Saints & theology", "duration": "20 min", "icon": Icons.library_books, "color": const Color(0xFF8D6E63)},
    {"title": "Fasting & Abstinence", "subtitle": "Sacrifice for God", "duration": "All day", "icon": Icons.no_meals, "color": const Color(0xFF9575CD)},
  ];

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
    _cardsAnimationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
    _floatingAnimationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _progressAnimationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _headerSlideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
      CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeOutCubic),
    );
    _cardsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardsAnimationController, curve: Curves.easeIn),
    );
    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(parent: _floatingAnimationController, curve: Curves.easeInOut),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressAnimationController, curve: Curves.easeOutCubic),
    );

    _headerAnimationController.forward();
    _cardsAnimationController.forward();
    _floatingAnimationController.repeat(reverse: true);
    _progressAnimationController.forward();

    _devotionalTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentDevotionalIndex = (_currentDevotionalIndex + 1) % _devotionalContent.length;
      });
    });
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    _cardsAnimationController.dispose();
    _floatingAnimationController.dispose();
    _progressAnimationController.dispose();
    _devotionalTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: const AppTopBar(
        title: 'Daily Devotional',
        actions: [
          Padding(padding: EdgeInsets.only(right: 25), child: Icon(Icons.notifications)),
          Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.settings)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          _buildWelcomeHeader(),
          const SizedBox(height: 20),
          _buildProgressCard(),
          const SizedBox(height: 25),
          _buildFeaturedDevotional(),
          const SizedBox(height: 25),
          _buildSectionHeader('Today\'s Schedule', 'Customize'),
          const SizedBox(height: 12),
          _buildDailySchedule(),
          const SizedBox(height: 25),
          _buildSectionHeader('Quick Prayers', 'View All'),
          const SizedBox(height: 12),
          _buildQuickPrayers(),
          const SizedBox(height: 25),
          _buildSectionHeader('Devotional Practices', 'Explore'),
          const SizedBox(height: 12),
          _buildDevotionalCategories(),
          const SizedBox(height: 25),
          _buildWeeklyGoals(),
          const SizedBox(height: 25),
          _buildSectionHeader('Spiritual Practices', 'Learn More'),
          const SizedBox(height: 12),
          _buildSpiritualPractices(),
          const SizedBox(height: 25),
          _buildSpiritualGrowthTracker(),
          const SizedBox(height: 25),
          _buildPrayerIntentions(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return AnimatedBuilder(
      animation: _headerSlideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _headerSlideAnimation.value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _deepPurple,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Continue your spiritual journey",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                _buildStreakBadge(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: _deepPurple, fontSize: 20, fontWeight: FontWeight.w600)),
          GestureDetector(
            onTap: () {},
            child: Text(actionText, style: TextStyle(color: _primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildStreakBadge() {
    return AnimatedBuilder(
      animation: _floatingAnimationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatingAnimation.value / 2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [const Color(0xFFFF6B35), const Color(0xFFFF8C42)]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: const Color(0xFFFF6B35).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
                const SizedBox(width: 6),
                Text("$_streakDays Days", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AnimatedBuilder(
        animation: _progressAnimation,
        builder: (context, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [_primaryBlue, _softTeal], begin: Alignment.topLeft, end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: _primaryBlue.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Today's Progress", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("${(_todayProgress * _progressAnimation.value).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: (_todayProgress / 100) * _progressAnimation.value,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildProgressStat("Prayers", "3/4", Icons.favorite),
                    _buildProgressStat("Reading", "15 min", Icons.menu_book),
                    _buildProgressStat("Reflection", "Done", Icons.check_circle),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.9), size: 22),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
      ],
    );
  }

  Widget _buildFeaturedDevotional() {
    final current = _devotionalContent[_currentDevotionalIndex];
    
    return AnimatedBuilder(
      animation: _cardsFadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _cardsFadeAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: current["colors"] as List<Color>, begin: Alignment.topLeft, end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: (current["colors"] as List<Color>)[0].withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
                          child: Icon(current["icon"] as IconData, color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(current["title"] as String, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time, color: Colors.white.withOpacity(0.9), size: 16),
                                  const SizedBox(width: 4),
                                  Text("${current["time"]} • ${current["duration"]}", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(current["description"] as String, style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 15, height: 1.5)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: (current["colors"] as List<Color>)[1],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: const Text("Start Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
                          child: IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border, color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDailySchedule() {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _devotionalContent.length,
        itemBuilder: (context, index) {
          final item = _devotionalContent[index];
          return _buildScheduleCard(item, index);
        },
      ),
    );
  }

  Widget _buildScheduleCard(Map<String, dynamic> item, int index) {
    final cardColor = (item["colors"] as List<Color>)[0];
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: cardColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: Icon(item["icon"] as IconData, color: cardColor, size: 24),
                ),
                const SizedBox(height: 12),
                Text(item["title"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(item["time"] as String, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: cardColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
                  child: Text(item["duration"] as String, style: TextStyle(fontSize: 11, color: cardColor, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
          if (index % 2 == 0)
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: _sageGreen, shape: BoxShape.circle),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildQuickPrayers() {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _quickPrayers.length,
        itemBuilder: (context, index) {
          return _buildQuickPrayerChip(_quickPrayers[index]);
        },
      ),
    );
  }

  Widget _buildQuickPrayerChip(Map<String, String> prayer) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _deepPurple,
          elevation: 4,
          shadowColor: _deepPurple.withOpacity(0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(prayer["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(prayer["duration"]!, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }

  Widget _buildDevotionalCategories() {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _devotionalCategories.length,
        itemBuilder: (context, index) {
          final category = _devotionalCategories[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 140,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: (category["color"] as Color).withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (category["color"] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(category["icon"] as IconData, color: category["color"] as Color, size: 24),
                  ),
                  const SizedBox(height: 12),
                  Text(category["title"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const Spacer(),
                  Text(category["count"] as String, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWeeklyGoals() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Weekly Goals", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _deepPurple)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: _sageGreen.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: Text("5 Days Left", style: TextStyle(fontSize: 12, color: _sageGreen, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._weeklyGoals.map((goal) => _buildGoalItem(goal)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalItem(Map<String, dynamic> goal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (goal["color"] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(goal["icon"] as IconData, color: goal["color"] as Color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(goal["title"] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("${goal["current"]}/${goal["target"]} completed", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              Text("${((goal["progress"] as double) * 100).toInt()}%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: goal["color"] as Color)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: goal["progress"] as double,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(goal["color"] as Color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpiritualPractices() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _spiritualPractices.length,
        itemBuilder: (context, index) {
          final practice = _spiritualPractices[index];
          final color = practice["color"] as Color;
          return GestureDetector(
            onTap: () {},
            child: Container(
              width: 180,
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [color.withOpacity(0.85), color], begin: Alignment.topLeft, end: Alignment.bottomRight),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: color.withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(practice["icon"] as IconData, color: Colors.white, size: 32),
                  const SizedBox(height: 12),
                  Text(practice["title"] as String, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Text(practice["subtitle"] as String, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.schedule, color: Colors.white.withOpacity(0.9), size: 14),
                      const SizedBox(width: 4),
                      Text(practice["duration"] as String, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSpiritualGrowthTracker() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_softTeal, _sageGreen], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: _softTeal.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.trending_up, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                const Text("Spiritual Growth", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            _buildGrowthMetric("Prayer Time", "45 min", "↑ 15% this week", Icons.timelapse),
            const SizedBox(height: 12),
            _buildGrowthMetric("Bible Chapters", "12", "↑ 3 from last week", Icons.book),
            const SizedBox(height: 12),
            _buildGrowthMetric("Consistency", "12 Days", "Keep going!", Icons.emoji_events),
          ],
        ),
      ),
    );
  }

  Widget _buildGrowthMetric(String label, String value, String change, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
                Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Text(change, style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildPrayerIntentions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [_deepPurple, _roseRed], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: _deepPurple.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.volunteer_activism, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Text("Prayer Intentions", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text("247 Active", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              "Join thousands of faithful in prayer. Share your intentions and pray for others in our community.",
              style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text("Add Intention"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: _deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.favorite, size: 18),
                    label: const Text("Pray for Others"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:faith_plus/common/constants.dart';
// import 'dart:async';
// import 'dart:math' as math;

// class DevotionalDashboardScreen extends StatefulWidget {
//   const DevotionalDashboardScreen({super.key});

//   @override
//   State<DevotionalDashboardScreen> createState() => _DevotionalDashboardScreenState();
// }

// class _DevotionalDashboardScreenState extends State<DevotionalDashboardScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _headerAnimationController;
//   late AnimationController _cardsAnimationController;
//   late AnimationController _floatingAnimationController;
//   late AnimationController _progressAnimationController;
//   late AnimationController _pulseAnimationController;
  
//   late Animation<double> _headerSlideAnimation;
//   late Animation<double> _cardsFadeAnimation;
//   late Animation<double> _floatingAnimation;
//   late Animation<double> _progressAnimation;
//   late Animation<double> _pulseAnimation;

//   int _currentDevotionalIndex = 0;
//   Timer? _devotionalTimer;
//   int _todayProgress = 65;
//   int _streakDays = 12;
//   int _currentInspirationIndex = 0;
//   Timer? _inspirationTimer;

//   final List<Map<String, dynamic>> _devotionalContent = [
//     {
//       "title": "Morning Prayer",
//       "time": "6:00 AM",
//       "duration": "10 min",
//       "description": "Start your day with gratitude and surrender to God's will",
//       "icon": Icons.wb_sunny,
//       "color": Colors.orange,
//       "gradient": [Colors.orange.shade300, Colors.deepOrange.shade400],
//     },
//     {
//       "title": "Scripture Reading",
//       "time": "12:00 PM",
//       "duration": "15 min",
//       "description": "Dive deep into God's Word and find wisdom for today",
//       "icon": Icons.menu_book,
//       "color": Colors.blue,
//       "gradient": [Colors.blue.shade300, Colors.indigo.shade400],
//     },
//     {
//       "title": "Rosary",
//       "time": "3:00 PM",
//       "duration": "20 min",
//       "description": "Meditate on the mysteries of Christ through Mary's eyes",
//       "icon": Icons.circle_outlined,
//       "color": Colors.purple,
//       "gradient": [Colors.purple.shade300, Colors.deepPurple.shade400],
//     },
//     {
//       "title": "Evening Reflection",
//       "time": "8:00 PM",
//       "duration": "10 min",
//       "description": "Review your day and thank God for His blessings",
//       "icon": Icons.nightlight_round,
//       "color": Colors.indigo,
//       "gradient": [Colors.indigo.shade300, Colors.blue.shade900],
//     },
//   ];

//   final List<Map<String, String>> _quickPrayers = [
//     {"title": "Our Father", "duration": "2 min"},
//     {"title": "Hail Mary", "duration": "1 min"},
//     {"title": "Glory Be", "duration": "30 sec"},
//     {"title": "Guardian Angel", "duration": "1 min"},
//     {"title": "St. Michael", "duration": "2 min"},
//     {"title": "Angelus", "duration": "3 min"},
//     {"title": "Apostles' Creed", "duration": "2 min"},
//     {"title": "Act of Contrition", "duration": "1 min"},
//   ];

//   final List<Map<String, String>> _inspirationalQuotes = [
//     {
//       "quote": "The greatest act of faith is when a man understands he is not God.",
//       "author": "Oliver Wendell Holmes"
//     },
//     {
//       "quote": "Faith is to believe what you do not see; the reward of this faith is to see what you believe.",
//       "author": "Saint Augustine"
//     },
//     {
//       "quote": "Prayer is the raising of one's mind and heart to God.",
//       "author": "Saint John Damascene"
//     },
//     {
//       "quote": "The rosary is the most beautiful and the most rich in graces of all prayers.",
//       "author": "Pope Pius IX"
//     },
//   ];

//   final List<Map<String, dynamic>> _devotionalCategories = [
//     {
//       "title": "Liturgy of Hours",
//       "subtitle": "Daily Office",
//       "icon": Icons.access_time,
//       "color": Colors.indigo,
//       "count": "7 prayers"
//     },
//     {
//       "title": "Novenas",
//       "subtitle": "9-Day Prayers",
//       "icon": Icons.calendar_today,
//       "color": Colors.purple,
//       "count": "15 available"
//     },
//     {
//       "title": "Chaplets",
//       "subtitle": "Divine Mercy & More",
//       "icon": Icons.spa,
//       "color": Colors.pink,
//       "count": "8 chaplets"
//     },
//     {
//       "title": "Lectio Divina",
//       "subtitle": "Sacred Reading",
//       "icon": Icons.auto_stories,
//       "color": Colors.teal,
//       "count": "Daily guide"
//     },
//     {
//       "title": "Stations of the Cross",
//       "subtitle": "Way of the Cross",
//       "icon": Icons.add,
//       "color": Colors.brown,
//       "count": "14 stations"
//     },
//     {
//       "title": "Marian Prayers",
//       "subtitle": "Honoring Mary",
//       "icon": Icons.favorite,
//       "color": Colors.blue,
//       "count": "20+ prayers"
//     },
//   ];

//   final List<Map<String, dynamic>> _weeklyGoals = [
//     {
//       "title": "Daily Mass Attendance",
//       "progress": 0.4,
//       "current": 2,
//       "target": 5,
//       "icon": Icons.church,
//       "color": Colors.red
//     },
//     {
//       "title": "Rosary Completion",
//       "progress": 0.7,
//       "current": 5,
//       "target": 7,
//       "icon": Icons.brightness_1,
//       "color": Colors.blue
//     },
//     {
//       "title": "Scripture Reading",
//       "progress": 0.86,
//       "current": 6,
//       "target": 7,
//       "icon": Icons.menu_book,
//       "color": Colors.green
//     },
//     {
//       "title": "Acts of Charity",
//       "progress": 0.6,
//       "current": 3,
//       "target": 5,
//       "icon": Icons.volunteer_activism,
//       "color": Colors.orange
//     },
//   ];

//   final List<Map<String, String>> _upcomingFeasts = [
//     {"name": "Feast of St. Francis", "date": "Oct 4", "type": "Memorial"},
//     {"name": "Our Lady of Rosary", "date": "Oct 7", "type": "Memorial"},
//     {"name": "Feast of St. Teresa", "date": "Oct 15", "type": "Memorial"},
//     {"name": "All Saints Day", "date": "Nov 1", "type": "Solemnity"},
//   ];

//   final List<Map<String, dynamic>> _spiritualPractices = [
//     {
//       "title": "Eucharistic Adoration",
//       "subtitle": "Spend time with Jesus",
//       "duration": "30 min",
//       "icon": Icons.wb_sunny_outlined,
//       "color": Colors.amber
//     },
//     {
//       "title": "Examination of Conscience",
//       "subtitle": "Daily self-reflection",
//       "duration": "15 min",
//       "icon": Icons.psychology,
//       "color": Colors.indigo
//     },
//     {
//       "title": "Spiritual Reading",
//       "subtitle": "Saints & theology",
//       "duration": "20 min",
//       "icon": Icons.library_books,
//       "color": Colors.brown
//     },
//     {
//       "title": "Fasting & Abstinence",
//       "subtitle": "Sacrifice for God",
//       "duration": "All day",
//       "icon": Icons.no_meals,
//       "color": Colors.purple
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _headerAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _cardsAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1200),
//       vsync: this,
//     );

//     _floatingAnimationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     );

//     _progressAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 2000),
//       vsync: this,
//     );

//     _pulseAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );

//     _headerSlideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _headerAnimationController,
//         curve: Curves.easeOutCubic,
//       ),
//     );

//     _cardsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _cardsAnimationController,
//         curve: Curves.easeIn,
//       ),
//     );

//     _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
//       CurvedAnimation(
//         parent: _floatingAnimationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _progressAnimationController,
//         curve: Curves.easeOutCubic,
//       ),
//     );

//     _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
//       CurvedAnimation(
//         parent: _pulseAnimationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     _headerAnimationController.forward();
//     _cardsAnimationController.forward();
//     _floatingAnimationController.repeat(reverse: true);
//     _progressAnimationController.forward();
//     _pulseAnimationController.repeat(reverse: true);

//     _devotionalTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       setState(() {
//         _currentDevotionalIndex = (_currentDevotionalIndex + 1) % _devotionalContent.length;
//       });
//     });

//     _inspirationTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
//       setState(() {
//         _currentInspirationIndex = (_currentInspirationIndex + 1) % _inspirationalQuotes.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _headerAnimationController.dispose();
//     _cardsAnimationController.dispose();
//     _floatingAnimationController.dispose();
//     _progressAnimationController.dispose();
//     _pulseAnimationController.dispose();
//     _devotionalTimer?.cancel();
//     _inspirationTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppTopBar(
//         title: 'Daily Devotional',
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 25),
//             child: Icon(Icons.notifications),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(Icons.settings),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               Colors.blue.shade50,
//               Colors.purple.shade50,
//               Colors.pink.shade50,
//             ],
//           ),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           children: [
//             _buildWelcomeHeader(),
//             const SizedBox(height: 20),
//             _buildProgressCard(),
//             const SizedBox(height: 25),
//             _buildFeaturedDevotional(),
//             const SizedBox(height: 25),
//             _buildSectionHeader('Today\'s Schedule', 'Customize'),
//             const SizedBox(height: 12),
//             _buildDailySchedule(),
//             const SizedBox(height: 25),
//             _buildSectionHeader('Quick Prayers', 'View All'),
//             const SizedBox(height: 12),
//             _buildQuickPrayers(),
//             const SizedBox(height: 25),
//             _buildSectionHeader('Devotional Practices', 'Explore'),
//             const SizedBox(height: 12),
//             _buildDevotionalCategories(),
//             const SizedBox(height: 25),
//             _buildWeeklyGoals(),
//             const SizedBox(height: 25),
//             _buildSectionHeader('Spiritual Practices', 'Learn More'),
//             const SizedBox(height: 12),
//             _buildSpiritualPractices(),
//             // const SizedBox(height: 25),
//             // _buildInspirationalQuote(),
//             // const SizedBox(height: 25),
//             // _buildUpcomingFeasts(),
//             const SizedBox(height: 25),
//             _buildSpiritualGrowthTracker(),
//             const SizedBox(height: 25),
//             _buildPrayerIntentions(),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeHeader() {
//     return AnimatedBuilder(
//       animation: _headerSlideAnimation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _headerSlideAnimation.value),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Welcome Back!",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           foreground: Paint()
//                             ..shader = LinearGradient(
//                               colors: [Colors.blue.shade700, Colors.purple.shade700],
//                             ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Continue your spiritual journey",
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _buildStreakBadge(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildSectionHeader(String title, String actionText) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               color: Colors.blue,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: Text(
//               actionText,
//               style: const TextStyle(
//                 color: Colors.blue,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStreakBadge() {
//     return AnimatedBuilder(
//       animation: _floatingAnimationController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _floatingAnimation.value / 2),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.amber.shade400, Colors.orange.shade500],
//               ),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.orange.withOpacity(0.4),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
//                 const SizedBox(width: 6),
//                 Text(
//                   "$_streakDays Days",
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildProgressCard() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: AnimatedBuilder(
//         animation: _progressAnimation,
//         builder: (context, child) {
//           return Container(
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.blue.shade400, Colors.purple.shade500],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.blue.withOpacity(0.3),
//                   blurRadius: 20,
//                   offset: const Offset(0, 10),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Today's Progress",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "${(_todayProgress * _progressAnimation.value).toInt()}%",
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: LinearProgressIndicator(
//                     value: (_todayProgress / 100) * _progressAnimation.value,
//                     backgroundColor: Colors.white.withOpacity(0.3),
//                     valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                     minHeight: 12,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildProgressStat("Prayers", "3/4", Icons.favorite),
//                     _buildProgressStat("Reading", "15 min", Icons.menu_book),
//                     _buildProgressStat("Reflection", "Done", Icons.check_circle),
//                   ],
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildProgressStat(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white.withOpacity(0.9), size: 22),
//         const SizedBox(height: 6),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.8),
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFeaturedDevotional() {
//     final current = _devotionalContent[_currentDevotionalIndex];
    
//     return AnimatedBuilder(
//       animation: _cardsFadeAnimation,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _cardsFadeAnimation.value,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: GestureDetector(
//               onTap: () {},
//               child: Container(
//                 padding: const EdgeInsets.all(24),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: current["gradient"] as List<Color>,
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: (current["color"] as Color).withOpacity(0.4),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           child: Icon(
//                             current["icon"] as IconData,
//                             color: Colors.white,
//                             size: 28,
//                           ),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 current["title"] as String,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(Icons.access_time, 
//                                     color: Colors.white.withOpacity(0.9), 
//                                     size: 16
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(
//                                     "${current["time"]} • ${current["duration"]}",
//                                     style: TextStyle(
//                                       color: Colors.white.withOpacity(0.9),
//                                       fontSize: 13,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       current["description"] as String,
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.95),
//                         fontSize: 15,
//                         height: 1.5,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: current["color"] as Color,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               elevation: 0,
//                             ),
//                             child: const Text(
//                               "Start Now",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.3),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.bookmark_border, color: Colors.white),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildDailySchedule() {
//     return SizedBox(
//       height: 180,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _devotionalContent.length,
//         itemBuilder: (context, index) {
//           final item = _devotionalContent[index];
//           return _buildScheduleCard(item, index);
//         },
//       ),
//     );
//   }

//   Widget _buildScheduleCard(Map<String, dynamic> item, int index) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: (item["color"] as Color).withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     item["icon"] as IconData,
//                     color: item["color"] as Color,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   item["title"] as String,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.access_time,
//                       size: 14,
//                       color: Colors.grey.shade600,
//                     ),
//                     const SizedBox(width: 4),
//                     Text(
//                       item["time"] as String,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     item["duration"] as String,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (index % 2 == 0)
//             Positioned(
//               top: 12,
//               right: 12,
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   color: Colors.green.shade400,
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.check,
//                   color: Colors.white,
//                   size: 14,
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQuickPrayers() {
//     return SizedBox(
//       height: 80,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _quickPrayers.length,
//         itemBuilder: (context, index) {
//           return _buildQuickPrayerChip(_quickPrayers[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildQuickPrayerChip(Map<String, String> prayer) {
//     return Container(
//       margin: const EdgeInsets.only(right: 12),
//       child: ElevatedButton(
//         onPressed: () {},
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.blue.shade700,
//           elevation: 4,
//           shadowColor: Colors.blue.withOpacity(0.3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               prayer["title"]!,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               prayer["duration"]!,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDevotionalCategories() {
//     return SizedBox(
//       height: 140,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _devotionalCategories.length,
//         itemBuilder: (context, index) {
//           final category = _devotionalCategories[index];
//           return GestureDetector(
//             onTap: () {},
//             child: Container(
//               width: 140,
//               margin: const EdgeInsets.only(right: 16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (category["color"] as Color).withOpacity(0.2),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: (category["color"] as Color).withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       category["icon"] as IconData,
//                       color: category["color"] as Color,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     category["title"] as String,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const Spacer(),
//                   Text(
//                     category["count"] as String,
//                     style: TextStyle(
//                       fontSize: 11,
//                       color: Colors.grey.shade600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildWeeklyGoals() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Weekly Goals",
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.green.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     "5 Days Left",
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.green.shade700,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ..._weeklyGoals.map((goal) => _buildGoalItem(goal)).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGoalItem(Map<String, dynamic> goal) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: (goal["color"] as Color).withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Icon(
//                   goal["icon"] as IconData,
//                   color: goal["color"] as Color,
//                   size: 20,
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       goal["title"] as String,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "${goal["current"]}/${goal["target"]} completed",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 "${(goal["progress"] as double).toInt()}%",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14,
//                   color: goal["color"] as Color,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(10),
//             child: LinearProgressIndicator(
//               value: goal["progress"] as double,
//               backgroundColor: Colors.grey.shade200,
//               valueColor: AlwaysStoppedAnimation<Color>(goal["color"] as Color),
//               minHeight: 8,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSpiritualPractices() {
//     return SizedBox(
//       height: 160,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _spiritualPractices.length,
//         itemBuilder: (context, index) {
//           final practice = _spiritualPractices[index];
//           return GestureDetector(
//             onTap: () {},
//             child: Container(
//               width: 180,
//               margin: const EdgeInsets.only(right: 16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     (practice["color"] as Color).withOpacity(0.7),
//                     (practice["color"] as Color),
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: (practice["color"] as Color).withOpacity(0.3),
//                     blurRadius: 15,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Icon(
//                     practice["icon"] as IconData,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                   const SizedBox(height: 12),
//                   Text(
//                     practice["title"] as String,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     practice["subtitle"] as String,
//                     style: TextStyle(
//                       color: Colors.white.withOpacity(0.9),
//                       fontSize: 12,
//                     ),
//                   ),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.schedule,
//                         color: Colors.white.withOpacity(0.9),
//                         size: 14,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         practice["duration"] as String,
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.9),
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildInspirationalQuote() {
//     return AnimatedBuilder(
//       animation: _pulseAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _pulseAnimation.value,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Container(
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.amber.shade200, Colors.orange.shade300],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(24),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.orange.withOpacity(0.3),
//                     blurRadius: 20,
//                     offset: const Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.4),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: const Icon(
//                           Icons.format_quote,
//                           color: Colors.white,
//                           size: 24,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       const Text(
//                         "Inspirational Quote",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     _inspirationalQuotes[_currentInspirationIndex]["quote"]!,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontStyle: FontStyle.italic,
//                       height: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       "— ${_inspirationalQuotes[_currentInspirationIndex]["author"]}",
//                       style: TextStyle(
//                         color: Colors.white.withOpacity(0.9),
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildUpcomingFeasts() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.red.shade300, Colors.pink.shade400],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.celebration, color: Colors.white, size: 28),
//                 const SizedBox(width: 12),
//                 const Text(
//                   "Upcoming Feast Days",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             ..._upcomingFeasts.map((feast) => _buildFeastItem(feast)).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildFeastItem(Map<String, String> feast) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.3),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(
//               Icons.calendar_today,
//               color: Colors.white,
//               size: 20,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   feast["name"]!,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   feast["type"]!,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.8),
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             feast["date"]!,
//             style: const TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 14,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSpiritualGrowthTracker() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.teal.shade300, Colors.cyan.shade400],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.teal.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Icon(Icons.trending_up, color: Colors.white, size: 28),
//                 const SizedBox(width: 12),
//                 const Text(
//                   "Spiritual Growth",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             _buildGrowthMetric("Prayer Time", "45 min", "↑ 15% this week", Icons.timelapse),
//             const SizedBox(height: 12),
//             _buildGrowthMetric("Bible Chapters", "12", "↑ 3 from last week", Icons.book),
//             const SizedBox(height: 12),
//             _buildGrowthMetric("Consistency", "12 Days", "Keep going!", Icons.emoji_events),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGrowthMetric(String label, String value, String change, IconData icon) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.2),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.white, size: 20),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: TextStyle(
//                     color: Colors.white.withOpacity(0.9),
//                     fontSize: 13,
//                   ),
//                 ),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Text(
//             change,
//             style: TextStyle(
//               color: Colors.white.withOpacity(0.9),
//               fontSize: 12,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPrayerIntentions() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.deepPurple.shade300, Colors.purple.shade500],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.purple.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.volunteer_activism, color: Colors.white, size: 28),
//                     const SizedBox(width: 12),
//                     const Text(
//                       "Prayer Intentions",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Text(
//                     "247 Active",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Join thousands of faithful in prayer. Share your intentions and pray for others in our community.",
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.95),
//                 fontSize: 14,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.add, size: 18),
//                     label: const Text("Add Intention"),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       foregroundColor: Colors.purple.shade700,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: OutlinedButton.icon(
//                     onPressed: () {},
//                     icon: const Icon(Icons.favorite, size: 18),
//                     label: const Text("Pray for Others"),
//                     style: OutlinedButton.styleFrom(
//                       foregroundColor: Colors.white,
//                       side: const BorderSide(color: Colors.white, width: 2),
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }