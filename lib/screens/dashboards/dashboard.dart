import 'package:church_app/common/custom_calendar.dart';
import 'package:church_app/screens/readnow_screen.dart';
import 'package:church_app/common/constants.dart';
import 'package:church_app/screens/ui/faith/dashboard_detail/bible_readnow_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_detail/catholic_document_detail_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_detail/dashboard_read_biography.dart';
import 'package:church_app/screens/ui/faith/dashboard_detail/spiritual_resource_detail_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_detail/testament_books_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_view_all/bible_version_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_view_all/catholic_documents_screen.dart';
import 'package:church_app/screens/ui/faith/dashboard_view_all/spiritual_resources_screen.dart';
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

 // Navigation helper method for Daily Challenges
  void _navigateToChallenge(String challengeTitle) {
    Widget screen;
    switch (challengeTitle) {
      case "Scripture Memory":
        screen = const ScriptureMemoryScreen();
        break;
      case "Prayer Challenge":
        screen = const PrayerChallengeScreen();
        break;
      case "Bible Trivia":
        screen = const BibleTriviaScreen();
        break;
      case "Faith Journey":
        screen = const FaithJourneyScreen();
        break;
      default:
        // Fallback - show a snackbar if screen not found
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$challengeTitle screen coming soon!"),
            duration: const Duration(seconds: 2),
          ),
        );
        return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Navigation helper method for Spiritual Resources
  void _navigateToSpiritualResource(String resourceTitle, String resourceSubtitle) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpiritualResourceDetailScreen(
          resourceTitle: resourceTitle,
          resourceSubtitle: resourceSubtitle,
        ),
      ),
    );
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
          _buildSectionHeader('Catholic Documents', 'Explore', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CatholicDocumentsScreen()),
            );
          }),

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
          _buildSectionHeader('Spiritual Resources', 'Browse All', () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SpiritualResourcesScreen()),
            );
          }),

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
        "hasNavigation": true,
      },
      {
        "title": "Daily Bible Reading",
        "subtitle": "Today's Scripture",
        "content": "Psalm 23 - The Lord is my Shepherd",
        "hasNavigation": true,
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
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScriptureReadingScreen(
                                  title: scripture["title"] as String,
                                  content: scripture["content"] as String,
                                  reference: scripture["subtitle"] as String,
                                ),
                              ),
                            );
                          },
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
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestamentBooksScreen(
            initialTab: title, // This will open the correct tab
          ),
        ),
      );
    },
    child: Container(
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
          child: InkWell(
            onTap: () {
              // Check if this is a Catholic Document card
              final catholicDocs = _getCatholicDocuments();
              final isCatholicDoc = catholicDocs.any((doc) => doc["title"] == items[index]["title"]);
              
              if (isCatholicDoc) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CatholicDocumentDetailScreen(
                      documentTitle: items[index]["title"]!,
                      documentSubtitle: items[index]["subtitle"]!,
                    ),
                  ),
                );
              } else {
                // Handle other types of cards (Spiritual Resources, etc.)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Opening ${items[index]["title"]}..."),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
            borderRadius: BorderRadius.circular(12),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SaintBiographyScreen(
                          saintName: "St. Teresa Benedicta",
                          feastDay: "Aug 9",
                        ),
                      ),
                    );
                  },
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