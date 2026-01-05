import 'package:faith_plus/common/custom_calendar.dart';
import 'package:faith_plus/common/constants.dart' hide SectionHeader;
import 'package:faith_plus/screens/features/faith/dashboard_detail/scripture_reading_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/catholic_document_detail_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/daily_challenge_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/dashboard_read_biography.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/spiritual_resource_detail_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/testament_books_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/bible_version_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/catholic_documents_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/church_full_calender.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/daily_challenge_view_all_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/saint_feast_calender_screen.dart';
import 'package:faith_plus/screens/features/faith/dashboard_view_all/spiritual_resources_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:async';

import '../../common/reusable_widget.dart';
import '../../core/constants/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../features/faith/dashboard_detail/devotional_detail_screen.dart';
import '../features/faith/dashboard_view_all/patron_saints_screen.dart';
import '../features/faith/dashboard_view_all/saints_directory_screen.dart';

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

  Timer? _reflectionTimer;
  int _currentReflectionIndex = 0;

  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;

  final List<Map<String, String>> _saintQuotes = [
    {
      "quote": "Faith seeking understanding.",
      "author": "St. Anselm of Canterbury",
    },
    {
      "quote":
          "To one who has faith, no explanation is necessary. To one without faith, no explanation is possible.",
      "author": "St. Thomas Aquinas",
    },
    {
      "quote":
          "Prayer is the place of refuge for every worry, a foundation for cheerfulness.",
      "author": "St. John Chrysostom",
    },
    {
      "quote": "The goal of a virtuous life is to become like God.",
      "author": "St. Gregory of Nyssa",
    },
  ];

  final List<Map<String, dynamic>> _devotionalContent = [
    {
      "title": "Morning Prayer",
      "time": "6:00 AM",
      "duration": "10 min",
      "description":
          "Start your day with gratitude and surrender to God's will",
      "icon": Icons.wb_sunny,
      "colors": [const Color(0xFF9B7EBD), const Color(0xFF6B5B95)],
      // "colors": [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
    },
    {
      "title": "Scripture Reading",
      "time": "12:00 PM",
      "duration": "15 min",
      "description": "Dive deep into God's Word and find wisdom for today",
      "icon": Icons.menu_book,
      "colors": [const Color(0xFF5B7C99), const Color(0xFF3E5469)],
      // "colors": [const Color(0xFF4A90E2), const Color(0xFF3A7BC8)],
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

  @override
  void initState() {
    super.initState();

    // Initialize welcome animation controller
    _welcomeAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Initialize reflection animation controller
    _reflectionAnimationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Initialize header animation controller
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize cards animation controller
    _cardsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize floating animation controller
    _floatingAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Initialize progress animation controller
    _progressAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // Create animations
    _welcomeSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _welcomeAnimationController, curve: Curves.elasticOut),
    );

    _reflectionPulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(
          parent: _reflectionAnimationController, curve: Curves.easeInOut),
    );

    _headerSlideAnimation = Tween<double>(begin: -50.0, end: 0.0).animate(
      CurvedAnimation(
          parent: _headerAnimationController, curve: Curves.easeOutCubic),
    );

    _cardsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _cardsAnimationController, curve: Curves.easeIn),
    );

    _floatingAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(
      CurvedAnimation(
          parent: _floatingAnimationController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _progressAnimationController, curve: Curves.easeOutCubic),
    );

    // Start animations
    _welcomeAnimationController.forward();
    _reflectionAnimationController.repeat(reverse: true);
    _headerAnimationController.forward();
    _cardsAnimationController.forward();
    _floatingAnimationController.repeat(reverse: true);
    _progressAnimationController.forward();

    // Start devotional rotation timer
    _devotionalTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      setState(() {
        _currentDevotionalIndex =
            (_currentDevotionalIndex + 1) % _devotionalContent.length;
      });
    });

    _quoteTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        _currentQuoteIndex = (_currentQuoteIndex + 1) % _saintQuotes.length;
      });
    });
  }

  @override
  void dispose() {
    _welcomeAnimationController.dispose();
    _reflectionAnimationController.dispose();
    _headerAnimationController.dispose();
    _cardsAnimationController.dispose();
    _floatingAnimationController.dispose();
    _progressAnimationController.dispose();
    _reflectionTimer?.cancel();
    _devotionalTimer?.cancel();
    _quoteTimer?.cancel();
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
          _buildWelcomeHeader(),
          const SizedBox(height: 25),
          _buildFeaturedDevotional(),

          const SizedBox(height: 25),
          _buildSectionHeader('Bible', 'View All', onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BibleVersionsScreen()));
          }),

          const SizedBox(height: 15),
          _buildEnhancedCarousel(),

          // Old testament and New testament
          const SizedBox(height: 20),
          _buildTestamentCards(),

          // Catholic Documents (renamed from Catholic Teachings)
          const SizedBox(height: 24),
          _buildSectionHeader('Church Documents', 'Explore', onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CatholicDocumentsScreen()));
          }),

          const SizedBox(height: 14),
          _buildHorizontalScrollableCards(_getCatholicDocuments()),

          // Saints & Feast Days
          const SizedBox(height: 23),
          _buildSectionHeader('Saints & Feast Days', 'Calendar', onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SaintsCalendarScreen()));
          }),

          const SizedBox(height: 15),
          _buildSaintCard(),

          const SizedBox(height: 25),
          _buildSaintsHorizontalList(),

          // Daily Challenges Section
          const SizedBox(height: 24),
          _buildSectionHeader('Daily Challenges', 'View All', onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const DailyChallengesViewAllScreen()));
          }),

          const SizedBox(height: 14),
          _buildDailyChallenges(),

          // Spiritual Resources
          const SizedBox(height: 24),
          _buildSectionHeader('Spiritual Resources', 'Browse All', onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SpiritualResourcesScreen()));
          }),

          const SizedBox(height: 14),
          // _buildHorizontalScrollableCards(_getSpiritualResources()),
          _buildSpiritualResourcesGrid(),

          // Enhanced Daily Reflection
          const SizedBox(height: 20),
          // _buildEnhancedReflectionCard(),

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
                        _saintQuotes[_currentQuoteIndex]["quote"]!,
                        style: AppTextStyles.h5.copyWith(
                          color: AppColors.primaryPurple,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "— ${_saintQuotes[_currentQuoteIndex]["author"]}",
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                StreakBadge(streakCount: _streakDays),
              ],
            ),
          ),
        );
      },
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DevotionalDetailScreen(
                      title: current["title"] as String,
                      time: current["time"] as String,
                      duration: current["duration"] as String,
                      description: current["description"] as String,
                      icon: current["icon"] as IconData,
                      colors: current["colors"] as List<Color>,
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: current["colors"] as List<Color>,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                        color: (current["colors"] as List<Color>)[0]
                            .withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16)),
                          child: Icon(current["icon"] as IconData,
                              color: Colors.white, size: 28),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(current["title"] as String,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.access_time,
                                      color: Colors.white.withOpacity(0.9),
                                      size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                      "${current["time"]} • ${current["duration"]}",
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(current["description"] as String,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 15,
                            height: 1.5)),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            // onPressed: () {},
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DevotionalDetailScreen(
                                    title: current["title"] as String,
                                    time: current["time"] as String,
                                    duration: current["duration"] as String,
                                    description:
                                        current["description"] as String,
                                    icon: current["icon"] as IconData,
                                    colors: current["colors"] as List<Color>,
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  (current["colors"] as List<Color>)[1],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 0,
                            ),
                            child: const Text("Start Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border,
                                  color: Colors.white)),
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

  Widget _buildSectionHeader(String title, String actionText,
      {VoidCallback? onTap}) {
    return SectionHeader(
      title: title,
      actionText: actionText,
      onActionTap: onTap,
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
    final plans = [
      {
        "title": "Chronological Plan",
        "subtitle": "Read the Bible in Historical Order",
        "content": "Experience Scripture as events unfolded in time",
        "image":
            "https://images.unsplash.com/photo-1519074069444-1ba4fff66d16?w=800",
        "color": AppColors.primaryBlue,
      },
      {
        "title": "Canonical Plan",
        "subtitle": "Traditional Book Order",
        "content": "Follow the traditional arrangement of biblical books",
        "image":
            "https://images.unsplash.com/photo-1505682634904-d7c8d95cdc50?w=800",
        "color": AppColors.primaryPurple,
      },
      {
        "title": "Thematic Plan",
        "subtitle": "Topics and Themes",
        "content": "Explore Scripture through key spiritual themes",
        "image":
            "https://images.unsplash.com/photo-1504052434569-70ad5836ab65?w=800",
        "color": AppColors.accentTeal,
      },
      {
        "title": "One-Year Bible",
        "subtitle": "Complete in 365 Days",
        "content": "Read through the entire Bible in one year",
        "image":
            "https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=800",
        "color": AppColors.accentGold,
      },
      {
        "title": "Custom Plan",
        "subtitle": "Create Your Own",
        "content": "Design a personalized reading schedule",
        "image":
            "https://images.unsplash.com/photo-1490730141103-6cac27aaab94?w=800",
        "color": AppColors.accentRose,
      },
    ];

    return plans.map((plan) {
      bool isSaved = false; // Track saved state locally

      return StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScriptureReadingScreen(
                    title: plan["title"] as String,
                    content: plan["content"] as String,
                    reference: plan["subtitle"] as String,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 8,
                shadowColor: (plan["color"] as Color).withOpacity(0.3),
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
                          child: Image.network(
                            plan["image"] as String,
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 120,
                                color:
                                    (plan["color"] as Color).withOpacity(0.2),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: plan["color"] as Color,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 120,
                                color:
                                    (plan["color"] as Color).withOpacity(0.3),
                                child: Icon(
                                  Icons.menu_book,
                                  size: 48,
                                  color: plan["color"] as Color,
                                ),
                              );
                            },
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
                                Colors.black.withOpacity(0.6)
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
                                plan["title"] as String,
                                style: AppTextStyles.h4.copyWith(
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                        blurRadius: 3, color: Colors.black)
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                plan["subtitle"] as String,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white70,
                                  shadows: [
                                    const Shadow(
                                        blurRadius: 3, color: Colors.black)
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
                              plan["content"] as String,
                              style: AppTextStyles.bodyMedium
                                  .copyWith(color: plan["color"] as Color),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSaved = !isSaved;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(isSaved
                                            ? 'Saved to library'
                                            : 'Removed from library'),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        isSaved
                                            ? Icons.bookmark
                                            : Icons.bookmark_border,
                                        size: 20,
                                        color: isSaved
                                            ? plan["color"] as Color
                                            : Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        "Save",
                                        style: TextStyle(
                                          color: isSaved
                                              ? plan["color"] as Color
                                              : Colors.grey,
                                          fontWeight: isSaved
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                InkWell(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Sharing "${plan["title"]}"...'),
                                        duration: const Duration(seconds: 2),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: const [
                                      Icon(Icons.share,
                                          size: 20, color: Colors.grey),
                                      SizedBox(width: 4),
                                      Text("Share",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                AppButton(
                                  text: "Read Now",
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ScriptureReadingScreen(
                                          title: plan["title"] as String,
                                          content: plan["content"] as String,
                                          reference: plan["subtitle"] as String,
                                        ),
                                      ),
                                    );
                                  },
                                  isPrimary: true,
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
            ),
          );
        },
      );
    }).toList();
  }

  Widget _buildTestamentCards() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTestamentCard(
          "Old Testament",
          "46 Books",
          "assets/images/Image_fx_4.jpg",
        ),
        _buildTestamentCard(
          "New Testament",
          "27 Books",
          "assets/images/Image_fx_4.jpg",
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
              initialTab: title,
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
                final catholicDocs = _getCatholicDocuments();
                final spiritualResources = _getSpiritualResources();

                final isCatholicDoc = catholicDocs
                    .any((doc) => doc["title"] == items[index]["title"]);
                final isSpiritualResource = spiritualResources.any(
                    (resource) => resource["title"] == items[index]["title"]);

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
                } else if (isSpiritualResource) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpiritualResourceDetailScreen(
                        resourceTitle: items[index]["title"]!,
                        resourceSubtitle: items[index]["subtitle"]!,
                      ),
                    ),
                  );
                } else {
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.asset(
                      "assets/images/Image_fx_1.jpg",
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
      {
        "title": "Catechism of the Catholic Church",
        "subtitle": "Core Teachings"
      },
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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Main Featured Saint Card
          GestureDetector(
            onTap: () {
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
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Section with Overlay
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Image.asset(
                          "assets/images/Image_fx_1.jpg",
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        height: 180,
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
                              AppColors.primaryPurpleDark.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        left: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: AppColors.primaryPurple,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Aug 9",
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primaryPurple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        bottom: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Saint of the Day",
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "St. Teresa Benedicta",
                              style: AppTextStyles.h3.copyWith(
                                color: Colors.white,
                                shadows: [
                                  const Shadow(
                                      blurRadius: 8, color: Colors.black45),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Content Section
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Patron Saint of Europe, Philosopher and martyr",
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primaryBlue,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: "Read Biography",
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SaintBiographyScreen(
                                        saintName: "St. Teresa Benedicta",
                                        feastDay: "Aug 9",
                                      ),
                                    ),
                                  );
                                },
                                isPrimary: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primaryPurple,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Added to prayer intentions'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.favorite_border,
                                  color: AppColors.primaryPurple,
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
        ],
      ),
    );
  }

  // Widget _buildSaintsHorizontalList() {
  //   final saints = [
  //     {
  //       "title": "Saints Directory",
  //       "subtitle": "500+ Saints",
  //       "icon": Icons.people,
  //       "color": AppColors.primaryBlue,
  //     },
  //     {
  //       "title": "Feast Calendar",
  //       "subtitle": "Liturgical Year",
  //       "icon": Icons.event_note,
  //       "color": AppColors.primaryPurple,
  //     },
  //     {
  //       "title": "Patron Saints",
  //       "subtitle": "Find Your Saint",
  //       "icon": Icons.search,
  //       "color": AppColors.accentTeal,
  //     },
  //     {
  //       "title": "Modern Saints",
  //       "subtitle": "Contemporary",
  //       "icon": Icons.auto_awesome,
  //       "color": AppColors.accentRose,
  //     },
  //   ];

  //   return SizedBox(
  //     height: 120,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.symmetric(horizontal: 20),
  //       itemCount: saints.length,
  //       itemBuilder: (context, index) {
  //         final saint = saints[index];
  //         final title = saint["title"] as String;
  //         final subtitle = saint["subtitle"] as String;
  //         final icon = saint["icon"] as IconData;
  //         final color = saint["color"] as Color;

  //         return Container(
  //           width: 140,
  //           margin: const EdgeInsets.only(right: 12),
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [
  //                 color,
  //                 color.withOpacity(0.7),
  //               ],
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //             ),
  //             borderRadius: BorderRadius.circular(16),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: color.withOpacity(0.3),
  //                 blurRadius: 12,
  //                 offset: const Offset(0, 6),
  //               ),
  //             ],
  //           ),
  //           child: Material(
  //             color: Colors.transparent,
  //             child: InkWell(
  //               onTap: () {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text('Opening $title...'),
  //                     duration: const Duration(seconds: 2),
  //                   ),
  //                 );
  //               },
  //               borderRadius: BorderRadius.circular(16),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(16),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       padding: const EdgeInsets.all(8),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white.withOpacity(0.3),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: Icon(
  //                         icon,
  //                         color: Colors.white,
  //                         size: 24,
  //                       ),
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           title,
  //                           style: AppTextStyles.bodyMedium.copyWith(
  //                             color: Colors.white,
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                           maxLines: 2,
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                         const SizedBox(height: 2),
  //                         Text(
  //                           subtitle,
  //                           style: AppTextStyles.bodySmall.copyWith(
  //                             color: Colors.white70,
  //                             fontSize: 11,
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
  //     ),
  //   );
  // }




// Then update the _buildSaintsHorizontalList method in your _FaithDashboardScreenState class:

Widget _buildSaintsHorizontalList() {
  final saints = [
    {
      "title": "Saints Directory",
      "subtitle": "500+ Saints",
      "icon": Icons.people,
      "color": AppColors.primaryBlue,
      "route": "directory",
    },
    {
      "title": "Feast Calendar",
      "subtitle": "Liturgical Year",
      "icon": Icons.event_note,
      "color": AppColors.primaryPurple,
      "route": "calendar",
    },
    {
      "title": "Patron Saints",
      "subtitle": "Find Your Saint",
      "icon": Icons.search,
      "color": AppColors.accentTeal,
      "route": "patron",
    },
    {
      "title": "Modern Saints",
      "subtitle": "Contemporary",
      "icon": Icons.auto_awesome,
      "color": AppColors.accentRose,
      "route": "modern",
    },
  ];

  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: saints.length,
      itemBuilder: (context, index) {
        final saint = saints[index];
        final title = saint["title"] as String;
        final subtitle = saint["subtitle"] as String;
        final icon = saint["icon"] as IconData;
        final color = saint["color"] as Color;
        final route = saint["route"] as String;

        return Container(
          width: 140,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color,
                color.withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate based on route
                if (route == "directory") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaintsDirectoryScreen(),
                    ),
                  );
                } else if (route == "calendar") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaintsCalendarScreen(),
                    ),
                  );
                } else if (route == "patron") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PatronSaintsScreen(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening $title...'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: AppTextStyles.bodySmall.copyWith(
                            color: Colors.white70,
                            fontSize: 11,
                          ),
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
    ),
  );
}


