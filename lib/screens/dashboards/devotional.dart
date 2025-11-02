import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'dart:async';

import '../features/devotionals/challenges/challenge_detail_screen.dart';
import '../features/devotionals/challenges/challenge_view_all_screen.dart';

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
  String _selectedChallengeTab = 'Daily';

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
      "audioUrl": "morning_prayer.mp3",
    },
    {
      "title": "Scripture Reading",
      "time": "12:00 PM",
      "duration": "15 min",
      "description": "Dive deep into God's Word and find wisdom for today",
      "icon": Icons.menu_book,
      "colors": [const Color(0xFF4A90E2), const Color(0xFF3A7BC8)],
      "audioUrl": "scripture_reading.mp3",
    },
    {
      "title": "Rosary",
      "time": "3:00 PM",
      "duration": "20 min",
      "description": "Meditate on the mysteries of Christ through Mary's eyes",
      "icon": Icons.circle_outlined,
      "colors": [const Color(0xFF9B7EBD), const Color(0xFF6B5B95)],
      "audioUrl": "rosary.mp3",
    },
    {
      "title": "Evening Reflection",
      "time": "8:00 PM",
      "duration": "10 min",
      "description": "Review your day and thank God for His blessings",
      "icon": Icons.nightlight_round,
      "colors": [const Color(0xFF5B7C99), const Color(0xFF3E5469)],
      "audioUrl": "evening_reflection.mp3",
    },
  ];

  final List<Map<String, dynamic>> _quickPrayers = [
    {"title": "Our Father", "duration": "2 min", "content": "Our Father prayer content...", "audioUrl": "our_father.mp3"},
    {"title": "Hail Mary", "duration": "1 min", "content": "Hail Mary prayer content...", "audioUrl": "hail_mary.mp3"},
    {"title": "Glory Be", "duration": "30 sec", "content": "Glory Be prayer content...", "audioUrl": "glory_be.mp3"},
    {"title": "Guardian Angel", "duration": "1 min", "content": "Guardian Angel prayer content...", "audioUrl": "guardian_angel.mp3"},
    {"title": "St. Michael", "duration": "2 min", "content": "St. Michael prayer content...", "audioUrl": "st_michael.mp3"},
    {"title": "Angelus", "duration": "3 min", "content": "Angelus prayer content...", "audioUrl": "angelus.mp3"},
  ];

  final Map<String, List<Map<String, dynamic>>> _challenges = {
    'Daily': [
      {
        "title": "Read 3 Bible Chapters",
        "description": "Complete today's scripture reading from the Gospel",
        "progress": 0.67,
        "current": 2,
        "total": 3,
        "icon": Icons.menu_book,
        "color": Color(0xFF4A90E2),
        "type": "Bible Challenge"
      },
      {
        "title": "Pray the Rosary",
        "description": "Complete all mysteries with devotion",
        "progress": 0.0,
        "current": 0,
        "total": 1,
        "icon": Icons.circle_outlined,
        "color": Color(0xFF9B7EBD),
        "type": "Prayer Challenge"
      },
      {
        "title": "Random Act of Kindness",
        "description": "Help someone in need today",
        "progress": 0.0,
        "current": 0,
        "total": 1,
        "icon": Icons.volunteer_activism,
        "color": Color(0xFFD97687),
        "type": "Charity Challenge"
      },
    ],
    'Weekly': [
      {
        "title": "Attend Mass 3 Times",
        "description": "Be present at Holy Mass throughout the week",
        "progress": 0.33,
        "current": 1,
        "total": 3,
        "icon": Icons.church,
        "color": Color(0xFFE57373),
        "type": "Prayer Challenge"
      },
      {
        "title": "Complete Bible Reading Plan",
        "description": "Read all assigned chapters for the week",
        "progress": 0.57,
        "current": 4,
        "total": 7,
        "icon": Icons.auto_stories,
        "color": Color(0xFF4A90E2),
        "type": "Bible Challenge"
      },
      {
        "title": "Volunteer 2 Hours",
        "description": "Serve your community with love",
        "progress": 0.5,
        "current": 1,
        "total": 2,
        "icon": Icons.favorite,
        "color": Color(0xFFFFB74D),
        "type": "Charity Challenge"
      },
    ],
    'Monthly': [
      {
        "title": "30-Day Rosary Devotion",
        "description": "Pray the rosary every day this month",
        "progress": 0.4,
        "current": 12,
        "total": 30,
        "icon": Icons.calendar_month,
        "color": Color(0xFF9B7EBD),
        "type": "Prayer Challenge"
      },
      {
        "title": "Read Complete Gospel",
        "description": "Finish reading the Gospel of Mark",
        "progress": 0.625,
        "current": 10,
        "total": 16,
        "icon": Icons.book,
        "color": Color(0xFF50B5B0),
        "type": "Bible Challenge"
      },
      {
        "title": "Support 5 Causes",
        "description": "Donate or volunteer for charitable causes",
        "progress": 0.6,
        "current": 3,
        "total": 5,
        "icon": Icons.handshake,
        "color": Color(0xFF7CB798),
        "type": "Charity Challenge"
      },
    ],
    'Yearly': [
      {
        "title": "Read Entire Bible",
        "description": "Complete the full Bible reading plan",
        "progress": 0.28,
        "current": 104,
        "total": 365,
        "icon": Icons.menu_book,
        "color": Color(0xFF4A90E2),
        "type": "Bible Challenge"
      },
      {
        "title": "Daily Prayer Streak",
        "description": "Maintain consistent daily prayer",
        "progress": 0.32,
        "current": 118,
        "total": 365,
        "icon": Icons.local_fire_department,
        "color": Color(0xFFFF6B35),
        "type": "Prayer Challenge"
      },
      {
        "title": "100 Acts of Charity",
        "description": "Complete 100 charitable acts this year",
        "progress": 0.42,
        "current": 42,
        "total": 100,
        "icon": Icons.volunteer_activism,
        "color": Color(0xFFD4A574),
        "type": "Charity Challenge"
      },
    ],
  };

  final List<Map<String, dynamic>> _communityFeeds = [
    {
      "type": "prayer_request",
      "author": "Sarah Johnson",
      "authorImage": "assets/avatars/sarah.jpg",
      "timeAgo": "2 hours ago",
      "content": "Please pray for my father who is recovering from surgery. Your prayers mean the world to us.",
      "likes": 45,
      "comments": 12,
      "prayers": 78,
      "isLiked": false,
      "isPrayed": false,
    },
    {
      "type": "testimony",
      "author": "Michael Chen",
      "authorImage": "assets/avatars/michael.jpg",
      "timeAgo": "5 hours ago",
      "content": "Praise God! After months of prayer, I finally got the job I was hoping for. God is faithful!",
      "likes": 123,
      "comments": 28,
      "prayers": 0,
      "isLiked": true,
      "isPrayed": false,
    },
    {
      "type": "priest_post",
      "author": "Fr. James Martinez",
      "authorImage": "assets/avatars/priest.jpg",
      "timeAgo": "1 day ago",
      "title": "Daily Reflection: Finding Peace in Storms",
      "content": "Jesus said, 'Peace I leave with you; my peace I give you.' In times of trouble, remember that His peace surpasses all understanding.",
      "likes": 234,
      "comments": 45,
      "prayers": 0,
      "isLiked": false,
      "isPrayed": false,
      "verified": true,
    },
    {
      "type": "prayer_request",
      "author": "Emily Rodriguez",
      "authorImage": "assets/avatars/emily.jpg",
      "timeAgo": "3 hours ago",
      "content": "Requesting prayers for unity in our community and healing for all those suffering.",
      "likes": 67,
      "comments": 15,
      "prayers": 92,
      "isLiked": true,
      "isPrayed": true,
    },
  ];

  final List<Map<String, dynamic>> _devotionalCategories = [
    {"title": "Liturgy of Hours", "subtitle": "Daily Office", "icon": Icons.access_time, "count": "7 prayers", "color": const Color(0xFF4A90E2)},
    {"title": "Novenas", "subtitle": "9-Day Prayers", "icon": Icons.calendar_today, "count": "15 available", "color": const Color(0xFF6B5B95)},
    {"title": "Chaplets", "subtitle": "Divine Mercy & More", "icon": Icons.spa, "count": "8 chaplets", "color": const Color(0xFFD97687)},
    {"title": "Lectio Divina", "subtitle": "Sacred Reading", "icon": Icons.auto_stories, "count": "Daily guide", "color": const Color(0xFF50B5B0)},
    {"title": "Stations of the Cross", "subtitle": "Way of the Cross", "icon": Icons.add, "count": "14 stations", "color": const Color(0xFF8B7355)},
    {"title": "Marian Prayers", "subtitle": "Honoring Mary", "icon": Icons.favorite, "count": "20+ prayers", "color": const Color(0xFF7CB798)},
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
          _buildSectionHeader('Challenges', 'View All', onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChallengesViewAllScreen(
                  challenges: _challenges,
                  selectedTab: _selectedChallengeTab,
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
          _buildChallengeSection(),
          const SizedBox(height: 25),
          _buildSectionHeader('Today\'s Scripture', 'Customize'),
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
          _buildPrayerIntentions(),
          const SizedBox(height: 25),
          _buildSectionHeader('Community Feeds', 'See All'),
          const SizedBox(height: 12),
          _buildCommunityFeeds(),
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

  Widget _buildSectionHeader(String title, String actionText, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: _deepPurple, fontSize: 20, fontWeight: FontWeight.w600)),
          GestureDetector(
            onTap: onTap ?? () {},
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

  // Challenge Section - FIXED HEIGHT
  Widget _buildChallengeSection() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: ['Daily', 'Weekly', 'Monthly', 'Yearly'].map((tab) {
                final isSelected = _selectedChallengeTab == tab;
                return GestureDetector(
                  onTap: () => setState(() => _selectedChallengeTab = tab),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isSelected 
                        ? LinearGradient(colors: [_primaryBlue, _softTeal])
                        : null,
                      color: isSelected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected ? _primaryBlue.withOpacity(0.3) : Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? Colors.white : _deepPurple,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 210, // Fixed height increased to prevent overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: _challenges[_selectedChallengeTab]!.length,
            itemBuilder: (context, index) {
              return _buildChallengeCard(_challenges[_selectedChallengeTab]![index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChallengeDetailScreen(challenge: challenge),
          ),
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (challenge["color"] as Color).withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // Important for responsive layout
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (challenge["color"] as Color).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      challenge["icon"] as IconData,
                      color: challenge["color"] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge["title"] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: (challenge["color"] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            challenge["type"] as String,
                            style: TextStyle(
                              fontSize: 10,
                              color: challenge["color"] as Color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                challenge["description"] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${challenge["current"]}/${challenge["total"]} completed",
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${((challenge["progress"] as double) * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 13,
                      color: challenge["color"] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: challenge["progress"] as double,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(challenge["color"] as Color),
                  minHeight: 6,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _shareChallenge(challenge),
                  icon: const Icon(Icons.share, size: 14),
                  label: const Text("Share", style: TextStyle(fontSize: 11)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: challenge["color"] as Color,
                    side: BorderSide(color: challenge["color"] as Color),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareChallenge(Map<String, dynamic> challenge) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Share Challenge",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildShareOption(Icons.facebook, "Facebook", Colors.blue),
                _buildShareOption(Icons.message, "WhatsApp", const Color(0xFF25D366)),
                _buildShareOption(Icons.send, "Telegram", const Color(0xFF0088cc)),
                _buildShareOption(Icons.link, "Copy Link", _primaryBlue),
                _buildShareOption(Icons.group, "Community", _deepPurple),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Sharing via $label...")),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Today's Scripture with Listen, Read, Share icons
  Widget _buildDailySchedule() {
    return SizedBox(
      height: 220,
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
    return GestureDetector(
      onTap: () => _viewScriptureDetails(item),
      child: Container(
        width: 180,
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
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton(Icons.visibility, cardColor, () => _viewScriptureDetails(item), "View"),
                      _buildActionButton(Icons.headphones, cardColor, () => _playAudio(item["audioUrl"] as String), "Listen"),
                      _buildActionButton(Icons.share, cardColor, () => _shareContent(item), "Share"),
                    ],
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
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap, String tooltip) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }

  void _viewScriptureDetails(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Opening ${item['title']}...")),
    );
  }

  void _playAudio(String audioUrl) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Playing audio...")),
    );
  }

  void _shareContent(Map<String, dynamic> content) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Share Content",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildShareOption(Icons.facebook, "Facebook", Colors.blue),
                _buildShareOption(Icons.message, "WhatsApp", const Color(0xFF25D366)),
                _buildShareOption(Icons.send, "Telegram", const Color(0xFF0088cc)),
                _buildShareOption(Icons.link, "Twitter", const Color(0xFF1DA1F2)),
                _buildShareOption(Icons.link, "Copy Link", _primaryBlue),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Quick Prayers with better UI and action buttons - FIXED HEIGHT
  Widget _buildQuickPrayers() {
    return SizedBox(
      height: 155, // Increased height to prevent overflow
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _quickPrayers.length,
        itemBuilder: (context, index) {
          return _buildQuickPrayerCard(_quickPrayers[index]);
        },
      ),
    );
  }

  Widget _buildQuickPrayerCard(Map<String, dynamic> prayer) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _deepPurple.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [_deepPurple.withOpacity(0.15), _primaryBlue.withOpacity(0.15)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.favorite_border, color: _deepPurple, size: 20),
            ),
            const SizedBox(height: 10),
            Text(
              prayer["title"]!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              prayer["duration"]!,
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.visibility, _deepPurple, () => _viewPrayerDetails(prayer), "View"),
                _buildActionButton(Icons.headphones, _primaryBlue, () => _playAudio(prayer["audioUrl"] as String), "Listen"),
                _buildActionButton(Icons.share, _softTeal, () => _shareContent(prayer), "Share"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewPrayerDetails(Map<String, dynamic> prayer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(prayer["title"]!),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Duration: ${prayer["duration"]}",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              prayer["content"] as String,
              style: const TextStyle(height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _playAudio(prayer["audioUrl"] as String);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Listen"),
          ),
        ],
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

  // Community Feeds Section
  Widget _buildCommunityFeeds() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: _communityFeeds.map((feed) => _buildCommunityFeedCard(feed)).toList(),
      ),
    );
  }

  Widget _buildCommunityFeedCard(Map<String, dynamic> feed) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: _primaryBlue.withOpacity(0.2),
                  child: Text(
                    (feed["author"] as String).substring(0, 1),
                    style: TextStyle(
                      color: _primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            feed["author"] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          if (feed["verified"] == true) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.verified, size: 16, color: _primaryBlue),
                          ],
                        ],
                      ),
                      Text(
                        feed["timeAgo"] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getFeedTypeColor(feed["type"] as String).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getFeedTypeLabel(feed["type"] as String),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: _getFeedTypeColor(feed["type"] as String),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (feed["title"] != null) ...[
              Text(
                feed["title"] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: _deepPurple,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              feed["content"] as String,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade800,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildFeedActionButton(
                  icon: feed["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
                  label: "${feed["likes"]}",
                  color: feed["isLiked"] == true ? _roseRed : Colors.grey.shade600,
                  onTap: () => _toggleLike(feed),
                ),
                const SizedBox(width: 20),
                _buildFeedActionButton(
                  icon: Icons.comment_outlined,
                  label: "${feed["comments"]}",
                  color: Colors.grey.shade600,
                  onTap: () => _showComments(feed),
                ),
                if (feed["type"] == "prayer_request") ...[
                  const SizedBox(width: 20),
                  _buildFeedActionButton(
                    icon: feed["isPrayed"] == true ? Icons.waving_hand : Icons.volunteer_activism,
                    label: "${feed["prayers"]}",
                    color: feed["isPrayed"] == true ? _primaryBlue : Colors.grey.shade600,
                    onTap: () => _togglePrayer(feed),
                  ),
                ],
                const Spacer(),
                IconButton(
                  onPressed: () => _shareContent(feed),
                  icon: Icon(Icons.share, size: 20, color: Colors.grey.shade600),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getFeedTypeColor(String type) {
    switch (type) {
      case "prayer_request":
        return _primaryBlue;
      case "testimony":
        return _sageGreen;
      case "priest_post":
        return _deepPurple;
      default:
        return Colors.grey;
    }
  }

  String _getFeedTypeLabel(String type) {
    switch (type) {
      case "prayer_request":
        return "Prayer Request";
      case "testimony":
        return "Testimony";
      case "priest_post":
        return "Daily Word";
      default:
        return "Post";
    }
  }

  Widget _buildFeedActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(Map<String, dynamic> feed) {
    setState(() {
      if (feed["isLiked"] == true) {
        feed["isLiked"] = false;
        feed["likes"] = (feed["likes"] as int) - 1;
      } else {
        feed["isLiked"] = true;
        feed["likes"] = (feed["likes"] as int) + 1;
      }
    });
  }

  void _togglePrayer(Map<String, dynamic> feed) {
    setState(() {
      if (feed["isPrayed"] == true) {
        feed["isPrayed"] = false;
        feed["prayers"] = (feed["prayers"] as int) - 1;
      } else {
        feed["isPrayed"] = true;
        feed["prayers"] = (feed["prayers"] as int) + 1;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You're now praying for ${feed['author']}"),
            backgroundColor: _primaryBlue,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  void _showComments(Map<String, dynamic> feed) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Comments (${feed['comments']})",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildCommentItem("John Doe", "Praying for you and your family! 🙏", "1h ago"),
                    _buildCommentItem("Mary Smith", "God bless you! Stay strong in faith.", "3h ago"),
                    _buildCommentItem("Peter Brown", "Adding this to my daily prayers.", "5h ago"),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: _primaryBlue,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white, size: 20),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCommentItem(String author, String comment, String time) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: _primaryBlue.withOpacity(0.2),
            child: Text(
              author.substring(0, 1),
              style: TextStyle(
                color: _primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:faith_plus/common/constants.dart';
// import 'dart:async';

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
  
//   late Animation<double> _headerSlideAnimation;
//   late Animation<double> _cardsFadeAnimation;
//   late Animation<double> _floatingAnimation;
//   late Animation<double> _progressAnimation;

//   int _currentDevotionalIndex = 0;
//   Timer? _devotionalTimer;
//   int _todayProgress = 65;
//   int _streakDays = 12;
//   String _selectedChallengeTab = 'Daily';

//   // Harmonious color palette - Soft, calming religious theme
//   final Color _primaryBlue = const Color(0xFF4A90E2);
//   final Color _deepPurple = const Color(0xFF6B5B95);
//   final Color _softTeal = const Color(0xFF50B5B0);
//   final Color _warmGold = const Color(0xFFD4A574);
//   final Color _roseRed = const Color(0xFFD97687);
//   final Color _sageGreen = const Color(0xFF7CB798);

//   final List<Map<String, dynamic>> _devotionalContent = [
//     {
//       "title": "Morning Prayer",
//       "time": "6:00 AM",
//       "duration": "10 min",
//       "description": "Start your day with gratitude and surrender to God's will",
//       "icon": Icons.wb_sunny,
//       "colors": [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
//       "audioUrl": "morning_prayer.mp3",
//     },
//     {
//       "title": "Scripture Reading",
//       "time": "12:00 PM",
//       "duration": "15 min",
//       "description": "Dive deep into God's Word and find wisdom for today",
//       "icon": Icons.menu_book,
//       "colors": [const Color(0xFF4A90E2), const Color(0xFF3A7BC8)],
//       "audioUrl": "scripture_reading.mp3",
//     },
//     {
//       "title": "Rosary",
//       "time": "3:00 PM",
//       "duration": "20 min",
//       "description": "Meditate on the mysteries of Christ through Mary's eyes",
//       "icon": Icons.circle_outlined,
//       "colors": [const Color(0xFF9B7EBD), const Color(0xFF6B5B95)],
//       "audioUrl": "rosary.mp3",
//     },
//     {
//       "title": "Evening Reflection",
//       "time": "8:00 PM",
//       "duration": "10 min",
//       "description": "Review your day and thank God for His blessings",
//       "icon": Icons.nightlight_round,
//       "colors": [const Color(0xFF5B7C99), const Color(0xFF3E5469)],
//       "audioUrl": "evening_reflection.mp3",
//     },
//   ];

//   final List<Map<String, dynamic>> _quickPrayers = [
//     {"title": "Our Father", "duration": "2 min", "content": "Our Father prayer content...", "audioUrl": "our_father.mp3"},
//     {"title": "Hail Mary", "duration": "1 min", "content": "Hail Mary prayer content...", "audioUrl": "hail_mary.mp3"},
//     {"title": "Glory Be", "duration": "30 sec", "content": "Glory Be prayer content...", "audioUrl": "glory_be.mp3"},
//     {"title": "Guardian Angel", "duration": "1 min", "content": "Guardian Angel prayer content...", "audioUrl": "guardian_angel.mp3"},
//     {"title": "St. Michael", "duration": "2 min", "content": "St. Michael prayer content...", "audioUrl": "st_michael.mp3"},
//     {"title": "Angelus", "duration": "3 min", "content": "Angelus prayer content...", "audioUrl": "angelus.mp3"},
//   ];

//   final Map<String, List<Map<String, dynamic>>> _challenges = {
//     'Daily': [
//       {
//         "title": "Read 3 Bible Chapters",
//         "description": "Complete today's scripture reading from the Gospel",
//         "progress": 0.67,
//         "current": 2,
//         "total": 3,
//         "icon": Icons.menu_book,
//         "color": Color(0xFF4A90E2),
//         "type": "Bible Challenge"
//       },
//       {
//         "title": "Pray the Rosary",
//         "description": "Complete all mysteries with devotion",
//         "progress": 0.0,
//         "current": 0,
//         "total": 1,
//         "icon": Icons.circle_outlined,
//         "color": Color(0xFF9B7EBD),
//         "type": "Prayer Challenge"
//       },
//       {
//         "title": "Random Act of Kindness",
//         "description": "Help someone in need today",
//         "progress": 0.0,
//         "current": 0,
//         "total": 1,
//         "icon": Icons.volunteer_activism,
//         "color": Color(0xFFD97687),
//         "type": "Charity Challenge"
//       },
//     ],
//     'Weekly': [
//       {
//         "title": "Attend Mass 3 Times",
//         "description": "Be present at Holy Mass throughout the week",
//         "progress": 0.33,
//         "current": 1,
//         "total": 3,
//         "icon": Icons.church,
//         "color": Color(0xFFE57373),
//         "type": "Prayer Challenge"
//       },
//       {
//         "title": "Complete Bible Reading Plan",
//         "description": "Read all assigned chapters for the week",
//         "progress": 0.57,
//         "current": 4,
//         "total": 7,
//         "icon": Icons.auto_stories,
//         "color": Color(0xFF4A90E2),
//         "type": "Bible Challenge"
//       },
//       {
//         "title": "Volunteer 2 Hours",
//         "description": "Serve your community with love",
//         "progress": 0.5,
//         "current": 1,
//         "total": 2,
//         "icon": Icons.favorite,
//         "color": Color(0xFFFFB74D),
//         "type": "Charity Challenge"
//       },
//     ],
//     'Monthly': [
//       {
//         "title": "30-Day Rosary Devotion",
//         "description": "Pray the rosary every day this month",
//         "progress": 0.4,
//         "current": 12,
//         "total": 30,
//         "icon": Icons.calendar_month,
//         "color": Color(0xFF9B7EBD),
//         "type": "Prayer Challenge"
//       },
//       {
//         "title": "Read Complete Gospel",
//         "description": "Finish reading the Gospel of Mark",
//         "progress": 0.625,
//         "current": 10,
//         "total": 16,
//         "icon": Icons.book,
//         "color": Color(0xFF50B5B0),
//         "type": "Bible Challenge"
//       },
//       {
//         "title": "Support 5 Causes",
//         "description": "Donate or volunteer for charitable causes",
//         "progress": 0.6,
//         "current": 3,
//         "total": 5,
//         "icon": Icons.handshake,
//         "color": Color(0xFF7CB798),
//         "type": "Charity Challenge"
//       },
//     ],
//     'Yearly': [
//       {
//         "title": "Read Entire Bible",
//         "description": "Complete the full Bible reading plan",
//         "progress": 0.28,
//         "current": 104,
//         "total": 365,
//         "icon": Icons.menu_book,
//         "color": Color(0xFF4A90E2),
//         "type": "Bible Challenge"
//       },
//       {
//         "title": "Daily Prayer Streak",
//         "description": "Maintain consistent daily prayer",
//         "progress": 0.32,
//         "current": 118,
//         "total": 365,
//         "icon": Icons.local_fire_department,
//         "color": Color(0xFFFF6B35),
//         "type": "Prayer Challenge"
//       },
//       {
//         "title": "100 Acts of Charity",
//         "description": "Complete 100 charitable acts this year",
//         "progress": 0.42,
//         "current": 42,
//         "total": 100,
//         "icon": Icons.volunteer_activism,
//         "color": Color(0xFFD4A574),
//         "type": "Charity Challenge"
//       },
//     ],
//   };

//   final List<Map<String, dynamic>> _communityFeeds = [
//     {
//       "type": "prayer_request",
//       "author": "Sarah Johnson",
//       "authorImage": "assets/avatars/sarah.jpg",
//       "timeAgo": "2 hours ago",
//       "content": "Please pray for my father who is recovering from surgery. Your prayers mean the world to us.",
//       "likes": 45,
//       "comments": 12,
//       "prayers": 78,
//       "isLiked": false,
//       "isPrayed": false,
//     },
//     {
//       "type": "testimony",
//       "author": "Michael Chen",
//       "authorImage": "assets/avatars/michael.jpg",
//       "timeAgo": "5 hours ago",
//       "content": "Praise God! After months of prayer, I finally got the job I was hoping for. God is faithful!",
//       "likes": 123,
//       "comments": 28,
//       "prayers": 0,
//       "isLiked": true,
//       "isPrayed": false,
//     },
//     {
//       "type": "priest_post",
//       "author": "Fr. James Martinez",
//       "authorImage": "assets/avatars/priest.jpg",
//       "timeAgo": "1 day ago",
//       "title": "Daily Reflection: Finding Peace in Storms",
//       "content": "Jesus said, 'Peace I leave with you; my peace I give you.' In times of trouble, remember that His peace surpasses all understanding.",
//       "likes": 234,
//       "comments": 45,
//       "prayers": 0,
//       "isLiked": false,
//       "isPrayed": false,
//       "verified": true,
//     },
//     {
//       "type": "prayer_request",
//       "author": "Emily Rodriguez",
//       "authorImage": "assets/avatars/emily.jpg",
//       "timeAgo": "3 hours ago",
//       "content": "Requesting prayers for unity in our community and healing for all those suffering.",
//       "likes": 67,
//       "comments": 15,
//       "prayers": 92,
//       "isLiked": true,
//       "isPrayed": true,
//     },
//   ];

//   final List<Map<String, dynamic>> _devotionalCategories = [
//     {"title": "Liturgy of Hours", "subtitle": "Daily Office", "icon": Icons.access_time, "count": "7 prayers", "color": const Color(0xFF4A90E2)},
//     {"title": "Novenas", "subtitle": "9-Day Prayers", "icon": Icons.calendar_today, "count": "15 available", "color": const Color(0xFF6B5B95)},
//     {"title": "Chaplets", "subtitle": "Divine Mercy & More", "icon": Icons.spa, "count": "8 chaplets", "color": const Color(0xFFD97687)},
//     {"title": "Lectio Divina", "subtitle": "Sacred Reading", "icon": Icons.auto_stories, "count": "Daily guide", "color": const Color(0xFF50B5B0)},
//     {"title": "Stations of the Cross", "subtitle": "Way of the Cross", "icon": Icons.add, "count": "14 stations", "color": const Color(0xFF8B7355)},
//     {"title": "Marian Prayers", "subtitle": "Honoring Mary", "icon": Icons.favorite, "count": "20+ prayers", "color": const Color(0xFF7CB798)},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _headerAnimationController = AnimationController(duration: const Duration(milliseconds: 1500), vsync: this);
//     _cardsAnimationController = AnimationController(duration: const Duration(milliseconds: 1200), vsync: this);
//     _floatingAnimationController = AnimationController(duration: const Duration(seconds: 3), vsync: this);
//     _progressAnimationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

//     _headerSlideAnimation = Tween<double>(begin: -100.0, end: 0.0).animate(
//       CurvedAnimation(parent: _headerAnimationController, curve: Curves.easeOutCubic),
//     );
//     _cardsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _cardsAnimationController, curve: Curves.easeIn),
//     );
//     _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
//       CurvedAnimation(parent: _floatingAnimationController, curve: Curves.easeInOut),
//     );
//     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _progressAnimationController, curve: Curves.easeOutCubic),
//     );

//     _headerAnimationController.forward();
//     _cardsAnimationController.forward();
//     _floatingAnimationController.repeat(reverse: true);
//     _progressAnimationController.forward();

//     _devotionalTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
//       setState(() {
//         _currentDevotionalIndex = (_currentDevotionalIndex + 1) % _devotionalContent.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _headerAnimationController.dispose();
//     _cardsAnimationController.dispose();
//     _floatingAnimationController.dispose();
//     _progressAnimationController.dispose();
//     _devotionalTimer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FC),
//       appBar: const AppTopBar(
//         title: 'Daily Devotional',
//         actions: [
//           Padding(padding: EdgeInsets.only(right: 25), child: Icon(Icons.notifications)),
//           Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.settings)),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         children: [
//           _buildWelcomeHeader(),
//           const SizedBox(height: 20),
//           _buildProgressCard(),
//           const SizedBox(height: 25),
//           _buildSectionHeader('Challenges', 'View All'),
//           const SizedBox(height: 12),
//           _buildChallengeSection(),
//           const SizedBox(height: 25),
//           _buildSectionHeader('Today\'s Scripture', 'Customize'),
//           const SizedBox(height: 12),
//           _buildDailySchedule(),
//           const SizedBox(height: 25),
//           _buildSectionHeader('Quick Prayers', 'View All'),
//           const SizedBox(height: 12),
//           _buildQuickPrayers(),
//           const SizedBox(height: 25),
//           _buildSectionHeader('Devotional Practices', 'Explore'),
//           const SizedBox(height: 12),
//           _buildDevotionalCategories(),
//           const SizedBox(height: 25),
//           _buildPrayerIntentions(),
//           const SizedBox(height: 25),
//           _buildSectionHeader('Community Feeds', 'See All'),
//           const SizedBox(height: 12),
//           _buildCommunityFeeds(),
//           const SizedBox(height: 20),
//         ],
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
//                           color: _deepPurple,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Continue your spiritual journey",
//                         style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
//           Text(title, style: TextStyle(color: _deepPurple, fontSize: 20, fontWeight: FontWeight.w600)),
//           GestureDetector(
//             onTap: () {},
//             child: Text(actionText, style: TextStyle(color: _primaryBlue, fontSize: 14, fontWeight: FontWeight.w500)),
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
//               gradient: LinearGradient(colors: [const Color(0xFFFF6B35), const Color(0xFFFF8C42)]),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(color: const Color(0xFFFF6B35).withOpacity(0.3), blurRadius: 12, offset: const Offset(0, 4)),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
//                 const SizedBox(width: 6),
//                 Text("$_streakDays Days", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
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
//               gradient: LinearGradient(colors: [_primaryBlue, _softTeal], begin: Alignment.topLeft, end: Alignment.bottomRight),
//               borderRadius: BorderRadius.circular(24),
//               boxShadow: [
//                 BoxShadow(color: _primaryBlue.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Today's Progress", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//                     Text("${(_todayProgress * _progressAnimation.value).toInt()}%", style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
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
//         Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
//         Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
//       ],
//     );
//   }

//   // Challenge Section
//   Widget _buildChallengeSection() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: ['Daily', 'Weekly', 'Monthly', 'Yearly'].map((tab) {
//                 final isSelected = _selectedChallengeTab == tab;
//                 return GestureDetector(
//                   onTap: () => setState(() => _selectedChallengeTab = tab),
//                   child: Container(
//                     margin: const EdgeInsets.only(right: 12),
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     decoration: BoxDecoration(
//                       gradient: isSelected 
//                         ? LinearGradient(colors: [_primaryBlue, _softTeal])
//                         : null,
//                       color: isSelected ? null : Colors.white,
//                       borderRadius: BorderRadius.circular(20),
//                       boxShadow: [
//                         BoxShadow(
//                           color: isSelected ? _primaryBlue.withOpacity(0.3) : Colors.black.withOpacity(0.05),
//                           blurRadius: 8,
//                           offset: const Offset(0, 2),
//                         ),
//                       ],
//                     ),
//                     child: Text(
//                       tab,
//                       style: TextStyle(
//                         color: isSelected ? Colors.white : _deepPurple,
//                         fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         SizedBox(
//           height: 200,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             itemCount: _challenges[_selectedChallengeTab]!.length,
//             itemBuilder: (context, index) {
//               return _buildChallengeCard(_challenges[_selectedChallengeTab]![index]);
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildChallengeCard(Map<String, dynamic> challenge) {
//     return Container(
//       width: 280,
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: (challenge["color"] as Color).withOpacity(0.15),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: (challenge["color"] as Color).withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     challenge["icon"] as IconData,
//                     color: challenge["color"] as Color,
//                     size: 24,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         challenge["title"] as String,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const SizedBox(height: 4),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                         decoration: BoxDecoration(
//                           color: (challenge["color"] as Color).withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Text(
//                           challenge["type"] as String,
//                           style: TextStyle(
//                             fontSize: 10,
//                             color: challenge["color"] as Color,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Text(
//               challenge["description"] as String,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey.shade600,
//                 height: 1.4,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           const Spacer(),
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${challenge["current"]}/${challenge["total"]} completed",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     Text(
//                       "${((challenge["progress"] as double) * 100).toInt()}%",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: challenge["color"] as Color,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: LinearProgressIndicator(
//                     value: challenge["progress"] as double,
//                     backgroundColor: Colors.grey.shade200,
//                     valueColor: AlwaysStoppedAnimation<Color>(challenge["color"] as Color),
//                     minHeight: 8,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: OutlinedButton.icon(
//                         onPressed: () => _shareChallenge(challenge),
//                         icon: const Icon(Icons.share, size: 16),
//                         label: const Text("Share", style: TextStyle(fontSize: 12)),
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: challenge["color"] as Color,
//                           side: BorderSide(color: challenge["color"] as Color),
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _shareChallenge(Map<String, dynamic> challenge) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Share Challenge",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: _deepPurple,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 20,
//               runSpacing: 20,
//               alignment: WrapAlignment.center,
//               children: [
//                 _buildShareOption(Icons.facebook, "Facebook", Colors.blue),
//                 _buildShareOption(Icons.message, "WhatsApp", const Color(0xFF25D366)),
//                 _buildShareOption(Icons.send, "Telegram", const Color(0xFF0088cc)),
//                 _buildShareOption(Icons.link, "Copy Link", _primaryBlue),
//                 _buildShareOption(Icons.group, "Community", _deepPurple),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildShareOption(IconData icon, String label, Color color) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.pop(context);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Sharing via $label...")),
//         );
//       },
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: color.withOpacity(0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: color, size: 28),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             label,
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }

//   // Today's Scripture with Listen, Read, Share icons
//   Widget _buildDailySchedule() {
//     return SizedBox(
//       height: 220,
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
//     final cardColor = (item["colors"] as List<Color>)[0];
//     return GestureDetector(
//       onTap: () => _viewScriptureDetails(item),
//       child: Container(
//         width: 180,
//         margin: const EdgeInsets.only(right: 16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10, offset: const Offset(0, 4)),
//           ],
//         ),
//         child: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(color: cardColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
//                     child: Icon(item["icon"] as IconData, color: cardColor, size: 24),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(item["title"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15), maxLines: 2, overflow: TextOverflow.ellipsis),
//                   const Spacer(),
//                   Row(
//                     children: [
//                       Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
//                       const SizedBox(width: 4),
//                       Text(item["time"] as String, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
//                     ],
//                   ),
//                   const SizedBox(height: 4),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     decoration: BoxDecoration(color: cardColor.withOpacity(0.15), borderRadius: BorderRadius.circular(8)),
//                     child: Text(item["duration"] as String, style: TextStyle(fontSize: 11, color: cardColor, fontWeight: FontWeight.w600)),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       _buildActionButton(Icons.visibility, cardColor, () => _viewScriptureDetails(item), "View"),
//                       _buildActionButton(Icons.headphones, cardColor, () => _playAudio(item["audioUrl"] as String), "Listen"),
//                       _buildActionButton(Icons.share, cardColor, () => _shareContent(item), "Share"),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             if (index % 2 == 0)
//               Positioned(
//                 top: 12,
//                 right: 12,
//                 child: Container(
//                   padding: const EdgeInsets.all(4),
//                   decoration: BoxDecoration(color: _sageGreen, shape: BoxShape.circle),
//                   child: const Icon(Icons.check, color: Colors.white, size: 14),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(IconData icon, Color color, VoidCallback onTap, String tooltip) {
//     return Tooltip(
//       message: tooltip,
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, size: 16, color: color),
//         ),
//       ),
//     );
//   }

//   void _viewScriptureDetails(Map<String, dynamic> item) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Opening ${item['title']}...")),
//     );
//   }

//   void _playAudio(String audioUrl) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("Playing audio...")),
//     );
//   }

//   void _shareContent(Map<String, dynamic> content) {
//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "Share Content",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: _deepPurple,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Wrap(
//               spacing: 20,
//               runSpacing: 20,
//               alignment: WrapAlignment.center,
//               children: [
//                 _buildShareOption(Icons.facebook, "Facebook", Colors.blue),
//                 _buildShareOption(Icons.message, "WhatsApp", const Color(0xFF25D366)),
//                 _buildShareOption(Icons.send, "Telegram", const Color(0xFF0088cc)),
//                 _buildShareOption(Icons.link, "Twitter", const Color(0xFF1DA1F2)),
//                 _buildShareOption(Icons.link, "Copy Link", _primaryBlue),
//               ],
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   // Quick Prayers with better UI and action buttons
//   Widget _buildQuickPrayers() {
//     return SizedBox(
//       height: 140,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _quickPrayers.length,
//         itemBuilder: (context, index) {
//           return _buildQuickPrayerCard(_quickPrayers[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildQuickPrayerCard(Map<String, dynamic> prayer) {
//     return Container(
//       width: 160,
//       margin: const EdgeInsets.only(right: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: _deepPurple.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [_deepPurple.withOpacity(0.15), _primaryBlue.withOpacity(0.15)],
//                 ),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Icon(Icons.favorite_border, color: _deepPurple, size: 20),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               prayer["title"]!,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               prayer["duration"]!,
//               style: TextStyle(
//                 fontSize: 11,
//                 color: Colors.grey.shade600,
//               ),
//             ),
//             const Spacer(),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildActionButton(Icons.visibility, _deepPurple, () => _viewPrayerDetails(prayer), "View"),
//                 _buildActionButton(Icons.headphones, _primaryBlue, () => _playAudio(prayer["audioUrl"] as String), "Listen"),
//                 _buildActionButton(Icons.share, _softTeal, () => _shareContent(prayer), "Share"),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _viewPrayerDetails(Map<String, dynamic> prayer) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         title: Text(prayer["title"]!),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Duration: ${prayer["duration"]}",
//               style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               prayer["content"] as String,
//               style: const TextStyle(height: 1.5),
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Close"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _playAudio(prayer["audioUrl"] as String);
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: _primaryBlue,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//             ),
//             child: const Text("Listen"),
//           ),
//         ],
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
//                   BoxShadow(color: (category["color"] as Color).withOpacity(0.15), blurRadius: 10, offset: const Offset(0, 4)),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: (category["color"] as Color).withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(category["icon"] as IconData, color: category["color"] as Color, size: 24),
//                   ),
//                   const SizedBox(height: 12),
//                   Text(category["title"] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 2, overflow: TextOverflow.ellipsis),
//                   const Spacer(),
//                   Text(category["count"] as String, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildPrayerIntentions() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(colors: [_deepPurple, _roseRed], begin: Alignment.topLeft, end: Alignment.bottomRight),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(color: _deepPurple.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10)),
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
//                     const Text("Prayer Intentions", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.25),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Text("247 Active", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Join thousands of faithful in prayer. Share your intentions and pray for others in our community.",
//               style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 14, height: 1.5),
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
//                       foregroundColor: _deepPurple,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

//   // Community Feeds Section
//   Widget _buildCommunityFeeds() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         children: _communityFeeds.map((feed) => _buildCommunityFeedCard(feed)).toList(),
//       ),
//     );
//   }

//   Widget _buildCommunityFeedCard(Map<String, dynamic> feed) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 CircleAvatar(
//                   radius: 22,
//                   backgroundColor: _primaryBlue.withOpacity(0.2),
//                   child: Text(
//                     (feed["author"] as String).substring(0, 1),
//                     style: TextStyle(
//                       color: _primaryBlue,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             feed["author"] as String,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                           if (feed["verified"] == true) ...[
//                             const SizedBox(width: 4),
//                             Icon(Icons.verified, size: 16, color: _primaryBlue),
//                           ],
//                         ],
//                       ),
//                       Text(
//                         feed["timeAgo"] as String,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: _getFeedTypeColor(feed["type"] as String).withOpacity(0.15),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Text(
//                     _getFeedTypeLabel(feed["type"] as String),
//                     style: TextStyle(
//                       fontSize: 10,
//                       fontWeight: FontWeight.w600,
//                       color: _getFeedTypeColor(feed["type"] as String),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//             if (feed["title"] != null) ...[
//               Text(
//                 feed["title"] as String,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: _deepPurple,
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//             Text(
//               feed["content"] as String,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey.shade800,
//                 height: 1.5,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 _buildFeedActionButton(
//                   icon: feed["isLiked"] == true ? Icons.favorite : Icons.favorite_border,
//                   label: "${feed["likes"]}",
//                   color: feed["isLiked"] == true ? _roseRed : Colors.grey.shade600,
//                   onTap: () => _toggleLike(feed),
//                 ),
//                 const SizedBox(width: 20),
//                 _buildFeedActionButton(
//                   icon: Icons.comment_outlined,
//                   label: "${feed["comments"]}",
//                   color: Colors.grey.shade600,
//                   onTap: () => _showComments(feed),
//                 ),
//                 if (feed["type"] == "prayer_request") ...[
//                   const SizedBox(width: 20),
//                   _buildFeedActionButton(
//                     icon: feed["isPrayed"] == true ? Icons.waving_hand : Icons.volunteer_activism,
//                     label: "${feed["prayers"]}",
//                     color: feed["isPrayed"] == true ? _primaryBlue : Colors.grey.shade600,
//                     onTap: () => _togglePrayer(feed),
//                   ),
//                 ],
//                 const Spacer(),
//                 IconButton(
//                   onPressed: () => _shareContent(feed),
//                   icon: Icon(Icons.share, size: 20, color: Colors.grey.shade600),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Color _getFeedTypeColor(String type) {
//     switch (type) {
//       case "prayer_request":
//         return _primaryBlue;
//       case "testimony":
//         return _sageGreen;
//       case "priest_post":
//         return _deepPurple;
//       default:
//         return Colors.grey;
//     }
//   }

//   String _getFeedTypeLabel(String type) {
//     switch (type) {
//       case "prayer_request":
//         return "Prayer Request";
//       case "testimony":
//         return "Testimony";
//       case "priest_post":
//         return "Daily Word";
//       default:
//         return "Post";
//     }
//   }

//   Widget _buildFeedActionButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Row(
//         children: [
//           Icon(icon, size: 20, color: color),
//           const SizedBox(width: 6),
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 13,
//               color: color,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _toggleLike(Map<String, dynamic> feed) {
//     setState(() {
//       if (feed["isLiked"] == true) {
//         feed["isLiked"] = false;
//         feed["likes"] = (feed["likes"] as int) - 1;
//       } else {
//         feed["isLiked"] = true;
//         feed["likes"] = (feed["likes"] as int) + 1;
//       }
//     });
//   }

//   void _togglePrayer(Map<String, dynamic> feed) {
//     setState(() {
//       if (feed["isPrayed"] == true) {
//         feed["isPrayed"] = false;
//         feed["prayers"] = (feed["prayers"] as int) - 1;
//       } else {
//         feed["isPrayed"] = true;
//         feed["prayers"] = (feed["prayers"] as int) + 1;
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("You're now praying for ${feed['author']}"),
//             backgroundColor: _primaryBlue,
//             behavior: SnackBarBehavior.floating,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           ),
//         );
//       }
//     });
//   }

//   void _showComments(Map<String, dynamic> feed) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) => DraggableScrollableSheet(
//         initialChildSize: 0.7,
//         minChildSize: 0.5,
//         maxChildSize: 0.95,
//         expand: false,
//         builder: (context, scrollController) => Container(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 "Comments (${feed['comments']})",
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: _deepPurple,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView(
//                   controller: scrollController,
//                   children: [
//                     _buildCommentItem("John Doe", "Praying for you and your family! 🙏", "1h ago"),
//                     _buildCommentItem("Mary Smith", "God bless you! Stay strong in faith.", "3h ago"),
//                     _buildCommentItem("Peter Brown", "Adding this to my daily prayers.", "5h ago"),
//                   ],
//                 ),
//               ),
//               const Divider(),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: "Write a comment...",
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           borderSide: BorderSide.none,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey.shade100,
//                         contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   CircleAvatar(
//                     backgroundColor: _primaryBlue,
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white, size: 20),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCommentItem(String author, String comment, String time) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(
//             radius: 18,
//             backgroundColor: _primaryBlue.withOpacity(0.2),
//             child: Text(
//               author.substring(0, 1),
//               style: TextStyle(
//                 color: _primaryBlue,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Text(
//                       author,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       time,
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   comment,
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.grey.shade800,
//                     height: 1.4,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }