import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../common/reusable_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';

class ScriptureReadingScreen extends StatefulWidget {
  final String title;
  final String content;
  final String reference;

  const ScriptureReadingScreen({
    super.key,
    required this.title,
    required this.content,
    required this.reference,
  });

  @override
  State<ScriptureReadingScreen> createState() => _ScriptureReadingScreenState();
}

class _ScriptureReadingScreenState extends State<ScriptureReadingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isSaved = false;
  int _currentDay = 1;
  double _progress = 0.0;
  String _selectedFontSize = 'Medium';
  bool _isNightMode = false;

  // Content specific to each reading plan
  final Map<String, Map<String, dynamic>> _planContent = {
    "Chronological Plan": {
      "description":
          "Experience the Bible as history unfolded. This plan takes you through Scripture in the order events occurred, from Creation to Revelation.",
      "duration": "365 days",
      "totalReadings": 365,
      "difficulty": "Intermediate",
      "color": AppColors.primaryBlue,
      "image": "https://images.unsplash.com/photo-1519074069444-1ba4fff66d16?w=800",
      "dailyReadings": [
        {
          "day": 1,
          "title": "In the Beginning",
          "passages": ["Genesis 1:1-2:3"],
          "content":
              "In the beginning God created the heavens and the earth. Now the earth was formless and empty, darkness was over the surface of the deep, and the Spirit of God was hovering over the waters.\n\nAnd God said, 'Let there be light,' and there was light. God saw that the light was good, and he separated the light from the darkness. God called the light 'day,' and the darkness he called 'night.' And there was evening, and there was morning—the first day.\n\nAnd God said, 'Let there be a vault between the waters to separate water from water.' So God made the vault and separated the water under the vault from the water above it. And it was so. God called the vault 'sky.' And there was evening, and there was morning—the second day.",
          "reflection":
              "God's creation reveals His power, intentionality, and love. Everything He made was 'good,' showing His perfect design and care.",
          "prayer":
              "Creator God, help me see Your handiwork in creation and recognize Your presence in all things. Amen.",
        },
        {
          "day": 2,
          "title": "The Creation of Humanity",
          "passages": ["Genesis 2:4-25"],
          "content":
              "This is the account of the heavens and the earth when they were created, when the Lord God made the earth and the heavens.\n\nThen the Lord God formed a man from the dust of the ground and breathed into his nostrils the breath of life, and the man became a living being.\n\nNow the Lord God had planted a garden in the east, in Eden; and there he put the man he had formed. The Lord God made all kinds of trees grow out of the ground—trees that were pleasing to the eye and good for food. In the middle of the garden were the tree of life and the tree of the knowledge of good and evil.",
          "reflection":
              "Humanity is created in God's image with dignity, purpose, and the breath of divine life. We are meant for relationship with God.",
          "prayer":
              "Lord, remind me that I am fearfully and wonderfully made in Your image. Help me live worthy of this calling. Amen.",
        },
        // {
        //   "day": 3,
        //   "title": "The Fall of Man",
        //   "passages": ["Genesis 3:1-24"],
        //   "content":
        //       "Now the serpent was more crafty than any of the wild animals the Lord God had made. He said to the woman, 'Did God really say, "You must not eat from any tree in the garden"?'\n\nThe woman said to the serpent, 'We may eat fruit from the trees in the garden, but God did say, "You must not eat fruit from the tree that is in the middle of the garden, and you must not touch it, or you will die."'\n\n'You will not certainly die,' the serpent said to the woman. 'For God knows that when you eat from it your eyes will be opened, and you will be like God, knowing good and evil.'",
        //   "reflection":
        //       "Sin entered through disobedience, but even in judgment, God's mercy is evident. He provides covering and a promise of redemption.",
        //   "prayer":
        //       "Merciful Father, forgive my disobedience. Help me trust Your word and resist temptation. Thank You for Your redemption. Amen.",
        // },
      ],
    },
    "Canonical Plan": {
      "description":
          "Follow the traditional book order of the Bible. Read through Scripture as it appears in your Bible from Genesis to Revelation.",
      "duration": "365 days",
      "totalReadings": 365,
      "difficulty": "Beginner",
      "color": AppColors.primaryPurple,
      "image": "https://images.unsplash.com/photo-1505682634904-d7c8d95cdc50?w=800",
      "dailyReadings": [
        {
          "day": 1,
          "title": "The Beginning of All Things",
          "passages": ["Genesis 1-3"],
          "content":
              "In the beginning God created the heavens and the earth. The Bible opens with the majestic account of creation, establishing God as the sovereign Creator of all that exists.\n\nGod creates with purpose and order: light and darkness, sky and sea, land and vegetation, sun and moon and stars, fish and birds, animals and finally humanity—made in His own image.\n\nHumanity is given the sacred responsibility to steward creation and live in fellowship with God. Yet through disobedience, sin enters the world, disrupting the perfect harmony between God and His creation.",
          "reflection":
              "The canonical order reminds us that our story begins with God. He is the author of life, and we find our identity in Him.",
          "prayer":
              "God of all creation, help me recognize You as the beginning and end of all things. Guide me to walk in Your ways. Amen.",
        },
        {
          "day": 2,
          "title": "Cain and Abel",
          "passages": ["Genesis 4-5"],
          "content":
              "Adam made love to his wife Eve, and she became pregnant and gave birth to Cain. She said, 'With the help of the Lord I have brought forth a man.' Later she gave birth to his brother Abel.\n\nNow Abel kept flocks, and Cain worked the soil. In the course of time Cain brought some of the fruits of the soil as an offering to the Lord. And Abel also brought an offering—fat portions from some of the firstborn of his flock. The Lord looked with favor on Abel and his offering, but on Cain and his offering he did not look with favor.",
          "reflection":
              "The story of Cain and Abel teaches us about the condition of the heart in worship. God looks beyond our offerings to our attitudes.",
          "prayer":
              "Lord, examine my heart. Let my worship be genuine and pleasing to You. Guard me from jealousy and pride. Amen.",
        },
        {
          "day": 3,
          "title": "Noah and the Flood",
          "passages": ["Genesis 6-9"],
          "content":
              "The Lord saw how great the wickedness of the human race had become on the earth, and that every inclination of the thoughts of the human heart was only evil all the time. The Lord regretted that he had made human beings on the earth, and his heart was deeply troubled.\n\nBut Noah found favor in the eyes of the Lord. Noah was a righteous man, blameless among the people of his time, and he walked faithfully with God.\n\nSo God said to Noah, 'I am going to bring floodwaters on the earth to destroy all life under the heavens, every creature that has the breath of life in it. Everything on earth will perish. But I will establish my covenant with you.'",
          "reflection":
              "Even in judgment, God's grace shines through. Noah's obedience and faith saved his family and preserved God's creation.",
          "prayer":
              "Faithful God, like Noah, help me walk with You faithfully even when the world around me rejects You. Amen.",
        },
      ],
    },
    "Thematic Plan": {
      "description":
          "Explore Scripture through key spiritual themes like faith, love, prayer, and salvation. Discover how biblical truths connect across both testaments.",
      "duration": "180 days",
      "totalReadings": 180,
      "difficulty": "Intermediate",
      "color": AppColors.accentTeal,
      "image": "https://images.unsplash.com/photo-1504052434569-70ad5836ab65?w=800",
      "dailyReadings": [
        {
          "day": 1,
          "title": "Theme: Faith - Abraham's Call",
          "passages": ["Genesis 12:1-9", "Hebrews 11:8-12"],
          "content":
              "The Lord had said to Abram, 'Go from your country, your people and your father's household to the land I will show you. I will make you into a great nation, and I will bless you; I will make your name great, and you will be a blessing.'\n\nSo Abram went, as the Lord had told him; and Lot went with him. Abram was seventy-five years old when he set out from Harran.\n\nFrom Hebrews: By faith Abraham, when called to go to a place he would later receive as his inheritance, obeyed and went, even though he did not know where he was going. By faith he made his home in the promised land like a stranger in a foreign country.",
          "reflection":
              "True faith means trusting God even when we cannot see the full picture. Abraham's obedience became a blessing to all nations.",
          "prayer":
              "Lord, give me faith like Abraham to follow You wherever You lead, trusting Your promises completely. Amen.",
        },
        {
          "day": 2,
          "title": "Theme: Love - The Greatest Commandment",
          "passages": ["Deuteronomy 6:4-9", "Matthew 22:34-40", "1 John 4:7-21"],
          "content":
              "Hear, O Israel: The Lord our God, the Lord is one. Love the Lord your God with all your heart and with all your soul and with all your strength.\n\nJesus replied: 'Love the Lord your God with all your heart and with all your soul and with all your mind.' This is the first and greatest commandment. And the second is like it: 'Love your neighbor as yourself.'\n\nDear friends, let us love one another, for love comes from God. Everyone who loves has been born of God and knows God. Whoever does not love does not know God, because God is love.",
          "reflection":
              "Love is at the center of God's nature and His commands. Our love for God naturally overflows into love for others.",
          "prayer":
              "God of love, fill my heart with Your love. Help me love You completely and love others as You love me. Amen.",
        },
        {
          "day": 3,
          "title": "Theme: Prayer - Jesus Teaches Us to Pray",
          "passages": ["Matthew 6:5-15", "Luke 11:1-13", "1 Thessalonians 5:16-18"],
          "content":
              "One day Jesus was praying in a certain place. When he finished, one of his disciples said to him, 'Lord, teach us to pray, just as John taught his disciples.'\n\nHe said to them, 'When you pray, say: Father, hallowed be your name, your kingdom come. Give us each day our daily bread. Forgive us our sins, for we also forgive everyone who sins against us. And lead us not into temptation.'\n\nRejoice always, pray continually, give thanks in all circumstances; for this is God's will for you in Christ Jesus.",
          "reflection":
              "Prayer is conversation with God—simple, honest, and continuous. It's how we maintain our relationship with our Heavenly Father.",
          "prayer":
              "Father, teach me to pray with sincerity and persistence. May my prayers align with Your will and bring me closer to You. Amen.",
        },
      ],
    },
    "One-Year Bible": {
      "description":
          "Complete the entire Bible in one year with daily readings from the Old Testament, New Testament, Psalms, and Proverbs.",
      "duration": "365 days",
      "totalReadings": 365,
      "difficulty": "Advanced",
      "color": AppColors.accentGold,
      "image": "https://images.unsplash.com/photo-1474631245212-32dc3c8310c6?w=800",
      "dailyReadings": [
        {
          "day": 1,
          "title": "Day 1 - New Beginnings",
          "passages": [
            "Genesis 1-3",
            "Matthew 1:1-2:12",
            "Psalm 1",
            "Proverbs 1:1-7"
          ],
          "content":
              "OLD TESTAMENT - Genesis 1-3:\nIn the beginning God created the heavens and the earth. The creation narrative reveals God's power, wisdom, and intentional design. Humanity is made in God's image, given dominion over creation, and invited into fellowship with the Creator.\n\nNEW TESTAMENT - Matthew 1-2:\nThe genealogy of Jesus Christ connects the Old Testament promises to their fulfillment. Jesus' birth fulfills prophecy and brings hope to all nations. The Magi's journey shows that all peoples are called to worship the King.\n\nPSALM 1:\nBlessed is the one who does not walk in step with the wicked or stand in the way that sinners take or sit in the company of mockers, but whose delight is in the law of the Lord, and who meditates on his law day and night.\n\nPROVERBS 1:1-7:\nThe fear of the Lord is the beginning of knowledge, but fools despise wisdom and instruction.",
          "reflection":
              "Today's readings span from creation to Christ, from the beginning to the fulfillment of God's plan. Wisdom begins with reverence for God.",
          "prayer":
              "Lord, as I begin this year-long journey through Your Word, open my heart and mind to understand Your truth. Amen.",
        },
        {
          "day": 2,
          "title": "Day 2 - Covenant and Kingdom",
          "passages": [
            "Genesis 4-7",
            "Matthew 2:13-3:6",
            "Psalm 2",
            "Proverbs 1:8-19"
          ],
          "content":
              "OLD TESTAMENT - Genesis 4-7:\nSin's consequences spread through Cain's murder of Abel, yet God shows mercy. Humanity's wickedness grows, but Noah finds favor with God. The flood narrative demonstrates both God's judgment and His grace in preservation.\n\nNEW TESTAMENT - Matthew 2:13-3:6:\nThe holy family flees to Egypt, fulfilling prophecy. John the Baptist prepares the way for Jesus, calling people to repentance. The voice crying in the wilderness announces the coming King.\n\nPSALM 2:\nWhy do the nations conspire and the peoples plot in vain? The One enthroned in heaven laughs. The Lord says to me, 'You are my son; today I have become your father.'\n\nPROVERBS 1:8-19:\nListen, my son, to your father's instruction and do not forsake your mother's teaching. They are a garland to grace your head and a chain to adorn your neck.",
          "reflection":
              "God's plan unfolds despite human rebellion. He preserves a remnant and prepares the way for ultimate redemption through Christ.",
          "prayer":
              "Father, help me walk in obedience like Noah. Prepare my heart to receive Your truth like those who heard John's message. Amen.",
        },
        {
          "day": 3,
          "title": "Day 3 - Testing and Triumph",
          "passages": [
            "Genesis 8-11",
            "Matthew 3:7-4:11",
            "Psalm 3",
            "Proverbs 1:20-33"
          ],
          "content":
              "OLD TESTAMENT - Genesis 8-11:\nAfter the flood, God establishes His covenant with Noah. The rainbow becomes a sign of His promise. Yet humanity's pride leads to the tower of Babel, demonstrating the ongoing struggle between human ambition and God's sovereignty.\n\nNEW TESTAMENT - Matthew 3:7-4:11:\nJesus is baptized, affirming His identity as God's beloved Son. Immediately, He faces temptation in the wilderness, demonstrating perfect obedience where Israel (and humanity) failed. Jesus overcomes through Scripture and dependence on God.\n\nPSALM 3:\nLord, how many are my foes! How many rise up against me! But you, Lord, are a shield around me, my glory, the One who lifts my head high.\n\nPROVERBS 1:20-33:\nWisdom calls aloud in the street. Whoever listens to me will live in safety and be at ease, without fear of harm.",
          "reflection":
              "Jesus succeeds where humanity fails. Through Him, we can overcome temptation and live in covenant relationship with God.",
          "prayer":
              "Lord Jesus, You faced temptation and prevailed. Strengthen me to resist evil and cling to Your Word. Amen.",
        },
      ],
    },
    "Custom Plan": {
      "description":
          "Design your own personalized reading schedule. Choose specific books, themes, or create a unique path through Scripture that fits your spiritual journey.",
      "duration": "Flexible",
      "totalReadings": 0,
      "difficulty": "Customizable",
      "color": AppColors.accentRose,
      "image": "https://images.unsplash.com/photo-1490730141103-6cac27aaab94?w=800",
      "dailyReadings": [
        {
          "day": 1,
          "title": "Create Your Own Journey",
          "passages": ["Your Choice"],
          "content":
              "Welcome to the Custom Reading Plan!\n\nThis plan allows you to create a personalized Bible reading experience tailored to your spiritual needs and goals.\n\nYou can:\n• Choose specific books to study\n• Set your own reading pace\n• Focus on particular themes or topics\n• Combine Old and New Testament readings\n• Include daily devotionals and reflections\n• Track your progress your way\n\nHow to Get Started:\n1. Pray for guidance about what God wants you to study\n2. Consider your available time and commitment level\n3. Select books, passages, or themes that resonate with your current season\n4. Set realistic daily reading goals\n5. Build in time for reflection and application\n\nRemember: The goal isn't just to read through the Bible, but to let the Bible read through you—allowing God's Word to transform your heart and mind.",
          "reflection":
              "God meets us where we are. A custom plan allows you to engage Scripture in a way that fits your unique journey with Him.",
          "prayer":
              "Holy Spirit, guide me as I create my reading plan. Help me choose wisely and commit fully to encountering You in Your Word. Amen.",
        },
      ],
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _calculateProgress();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _calculateProgress() {
    final plan = _planContent[widget.title];
    if (plan != null && plan["totalReadings"] > 0) {
      setState(() {
        _progress = _currentDay / plan["totalReadings"];
      });
    }
  }

  Color _getPlanColor() {
    return _planContent[widget.title]?["color"] ?? AppColors.primaryBlue;
  }

  @override
  Widget build(BuildContext context) {
    final plan = _planContent[widget.title];
    if (plan == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: const Center(
          child: Text('Plan content not available'),
        ),
      );
    }

    final dailyReadings =
        plan["dailyReadings"] as List<Map<String, dynamic>>;
    final currentReading = dailyReadings[
        (_currentDay - 1).clamp(0, dailyReadings.length - 1)];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
                onPressed: () {
                  setState(() {
                    _isSaved = !_isSaved;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isSaved
                          ? 'Reading plan saved to library'
                          : 'Removed from library'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: _getPlanColor(),
                      action: SnackBarAction(
                        label: 'VIEW',
                        textColor: Colors.white,
                        onPressed: () {
                          // Navigate to saved items
                        },
                      ),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _showShareDialog(),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (value) {
                  if (value == 'font') {
                    _showFontSizeDialog();
                  } else if (value == 'night') {
                    setState(() {
                      _isNightMode = !_isNightMode;
                    });
                  } else if (value == 'notes') {
                    _showNotesDialog();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'font',
                    child: Row(
                      children: [
                        Icon(Icons.text_fields),
                        SizedBox(width: 12),
                        Text('Text Size'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'night',
                    child: Row(
                      children: [
                        Icon(Icons.nightlight),
                        SizedBox(width: 12),
                        Text('Night Mode'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'notes',
                    child: Row(
                      children: [
                        Icon(Icons.note_add),
                        SizedBox(width: 12),
                        Text('Add Note'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 3, color: Colors.black26)],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    plan["image"],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [_getPlanColor(), _getPlanColor().withOpacity(0.7)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: _isNightMode ? const Color(0xFF1a1a1a) : Colors.white,
              child: Column(
                children: [
                  // Plan Info Card
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: _isNightMode ? const Color(0xFF2a2a2a) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: _getPlanColor().withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.reference,
                          style: AppTextStyles.h5.copyWith(
                            color: _getPlanColor(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          plan["description"],
                          style: AppTextStyles.bodyMedium.copyWith(
                            height: 1.6,
                            color: _isNightMode ? Colors.white70 : AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoChip(
                              Icons.calendar_today,
                              plan["duration"],
                              _getPlanColor(),
                            ),
                            _buildInfoChip(
                              Icons.menu_book,
                              '${plan["totalReadings"]} readings',
                              _getPlanColor(),
                            ),
                            _buildInfoChip(
                              Icons.signal_cellular_alt,
                              plan["difficulty"],
                              _getPlanColor(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Progress Section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getPlanColor().withOpacity(0.1),
                          _getPlanColor().withOpacity(0.05),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Day $_currentDay of ${plan["totalReadings"]}',
                              style: AppTextStyles.h5.copyWith(
                                color: _isNightMode ? Colors.white : AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '${(_progress * 100).toStringAsFixed(0)}%',
                              style: AppTextStyles.h5.copyWith(
                                color: _getPlanColor(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progress,
                            minHeight: 8,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(_getPlanColor()),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                text: 'Previous Day',
                                onPressed: _currentDay > 1
                                    ? () {
                                        setState(() {
                                          _currentDay--;
                                          _calculateProgress();
                                        });
                                      }
                                    : () {},
                                icon: Icons.arrow_back,
                                isPrimary: false,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: AppButton(
                                text: 'Next Day',
                                onPressed: _currentDay < dailyReadings.length
                                    ? () {
                                        setState(() {
                                          _currentDay++;
                                          _calculateProgress();
                                        });
                                      }
                                    : () {},
                                icon: Icons.arrow_forward,
                                isPrimary: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Tab Bar
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: _isNightMode ? const Color(0xFF2a2a2a) : Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      indicator: BoxDecoration(
                        color: _getPlanColor(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: _isNightMode ? Colors.white70 : Colors.grey[700],
                      tabs: const [
                        Tab(text: 'Reading'),
                        Tab(text: 'Reflection'),
                        Tab(text: 'Prayer'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tab Content
                  SizedBox(
                    height: 600,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildReadingTab(currentReading),
                        _buildReflectionTab(currentReading),
                        _buildPrayerTab(currentReading),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        AppButton(
                          text: 'Mark Day Complete',
                          onPressed: () => _showCompletionDialog(),
                          icon: Icons.check_circle,
                          isPrimary: true,
                        ),
                        const SizedBox(height: 12),
                        AppButton(
                          text: 'View All Readings',
                          onPressed: () => _showAllReadingsDialog(),
                          icon: Icons.list,
                          isPrimary: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadingTab(Map<String, dynamic> reading) {
    double fontSize = _selectedFontSize == 'Small'
        ? 14
        : _selectedFontSize == 'Medium'
            ? 16
            : 18;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isNightMode ? const Color(0xFF2a2a2a) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reading["title"],
              style: AppTextStyles.h4.copyWith(
                color: _isNightMode ? Colors.white : _getPlanColor(),
                fontSize: fontSize + 4,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: (reading["passages"] as List<String>)
                  .map((passage) => Chip(
                        label: Text(
                          passage,
                          style: const TextStyle(fontSize: 12),
                        ),
                        backgroundColor: _getPlanColor().withOpacity(0.1),
                        side: BorderSide(color: _getPlanColor().withOpacity(0.3)),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Text(
              reading["content"],
              style: TextStyle(
                fontSize: fontSize,
                height: 1.8,
                color: _isNightMode ? Colors.white70 : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  Icons.highlight,
                  'Highlight',
                  () => _showHighlightOptions(),
                ),
                _buildActionButton(
                  Icons.content_copy,
                  'Copy',
                  () => _copyToClipboard(reading["content"]),
                ),
                _buildActionButton(
                  Icons.volume_up,
                  'Listen',
                  () => _showAudioPlayer(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReflectionTab(Map<String, dynamic> reading) {
    double fontSize = _selectedFontSize == 'Small'
        ? 14
        : _selectedFontSize == 'Medium'
            ? 16
            : 18;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isNightMode ? const Color(0xFF2a2a2a) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.wb_sunny, color: _getPlanColor(), size: 28),
                const SizedBox(width: 12),
                Text(
                  'Today\'s Reflection',
                  style: AppTextStyles.h5.copyWith(
                    color: _isNightMode ? Colors.white : _getPlanColor(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getPlanColor().withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _getPlanColor().withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Text(
                reading["reflection"],
                style: AppTextStyles.quote.copyWith(
                  fontSize: fontSize,
                  color: _isNightMode ? Colors.white70 : AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Personal Notes',
              style: AppTextStyles.h5.copyWith(
                color: _isNightMode ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 5,
              style: TextStyle(
                color: _isNightMode ? Colors.white : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Write your thoughts and reflections here...',
                hintStyle: TextStyle(
                  color: _isNightMode ? Colors.white38 : Colors.grey,
                ),
                filled: true,
                fillColor: _isNightMode
                    ? const Color(0xFF1a1a1a)
                    : Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor().withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor().withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor(), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Save Notes',
              onPressed: () => _saveNotes(),
              icon: Icons.save,
              isPrimary: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrayerTab(Map<String, dynamic> reading) {
    double fontSize = _selectedFontSize == 'Small'
        ? 14
        : _selectedFontSize == 'Medium'
            ? 16
            : 18;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _isNightMode ? const Color(0xFF2a2a2a) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.favorite, color: _getPlanColor(), size: 28),
                const SizedBox(width: 12),
                Text(
                  'Prayer for Today',
                  style: AppTextStyles.h5.copyWith(
                    color: _isNightMode ? Colors.white : _getPlanColor(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getPlanColor().withOpacity(0.1),
                    _getPlanColor().withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                reading["prayer"],
                style: TextStyle(
                  fontSize: fontSize,
                  height: 1.8,
                  fontStyle: FontStyle.italic,
                  color: _isNightMode ? Colors.white70 : AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'My Prayer Requests',
              style: AppTextStyles.h5.copyWith(
                color: _isNightMode ? Colors.white : AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              maxLines: 5,
              style: TextStyle(
                color: _isNightMode ? Colors.white : AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: 'Write your prayer requests here...',
                hintStyle: TextStyle(
                  color: _isNightMode ? Colors.white38 : Colors.grey,
                ),
                filled: true,
                fillColor: _isNightMode
                    ? const Color(0xFF1a1a1a)
                    : Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor().withOpacity(0.3)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor().withOpacity(0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _getPlanColor(), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Save Prayer',
                    onPressed: () => _savePrayer(),
                    icon: Icons.save,
                    isPrimary: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: 'Share Prayer',
                    onPressed: () => _sharePrayer(),
                    icon: Icons.share,
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _getPlanColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _getPlanColor().withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: _getPlanColor(), size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getPlanColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showShareDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.share, color: _getPlanColor()),
            const SizedBox(width: 12),
            const Text('Share Reading Plan'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildShareOption(Icons.message, 'Message', () {
              Navigator.pop(context);
              _shareViaMessage();
            }),
            _buildShareOption(Icons.email, 'Email', () {
              Navigator.pop(context);
              _shareViaEmail();
            }),
            _buildShareOption(Icons.link, 'Copy Link', () {
              Navigator.pop(context);
              _copyShareLink();
            }),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: _getPlanColor()),
      title: Text(label),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  void _shareViaMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${widget.title} via Message...'),
        backgroundColor: _getPlanColor(),
      ),
    );
  }

  void _shareViaEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${widget.title} via Email...'),
        backgroundColor: _getPlanColor(),
      ),
    );
  }

  void _copyShareLink() {
    Clipboard.setData(ClipboardData(
      text: 'Check out this reading plan: ${widget.title}',
    ));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showFontSizeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Text Size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['Small', 'Medium', 'Large'].map((size) {
            return RadioListTile<String>(
              title: Text(size),
              value: size,
              groupValue: _selectedFontSize,
              activeColor: _getPlanColor(),
              onChanged: (value) {
                setState(() {
                  _selectedFontSize = value!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showNotesDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.note_add, color: _getPlanColor()),
            const SizedBox(width: 12),
            const Text('Add Note'),
          ],
        ),
        content: TextField(
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Write your note here...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Note saved successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: _getPlanColor()),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showHighlightOptions() {
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
            const Text(
              'Highlight Color',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorOption(Colors.yellow),
                _buildColorOption(Colors.green),
                _buildColorOption(Colors.blue),
                _buildColorOption(Colors.pink),
                _buildColorOption(Colors.orange),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(Color color) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Text highlighted!')),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 2),
        ),
      ),
    );
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Text copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showAudioPlayer() {
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
            Icon(Icons.headphones, size: 48, color: _getPlanColor()),
            const SizedBox(height: 16),
            const Text(
              'Audio Player',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  iconSize: 32,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.play_circle_filled, color: _getPlanColor()),
                  iconSize: 64,
                  onPressed: () {},
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  iconSize: 32,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _saveNotes() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Notes saved successfully!'),
        backgroundColor: _getPlanColor(),
        action: SnackBarAction(
          label: 'VIEW',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }

  void _savePrayer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Prayer saved successfully!'),
        backgroundColor: _getPlanColor(),
      ),
    );
  }

  void _sharePrayer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sharing prayer...'),
        backgroundColor: _getPlanColor(),
      ),
    );
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.celebration, color: _getPlanColor()),
            const SizedBox(width: 12),
            const Text('Great Job!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You\'ve completed Day $_currentDay!',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: _progress,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(_getPlanColor()),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              if (_currentDay < _planContent[widget.title]!["totalReadings"]) {
                setState(() {
                  _currentDay++;
                  _calculateProgress();
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: _getPlanColor()),
            child: const Text('Next Day'),
          ),
        ],
      ),
    );
  }

  void _showAllReadingsDialog() {
    final plan = _planContent[widget.title];
    final dailyReadings = plan!["dailyReadings"] as List<Map<String, dynamic>>;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.list, color: _getPlanColor()),
                  const SizedBox(width: 12),
                  const Text(
                    'All Readings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: dailyReadings.length,
                  itemBuilder: (context, index) {
                    final reading = dailyReadings[index];
                    final isCompleted = reading["day"] < _currentDay;
                    final isCurrent = reading["day"] == _currentDay;

                    return Card(
                      color: isCurrent ? _getPlanColor().withOpacity(0.1) : null,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isCompleted
                              ? Colors.green
                              : isCurrent
                                  ? _getPlanColor()
                                  : Colors.grey[300],
                          child: Icon(
                            isCompleted ? Icons.check : Icons.book,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          'Day ${reading["day"]}: ${reading["title"]}',
                          style: TextStyle(
                            fontWeight:
                                isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          (reading["passages"] as List<String>).join(', '),
                          style: const TextStyle(fontSize: 12),
                        ),
                        trailing: isCurrent
                            ? Chip(
                                label: const Text('Current'),
                                backgroundColor: _getPlanColor(),
                                labelStyle: const TextStyle(color: Colors.white),
                              )
                            : null,
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _currentDay = reading["day"];
                            _calculateProgress();
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../../../../core/constants/app_colors.dart';

// class ScriptureReadingScreen extends StatefulWidget {
//   final String title;
//   final String content;
//   final String? reference;

//   const ScriptureReadingScreen({
//     super.key,
//     required this.title,
//     required this.content,
//     this.reference,
//   });

//   @override
//   State<ScriptureReadingScreen> createState() => _ScriptureReadingScreenState();
// }

// class _ScriptureReadingScreenState extends State<ScriptureReadingScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<Offset> _slideAnimation;
  
//   double _fontSize = 18.0;
//   bool _isBookmarked = false;
//   bool _isDarkMode = false;




// final Map<String, Map<String, dynamic>> _scriptureContent = {
//   "Chronological Plan": {
//     "chapter": "Reading Plan",
//     "title": "Chronological Bible Reading Plan",
//     "verses": [
//       {
//         "verse": "Overview",
//         "text": "Read the Bible in the order events occurred historically. This plan helps you understand the timeline of biblical history from Creation to the early Church."
//       },
//       {
//         "verse": "Week 1",
//         "text": "Genesis 1-11: Creation, Fall, and the Flood. Experience the beginning of human history and God's covenant with Noah."
//       },
//       {
//         "verse": "Week 2",
//         "text": "Genesis 12-50: The Patriarchs. Follow Abraham, Isaac, Jacob, and Joseph as God establishes His chosen people."
//       },
//       {
//         "verse": "Benefits",
//         "text": "Understanding Scripture in historical context provides clarity on how God's plan unfolded through time, revealing the continuity of His saving work."
//       },
//     ],
//     "reflection": "Reading chronologically helps us see God's patient love working through history, preparing humanity for the coming of Christ.",
//   },
//   "Canonical Plan": {
//     "chapter": "Reading Plan",
//     "title": "Canonical Bible Reading Plan",
//     "verses": [
//       {
//         "verse": "Overview",
//         "text": "Follow the traditional order of biblical books as arranged in the Catholic Bible, from Genesis to Revelation."
//       },
//       {
//         "verse": "Old Testament",
//         "text": "Begin with the Pentateuch (Genesis-Deuteronomy), then Historical Books, Wisdom Literature, and Prophets. This order shows the development of God's revelation."
//       },
//       {
//         "verse": "New Testament",
//         "text": "Read the Gospels, Acts, Epistles, and Revelation. See how Christ fulfills the Old Testament and establishes the Church."
//       },
//     ],
//     "reflection": "The canonical order reflects how the Church has traditionally received and organized Scripture, honoring centuries of faithful transmission.",
//   },
//   "Thematic Plan": {
//     "chapter": "Reading Plan",
//     "title": "Thematic Bible Reading Plan",
//     "verses": [
//       {
//         "verse": "Overview",
//         "text": "Explore Scripture through key spiritual themes such as love, faith, hope, salvation, prayer, and discipleship."
//       },
//       {
//         "verse": "Theme: God's Love",
//         "text": "Journey through passages revealing God's merciful love: John 3:16, Romans 8:38-39, 1 John 4:7-21, and the parables of mercy in Luke 15."
//       },
//       {
//         "verse": "Theme: Prayer",
//         "text": "Learn from Jesus and the saints about prayer: The Lord's Prayer (Matthew 6:9-13), Jesus in Gethsemane (Luke 22:39-46), and Paul's prayers in Ephesians."
//       },
//     ],
//     "reflection": "Thematic reading helps us deeply understand specific aspects of our faith and apply them to our daily spiritual lives.",
//   },
//   "One-Year Bible": {
//     "chapter": "Reading Plan",
//     "title": "One-Year Bible Reading Plan",
//     "verses": [
//       {
//         "verse": "Overview",
//         "text": "Complete the entire Catholic Bible in 365 days with daily readings from both Old and New Testaments."
//       },
//       {
//         "verse": "Daily Structure",
//         "text": "Each day includes: 3 chapters from the Old Testament, 1 Psalm, 1 chapter from Wisdom Literature, and 1-2 chapters from the New Testament."
//       },
//       {
//         "verse": "Commitment",
//         "text": "This plan requires dedication but rewards you with comprehensive biblical knowledge and spiritual growth throughout the year."
//       },
//     ],
//     "reflection": "Immersing yourself in Scripture daily transforms your mind and heart, allowing God's Word to shape every aspect of your life.",
//   },
//   "Custom Plan": {
//     "chapter": "Reading Plan",
//     "title": "Create Your Custom Reading Plan",
//     "verses": [
//       {
//         "verse": "Personalize",
//         "text": "Design a reading plan that fits your spiritual needs, schedule, and goals. Choose specific books, themes, or time frames."
//       },
//       {
//         "verse": "Flexibility",
//         "text": "Adjust your pace, focus on challenging books, revisit favorites, or create a plan around liturgical seasons like Advent or Lent."
//       },
//       {
//         "verse": "Guidance",
//         "text": "Consider consulting with a spiritual director or priest to create a plan that supports your current spiritual journey."
//       },
//     ],
//     "reflection": "A personalized approach to Scripture allows the Holy Spirit to guide you uniquely, meeting you exactly where you are in your faith journey.",
//   },
  
//   // Keep the original scripture readings as well
//   "Matthew 13:1-23 - The Parable of the Sower": {
//     "chapter": "Matthew 13:1-23",
//     "title": "The Parable of the Sower",
//     "verses": [
//       {"verse": "1", "text": "That same day Jesus went out of the house and sat by the lake."},
//       {"verse": "2", "text": "Such large crowds gathered around him that he got into a boat and sat in it, while all the people stood on the shore."},
//       {"verse": "3", "text": "Then he told them many things in parables, saying: \"A farmer went out to sow his seed."},
//       {"verse": "4", "text": "As he was scattering the seed, some fell along the path, and the birds came and ate it up."},
//       {"verse": "5", "text": "Some fell on rocky places, where it did not have much soil. It sprang up quickly, because the soil was shallow."},
//       {"verse": "6", "text": "But when the sun came up, the plants were scorched, and they withered because they had no root."},
//       {"verse": "7", "text": "Other seed fell among thorns, which grew up and choked the plants."},
//       {"verse": "8", "text": "Still other seed fell on good soil, where it produced a crop—a hundred, sixty or thirty times what was sown."},
//       {"verse": "9", "text": "Whoever has ears, let them hear.\""},
//     ],
//     "reflection": "This parable teaches us about the different ways people receive God's word. The seed represents the message of the kingdom, and the different soils represent the condition of our hearts when we hear it.",
//   },
// };  

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );
    
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
    
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(0, 0.3),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    
//     _animationController.forward();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _shareScripture() {
//     final content = _scriptureContent[widget.content];
//     if (content != null) {
//       String shareText = "${content['title']}\n\n";
//       for (var verse in content['verses']) {
//         shareText += "${content['chapter'].split(' ')[0]} ${content['chapter'].split(' ')[1].split(':')[0]}:${verse['verse']} ${verse['text']}\n\n";
//       }
      
//       // In a real app, you would use share_plus package
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Scripture copied to share')),
//       );
//     }
//   }

//   void _copyToClipboard() {
//     final content = _scriptureContent[widget.content];
//     if (content != null) {
//       String copyText = "${content['title']}\n\n";
//       for (var verse in content['verses']) {
//         copyText += "${content['chapter'].split(' ')[0]} ${content['chapter'].split(' ')[1].split(':')[0]}:${verse['verse']} ${verse['text']}\n\n";
//       }
      
//       Clipboard.setData(ClipboardData(text: copyText));
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Scripture copied to clipboard'),
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final content = _scriptureContent[widget.content];
    
//     return Scaffold(
//       backgroundColor: _isDarkMode ? Colors.grey[900] : AppColors.backgroundLight,
//       appBar: AppBar(
//         backgroundColor: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Scripture Reading',
//           style: TextStyle(
//             color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
//               color: _isBookmarked ? AppColors.primaryPurple : (_isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary),
//             ),
//             onPressed: () {
//               setState(() {
//                 _isBookmarked = !_isBookmarked;
//               });
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(_isBookmarked ? 'Scripture bookmarked' : 'Bookmark removed'),
//                   duration: const Duration(seconds: 2),
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               _isDarkMode ? Icons.light_mode : Icons.dark_mode,
//               color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//             ),
//             onPressed: () {
//               setState(() {
//                 _isDarkMode = !_isDarkMode;
//               });
//             },
//           ),
//           PopupMenuButton<String>(
//             icon: Icon(
//               Icons.more_vert,
//               color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//             ),
//             onSelected: (value) {
//               switch (value) {
//                 case 'share':
//                   _shareScripture();
//                   break;
//                 case 'copy':
//                   _copyToClipboard();
//                   break;
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'share',
//                 child: Row(
//                   children: [
//                     Icon(Icons.share, size: 20),
//                     SizedBox(width: 12),
//                     Text('Share'),
//                   ],
//                 ),
//               ),
//               const PopupMenuItem(
//                 value: 'copy',
//                 child: Row(
//                   children: [
//                     Icon(Icons.copy, size: 20),
//                     SizedBox(width: 12),
//                     Text('Copy'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: content == null
//           ? const Center(child: Text('Scripture not found'))
//           : Column(
//               children: [
//                 // Font Size Controls
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
//                     boxShadow: [
//                       BoxShadow(
//                         color: AppColors.textPrimary.withOpacity(0.1),
//                         blurRadius: 4,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.text_decrease),
//                         onPressed: _fontSize > 12
//                             ? () => setState(() => _fontSize -= 2)
//                             : null,
//                       ),
//                       Text(
//                         'Font Size',
//                         style: TextStyle(
//                           color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(Icons.text_increase),
//                         onPressed: _fontSize < 28
//                             ? () => setState(() => _fontSize += 2)
//                             : null,
//                       ),
//                     ],
//                   ),
//                 ),
                
//                 // Scripture Content
//                 Expanded(
//                   child: AnimatedBuilder(
//                     animation: _fadeAnimation,
//                     builder: (context, child) {
//                       return FadeTransition(
//                         opacity: _fadeAnimation,
//                         child: SlideTransition(
//                           position: _slideAnimation,
//                           child: SingleChildScrollView(
//                             padding: const EdgeInsets.all(20),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 // Header
//                                 Container(
//                                   padding: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     gradient: LinearGradient(
//                                       colors: [
//                                         Colors.blue.shade600,
//                                         Colors.blue.shade400,
//                                       ],
//                                       begin: Alignment.topLeft,
//                                       end: Alignment.bottomRight,
//                                     ),
//                                     borderRadius: BorderRadius.circular(16),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         content['chapter'],
//                                         style: const TextStyle(
//                                           color: AppColors.backgroundWhite,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 8),
//                                       Text(
//                                         content['title'],
//                                         style: const TextStyle(
//                                           color: AppColors.backgroundWhite,
//                                           fontSize: 24,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
                                
//                                 const SizedBox(height: 24),
                                
//                                 // Scripture Verses
//                                 ...content['verses'].map<Widget>((verse) {
//                                   return Container(
//                                     margin: const EdgeInsets.only(bottom: 16),
//                                     padding: const EdgeInsets.all(16),
//                                     decoration: BoxDecoration(
//                                       color: _isDarkMode ? Colors.grey[800] : AppColors.backgroundWhite,
//                                       borderRadius: BorderRadius.circular(12),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: AppColors.textPrimary.withOpacity(0.08),
//                                           blurRadius: 8,
//                                           offset: const Offset(0, 2),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           width: 32,
//                                           height: 32,
//                                           decoration: BoxDecoration(
//                                             color: Colors.blue.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(16),
//                                           ),
//                                           child: Center(
//                                             child: Text(
//                                               verse['verse'],
//                                               style: const TextStyle(
//                                                 color: Colors.blue,
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 16),
//                                         Expanded(
//                                           child: Text(
//                                             verse['text'],
//                                             style: TextStyle(
//                                               fontSize: _fontSize,
//                                               height: 1.6,
//                                               color: _isDarkMode ? AppColors.backgroundWhite : AppColors.textPrimary,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }).toList(),
                                
//                                 const SizedBox(height: 24),
                                
//                                 // Reflection Section
//                                 Container(
//                                   padding: const EdgeInsets.all(20),
//                                   decoration: BoxDecoration(
//                                     color: _isDarkMode ? Colors.amber[700] : Colors.amber[50],
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(
//                                       color: _isDarkMode ? Colors.amber[600]! : Colors.amber[200]!,
//                                       width: 1,
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.lightbulb,
//                                             color: _isDarkMode ? Colors.amber[200] : Colors.amber[700],
//                                             size: 24,
//                                           ),
//                                           const SizedBox(width: 8),
//                                           Text(
//                                             'Reflection',
//                                             style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.bold,
//                                               color: _isDarkMode ? Colors.amber[200] : Colors.amber[700],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 12),
//                                       Text(
//                                         content['reflection'],
//                                         style: TextStyle(
//                                           fontSize: 16,
//                                           height: 1.5,
//                                           color: _isDarkMode ? Colors.amber[100] : Colors.amber[800],
//                                           fontStyle: FontStyle.italic,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
                                
//                                 const SizedBox(height: 40),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }