import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/constants/app_colors.dart';

class ScriptureReadingScreen extends StatefulWidget {
  final String title;
  final String content;
  final String? reference;

  const ScriptureReadingScreen({
    super.key,
    required this.title,
    required this.content,
    this.reference,
  });

  @override
  State<ScriptureReadingScreen> createState() => _ScriptureReadingScreenState();
}

class _ScriptureReadingScreenState extends State<ScriptureReadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  double _fontSize = 18.0;
  bool _isBookmarked = false;
  bool _isDarkMode = false;

  // Sample scripture content - in real app, this would come from an API or database
  // final Map<String, Map<String, dynamic>> _scriptureContent = {
  //   "Matthew 13:1-23 - The Parable of the Sower": {
  //     "chapter": "Matthew 13:1-23",
  //     "title": "The Parable of the Sower",
  //     "verses": [
  //       {
  //         "verse": "1",
  //         "text": "That same day Jesus went out of the house and sat by the lake."
  //       },
  //       {
  //         "verse": "2", 
  //         "text": "Such large crowds gathered around him that he got into a boat and sat in it, while all the people stood on the shore."
  //       },
  //       {
  //         "verse": "3",
  //         "text": "Then he told them many things in parables, saying: \"A farmer went out to sow his seed."
  //       },
  //       {
  //         "verse": "4",
  //         "text": "As he was scattering the seed, some fell along the path, and the birds came and ate it up."
  //       },
  //       {
  //         "verse": "5",
  //         "text": "Some fell on rocky places, where it did not have much soil. It sprang up quickly, because the soil was shallow."
  //       },
  //       {
  //         "verse": "6", 
  //         "text": "But when the sun came up, the plants were scorched, and they withered because they had no root."
  //       },
  //       {
  //         "verse": "7",
  //         "text": "Other seed fell among thorns, which grew up and choked the plants."
  //       },
  //       {
  //         "verse": "8",
  //         "text": "Still other seed fell on good soil, where it produced a crop—a hundred, sixty or thirty times what was sown."
  //       },
  //       {
  //         "verse": "9",
  //         "text": "Whoever has ears, let them hear.\""
  //       },
  //     ],
  //     "reflection": "This parable teaches us about the different ways people receive God's word. The seed represents the message of the kingdom, and the different soils represent the condition of our hearts when we hear it.",
  //   },
  //   "John 3:16 - For God so loved the world...": {
  //     "chapter": "John 3:16",
  //     "title": "God's Love for the World",
  //     "verses": [
  //       {
  //         "verse": "16",
  //         "text": "For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."
  //       },
  //     ],
  //     "reflection": "This verse encapsulates the heart of the Gospel - God's immense love for humanity and the gift of salvation through Jesus Christ.",
  //   },
  //   "Psalm 23 - The Lord is my Shepherd": {
  //     "chapter": "Psalm 23",
  //     "title": "The Lord is my Shepherd", 
  //     "verses": [
  //       {
  //         "verse": "1",
  //         "text": "The Lord is my shepherd, I lack nothing."
  //       },
  //       {
  //         "verse": "2",
  //         "text": "He makes me lie down in green pastures, he leads me beside quiet waters,"
  //       },
  //       {
  //         "verse": "3",
  //         "text": "he refreshes my soul. He guides me along the right paths for his name's sake."
  //       },
  //       {
  //         "verse": "4",
  //         "text": "Even though I walk through the darkest valley, I will fear no evil, for you are with me; your rod and your staff, they comfort me."
  //       },
  //       {
  //         "verse": "5",
  //         "text": "You prepare a table before me in the presence of my enemies. You anoint my head with oil; my cup overflows."
  //       },
  //       {
  //         "verse": "6",
  //         "text": "Surely your goodness and love will follow me all the days of my life, and I will dwell in the house of the Lord forever."
  //       },
  //     ],
  //     "reflection": "This beloved psalm portrays God as our caring shepherd who provides, protects, and guides us through all circumstances of life.",
  //   },
  // };