Widget _buildDailyChallenges() {
  final challenges = [
    {
      "title": "Scripture Memory",
      "subtitle": "Memorize Verses",
      "description": "Learn and memorize key Bible passages",
      "icon": Icons.psychology,
      "gradient": [AppColors.primaryPurple, AppColors.primaryPurpleDark],
      "progress": 0.65,
    },
    {
      "title": "Prayer Challenge",
      "subtitle": "Daily Prayers",
      "description": "Strengthen your prayer life daily",
      "icon": Icons.favorite,
      "gradient": [AppColors.accentRose, AppColors.primaryPurpleDark],
      "progress": 0.80,
    },
    {
      "title": "Bible Trivia",
      "subtitle": "Test Knowledge",
      "description": "Challenge yourself with biblical questions",
      "icon": Icons.quiz,
      "gradient": [AppColors.primaryBlue, AppColors.primaryBlueDark],
      "progress": 0.45,
    },
    {
      "title": "Faith Journey",
      "subtitle": "Daily Reflection",
      "description": "Reflect on your spiritual growth",
      "icon": Icons.auto_awesome,
      "gradient": [AppColors.accentTeal, AppColors.primaryBlue],
      "progress": 0.90,
    },
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: challenges.asMap().entries.map((entry) {
        final index = entry.key;
        final challenge = entry.value;
        final title = challenge["title"] as String;
        final subtitle = challenge["subtitle"] as String;
        final description = challenge["description"] as String;
        final icon = challenge["icon"] as IconData;
        final gradient = challenge["gradient"] as List<Color>;
        final progress = challenge["progress"] as double;

        return Container(
          margin: EdgeInsets.only(bottom: index < challenges.length - 1 ? 16 : 0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradient[0].withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DailyChallengeScreen(
                      challengeTitle: title,
                    ),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    // Icon Container
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: AppTextStyles.h5.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            description,
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    subtitle,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "${(progress * 100).toInt()}%",
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Arrow Icon
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}


Widget _buildSpiritualResourcesGrid() {
  final resources = [
    {
      "title": "Prayer Collection",
      "subtitle": "Traditional Prayers",
      "icon": Icons.menu_book,
      "color": AppColors.primaryPurple,
    },
    {
      "title": "Meditation Guides",
      "subtitle": "Spiritual Practice",
      "icon": Icons.self_improvement,
      "color": AppColors.primaryBlue,
    },
    {
      "title": "Spiritual Articles",
      "subtitle": "Faith Insights",
      "icon": Icons.article,
      "color": AppColors.accentTeal,
    },
    {
      "title": "Study Materials",
      "subtitle": "Learning Resources",
      "icon": Icons.school,
      "color": AppColors.accentRose,
    },
    {
      "title": "Daily Devotions",
      "subtitle": "Spiritual Growth",
      "icon": Icons.wb_sunny,
      "color": AppColors.accentGold,
    },
    {
      "title": "Liturgical Texts",
      "subtitle": "Mass Readings",
      "icon": Icons.auto_stories,
      "color": AppColors.primaryPurpleDark,
    },
  ];

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75, // Changed from 0.85 to 0.75 for more height
      ),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final resource = resources[index];
        final title = resource["title"] as String;
        final subtitle = resource["subtitle"] as String;
        final icon = resource["icon"] as IconData;
        final color = resource["color"] as Color;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SpiritualResourceDetailScreen(
                  resourceTitle: title,
                  resourceSubtitle: subtitle,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon Header with Gradient
                Container(
                  height: 90, // Reduced from 100
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(14), // Reduced from 16
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 32, // Reduced from 36
                      ),
                    ),
                  ),
                ),
                // Content Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12), // Reduced from 16
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: AppTextStyles.h5.copyWith(
                                  color: color,
                                  fontSize: 14, // Reduced from 15
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3), // Reduced from 4
                              Text(
                                subtitle,
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 11, // Reduced from 12
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Actio                    n Button
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Explore",
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward,
                                color: color,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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

}




// // import 'package:intl/intl.dart';
// import 'package:faith_plus/common/custom_calendar.dart';
// import 'package:faith_plus/common/constants.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/bible_readnow_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/catholic_document_detail_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/daily_challenge_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/dashboard_read_biography.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/spiritual_resource_detail_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_detail/testament_books_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/bible_version_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/catholic_documents_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/church_full_calender.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/daily_challenge_view_all_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/saint_feast_calender_screen.dart';
// import 'package:faith_plus/screens/ui/faith/dashboard_view_all/spiritual_resources_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'dart:async';

// class FaithDashboardScreen extends StatefulWidget {
//   const FaithDashboardScreen({super.key});

//   @override
//   State<FaithDashboardScreen> createState() => _FaithDashboardScreenState();
// }

// class _FaithDashboardScreenState extends State<FaithDashboardScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _welcomeAnimationController;
//   late AnimationController _reflectionAnimationController;
//   late Animation<double> _welcomeSlideAnimation;
//   late Animation<double> _reflectionPulseAnimation;

//     late AnimationController _headerAnimationController;
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

//   Timer? _reflectionTimer;
//   int _currentReflectionIndex = 0;

//   final Color _deepPurple = const Color(0xFF6B5B95);

//   final List<Map<String, String>> _reflections = [
//     {
//       "quote":
//           "Faith is taking the first step even when you don't see the whole staircase. Trust in God's plan and walk forward with courage.",
//       "reference": "— Reflection for Today",
//       "verse": "Proverbs 3:5-6"
//     },
//     {
//       "quote":
//           "Be still and know that I am God. In the quiet moments, we find His peace and strength for our journey.",
//       "reference": "— Morning Reflection",
//       "verse": "Psalm 46:10"
//     },
//     {
//       "quote":
//           "The Lord your God is with you, the Mighty Warrior who saves. He will take great delight in you and quiet you with his love.",
//       "reference": "— Evening Reflection",
//       "verse": "Zephaniah 3:17"
//     },
//     {
//       "quote":
//           "Cast all your anxiety on him because he cares for you. His love is boundless and His mercy endures forever.",
//       "reference": "— Daily Encouragement",
//       "verse": "1 Peter 5:7"
//     }
//   ];

//     final List<Map<String, dynamic>> _devotionalContent = [
//     {
//       "title": "Morning Prayer",
//       "time": "6:00 AM",
//       "duration": "10 min",
//       "description": "Start your day with gratitude and surrender to God's will",
//       "icon": Icons.wb_sunny,
//       "colors": [const Color(0xFFFFB75E), const Color(0xFFED8F03)],
//     },
//     {
//       "title": "Scripture Reading",
//       "time": "12:00 PM",
//       "duration": "15 min",
//       "description": "Dive deep into God's Word and find wisdom for today",
//       "icon": Icons.menu_book,
//       "colors": [const Color(0xFF4A90E2), const Color(0xFF3A7BC8)],
//     },
//     {
//       "title": "Rosary",
//       "time": "3:00 PM",
//       "duration": "20 min",
//       "description": "Meditate on the mysteries of Christ through Mary's eyes",
//       "icon": Icons.circle_outlined,
//       "colors": [const Color(0xFF9B7EBD), const Color(0xFF6B5B95)],
//     },
//     {
//       "title": "Evening Reflection",
//       "time": "8:00 PM",
//       "duration": "10 min",
//       "description": "Review your day and thank God for His blessings",
//       "icon": Icons.nightlight_round,
//       "colors": [const Color(0xFF5B7C99), const Color(0xFF3E5469)],
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _welcomeAnimationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _reflectionAnimationController = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     );

//     _welcomeSlideAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
//       CurvedAnimation(
//           parent: _welcomeAnimationController, curve: Curves.elasticOut),
//     );

//     _reflectionPulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
//       CurvedAnimation(
//           parent: _reflectionAnimationController, curve: Curves.easeInOut),
//     );

//     _welcomeAnimationController.forward();
//     _reflectionAnimationController.repeat(reverse: true);

//     // Start reflection rotation timer
//     _reflectionTimer = Timer.periodic(const Duration(seconds: 8), (timer) {
//       setState(() {
//         _currentReflectionIndex =
//             (_currentReflectionIndex + 1) % _reflections.length;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _welcomeAnimationController.dispose();
//     _reflectionAnimationController.dispose();
//     _reflectionTimer?.cancel();
//     super.dispose();
//   }

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
//           // Animated Welcome Card
//           // AnimatedBuilder(
//           //   animation: _welcomeSlideAnimation,
//           //   builder: (context, child) {
//           //     return Transform.translate(
//           //       offset: Offset(_welcomeSlideAnimation.value * 200, 0),
//           //       child: _buildWelcomeCard(),
//           //     );
//           //   },
//           // ),
//            _buildWelcomeHeader(),
//           const SizedBox(height: 25),
//           _buildFeaturedDevotional(),

//           // Bible & Scripture Section
//           const SizedBox(height: 23),
//           _buildSectionHeader('Bible', 'View All', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const BibleVersionsScreen()),
//             );
//           }),

//           const SizedBox(height: 15),
//           _buildEnhancedCarousel(),

//           // Old testament and New testament
//           const SizedBox(height: 20),
//           _buildTestamentCards(),

//           // Catholic Documents (renamed from Catholic Teachings)
//           const SizedBox(height: 24),
//           _buildSectionHeader('Catholic Documents', 'Explore', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const CatholicDocumentsScreen()),
//             );
//           }),

//           const SizedBox(height: 14),
//           _buildHorizontalScrollableCards(_getCatholicDocuments()),

//           // Saints & Feast Days
//           const SizedBox(height: 23),
//           _buildSectionHeader('Saints & Feast Days', 'Calendar', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const SaintsCalendarScreen(),
//               ),
//             );
//           }),

//           const SizedBox(height: 15),
//           _buildSaintCard(),

//           const SizedBox(height: 25),
//           _buildSaintsHorizontalList(),

//           // Church Calendar
//           const SizedBox(height: 23),
//           _buildSectionHeader('Church', 'Full Calendar', () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => const FullCalendarScreen(),
//             ),
//           );
//           }),

//           CustomCalendar(),

//           // Daily Challenges Section
//           const SizedBox(height: 24),
//           // _buildSectionHeader('Daily Challenges', 'View All', () {}),
//           _buildSectionHeader('Daily Challenges', 'View All', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const DailyChallengesViewAllScreen()),
//             );
//           }),

//           const SizedBox(height: 14),
//           _buildDailyChallenges(),

//           // Spiritual Resources
//           const SizedBox(height: 24),
//           _buildSectionHeader('Spiritual Resources', 'Browse All', () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => const SpiritualResourcesScreen()),
//             );
//           }),

//           const SizedBox(height: 14),
//           _buildHorizontalScrollableCards(_getSpiritualResources()),

//           // Enhanced Daily Reflection
//           const SizedBox(height: 20),
//           _buildEnhancedReflectionCard(),

//           const SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomeCard() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.blue.shade600, Colors.blue.shade400],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(22),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.blue.withOpacity(0.3),
//               blurRadius: 15,
//               offset: const Offset(0, 8),
//             ),
//           ],
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Welcome to Faith",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 6),
//                   Text(
//                     "Explore Catholic teachings, scriptures and spiritual resources",
//                     style: TextStyle(
//                       color: Colors.white70,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: const Icon(
//                 Icons.auto_awesome,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
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
//                   gradient: LinearGradient(colors: current["colors"] as List<Color>, begin: Alignment.topLeft, end: Alignment.bottomRight),
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(color: (current["colors"] as List<Color>)[0].withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 10)),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
//                           child: Icon(current["icon"] as IconData, color: Colors.white, size: 28),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(current["title"] as String, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   Icon(Icons.access_time, color: Colors.white.withOpacity(0.9), size: 16),
//                                   const SizedBox(width: 4),
//                                   Text("${current["time"]} • ${current["duration"]}", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     Text(current["description"] as String, style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 15, height: 1.5)),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton(
//                             onPressed: () {},
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               foregroundColor: (current["colors"] as List<Color>)[1],
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               elevation: 0,
//                             ),
//                             child: const Text("Start Now", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           decoration: BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(12)),
//                           child: IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border, color: Colors.white)),
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

//   Widget _buildSectionHeader(
//       String title, String actionText, VoidCallback onTap) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 17),
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
//             onTap: onTap,
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

//   Widget _buildEnhancedCarousel() {
//     return CarouselSlider(
//       options: CarouselOptions(
//         height: 280,
//         autoPlay: true,
//         autoPlayInterval: const Duration(seconds: 4),
//         enlargeCenterPage: true,
//         viewportFraction: 0.85,
//         enableInfiniteScroll: true,
//         enlargeStrategy: CenterPageEnlargeStrategy.height,
//       ),
//       items: _getScriptureCards(),
//     );
//   }

//   List<Widget> _getScriptureCards() {
//     final scriptures = [
//       {
//         "title": "Daily Bible Reading",
//         "subtitle": "Today's Scripture",
//         "content": "Matthew 13:1-23 - The Parable of the Sower",
//         "hasNavigation": true,
//       },
//       {
//         "title": "Daily Bible Reading",
//         "subtitle": "Today's Scripture",
//         "content": "John 3:16 - For God so loved the world...",
//         "hasNavigation": true,
//       },
//       {
//         "title": "Daily Bible Reading",
//         "subtitle": "Today's Scripture",
//         "content": "Psalm 23 - The Lord is my Shepherd",
//         "hasNavigation": true,
//       },
//     ];

//     return scriptures.map((scripture) {
//       return Container(
//         margin: const EdgeInsets.symmetric(horizontal: 8),
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 8,
//           shadowColor: Colors.blue.withOpacity(0.3),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(20),
//                       topRight: Radius.circular(20),
//                     ),
//                     child: Image.asset(
//                       "assets/images/Image_fx_1.jpg",
//                       height: 120,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Container(
//                     height: 120,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         topLeft: Radius.circular(20),
//                         topRight: Radius.circular(20),
//                       ),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Colors.transparent,
//                           Colors.black.withOpacity(0.6),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 12,
//                     bottom: 15,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           scripture["title"] as String,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20,
//                             color: Colors.white,
//                             shadows: [
//                               Shadow(blurRadius: 3, color: Colors.black),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           scripture["subtitle"] as String,
//                           style: const TextStyle(
//                             color: Colors.white70,
//                             fontSize: 14,
//                             shadows: [
//                               Shadow(blurRadius: 3, color: Colors.black),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         scripture["content"] as String,
//                         style: const TextStyle(
//                           color: Colors.blue,
//                           fontSize: 15,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const Spacer(),
//                       Row(
//                         children: [
//                           const Icon(Icons.bookmark_border,
//                               size: 20, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           const Text("Save",
//                               style: TextStyle(color: Colors.grey)),
//                           const SizedBox(width: 20),
//                           const Icon(Icons.share, size: 20, color: Colors.grey),
//                           const SizedBox(width: 4),
//                           const Text("Share",
//                               style: TextStyle(color: Colors.grey)),
//                           const Spacer(),
//                           ElevatedButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ScriptureReadingScreen(
//                                     title: scripture["title"] as String,
//                                     content: scripture["content"] as String,
//                                     reference: scripture["subtitle"] as String,
//                                   ),
//                                 ),
//                               );
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 16, vertical: 8),
//                             ),
//                             child: const Text(
//                               "Read Now",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       );
//     }).toList();
//   }

