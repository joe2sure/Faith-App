import 'package:flutter/material.dart';
import 'package:church_app/common/constants.dart';

class SpiritualResourceDetailScreen extends StatefulWidget {
  final String resourceTitle;
  final String resourceSubtitle;

  const SpiritualResourceDetailScreen({
    super.key,
    required this.resourceTitle,
    required this.resourceSubtitle,
  });

  @override
  State<SpiritualResourceDetailScreen> createState() => _SpiritualResourceDetailScreenState();
}

class _SpiritualResourceDetailScreenState extends State<SpiritualResourceDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _slideAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isBookmarked = false;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideAnimationController, curve: Curves.easeOutCubic),
    );
    
    _fadeAnimationController.forward();
    _slideAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _slideAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeaderSection(),
                        _buildTabSection(),
                        _buildContentSection(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: Colors.blue.shade600,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isBookmarked = !_isBookmarked;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_isBookmarked ? 'Added to bookmarks' : 'Removed from bookmarks'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sharing feature coming soon!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade600,
                Colors.blue.shade400,
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 20,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.resourceTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(blurRadius: 3, color: Colors.black26),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.resourceSubtitle,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        shadows: [
                          Shadow(blurRadius: 2, color: Colors.black26),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 80,
                right: -20,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    _getResourceIcon(),
                    size: 120,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
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
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getResourceIcon(),
                  color: Colors.blue.shade600,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getResourceDescription(),
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatItem(Icons.visibility, '2.5k', 'Views'),
        _buildStatItem(Icons.favorite, '180', 'Likes'),
        _buildStatItem(Icons.download, '45', 'Downloads'),
        _buildStatItem(Icons.star, '4.8', 'Rating'),
      ],
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.shade600, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildTab('Content', 0),
          _buildTab('About', 1),
          _buildTab('Related', 2),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    final isSelected = _selectedTabIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTabIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? Colors.blue.shade600 : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.blue.shade600 : Colors.grey.shade600,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: _getTabContent(),
    );
  }

  Widget _getTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildContentTab();
      case 1:
        return _buildAboutTab();
      case 2:
        return _buildRelatedTab();
      default:
        return _buildContentTab();
    }
  }

  Widget _buildContentTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Content',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ..._getResourceContent().map((item) => _buildContentItem(item)),
      ],
    );
  }

  Widget _buildContentItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  _getContentIcon(item['type']!),
                  color: Colors.blue.shade600,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      item['duration']!,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow, color: Colors.blue),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening ${item['title']}...'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item['description']!,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'About This Resource',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _getDetailedDescription(),
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _getResourceTags().map((tag) => Chip(
            label: Text(tag),
            backgroundColor: Colors.blue.shade50,
            labelStyle: TextStyle(color: Colors.blue.shade700),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildRelatedTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Resources',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        ..._getRelatedResources().map((resource) => _buildRelatedItem(resource)),
      ],
    );
  }

  Widget _buildRelatedItem(Map<String, String> resource) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: 60,
              height: 60,
              color: Colors.blue.shade100,
              child: Icon(
                _getResourceIcon(),
                color: Colors.blue.shade600,
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource['title']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  resource['subtitle']!,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 16),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening ${resource['title']}...'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Starting guided experience...'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      backgroundColor: Colors.blue.shade600,
      icon: const Icon(Icons.play_arrow, color: Colors.white),
      label: const Text(
        'Start',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper methods to get resource-specific data
  IconData _getResourceIcon() {
    switch (widget.resourceTitle) {
      case 'Prayer Collection':
        return Icons.favorite;
      case 'Meditation Guides':
        return Icons.self_improvement;
      case 'Spiritual Articles':
        return Icons.article;
      case 'Study Materials':
        return Icons.menu_book;
      case 'Daily Devotions':
        return Icons.wb_sunny;
      case 'Liturgical Texts':
        return Icons.auto_stories;
      default:
        return Icons.book;
    }
  }

  IconData _getContentIcon(String type) {
    switch (type) {
      case 'prayer':
        return Icons.favorite;
      case 'meditation':
        return Icons.self_improvement;
      case 'reading':
        return Icons.menu_book;
      case 'audio':
        return Icons.headphones;
      default:
        return Icons.article;
    }
  }

  String _getResourceDescription() {
    switch (widget.resourceTitle) {
      case 'Prayer Collection':
        return 'A comprehensive collection of traditional Catholic prayers, novenas, and devotions to enrich your spiritual life.';
      case 'Meditation Guides':
        return 'Guided meditations and contemplative practices to deepen your relationship with God and find inner peace.';
      case 'Spiritual Articles':
        return 'Inspiring articles and reflections on faith, spirituality, and living a Christ-centered life.';
      case 'Study Materials':
        return 'Educational resources and study guides to help you grow in understanding of Catholic teachings and scripture.';
      case 'Daily Devotions':
        return 'Daily spiritual practices and devotions to help you maintain a consistent prayer life and spiritual growth.';
      case 'Liturgical Texts':
        return 'Official liturgical texts, mass readings, and prayers used in Catholic worship and celebration.';
      default:
        return 'Spiritual resources to support your faith journey and deepen your relationship with God.';
    }
  }

  String _getDetailedDescription() {
    switch (widget.resourceTitle) {
      case 'Prayer Collection':
        return 'This extensive prayer collection includes traditional Catholic prayers passed down through generations, contemporary prayers for modern situations, novenas for special intentions, and seasonal prayers for different liturgical periods. Each prayer is presented with its historical context and spiritual significance, helping you connect more deeply with centuries of Catholic tradition.';
      case 'Meditation Guides':
        return 'Our meditation guides offer structured approaches to contemplative prayer, including Lectio Divina, Ignatian meditation, and centering prayer techniques. These resources are designed for both beginners and experienced practitioners, providing step-by-step instructions, scriptural foundations, and practical tips for developing a deeper prayer life.';
      case 'Spiritual Articles':
        return 'These carefully curated articles explore various aspects of Catholic spirituality, featuring insights from saints, theologians, and contemporary spiritual writers. Topics include living the virtues, understanding suffering, finding God in daily life, and navigating modern challenges with faith.';
      case 'Study Materials':
        return 'Comprehensive study resources including scripture commentaries, doctrinal explanations, catechetical materials, and theological insights. These materials are designed to help Catholics at all levels deepen their understanding of the faith through systematic study and reflection.';
      case 'Daily Devotions':
        return 'A collection of daily spiritual practices including morning prayers, evening prayers, examination of conscience, and seasonal devotions. These resources help establish and maintain consistent spiritual routines that nurture ongoing conversion and growth in holiness.';
      case 'Liturgical Texts':
        return 'Official texts from the Roman Missal, Liturgy of the Hours, and other liturgical books. These resources help you participate more fully in the Church\'s public prayer and understand the rich symbolism and meaning of Catholic worship.';
      default:
        return 'This spiritual resource provides valuable content to support your Catholic faith journey and help you grow closer to God through prayer, study, and reflection.';
    }
  }

  List<String> _getResourceTags() {
    switch (widget.resourceTitle) {
      case 'Prayer Collection':
        return ['Traditional Prayers', 'Novenas', 'Devotions', 'Saints', 'Mary'];
      case 'Meditation Guides':
        return ['Contemplation', 'Lectio Divina', 'Ignatian', 'Centering Prayer', 'Silence'];
      case 'Spiritual Articles':
        return ['Spirituality', 'Saints', 'Virtue', 'Modern Life', 'Inspiration'];
      case 'Study Materials':
        return ['Scripture', 'Doctrine', 'Catechism', 'Theology', 'Education'];
      case 'Daily Devotions':
        return ['Daily Prayer', 'Morning', 'Evening', 'Examination', 'Routine'];
      case 'Liturgical Texts':
        return ['Mass', 'Liturgy', 'Worship', 'Sacraments', 'Official'];
      default:
        return ['Faith', 'Catholic', 'Spiritual', 'Growth', 'Prayer'];
    }
  }

  List<Map<String, String>> _getResourceContent() {
    switch (widget.resourceTitle) {
      case 'Prayer Collection':
        return [
          {
            'title': 'The Rosary',
            'type': 'prayer',
            'duration': '20 min',
            'description': 'Complete guide to praying the Holy Rosary with meditations on the mysteries.',
          },
          {
            'title': 'Divine Mercy Chaplet',
            'type': 'prayer',
            'duration': '10 min',
            'description': 'The powerful prayer given to St. Faustina for God\'s mercy.',
          },
          {
            'title': 'Stations of the Cross',
            'type': 'prayer',
            'duration': '30 min',
            'description': 'Traditional devotion following Jesus\' path to Calvary.',
          },
        ];
      case 'Meditation Guides':
        return [
          {
            'title': 'Introduction to Lectio Divina',
            'type': 'meditation',
            'duration': '15 min',
            'description': 'Learn the ancient practice of sacred reading and meditation.',
          },
          {
            'title': 'Ignatian Contemplation',
            'type': 'meditation',
            'duration': '25 min',
            'description': 'Experience Gospel scenes through imaginative prayer.',
          },
          {
            'title': 'Centering Prayer Practice',
            'type': 'meditation',
            'duration': '20 min',
            'description': 'Silent prayer of resting in God\'s presence.',
          },
        ];
      default:
        return [
          {
            'title': 'Getting Started',
            'type': 'reading',
            'duration': '5 min',
            'description': 'An introduction to this spiritual resource.',
          },
          {
            'title': 'Featured Content',
            'type': 'audio',
            'duration': '15 min',
            'description': 'Selected highlights from this collection.',
          },
          {
            'title': 'Daily Practice',
            'type': 'reading',
            'duration': '10 min',
            'description': 'How to incorporate this into your daily routine.',
          },
        ];
    }
  }

  List<Map<String, String>> _getRelatedResources() {
    // Get all spiritual resources except the current one
    final allResources = [
      {"title": "Prayer Collection", "subtitle": "Traditional Prayers"},
      {"title": "Meditation Guides", "subtitle": "Spiritual Practice"},
      {"title": "Spiritual Articles", "subtitle": "Faith Insights"},
      {"title": "Study Materials", "subtitle": "Learning Resources"},
      {"title": "Daily Devotions", "subtitle": "Spiritual Growth"},
      {"title": "Liturgical Texts", "subtitle": "Mass Readings"},
    ];
    
    return allResources
        .where((resource) => resource["title"] != widget.resourceTitle)
        .take(3)
        .toList();
  }
}