final Map<String, Map<String, dynamic>> _scriptureContent = {
  "Chronological Plan": {
    "chapter": "Reading Plan",
    "title": "Chronological Bible Reading Plan",
    "verses": [
      {
        "verse": "Overview",
        "text": "Read the Bible in the order events occurred historically. This plan helps you understand the timeline of biblical history from Creation to the early Church."
      },
      {
        "verse": "Week 1",
        "text": "Genesis 1-11: Creation, Fall, and the Flood. Experience the beginning of human history and God's covenant with Noah."
      },
      {
        "verse": "Week 2",
        "text": "Genesis 12-50: The Patriarchs. Follow Abraham, Isaac, Jacob, and Joseph as God establishes His chosen people."
      },
      {
        "verse": "Benefits",
        "text": "Understanding Scripture in historical context provides clarity on how God's plan unfolded through time, revealing the continuity of His saving work."
      },
    ],
    "reflection": "Reading chronologically helps us see God's patient love working through history, preparing humanity for the coming of Christ.",
  },
  "Canonical Plan": {
    "chapter": "Reading Plan",
    "title": "Canonical Bible Reading Plan",
    "verses": [
      {
        "verse": "Overview",
        "text": "Follow the traditional order of biblical books as arranged in the Catholic Bible, from Genesis to Revelation."
      },
      {
        "verse": "Old Testament",
        "text": "Begin with the Pentateuch (Genesis-Deuteronomy), then Historical Books, Wisdom Literature, and Prophets. This order shows the development of God's revelation."
      },
      {
        "verse": "New Testament",
        "text": "Read the Gospels, Acts, Epistles, and Revelation. See how Christ fulfills the Old Testament and establishes the Church."
      },
    ],
    "reflection": "The canonical order reflects how the Church has traditionally received and organized Scripture, honoring centuries of faithful transmission.",
  },
  "Thematic Plan": {
    "chapter": "Reading Plan",
    "title": "Thematic Bible Reading Plan",
    "verses": [
      {
        "verse": "Overview",
        "text": "Explore Scripture through key spiritual themes such as love, faith, hope, salvation, prayer, and discipleship."
      },
      {
        "verse": "Theme: God's Love",
        "text": "Journey through passages revealing God's merciful love: John 3:16, Romans 8:38-39, 1 John 4:7-21, and the parables of mercy in Luke 15."
      },
      {
        "verse": "Theme: Prayer",
        "text": "Learn from Jesus and the saints about prayer: The Lord's Prayer (Matthew 6:9-13), Jesus in Gethsemane (Luke 22:39-46), and Paul's prayers in Ephesians."
      },
    ],
    "reflection": "Thematic reading helps us deeply understand specific aspects of our faith and apply them to our daily spiritual lives.",
  },
  "One-Year Bible": {
    "chapter": "Reading Plan",
    "title": "One-Year Bible Reading Plan",
    "verses": [
      {
        "verse": "Overview",
        "text": "Complete the entire Catholic Bible in 365 days with daily readings from both Old and New Testaments."
      },
      {
        "verse": "Daily Structure",
        "text": "Each day includes: 3 chapters from the Old Testament, 1 Psalm, 1 chapter from Wisdom Literature, and 1-2 chapters from the New Testament."
      },
      {
        "verse": "Commitment",
        "text": "This plan requires dedication but rewards you with comprehensive biblical knowledge and spiritual growth throughout the year."
      },
    ],
    "reflection": "Immersing yourself in Scripture daily transforms your mind and heart, allowing God's Word to shape every aspect of your life.",
  },
  "Custom Plan": {
    "chapter": "Reading Plan",
    "title": "Create Your Custom Reading Plan",
    "verses": [
      {
        "verse": "Personalize",
        "text": "Design a reading plan that fits your spiritual needs, schedule, and goals. Choose specific books, themes, or time frames."
      },
      {
        "verse": "Flexibility",
        "text": "Adjust your pace, focus on challenging books, revisit favorites, or create a plan around liturgical seasons like Advent or Lent."
      },
      {
        "verse": "Guidance",
        "text": "Consider consulting with a spiritual director or priest to create a plan that supports your current spiritual journey."
      },
    ],
    "reflection": "A personalized approach to Scripture allows the Holy Spirit to guide you uniquely, meeting you exactly where you are in your faith journey.",
  },
  
  // Keep the original scripture readings as well
  "Matthew 13:1-23 - The Parable of the Sower": {
    "chapter": "Matthew 13:1-23",
    "title": "The Parable of the Sower",
    "verses": [
      {"verse": "1", "text": "That same day Jesus went out of the house and sat by the lake."},
      {"verse": "2", "text": "Such large crowds gathered around him that he got into a boat and sat in it, while all the people stood on the shore."},
      {"verse": "3", "text": "Then he told them many things in parables, saying: \"A farmer went out to sow his seed."},
      {"verse": "4", "text": "As he was scattering the seed, some fell along the path, and the birds came and ate it up."},
      {"verse": "5", "text": "Some fell on rocky places, where it did not have much soil. It sprang up quickly, because the soil was shallow."},
      {"verse": "6", "text": "But when the sun came up, the plants were scorched, and they withered because they had no root."},
      {"verse": "7", "text": "Other seed fell among thorns, which grew up and choked the plants."},
      {"verse": "8", "text": "Still other seed fell on good soil, where it produced a crop—a hundred, sixty or thirty times what was sown."},
      {"verse": "9", "text": "Whoever has ears, let them hear.\""},
    ],
    "reflection": "This parable teaches us about the different ways people receive God's word. The seed represents the message of the kingdom, and the different soils represent the condition of our hearts when we hear it.",
  },
};  

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _shareScripture() {
    final content = _scriptureContent[widget.content];
    if (content != null) {
      String shareText = "${content['title']}\n\n";
      for (var verse in content['verses']) {
        shareText += "${content['chapter'].split(' ')[0]} ${content['chapter'].split(' ')[1].split(':')[0]}:${verse['verse']} ${verse['text']}\n\n";
      }
      
      // In a real app, you would use share_plus package
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Scripture copied to share')),
      );
    }
  }

  void _copyToClipboard() {
    final content = _scriptureContent[widget.content];
    if (content != null) {
      String copyText = "${content['title']}\n\n";
      for (var verse in content['verses']) {
        copyText += "${content['chapter'].split(' ')[0]} ${content['chapter'].split(' ')[1].split(':')[0]}:${verse['verse']} ${verse['text']}\n\n";
      }
      
      Clipboard.setData(ClipboardData(text: copyText));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Scripture copied to clipboard'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _scriptureContent[widget.content];
    
    return Scaffold(
      backgroundColor: _isDarkMode ? Colors.grey[900] : AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Scripture Reading',
          style: TextStyle(
            color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? AppColors.primaryPurple : (_isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary),
            ),
            onPressed: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(_isBookmarked ? 'Scripture bookmarked' : 'Bookmark removed'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(
              _isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
            ),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
            ),
            onSelected: (value) {
              switch (value) {
                case 'share':
                  _shareScripture();
                  break;
                case 'copy':
                  _copyToClipboard();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 20),
                    SizedBox(width: 12),
                    Text('Share'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy, size: 20),
                    SizedBox(width: 12),
                    Text('Copy'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: content == null
          ? const Center(child: Text('Scripture not found'))
          : Column(
              children: [
                // Font Size Controls
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textPrimary.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.text_decrease),
                        onPressed: _fontSize > 12
                            ? () => setState(() => _fontSize -= 2)
                            : null,
                      ),
                      Text(
                        'Font Size',
                        style: TextStyle(
                          color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.text_increase),
                        onPressed: _fontSize < 28
                            ? () => setState(() => _fontSize += 2)
                            : null,
                      ),
                    ],
                  ),
                ),
                
                // Scripture Content
                Expanded(
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Header
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.blue.shade600,
                                        Colors.blue.shade400,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        content['chapter'],
                                        style: const TextStyle(
                                          color: AppColors.backgroundWhite,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        content['title'],
                                        style: const TextStyle(
                                          color: AppColors.backgroundWhite,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 24),
                                
                                // Scripture Verses
                                ...content['verses'].map<Widget>((verse) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.textPrimary.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          child: Center(
                                            child: Text(
                                              verse['verse'],
                                              style: const TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Text(
                                            verse['text'],
                                            style: TextStyle(
                                              fontSize: _fontSize,
                                              height: 1.6,
                                              color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                
                                const SizedBox(height: 24),
                                
                                // Reflection Section
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: _isDarkMode ? Colors.amber[700] : Colors.amber[50],
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: _isDarkMode ? Colors.amber[600]! : Colors.amber[200]!,
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lightbulb,
                                            color: _isDarkMode ? Colors.amber[200] : Colors.amber[700],
                                            size: 24,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Reflection',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: _isDarkMode ? Colors.amber[200] : Colors.amber[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        content['reflection'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: _isDarkMode ? Colors.amber[100] : Colors.amber[800],
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 40),
                              ],
                            ),
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
}