//   Widget _buildTestamentCards() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildTestamentCard(
//           "Old Testament",
//           "39 Books",
//           "assets/images/Image_fx_4.jpg",
//         ),
//         _buildTestamentCard(
//           "New Testament",
//           "27 Books",
//           "assets/images/Image_fx_4.jpg",
//         ),
//       ],
//     );
//   }

//   Widget _buildTestamentCard(String title, String subtitle, String imagePath) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TestamentBooksScreen(
//               initialTab: title, // This will open the correct tab
//             ),
//           ),
//         );
//       },
//       child: Container(
//         width: MediaQuery.of(context).size.width * 0.42,
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Image.asset(
//               imagePath,
//               width: 50,
//               height: 50,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 4),
//             Text(
//               subtitle,
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildHorizontalScrollableCards(List<Map<String, String>> items) {
//     return SizedBox(
//       height: 160,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 140,
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black12,
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: InkWell(
//               onTap: () {
//                 // Check if this is a Catholic Document card
//                 final catholicDocs = _getCatholicDocuments();
//                 final spiritualResources = _getSpiritualResources();

//                 final isCatholicDoc = catholicDocs
//                     .any((doc) => doc["title"] == items[index]["title"]);
//                 final isSpiritualResource = spiritualResources.any(
//                     (resource) => resource["title"] == items[index]["title"]);

//                 if (isCatholicDoc) {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => CatholicDocumentDetailScreen(
//                         documentTitle: items[index]["title"]!,
//                         documentSubtitle: items[index]["subtitle"]!,
//                       ),
//                     ),
//                   );
//                 } else if (isSpiritualResource) {
//                   // Navigate to Spiritual Resource Detail Screen
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => SpiritualResourceDetailScreen(
//                         resourceTitle: items[index]["title"]!,
//                         resourceSubtitle: items[index]["subtitle"]!,
//                       ),
//                     ),
//                   );
//                 } else {
//                   // Handle other types of cards
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Opening ${items[index]["title"]}..."),
//                       duration: const Duration(seconds: 2),
//                     ),
//                   );
//                 }
//               },
//               borderRadius: BorderRadius.circular(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(12)),
//                     child: Image.asset(
//                       "assets/images/Image_fx_1.jpg",
//                       height: 80,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           items[index]["title"]!,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           items[index]["subtitle"]!,
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
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

//   List<Map<String, String>> _getCatholicDocuments() {
//     return [
//       {
//         "title": "Catechism of the Catholic Church",
//         "subtitle": "Core Teachings"
//       },
//       {"title": "Canon Law", "subtitle": "Church Law"},
//       {"title": "Vatican Council II", "subtitle": "Council Documents"},
//       {"title": "Catholic Social Doctrine", "subtitle": "Social Teaching"},
//       {"title": "Church Fathers", "subtitle": "Early Writings"},
//       {"title": "Papal Encyclicals", "subtitle": "Papal Letters"},
//     ];
//   }

//   List<Map<String, String>> _getSpiritualResources() {
//     return [
//       {"title": "Prayer Collection", "subtitle": "Traditional Prayers"},
//       {"title": "Meditation Guides", "subtitle": "Spiritual Practice"},
//       {"title": "Spiritual Articles", "subtitle": "Faith Insights"},
//       {"title": "Study Materials", "subtitle": "Learning Resources"},
//       {"title": "Daily Devotions", "subtitle": "Spiritual Growth"},
//       {"title": "Liturgical Texts", "subtitle": "Mass Readings"},
//     ];
//   }

//   Widget _buildSaintCard() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 8,
//         shadowColor: Colors.orange.withOpacity(0.3),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Stack(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                   child: Image.asset(
//                     "assets/images/Image_fx_1.jpg",
//                     height: 150,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Positioned(
//                   left: 12,
//                   bottom: 15,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Saint of the Day",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 23,
//                           color: Colors.white,
//                           shadows: [
//                             Shadow(blurRadius: 3, color: Colors.black),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         "St. Teresa Benedicta",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 16,
//                           shadows: [
//                             Shadow(blurRadius: 3, color: Colors.black),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: const Text(
//                 "Patron Saint of Europe, Philosopher and martyr",
//                 style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               child: Row(
//                 children: [
//                   const Icon(Icons.calendar_month,
//                       size: 20, color: Colors.grey),
//                   const SizedBox(width: 4),
//                   const Text("Aug 9", style: TextStyle(color: Colors.grey)),
//                   const SizedBox(width: 20),
//                   const Icon(Icons.favorite_border,
//                       size: 20, color: Colors.grey),
//                   const SizedBox(width: 4),
//                   const Text("Pray", style: TextStyle(color: Colors.grey)),
//                   const Spacer(),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const SaintBiographyScreen(
//                             saintName: "St. Teresa Benedicta",
//                             feastDay: "Aug 9",
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(6),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 22, vertical: 8),
//                     ),
//                     child: const Text(
//                       "Read Biography",
//                       style: TextStyle(
//                           color: Colors.white, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSaintsHorizontalList() {
//     final saints = [
//       {"title": "Saints Directory", "subtitle": "500+ Saints"},
//       {"title": "Feast Calendar", "subtitle": "Liturgical Year"},
//       {"title": "Patron Saints", "subtitle": "Find Your Saint"},
//       {"title": "Modern Saints", "subtitle": "Contemporary"},
//     ];

//     return SizedBox(
//       height: 100,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: saints.length,
//         itemBuilder: (context, index) {
//           return Container(
//             width: 130,
//             margin: const EdgeInsets.only(right: 12),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "assets/images/Image_fx_4.jpg",
//                   width: 30,
//                   height: 30,
//                   fit: BoxFit.contain,
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   saints[index]["title"]!,
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   saints[index]["subtitle"]!,
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey[600],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildDailyChallenges() {
//     final challenges = [
//       {
//         "title": "Scripture Memory",
//         "subtitle": "Memorize Verses",
//         "icon": Icons.psychology,
//         "color": Colors.purple,
//       },
//       {
//         "title": "Prayer Challenge",
//         "subtitle": "Daily Prayers",
//         "icon": Icons.favorite,
//         "color": Colors.red,
//       },
//       {
//         "title": "Bible Trivia",
//         "subtitle": "Test Knowledge",
//         "icon": Icons.quiz,
//         "color": Colors.green,
//       },
//       {
//         "title": "Faith Journey",
//         "subtitle": "Daily Reflection",
//         "icon": Icons.auto_awesome,
//         "color": Colors.orange,
//       },
//     ];

//     return SizedBox(
//       height: 120,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: challenges.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               // Navigate to DailyChallengeScreen with the specific challenge title
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => DailyChallengeScreen(
//                     challengeTitle: challenges[index]["title"] as String,
//                   ),
//                 ),
//               );
//             },
//             child: Container(
//               width: 100,
//               margin: const EdgeInsets.only(right: 16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: challenges[index]["color"] as Color,
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                     spreadRadius: -5,
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: (challenges[index]["color"] as Color)
//                           .withOpacity(0.1),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Icon(
//                       challenges[index]["icon"] as IconData,
//                       color: challenges[index]["color"] as Color,
//                       size: 24,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     challenges[index]["title"] as String,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                     ),
//                     textAlign: TextAlign.center,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     challenges[index]["subtitle"] as String,
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: Colors.grey[600],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildEnhancedReflectionCard() {
//     return AnimatedBuilder(
//       animation: _reflectionPulseAnimation,
//       builder: (context, child) {
//         return Transform.scale(
//           scale: _reflectionPulseAnimation.value,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [Colors.amber.shade200, Colors.orange.shade200],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.amber.withOpacity(0.4),
//                     blurRadius: 15,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       color: Colors.amber[600],
//                       shape: BoxShape.circle,
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.amber.withOpacity(0.5),
//                           blurRadius: 10,
//                           offset: const Offset(0, 4),
//                         ),
//                       ],
//                     ),
//                     child: const Icon(Icons.lightbulb,
//                         color: Colors.white, size: 24),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Daily Reflection",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text(
//                           _reflections[_currentReflectionIndex]["quote"]!,
//                           style: const TextStyle(
//                             fontStyle: FontStyle.italic,
//                             fontSize: 15,
//                             color: Colors.black87,
//                             height: 1.4,
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               _reflections[_currentReflectionIndex]
//                                   ["reference"]!,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black54,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 8, vertical: 4),
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.7),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 _reflections[_currentReflectionIndex]["verse"]!,
//                                 style: const TextStyle(
//                                   fontSize: 10,
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
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
// }