import 'package:church_app/screens/ui/faith/dashboard_detail/daily_challenge_screen.dart';
import 'package:flutter/material.dart';
import 'package:church_app/common/constants.dart';
// import 'package:church_app/screens/ui/faith/daily_challenge_screen.dart';

class DailyChallengesViewAllScreen extends StatefulWidget {
  const DailyChallengesViewAllScreen({super.key});

  @override
  State<DailyChallengesViewAllScreen> createState() => _DailyChallengesViewAllScreenState();
}

class _DailyChallengesViewAllScreenState extends State<DailyChallengesViewAllScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  final List<Map<String, dynamic>> _challenges = [
    {
      "title": "Scripture Memory",
      "subtitle": "Memorize Verses",
      "icon": Icons.psychology,
      "color": Colors.purple,
      "description": "Challenge yourself to memorize meaningful Bible verses and deepen your understanding of God's word.",
      "difficulty": "Medium",
      "duration": "15 min/day",
      "participants": "2.3k",
      "completionRate": 0.7,
      "streak": 5,
      "isActive": true,
    },
    {
      "title": "Prayer Challenge",
      "subtitle": "Daily Prayers",
      "icon": Icons.favorite,
      "color": Colors.red,
      "description": "Strengthen your prayer life through structured daily prayer challenges and spiritual exercises.",
      "difficulty": "Easy",
      "duration": "20 min/day",
      "participants": "4.1k",
      "completionRate": 0.4,
      "streak": 3,
      "isActive": true,
    },
    {
      "title": "Bible Trivia",
      "subtitle": "Test Knowledge",
      "icon": Icons.quiz,
      "color": Colors.green,
      "description": "Test and expand your Biblical knowledge with daily trivia questions covering Old and New Testament.",
      "difficulty": "Hard",
      "duration": "10 min/day",
      "participants": "1.8k",
      "completionRate": 0.85,
      "streak": 7,
      "isActive": true,
    },
    {
      "title": "Faith Journey",
      "subtitle": "Daily Reflection",
      "icon": Icons.auto_awesome,
      "color": Colors.orange,
      "description": "Reflect on your spiritual growth through guided daily reflections and journaling exercises.",
      "difficulty": "Easy",
      "duration": "25 min/day",
      "participants": "3.2k",
      "completionRate": 0.6,
      "streak": 4,
      "isActive": true,
    },
    {
      "title": "Acts of Service",
      "subtitle": "Serve Others",
      "icon": Icons.volunteer_activism,
      "color": Colors.teal,
      "description": "Put your faith into action through daily acts of service and kindness in your community.",
      "difficulty": "Medium",
      "duration": "30 min/day",
      "participants": "956",
      "completionRate": 0.3,
      "streak": 0,
      "isActive": false,
    },
    {
      "title": "Gratitude Practice",
      "subtitle": "Count Blessings",
      "icon": Icons.emoji_emotions,
      "color": Colors.amber,
      "description": "Cultivate a grateful heart by daily recognizing and recording God's blessings in your life.",
      "difficulty": "Easy",
      "duration": "10 min/day",
      "participants": "5.7k",
      "completionRate": 0.9,
      "streak": 0,
      "isActive": false,
    },
    {
      "title": "Fasting & Prayer",
      "subtitle": "Spiritual Discipline",
      "icon": Icons.self_improvement,
      "color": Colors.indigo,
      "description": "Deepen your spiritual discipline through guided fasting periods combined with focused prayer.",
      "difficulty": "Hard",
      "duration": "Variable",
      "participants": "743",
      "completionRate": 0.2,
      "streak": 0,
      "isActive": false,
    },
    {
      "title": "Scripture Art",
      "subtitle": "Creative Expression",
      "icon": Icons.palette,
      "color": Colors.pink,
      "description": "Express your faith creatively by creating art inspired by daily scripture readings.",
      "difficulty": "Medium",
      "duration": "45 min/day",
      "participants": "1.2k",
      "completionRate": 0.5,
      "streak": 0,
      "isActive": false,
    },
  ];

  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Active", "Easy", "Medium", "Hard"];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutQuart),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredChallenges {
    if (_selectedCategory == "All") return _challenges;
    if (_selectedCategory == "Active") {
      return _challenges.where((challenge) => challenge["isActive"] == true).toList();
    }
    return _challenges.where((challenge) => 
      challenge["difficulty"].toString().toLowerCase() == _selectedCategory.toLowerCase()
    ).toList();
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
          // Header Section
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade600, Colors.blue.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Transform Your Faith Journey",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Choose from various challenges to grow spiritually",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Statistics Row
                Row(
                  children: [
                    _buildStatItem("Active Challenges", "${_challenges.where((c) => c["isActive"]).length}"),
                    const SizedBox(width: 20),
                    _buildStatItem("Total Participants", "18.8k"),
                    const SizedBox(width: 20),
                    _buildStatItem("Avg. Completion", "56%"),
                  ],
                ),
              ],
            ),
          ),

          // Category Filter
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.grey[200],
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: isSelected ? [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ] : null,
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Challenges List
          Expanded(
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, _slideAnimation.value * 50),
                  child: Opacity(
                    opacity: 1 - _slideAnimation.value,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredChallenges.length,
                      itemBuilder: (context, index) {
                        return _buildChallengeCard(_filteredChallenges[index], index);
                      },
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

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildChallengeCard(Map<String, dynamic> challenge, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: challenge["color"].withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with gradient
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  challenge["color"].withOpacity(0.8),
                  challenge["color"].withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    challenge["icon"],
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            challenge["title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (challenge["isActive"])
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "ACTIVE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        challenge["subtitle"],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (challenge["streak"] > 0)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "${challenge["streak"]}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "streak",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  challenge["description"],
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                
                // Challenge Stats
                Row(
                  children: [
                    _buildChallengeStatChip(
                      Icons.schedule,
                      challenge["duration"],
                      Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildChallengeStatChip(
                      Icons.trending_up,
                      challenge["difficulty"],
                      _getDifficultyColor(challenge["difficulty"]),
                    ),
                    const SizedBox(width: 8),
                    _buildChallengeStatChip(
                      Icons.people,
                      challenge["participants"],
                      Colors.purple,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Progress Bar
                Row(
                  children: [
                    const Text(
                      "Completion Rate: ",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "${(challenge["completionRate"] * 100).toInt()}%",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: challenge["color"],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: challenge["completionRate"],
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(challenge["color"]),
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 20),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DailyChallengeScreen(
                                challengeTitle: challenge["title"],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: challenge["color"],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text(
                          challenge["isActive"] ? "Continue" : "Start Challenge",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showChallengeDetails(challenge);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: challenge["color"]),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "Details",
                          style: TextStyle(
                            color: challenge["color"],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
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
    );
  }

  Widget _buildChallengeStatChip(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "hard":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showChallengeDetails(Map<String, dynamic> challenge) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: challenge["color"].withOpacity(0.1),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: challenge["color"],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      challenge["icon"],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challenge["title"],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          challenge["subtitle"],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "About This Challenge",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      challenge["description"],
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    const Text(
                      "Challenge Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    _buildDetailRow("Duration", challenge["duration"]),
                    _buildDetailRow("Difficulty", challenge["difficulty"]),
                    _buildDetailRow("Participants", challenge["participants"]),
                    _buildDetailRow(
                      "Success Rate", 
                      "${(challenge["completionRate"] * 100).toInt()}%"
                    ),
                    
                    const SizedBox(height: 24),
                    
                    if (challenge["isActive"]) ...[
                      const Text(
                        "Your Progress",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildDetailRow("Current Streak", "${challenge["streak"]} days"),
                      _buildDetailRow(
                        "Completion", 
                        "${(challenge["completionRate"] * 100).toInt()}%"
                      ),
                    ],
                  ],
                ),
              ),
            ),
            
            // Bottom Button
            Container(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DailyChallengeScreen(
                          challengeTitle: challenge["title"],
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: challenge["color"],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    challenge["isActive"] ? "Continue Challenge" : "Start Challenge",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
    }