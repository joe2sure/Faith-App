import 'package:flutter/material.dart';
import 'package:church_app/common/constants.dart';

class DailyChallengeScreen extends StatefulWidget {
  final String? challengeTitle;
  
  const DailyChallengeScreen({super.key, this.challengeTitle});

  @override
  State<DailyChallengeScreen> createState() => _DailyChallengeScreenState();
}

class _DailyChallengeScreenState extends State<DailyChallengeScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  final List<Map<String, dynamic>> _challenges = [
    {
      "title": "Scripture Memory",
      "subtitle": "Memorize Verses",
      "icon": Icons.psychology,
      "color": Colors.purple,
      "description": "Challenge yourself to memorize meaningful Bible verses",
      "todaysVerse": "John 3:16 - For God so loved the world that he gave his one and only Son...",
      "progress": 0.7,
      "streak": 5,
      "totalVerses": 15,
      "memorizedVerses": 10,
    },
    {
      "title": "Prayer Challenge",
      "subtitle": "Daily Prayers",
      "icon": Icons.favorite,
      "color": Colors.red,
      "description": "Strengthen your prayer life with daily challenges",
      "todaysChallenge": "Pray the Rosary with intentional meditation",
      "progress": 0.4,
      "streak": 3,
      "totalPrayers": 20,
      "completedPrayers": 8,
    },
    {
      "title": "Bible Trivia",
      "subtitle": "Test Knowledge",
      "icon": Icons.quiz,
      "color": Colors.green,
      "description": "Test and expand your Biblical knowledge",
      "todaysQuestion": "Which disciple walked on water with Jesus?",
      "progress": 0.85,
      "streak": 7,
      "totalQuestions": 100,
      "answeredQuestions": 85,
    },
    {
      "title": "Faith Journey",
      "subtitle": "Daily Reflection",
      "icon": Icons.auto_awesome,
      "color": Colors.orange,
      "description": "Reflect on your spiritual growth and faith journey",
      "todaysReflection": "How has God shown His love to you today?",
      "progress": 0.6,
      "streak": 4,
      "totalReflections": 30,
      "completedReflections": 18,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _challenges.length, vsync: this);
    
    // If a specific challenge was passed, set the initial tab
    if (widget.challengeTitle != null) {
      final index = _challenges.indexWhere(
        (challenge) => challenge["title"] == widget.challengeTitle,
      );
      if (index != -1) {
        _currentTabIndex = index;
        _tabController.index = index;
      }
    }
    
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Daily Challenges',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Challenge Overview Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _challenges[_currentTabIndex]["color"].withOpacity(0.8),
                  _challenges[_currentTabIndex]["color"].withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: _challenges[_currentTabIndex]["color"].withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
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
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _challenges[_currentTabIndex]["icon"],
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _challenges[_currentTabIndex]["title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            _challenges[_currentTabIndex]["description"],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildStatCard("Streak", "${_challenges[_currentTabIndex]["streak"]} days"),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      "Progress", 
                      "${(_challenges[_currentTabIndex]["progress"] * 100).toInt()}%"
                    ),
                    const SizedBox(width: 12),
                    _buildStatCard(
                      "Completed", 
                      _getChallengeProgress(_currentTabIndex)
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: _challenges[_currentTabIndex]["color"],
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[600],
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              tabs: _challenges.map((challenge) {
                return Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(challenge["icon"], size: 16),
                      const SizedBox(width: 4),
                      Text(challenge["title"]),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _challenges.map((challenge) {
                final index = _challenges.indexOf(challenge);
                return _buildChallengeContent(index);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getChallengeProgress(int index) {
    final challenge = _challenges[index];
    switch (challenge["title"]) {
      case "Scripture Memory":
        return "${challenge["memorizedVerses"]}/${challenge["totalVerses"]}";
      case "Prayer Challenge":
        return "${challenge["completedPrayers"]}/${challenge["totalPrayers"]}";
      case "Bible Trivia":
        return "${challenge["answeredQuestions"]}/${challenge["totalQuestions"]}";
      case "Faith Journey":
        return "${challenge["completedReflections"]}/${challenge["totalReflections"]}";
      default:
        return "0/0";
    }
  }

  Widget _buildChallengeContent(int index) {
    final challenge = _challenges[index];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: challenge["color"],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: challenge["color"].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "${challenge["streak"]} day streak",
                          style: TextStyle(
                            color: challenge["color"],
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  LinearProgressIndicator(
                    value: challenge["progress"],
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(challenge["color"]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "${(challenge["progress"] * 100).toInt()}% Complete",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Today's Challenge Card
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's ${challenge["title"]}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: challenge["color"].withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: challenge["color"].withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getTodaysContent(index),
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  _startChallenge(index);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: challenge["color"],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  _getActionButtonText(index),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            OutlinedButton(
                              onPressed: () {
                                _skipChallenge(index);
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: challenge["color"]),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                  color: challenge["color"],
                                  fontWeight: FontWeight.bold,
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

          const SizedBox(height: 16),

          // Recent Achievements
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Recent Achievements",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildAchievementsList(index),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getTodaysContent(int index) {
    final challenge = _challenges[index];
    switch (challenge["title"]) {
      case "Scripture Memory":
        return challenge["todaysVerse"];
      case "Prayer Challenge":
        return challenge["todaysChallenge"];
      case "Bible Trivia":
        return challenge["todaysQuestion"];
      case "Faith Journey":
        return challenge["todaysReflection"];
      default:
        return "No challenge available";
    }
  }

  String _getActionButtonText(int index) {
    final challenge = _challenges[index];
    switch (challenge["title"]) {
      case "Scripture Memory":
        return "Start Memorizing";
      case "Prayer Challenge":
        return "Begin Prayer";
      case "Bible Trivia":
        return "Answer Question";
      case "Faith Journey":
        return "Write Reflection";
      default:
        return "Start Challenge";
    }
  }

  Widget _buildAchievementsList(int index) {
    final achievements = _getAchievements(index);
    
    return Column(
      children: achievements.map((achievement) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _challenges[index]["color"].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  achievement["icon"],
                  color: _challenges[index]["color"],
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement["title"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      achievement["description"],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                achievement["date"],
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<Map<String, dynamic>> _getAchievements(int index) {
    final challengeTitle = _challenges[index]["title"];
    
    switch (challengeTitle) {
      case "Scripture Memory":
        return [
          {
            "icon": Icons.star,
            "title": "5-Day Streak",
            "description": "Completed memory challenges for 5 days",
            "date": "2 days ago"
          },
          {
            "icon": Icons.book,
            "title": "John 3:16 Mastered",
            "description": "Successfully memorized this verse",
            "date": "1 week ago"
          },
        ];
      case "Prayer Challenge":
        return [
          {
            "icon": Icons.favorite,
            "title": "Rosary Champion",
            "description": "Prayed the Rosary for 7 consecutive days",
            "date": "3 days ago"
          },
          {
            "icon": Icons.schedule,
            "title": "Morning Prayer",
            "description": "Completed morning prayers for 30 days",
            "date": "1 week ago"
          },
        ];
      case "Bible Trivia":
        return [
          {
            "icon": Icons.psychology,
            "title": "Bible Scholar",
            "description": "Answered 50 questions correctly",
            "date": "1 day ago"
          },
          {
            "icon": Icons.quiz,
            "title": "Perfect Score",
            "description": "Got 10 questions right in a row",
            "date": "3 days ago"
          },
        ];
      case "Faith Journey":
        return [
          {
            "icon": Icons.edit,
            "title": "Reflective Soul",
            "description": "Completed 15 daily reflections",
            "date": "2 days ago"
          },
          {
            "icon": Icons.auto_awesome,
            "title": "Deep Thinker",
            "description": "Wrote a 200+ word reflection",
            "date": "5 days ago"
          },
        ];
      default:
        return [];
    }
  }

  void _startChallenge(int index) {
    final challengeTitle = _challenges[index]["title"];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Starting $challengeTitle challenge..."),
        backgroundColor: _challenges[index]["color"],
        duration: const Duration(seconds: 2),
      ),
    );
    
    // Here you would navigate to the specific challenge implementation
    // For now, just showing a snackbar
  }

  void _skipChallenge(int index) {
    final challengeTitle = _challenges[index]["title"];
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Skipped today's $challengeTitle. Try again tomorrow!"),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}