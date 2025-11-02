import 'package:flutter/material.dart';

class DevotionalPracticeDetailScreen extends StatefulWidget {
  final Map<String, dynamic> practice;

  const DevotionalPracticeDetailScreen({super.key, required this.practice});

  @override
  State<DevotionalPracticeDetailScreen> createState() => _DevotionalPracticeDetailScreenState();
}

class _DevotionalPracticeDetailScreenState extends State<DevotionalPracticeDetailScreen> {
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  bool _isEnrolled = false;
  int _progressDays = 0;

  final Map<String, Map<String, dynamic>> _practiceDetails = {
    "Liturgy of Hours": {
      "description": "The Liturgy of the Hours is the official daily prayer of the Catholic Church. It sanctifies the different hours of the day through psalms, readings, and prayers.",
      "benefits": [
        "Sanctifies your entire day",
        "Deepens connection with the universal Church",
        "Structured prayer routine",
        "Rich scriptural meditation"
      ],
      "schedule": [
        {"time": "5:00 AM", "prayer": "Office of Readings"},
        {"time": "6:00 AM", "prayer": "Morning Prayer (Lauds)"},
        {"time": "9:00 AM", "prayer": "Mid-Morning Prayer"},
        {"time": "12:00 PM", "prayer": "Midday Prayer"},
        {"time": "3:00 PM", "prayer": "Mid-Afternoon Prayer"},
        {"time": "6:00 PM", "prayer": "Evening Prayer (Vespers)"},
        {"time": "9:00 PM", "prayer": "Night Prayer (Compline)"}
      ],
    },
    "Novenas": {
      "description": "A novena is a nine-day period of prayer seeking special graces or intercession. It's an ancient Catholic tradition rooted in the nine days the Apostles and Mary spent in prayer between Ascension and Pentecost.",
      "benefits": [
        "Focused intention for 9 days",
        "Deepens faith through persistence",
        "Powerful spiritual practice",
        "Community prayer tradition"
      ],
      "schedule": [
        {"day": "Day 1", "focus": "Opening Prayer & Intention"},
        {"day": "Day 2", "focus": "Trust in God's Will"},
        {"day": "Day 3", "focus": "Gratitude & Thanksgiving"},
        {"day": "Day 4-8", "focus": "Daily Meditation"},
        {"day": "Day 9", "focus": "Closing Prayer"}
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final practiceColor = widget.practice["color"] as Color;
    final practiceTitle = widget.practice["title"] as String;
    final details = _practiceDetails[practiceTitle] ?? {
      "description": "Explore this rich devotional practice and grow in your faith.",
      "benefits": ["Spiritual growth", "Deeper prayer life", "Catholic tradition"],
      "schedule": [],
    };

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: CustomScrollView(
        slivers: [
          // Hero Header
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: practiceColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () => _sharePractice(),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [practiceColor, practiceColor.withOpacity(0.7)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.practice["icon"] as IconData,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(
                        practiceTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.practice["subtitle"] as String,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Enrollment Card
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: _isEnrolled
                          ? [const Color(0xFF7CB798), const Color(0xFF50B5B0)]
                          : [_primaryBlue, _deepPurple],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: practiceColor.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      if (_isEnrolled) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Your Progress",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                "$_progressDays days",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progressDays / 30,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 12,
                          ),
                        ),
                      ] else ...[
                        Row(
                          children: [
                            const Icon(Icons.people, color: Colors.white, size: 24),
                            const SizedBox(width: 12),
                            const Text(
                              "Join 2,547 others",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => setState(() {
                            _isEnrolled = !_isEnrolled;
                            if (_isEnrolled) _progressDays = 3;
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: practiceColor,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            _isEnrolled ? "Continue Practice" : "Start This Practice",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Description Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About This Practice",
                        style: TextStyle(
                          color: _deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
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
                        child: Text(
                          details["description"] as String,
                          style: TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Benefits Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Benefits",
                        style: TextStyle(
                          color: _deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...(details["benefits"] as List<String>).map((benefit) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: practiceColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.check_circle,
                                  color: practiceColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  benefit,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Schedule/Structure Section
                if ((details["schedule"] as List).isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          practiceTitle.contains("Liturgy") ? "Daily Schedule" : "Structure",
                          style: TextStyle(
                            color: _deepPurple,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
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
                          child: Column(
                            children: (details["schedule"] as List).map<Widget>((item) {
                              final isLast = item == (details["schedule"] as List).last;
                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: practiceColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["time"] as String? ?? item["day"] as String,
                                              style: TextStyle(
                                                color: practiceColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              item["prayer"] as String? ?? item["focus"] as String,
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (!isLast) ...[
                                    const SizedBox(height: 16),
                                    const Divider(),
                                    const SizedBox(height: 16),
                                  ],
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 32),

                // Resources Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Resources",
                        style: TextStyle(
                          color: _deepPurple,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildResourceCard(
                        "Getting Started Guide",
                        "Complete introduction for beginners",
                        Icons.menu_book,
                        practiceColor,
                      ),
                      _buildResourceCard(
                        "Audio Guides",
                        "Listen to guided practices",
                        Icons.headphones,
                        practiceColor,
                      ),
                      _buildResourceCard(
                        "Community Forum",
                        "Connect with other practitioners",
                        Icons.forum,
                        practiceColor,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
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
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  void _sharePractice() {
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
              "Share Practice",
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
}