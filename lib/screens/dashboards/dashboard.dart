import 'package:church_app/common/custom_calendar.dart';
import 'package:church_app/screens/readnow_screen.dart';
import 'package:church_app/screens/ui/faith/bible_version_screen.dart';
import 'package:church_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';

class FaithDashboardScreen extends StatefulWidget {
  const FaithDashboardScreen({super.key});

  @override
  State<FaithDashboardScreen> createState() => _FaithDashboardScreenState();
}

class _FaithDashboardScreenState extends State<FaithDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _welcomeAnimationController;
  late AnimationController _reflectionAnimationController;
  late Animation<double> _welcomeSlideAnimation;
  late Animation<double> _reflectionPulseAnimation;
  
  Timer? _reflectionTimer;
  int _currentReflectionIndex = 0;
  
  final List<Map<String, String>> _reflections = [
    {
      "quote": "Faith is taking the first step even when you don't see the whole staircase. Trust in God's plan and walk forward with courage.",
      "reference": "— Reflection for Today",
      "verse": "Proverbs 3:5-6"
    },
    {
      "quote": "Be still and know that I am God. In the quiet moments, we find His peace and strength for our journey.",
      "reference": "— Morning Reflection",
      "verse": "Psalm 46:10"
    },
    {
      "quote": "The Lord your God is with you, the Mighty Warrior who saves. He will take great delight in you and quiet you with his love.",
      "reference": "— Evening Reflection",
      "verse": "Zephaniah 3:17"
    },
    {
      "quote": "Cast all your anxiety on him because he cares for you. His love is boundless and His mercy endures forever.",
      "reference": "— Daily Encouragement",
      "verse": "1 Peter 5:7"
    }
  ];

  @override
  void initState() {
    super.initState();
    
    _welcomeAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _reflectionAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    
    _welcomeSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _welcomeAnimationController, curve: Curves.elasticOut),
    );
    
    _reflectionPulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _reflectionAnimationController, curve: Curves.easeInOut),
    );
    
    _welcomeAnimationController.forward();
    _reflectionAnimationController.repeat(reverse: true);
    
    // Start reflection rotation timer
    _reflectionTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
      setState(() {
        _currentReflectionIndex = (_currentReflectionIndex + 1) % _reflections.length;
      });
    });
  }

  @override
  void dispose() {
    _welcomeAnimationController.dispose();
    _reflectionAnimationController.dispose();
    _reflectionTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Catholic Faith',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(Icons.notifications),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Animated Welcome Card
          AnimatedBuilder(
            animation: _welcomeSlideAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_welcomeSlideAnimation.value * 200, 0),
                child: _buildWelcomeCard(),
              );
            },
          ),

          // Bible & Scripture Section
          const SizedBox(height: 23),
          _buildSectionHeader('Bible & Scripture', 'View All', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BibleVersionsScreen()),
            );
          }),

          const SizedBox(height: 15),
          _buildEnhancedCarousel(),

          // Old testament and New testament
          const SizedBox(height: 20),
          _buildTestamentCards(),

          // Catholic Documents (renamed from Catholic Teachings)
          const SizedBox(height: 24),
          _buildSectionHeader('Catholic Documents', 'Explore', () {}),

          const SizedBox(height: 14),
          _buildHorizontalScrollableCards(_getCatholicDocuments()),

          // Saints & Feast Days
          const SizedBox(height: 23),
          _buildSectionHeader('Saints & Feast Days', 'Calendar', () {}),

          const SizedBox(height: 15),
          _buildSaintCard(),

          const SizedBox(height: 25),
          _buildSaintsHorizontalList(),

          // Church Calendar
          const SizedBox(height: 23),
          _buildSectionHeader('Church Calendar', 'Full Calendar', () {}),

          CustomCalendar(),

          // Daily Challenges Section
          const SizedBox(height: 24),
          _buildSectionHeader('Daily Challenges', 'View All', () {}),

          const SizedBox(height: 14),
          _buildDailyChallenges(),

          // Spiritual Resources
          const SizedBox(height: 24),
          _buildSectionHeader('Spiritual Resources', 'Browse All', () {}),

          const SizedBox(height: 14),
          _buildHorizontalScrollableCards(_getSpiritualResources()),

          // Enhanced Daily Reflection
          const SizedBox(height: 20),
          _buildEnhancedReflectionCard(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Welcome to Faith",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Explore Catholic teachings, scriptures and spiritual resources",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String actionText, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 280,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.85,
        enableInfiniteScroll: true,
        enlargeStrategy: CenterPageEnlargeStrategy.height,
      ),
      items: _getScriptureCards(),
    );
  }

  List<Widget> _getScriptureCards() {
    final scriptures = [
      {
        "title": "Daily Bible Reading",
        "subtitle": "Today's Scripture",
        "content": "Matthew 13:1-23 - The Parable of the Sower",
        "hasNavigation": true,
      },
      {
        "title": "Daily Bible Reading",
        "subtitle": "Today's Scripture",
        "content": "John 3:16 - For God so loved the world...",
        "hasNavigation": false,
      },
      {
        "title": "Daily Bible Reading",
        "subtitle": "Today's Scripture",
        "content": "Psalm 23 - The Lord is my Shepherd",
        "hasNavigation": false,
      },
    ];

    return scriptures.map((scripture) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          shadowColor: Colors.blue.withOpacity(0.3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      "assets/images/Image_fx (1).jpg",
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 12,
                    bottom: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scripture["title"] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                            shadows: [
                              Shadow(blurRadius: 3, color: Colors.black),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          scripture["subtitle"] as String,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            shadows: [
                              Shadow(blurRadius: 3, color: Colors.black),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        scripture["content"] as String,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.bookmark_border, size: 20, color: Colors.grey),
                          const SizedBox(width: 4),
                          const Text("Save", style: TextStyle(color: Colors.grey)),
                          const SizedBox(width: 20),
                          const Icon(Icons.share, size: 20, color: Colors.grey),
                          const SizedBox(width: 4),
                          const Text("Share", style: TextStyle(color: Colors.grey)),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: scripture["hasNavigation"] == true
                                ? () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReadNowScreen()),
                                    );
                                  }
                                : () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                            ),
                            child: const Text(
                              "Read Now",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTestamentCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTestamentCard(
          "Old Testament",
          "39 Books",
          "assets/images/Image_fx (4).jpg",
        ),
        _buildTestamentCard(
          "New Testament",
          "27 Books",
          "assets/images/Image_fx (4).jpg",
        ),
      ],
    );
  }

  Widget _buildTestamentCard(String title, String subtitle, String imagePath) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalScrollableCards(List<Map<String, String>> items) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    "assets/images/Image_fx (1).jpg",
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        items[index]["title"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index]["subtitle"]!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Map<String, String>> _getCatholicDocuments() {
    return [
      {"title": "Catechism of the Catholic Church", "subtitle": "Core Teachings"},
      {"title": "Canon Law", "subtitle": "Church Law"},
      {"title": "Vatican Council II", "subtitle": "Council Documents"},
      {"title": "Catholic Social Doctrine", "subtitle": "Social Teaching"},
      {"title": "Church Fathers", "subtitle": "Early Writings"},
      {"title": "Papal Encyclicals", "subtitle": "Papal Letters"},
    ];
  }

  List<Map<String, String>> _getSpiritualResources() {
    return [
      {"title": "Prayer Collection", "subtitle": "Traditional Prayers"},
      {"title": "Meditation Guides", "subtitle": "Spiritual Practice"},
      {"title": "Spiritual Articles", "subtitle": "Faith Insights"},
      {"title": "Study Materials", "subtitle": "Learning Resources"},
      {"title": "Daily Devotions", "subtitle": "Spiritual Growth"},
      {"title": "Liturgical Texts", "subtitle": "Mass Readings"},
    ];
  }

  Widget _buildSaintCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 8,
        shadowColor: Colors.orange.withOpacity(0.3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/Image_fx (1).jpg",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Saint of the Day",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "St. Teresa Benedicta",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text(
                "Patron Saint of Europe, Philosopher and martyr",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month, size: 20, color: Colors.grey),
                  const SizedBox(width: 4),
                  const Text("Aug 9", style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 20),
                  const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                  const SizedBox(width: 4),
                  const Text("Pray", style: TextStyle(color: Colors.grey)),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                    ),
                    child: const Text(
                      "Read Biography",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSaintsHorizontalList() {
    final saints = [
      {"title": "Saints Directory", "subtitle": "500+ Saints"},
      {"title": "Feast Calendar", "subtitle": "Liturgical Year"},
      {"title": "Patron Saints", "subtitle": "Find Your Saint"},
      {"title": "Modern Saints", "subtitle": "Contemporary"},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: saints.length,
        itemBuilder: (context, index) {
          return Container(
            width: 130,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/Image_fx (4).jpg",
                  width: 30,
                  height: 30,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 6),
                Text(
                  saints[index]["title"]!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  saints[index]["subtitle"]!,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyChallenges() {
    final challenges = [
      {
        "title": "Scripture Memory",
        "subtitle": "Memorize Verses",
        "icon": Icons.psychology,
        "color": Colors.purple,
      },
      {
        "title": "Prayer Challenge",
        "subtitle": "Daily Prayers",
        "icon": Icons.favorite,
        "color": Colors.red,
      },
      {
        "title": "Bible Trivia",
        "subtitle": "Test Knowledge",
        "icon": Icons.quiz,
        "color": Colors.green,
      },
      {
        "title": "Faith Journey",
        "subtitle": "Daily Reflection",
        "icon": Icons.auto_awesome,
        "color": Colors.orange,
      },
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: challenges.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: challenges[index]["color"] as Color,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (challenges[index]["color"] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    challenges[index]["icon"] as IconData,
                    color: challenges[index]["color"] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  challenges[index]["title"] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  challenges[index]["subtitle"] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEnhancedReflectionCard() {
    return AnimatedBuilder(
      animation: _reflectionPulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _reflectionPulseAnimation.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.amber.shade200, Colors.orange.shade200],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.5),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.lightbulb, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Daily Reflection",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _reflections[_currentReflectionIndex]["quote"]!,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 15,
                            color: Colors.black87,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _reflections[_currentReflectionIndex]["reference"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _reflections[_currentReflectionIndex]["verse"]!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Bible Versions Screen
// class BibleVersionsScreen extends StatelessWidget {
//   const BibleVersionsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Bible Versions'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Search Bar
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.grey[100],
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: const [
//                 Icon(Icons.search, color: Colors.grey),
//                 SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: 'Search Bible versions...',
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           // Popular Versions Section
//           const Text(
//             'Popular Versions',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 12),
          
//           ..._getPopularVersions().map((version) => _buildVersionCard(version)),

//           const SizedBox(height: 24),

//           // By Language Section
//           const Text(
//             'By Language',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 12),

//           ..._getLanguageVersions().map((version) => _buildVersionCard(version)),

//           const SizedBox(height: 24),

//           // Study Bibles & Commentaries
//           const Text(
//             'Study Bibles & Commentaries',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 12),

//           ..._getStudyBibles().map((version) => _buildVersionCard(version)),

//           const SizedBox(height: 24),

//           // Audio Bibles Section
//           const Text(
//             'Audio Bibles',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//           const SizedBox(height: 12),

//           ..._getAudioBibles().map((version) => _buildVersionCard(version)),
//         ],
//       ),
//     );
//   }

//   List<Map<String, String>> _getPopularVersions() {
//     return [
//       {
//         "title": "New American Bible (NAB)",
//         "subtitle": "Catholic Standard Version",
//         "language": "English",
//         "description": "Official Bible used in the Catholic Church in the United States"
//       },
//       {
//         "title": "Douay-Rheims Bible",
//         "subtitle": "Traditional Catholic Translation",
//         "language": "English",
//         "description": "Classic Catholic English translation from the Latin Vulgate"
//       },
//       {
//         "title": "Jerusalem Bible",
//         "subtitle": "Catholic Study Bible",
//         "language": "English",
//         "description": "Scholarly Catholic translation with extensive notes"
//       },
//       {
//         "title": "New Jerusalem Bible",
//         "subtitle": "Updated Catholic Translation",
//         "language": "English",
//         "description": "Revised edition of the Jerusalem Bible"
//       },
//     ];
//   }

//   List<Map<String, String>> _getLanguageVersions() {
//     return [
//       {
//         "title": "Biblia de Jerusalén",
//         "subtitle": "Spanish Catholic Bible",
//         "language": "Spanish",
//         "description": "Spanish translation of the Jerusalem Bible"
//       },
//       {
//         "title": "Bible de Jérusalem",
//         "subtitle": "French Catholic Bible",
//         "language": "French",
//         "description": "French Catholic translation with scholarly notes"
//       },
//       {
//         "title": "Bibbia di Gerusalemme",
//         "subtitle": "Italian Catholic Bible",
//         "language": "Italian",
//         "description": "Italian Catholic translation"
//       },
//       {
//         "title": "Bíblia de Jerusalém",
//         "subtitle": "Portuguese Catholic Bible",
//         "language": "Portuguese",
//         "description": "Portuguese Catholic translation"
//       },
//     ];
//   }

//   List<Map<String, String>> _getStudyBibles() {
//     return [
//       {
//         "title": "Catholic Study Bible",
//         "subtitle": "NAB with Commentary",
//         "language": "English",
//         "description": "Complete study notes and Catholic commentary"
//       },
//       {
//         "title": "Ignatius Catholic Study Bible",
//         "subtitle": "RSV with Notes",
//         "language": "English",
//         "description": "Study Bible with Catholic commentary and cross-references"
//       },
//       {
//         "title": "Haydock Catholic Commentary",
//         "subtitle": "Traditional Commentary",
//         "language": "English",
//         "description": "Classical Catholic biblical commentary"
//       },
//       {
//         "title": "Navarre Bible",
//         "subtitle": "Catholic Commentary Series",
//         "language": "English",
//         "description": "Complete commentary series from University of Navarre"
//       },
//     ];
//   }

//   List<Map<String, String>> _getAudioBibles() {
//     return [
//       {
//         "title": "NAB Audio Bible",
//         "subtitle": "Professional Narration",
//         "language": "English",
//         "description": "Complete New American Bible in audio format"
//       },
//       {
//         "title": "Douay-Rheims Audio",
//         "subtitle": "Traditional Reading",
//         "language": "English",
//         "description": "Audio version of the classic Catholic translation"
//       },
//       {
//         "title": "Spanish Audio Bible",
//         "subtitle": "Biblia Católica",
//         "language": "Spanish",
//         "description": "Spanish Catholic Bible audio narration"
//       },
//     ];
//   }

//   Widget _buildVersionCard(Map<String, String> version) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         version["title"]!,
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black87,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         version["subtitle"]!,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           color: Colors.blue,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     version["language"]!,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Colors.blue,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Text(
//               version["description"]!,
//               style: TextStyle(
//                 fontSize: 13,
//                 color: Colors.grey[600],
//               ),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 ElevatedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.download, size: 16),
//                   label: const Text('Download'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 OutlinedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.preview, size: 16),
//                   label: const Text('Preview'),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

// // Calendar Widget (keeping the existing one but with responsive improvements)
// class CalendarWidget extends StatefulWidget {
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _focusedMonth = DateTime(2025, 8);

//   final Map<DateTime, Map<String, dynamic>> _events = {
//     DateTime(2025, 8, 9): {
//       "title": "St. Teresa Benedicta",
//       "color": Colors.blue,
//     },
//     DateTime(2025, 8, 15): {
//       "title": "Assumption of Mary",
//       "color": Colors.orange,
//     },
//     DateTime(2025, 8, 22): {
//       "title": "Queenship of Mary",
//       "color": Colors.orange,
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   setState(() {
//                     _focusedMonth =
//                         DateTime(_focusedMonth.year, _focusedMonth.month - 1);
//                   });
//                 },
//               ),
//               Text(
//                 DateFormat.yMMMM().format(_focusedMonth),
//                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.arrow_forward_ios),
//                 onPressed: () {
//                   setState(() {
//                     _focusedMonth =
//                         DateTime(_focusedMonth.year, _focusedMonth.month + 1);
//                   });
//                 },
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: ["S", "M", "T", "W", "T", "F", "S"]
//                 .map((e) => Expanded(
//                       child: Center(
//                           child: Text(
//                         e,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       )),
//                     ))
//                 .toList(),
//           ),

//           const SizedBox(height: 8),

//           _buildCalendarGrid(),

//           const SizedBox(height: 12),

//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: _events.entries
//                 .where((entry) =>
//                     entry.key.year == _focusedMonth.year &&
//                     entry.key.month == _focusedMonth.month)
//                 .map(
//                   (entry) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             color: entry.value["color"],
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         Text(
//                           "${DateFormat.MMMd().format(entry.key)} - ${entry.value["title"]}",
//                           style:
//                               TextStyle(fontSize: 14, color: Colors.grey[800]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCalendarGrid() {
//     final firstDayOfMonth =
//         DateTime(_focusedMonth.year, _focusedMonth.month, 1);
//     final lastDayOfMonth =
//         DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

//     int startWeekday = firstDayOfMonth.weekday % 7;
//     List<Widget> dayWidgets = [];

//     for (int i = 0; i < startWeekday; i++) {
//       dayWidgets.add(Container());
//     }

//     for (int day = 1; day <= lastDayOfMonth.day; day++) {
//       DateTime currentDate =
//           DateTime(_focusedMonth.year, _focusedMonth.month, day);

//       bool hasEvent = _events.containsKey(currentDate);

//       dayWidgets.add(
//         Container(
//           margin: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: hasEvent
//                 ? _events[currentDate]!["color"].withOpacity(0.2)
//                 : null,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               "$day",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: hasEvent ? _events[currentDate]!["color"] : Colors.black,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return GridView.count(
//       crossAxisCount: 7,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       children: dayWidgets,
//     );
//   }
// }




// // ignore_for_file: deprecated_member_use, duplicate_ignore

// import 'package:church_app/screens/readnow_screen.dart';
// import 'package:church_app/widgets/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:intl/intl.dart';

// class FaithDashboardScreen extends StatelessWidget {
//   const FaithDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppTopBar(
//         title: 'Catholic Faith',
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
//       body: ListView(
//         padding: const EdgeInsets.symmetric(vertical: 16),
//         children: [
//           // Welcome Card
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(22),
//                 ),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // texts on the left
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Welcome to Faith",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           SizedBox(height: 6),
//                           Text(
//                             "Explore Catholic teachings, scriptures and spiritual resources",
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 24,
//                     ),
//                   ],
//                 )),
//           ),

//           // Bible & Scripture
//           SizedBox(height: 23),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Bible & Scripture',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Text(
//                   'View All',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                   ),
//                 ), 
//               ],
//             ),
//           ),

//           SizedBox(height: 15),
//           CarouselSlider(
//             options: CarouselOptions(
//               height: 320, // total height
//               autoPlay: true, // auto swipe
//               autoPlayInterval: Duration(seconds: 4),
//               enlargeCenterPage: true,
//               viewportFraction: 0.9,
//               enableInfiniteScroll: true,
//             ),
//             items: [
//               // Card 1
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 14),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 4,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: Image.asset(
//                               "assets/images/Image_fx (1).jpg",
//                               height: 150,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             left: 12,
//                             bottom: 15,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Daily Bible Reading",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 23,
//                                     color: Colors.white,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Today`s Scripture",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 16,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: Text(
//                           "Mathew 13: 1-23 - The Parable of the Sower",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12),
//                         child: Row(
//                           children: [
//                             Icon(Icons.bookmark_border,
//                                 size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Save", style: TextStyle(color: Colors.grey)),
//                             SizedBox(width: 20),
//                             Icon(Icons.share, size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Share", style: TextStyle(color: Colors.grey)),
//                             Spacer(),
//                             ElevatedButton(
//                               onPressed: () {
//                                 // Navigate to ReadNowScreen
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => ReadNowScreen()),
//                                 );
//                               },
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 22, vertical: 8),
//                               ),
//                               child: const Text(
//                                 "Read Now",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),

//               // Card 2
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 14),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 4,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: Image.asset(
//                               "assets/images/Image_fx (1).jpg",
//                               height: 150,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             left: 12,
//                             bottom: 15,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Daily Bible Reading",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 23,
//                                     color: Colors.white,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Today`s Scripture",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 16,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: Text(
//                           "John 3:16 - For God so loved the world...",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         child: Row(
//                           children: [
//                             Icon(Icons.bookmark_border,
//                                 size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Save", style: TextStyle(color: Colors.grey)),
//                             SizedBox(width: 20),
//                             Icon(Icons.share, size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Share", style: TextStyle(color: Colors.grey)),
//                             Spacer(),
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 22, vertical: 8),
//                               ),
//                               child: const Text(
//                                 "Read Now",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),

//               // Card 3
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 14),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   elevation: 4,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                             ),
//                             child: Image.asset(
//                               "assets/images/Image_fx (1).jpg",
//                               height: 150,
//                               width: double.infinity,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           Positioned(
//                             left: 12,
//                             bottom: 15,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Daily Bible Reading",
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 23,
//                                     color: Colors.white,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(height: 4),
//                                 Text(
//                                   "Today`s Scripture",
//                                   style: TextStyle(
//                                     color: Colors.white70,
//                                     fontSize: 16,
//                                     shadows: [
//                                       Shadow(
//                                           blurRadius: 3, color: Colors.black),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(12.0),
//                         child: Text(
//                           "Psalm 23 - The Lord is my Shepherd",
//                           style: TextStyle(
//                             color: Colors.blue,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 8),
//                         child: Row(
//                           children: [
//                             Icon(Icons.bookmark_border,
//                                 size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Save", style: TextStyle(color: Colors.grey)),
//                             SizedBox(width: 20),
//                             Icon(Icons.share, size: 20, color: Colors.grey),
//                             SizedBox(width: 4),
//                             Text("Share", style: TextStyle(color: Colors.grey)),
//                             Spacer(),
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.blue,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 22, vertical: 8),
//                               ),
//                               child: const Text(
//                                 "Read Now",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

// // Old testament and New testament
//           SizedBox(height: 20),
//           // ...existing code...
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               // Old Testament Card
//               Container(
//                 width: 170,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/Image_fx (4).jpg",
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(height: 6),
//                     const Text(
//                       "Old Testament",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "39 Books",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               // New Testament Card
//               Container(
//                 width: 170,
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.06),
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Image.asset(
//                       "assets/images/Image_fx (4).jpg",
//                       width: 50,
//                       height: 50,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(height: 8),
//                     const Text(
//                       "New Testament",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "27 Books",
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           // Catholic Teachings
//           SizedBox(height: 24),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Catholic Teachings',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Text(
//                   'Explore',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                   ),
//                 ), // right-side text; fill later
//               ],
//             ),
//           ),

// // catechism
//           SizedBox(height: 14),

//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0), // space at the ends
//             child: Wrap(
//               spacing: 16, // space between items (horizontally)
//               runSpacing: 16, // space between rows (vertically)
//               alignment: WrapAlignment.center, // keep items centered
//               children: [
//                 // 1st container
//                 Container(
//                   width: 170, // fixed width
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12)),
//                         child: Image.asset(
//                           "assets/images/Image_fx (1).jpg",
//                           height: 90, // fixed image height
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Catechism",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Core Teachings",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // 2nd container
//                 Container(
//                   width: 170,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12)),
//                         child: Image.asset(
//                           "assets/images/Image_fx (1).jpg",
//                           height: 90,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Encyclicals",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Papal Letters",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // 3rd container
//                 Container(
//                   width: 170,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12)),
//                         child: Image.asset(
//                           "assets/images/Image_fx (1).jpg",
//                           height: 90,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Church Documents",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Official Texts",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // 4th container
//                 Container(
//                   width: 170,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                             top: Radius.circular(12)),
//                         child: Image.asset(
//                           "assets/images/Image_fx (1).jpg",
//                           height: 90,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Fundamental Beliefs",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                               ),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               "Core Faith",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 13,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Saints & Feast Days
//           SizedBox(height: 23),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Saints & Feast Days',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Text(
//                   'Calendar',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                   ),
//                 ), // right-side text; fill later
//               ],
//             ),
//           ),

// // saints & feast days
//           SizedBox(height: 15),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 14), // space at the ends
//             child: Card(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               elevation: 4,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // image with texts inside
//                   Stack(children: [
//                     ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                       child: Image.asset(
//                         "assets/images/Image_fx (1).jpg",
//                         height: 150,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     // texts in the image
//                     Positioned(
//                       left: 12,
//                       bottom: 15,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Saint of the Day",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 23,
//                               color: Colors.white,
//                               shadows: [
//                                 Shadow(blurRadius: 3, color: Colors.black),
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "St. Teresa Benedicta",
//                             style: TextStyle(
//                               color: Colors.white70,
//                               fontSize: 16,
//                               shadows: [
//                                 Shadow(blurRadius: 3, color: Colors.black),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),

//                   Padding(
//                     padding: EdgeInsets.all(12.0),
//                     child: Text(
//                       "Patron Saint of Europe, Philosopher and martyr",
//                       style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 15,
//                         // decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),

//                   // bottom row with save, share and button
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                     child: Row(
//                       children: [
//                         Icon(Icons.calendar_month,
//                             size: 20, color: Colors.grey),
//                         SizedBox(width: 4),
//                         Text("Aug 9", style: TextStyle(color: Colors.grey)),
//                         SizedBox(width: 20),
//                         Icon(Icons.favorite_border,
//                             size: 20, color: Colors.grey),
//                         const SizedBox(width: 4),
//                         const Text("Pray",
//                             style: TextStyle(color: Colors.grey)),
//                         Spacer(),
//                         ElevatedButton(
//                           onPressed: () {},
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.blue,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 22, vertical: 8),
//                           ),
//                           child: const Text(
//                             "Read Biography",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),

//           SizedBox(height: 25),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 // Old Testament Card
//                 Container(
//                   width: 130,
//                   margin: const EdgeInsets.only(left: 16, right: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.06),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/images/Image_fx (4).jpg",
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.contain,
//                       ),
//                       const SizedBox(height: 6),
//                       const Text(
//                         "Saints Directory",
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "500+ Saints",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // New Testament Card
//                 Container(
//                   width: 130,
//                   margin: const EdgeInsets.only(right: 12),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.06),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/images/Image_fx (4).jpg",
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.contain,
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "Feast Calendar",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Liturgical Year",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Patron Saints Card
//                 Container(
//                   width: 130,
//                   margin: const EdgeInsets.only(right: 16),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.06),
//                         blurRadius: 8,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Image.asset(
//                         "assets/images/Image_fx (4).jpg",
//                         width: 40,
//                         height: 40,
//                         fit: BoxFit.contain,
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "Patron Saints",
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Find Your Saint",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Church Calendar
//           SizedBox(height: 23),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Church Calendar',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Text(
//                   'Full Calendar',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           Column(
//             children: [
//               SizedBox(height: 23),
//               // calendar goes here
//               CalendarWidget(),
//             ],
//           ),
//           // Spiritual Resources
//           SizedBox(height: 24),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 17),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: const [
//                 Text(
//                   'Spiritual Resources',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 20,
//                   ),
//                 ),
//                 Text(
//                   'Browse All',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//           ),

// // catechism
//           SizedBox(height: 14),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Wrap(
//               spacing: 16,
//               runSpacing: 16,
//               alignment: WrapAlignment.center,
//               children: [
//                 // 1st container
//                 Container(
//                   width: 170,
//                   height: 130,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             "assets/images/Image_fx (1).jpg",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Prayer Collection",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Traditional Prayers",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                     ],
//                   ),
//                 ),
//                 // 2nd container
//                 Container(
//                   width: 170,
//                   height: 130,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             "assets/images/Image_fx (1).jpg",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Meditation Guides",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Spiritual Practice",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                     ],
//                   ),
//                 ),
//                 // 3rd container
//                 Container(
//                   width: 170,
//                   height: 130,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             "assets/images/Image_fx (1).jpg",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Spiritual Articles",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Faith Insights",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                     ],
//                   ),
//                 ),
//                 // 4th container
//                 Container(
//                   width: 170,
//                   height: 130,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 6,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 12.0),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(8),
//                           child: Image.asset(
//                             "assets/images/Image_fx (1).jpg",
//                             width: 50,
//                             height: 50,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: const [
//                           Text(
//                             "Study Materials",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15,
//                             ),
//                           ),
//                           SizedBox(height: 4),
//                           Text(
//                             "Learning Resources",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.grey,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           SizedBox(height: 20),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 16.0), // space at the ends
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.amber[200], // light background
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Circle with icon
//                   Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[600], // yellow background
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(Icons.lightbulb, color: Colors.white, size: 20),
//                   ),
//                   const SizedBox(width: 12),
//                   // Text part
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Daily Reflection",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 16,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "\"Faith is taking the first step even when you don’t see the whole staircase. Trust in God’s plan and walk forward with courage.\"",
//                           style: TextStyle(
//                             fontStyle: FontStyle.italic,
//                             fontSize: 14,
//                           ),
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           "— Reflection for Today",
//                           style: TextStyle(
//                             fontSize: 13,
//                             color: Colors.black54,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _SimpleCalendar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final now = DateTime.now();
//     final firstDayOfMonth = DateTime(now.year, now.month, 1);
//     final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
//     final firstWeekday = firstDayOfMonth.weekday; // 1=Mon, 7=Sun

//     // Build a list of day numbers, with leading blanks for the first week
//     final List<Widget> dayWidgets = [];
//     for (int i = 1; i < firstWeekday; i++) {
//       dayWidgets.add(const SizedBox());
//     }
//     for (int day = 1; day <= daysInMonth; day++) {
//       final isToday = day == now.day;
//       dayWidgets.add(
//         Container(
//           margin: const EdgeInsets.all(2),
//           decoration: isToday
//               ? BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(8),
//                 )
//               : null,
//           child: Center(
//             child: Text(
//               '$day',
//               style: TextStyle(
//                 fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
//                 color: isToday ? Colors.blue : Colors.black,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: Column(
//         children: [
//           // Weekday headers
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               Text(
//                 'Mon',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Tue',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Wed',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Thu',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Fri',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Sat',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//               Text(
//                 'Sun',
//                 style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           // Calendar grid
//           GridView.count(
//             crossAxisCount: 7,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             childAspectRatio: 1.2,
//             children: dayWidgets,
//           ),
//         ],
//       ),
//     );
//   }
// }

// String _monthName(int month) {
//   const months = [
//     'January',
//     'February',
//     'March',
//     'April',
//     'May',
//     'June',
//     'July',
//     'August',
//     'September',
//     'October',
//     'November',
//     'December',
//   ];
//   return months[month - 1];
// }

// String _todayFeast() {
//   // In a real app, lookup today's feast from a data source.
//   // For demo, return a placeholder.
//   final now = DateTime.now();
//   if (now.month == 8 && now.day == 9) return 'St. Teresa Benedicta';
//   if (now.month == 8 && now.day == 15) return 'Assumption of Mary';
//   if (now.month == 8 && now.day == 22) return 'Queenship of Mary';
//   return 'Ordinary Time';
// }

// class _ThreeMiniTilesRow extends StatelessWidget {
//   const _ThreeMiniTilesRow();
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 116,
//       child: ListView.separated(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         scrollDirection: Axis.horizontal,
//         itemCount: 3,
//         separatorBuilder: (_, __) => const SizedBox(width: 12),
//         itemBuilder: (context, i) => Container(
//           width: 160,
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(16),
//             boxShadow: [
//               BoxShadow(
//                 // ignore: duplicate_ignore
//                 // ignore: deprecated_member_use
//                 color: Colors.black.withOpacity(0.05),
//                 blurRadius: 12,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.network(
//                     'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80', // quiz/brain

//                     height: 48,
//                     width: 48,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Center(
//                 child: Column(
//                   children: [
//                     Text(
//                       'Daily Challenge',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.w700),
//                     ),
//                     Text(
//                       'bible Stories',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontWeight: FontWeight.w300),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TwoGameTilesRow extends StatelessWidget {
//   const _TwoGameTilesRow();
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: const [
//           Expanded(
//             child: _GameTile(
//               title: 'Scripture Word Search',
//               subtitle: 'find hidden biblical words',
//             ),
//           ),
//           SizedBox(width: 12),
//           Expanded(
//             child: _GameTile(
//               title: 'Catholic Crosswords',
//               subtitle: 'faith-based word puzzles',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _GameTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   const _GameTile({required this.title, required this.subtitle});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             // ignore: deprecated_member_use
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       margin: EdgeInsets.zero,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//             child: AspectRatio(
//               aspectRatio: 16 / 10,
//               child: Image.network(randomPhoto(800, 500), fit: BoxFit.cover),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 SizedBox(height: 8),
//                 Text(
//                   subtitle,
//                   style: const TextStyle(fontWeight: FontWeight.w300),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CalendarWidget extends StatefulWidget {
//   @override
//   _CalendarWidgetState createState() => _CalendarWidgetState();
// }

// class _CalendarWidgetState extends State<CalendarWidget> {
//   DateTime _focusedMonth = DateTime(2025, 8); // Start at August 2025

//   // Events (with colors)
//   final Map<DateTime, Map<String, dynamic>> _events = {
//     DateTime(2025, 8, 9): {
//       "title": "St. Teresa Benedicta",
//       "color": Colors.blue,
//     },
//     DateTime(2025, 8, 15): {
//       "title": "Assumption of Mary",
//       "color": Colors.orange,
//     },
//     DateTime(2025, 8, 22): {
//       "title": "Queenship of Mary",
//       "color": Colors.orange,
//     },
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 6,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header with arrows
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back_ios),
//                 onPressed: () {
//                   setState(() {
//                     _focusedMonth =
//                         DateTime(_focusedMonth.year, _focusedMonth.month - 1);
//                   });
//                 },
//               ),
//               Text(
//                 DateFormat.yMMMM().format(_focusedMonth), // August 2025
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               IconButton(
//                 icon: Icon(Icons.arrow_forward_ios),
//                 onPressed: () {
//                   setState(() {
//                     _focusedMonth =
//                         DateTime(_focusedMonth.year, _focusedMonth.month + 1);
//                   });
//                 },
//               ),
//             ],
//           ),

//           SizedBox(height: 10),

//           // Days of the week header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: ["S", "M", "T", "W", "T", "F", "S"]
//                 .map((e) => Expanded(
//                       child: Center(
//                           child: Text(
//                         e,
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       )),
//                     ))
//                 .toList(),
//           ),

//           SizedBox(height: 8),

//           // Calendar Grid
//           _buildCalendarGrid(),

//           SizedBox(height: 12),

//           // Events text with colored dots
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: _events.entries
//                 .where((entry) =>
//                     entry.key.year == _focusedMonth.year &&
//                     entry.key.month == _focusedMonth.month)
//                 .map(
//                   (entry) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 10,
//                           height: 10,
//                           decoration: BoxDecoration(
//                             color: entry.value["color"],
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           "${DateFormat.MMMd().format(entry.key)} - ${entry.value["title"]}",
//                           style:
//                               TextStyle(fontSize: 14, color: Colors.grey[800]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCalendarGrid() {
//     final firstDayOfMonth =
//         DateTime(_focusedMonth.year, _focusedMonth.month, 1);
//     final lastDayOfMonth =
//         DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

//     int startWeekday = firstDayOfMonth.weekday % 7;
//     List<Widget> dayWidgets = [];

//     // Empty slots before first day
//     for (int i = 0; i < startWeekday; i++) {
//       dayWidgets.add(Container());
//     }

//     // Days of the month
//     for (int day = 1; day <= lastDayOfMonth.day; day++) {
//       DateTime currentDate =
//           DateTime(_focusedMonth.year, _focusedMonth.month, day);

//       bool hasEvent = _events.containsKey(currentDate);

//       dayWidgets.add(
//         Container(
//           margin: EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: hasEvent
//                 ? _events[currentDate]!["color"].withOpacity(0.2)
//                 : null,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Center(
//             child: Text(
//               "$day",
//               style: TextStyle(
//                 fontWeight: FontWeight.w500,
//                 color: hasEvent ? _events[currentDate]!["color"] : Colors.black,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     return GridView.count(
//       crossAxisCount: 7,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: dayWidgets,
//     );
//   }
// }