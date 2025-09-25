import 'package:flutter/material.dart';

class SpiritualResourcesScreen extends StatefulWidget {
  const SpiritualResourcesScreen({super.key});

  @override
  State<SpiritualResourcesScreen> createState() => _SpiritualResourcesScreenState();
}

class _SpiritualResourcesScreenState extends State<SpiritualResourcesScreen>
    with TickerProviderStateMixin {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isGridView = true;
  late TabController _tabController;
  
  final List<String> _categories = [
    'All',
    'Prayers',
    'Meditation',
    'Articles',
    'Study Materials',
    'Devotions',
    'Liturgy',
    'Scripture',
    'Saints'
  ];

  final List<String> _tabs = ['Resources', 'Favorites', 'Recent'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spiritual Resources'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showOptionsMenu(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.green,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search spiritual resources...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      child: const Icon(Icons.clear, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _categories[index] == _selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = _categories[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.green : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildResourcesView(),
                _buildFavoritesView(),
                _buildRecentView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddResourceDialog(context),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildResourcesView() {
    final filteredResources = _getFilteredResources();
    
    if (filteredResources.isEmpty) {
      return _buildEmptyState();
    }

    return _isGridView
        ? GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: filteredResources.length,
            itemBuilder: (context, index) {
              final resource = filteredResources[index];
              return _buildResourceCard(resource);
            },
          )
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filteredResources.length,
            itemBuilder: (context, index) {
              final resource = filteredResources[index];
              return _buildResourceListTile(resource);
            },
          );
  }

  Widget _buildFavoritesView() {
    final favorites = _getAllResources().where((r) => r['isBookmarked'] == true).toList();
    
    if (favorites.isEmpty) {
      return _buildEmptyFavoritesState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favorites.length,
      itemBuilder: (context, index) => _buildResourceListTile(favorites[index]),
    );
  }

  Widget _buildRecentView() {
    final recent = _getAllResources().take(5).toList();
    
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: recent.length,
      itemBuilder: (context, index) => _buildResourceListTile(recent[index]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No resources found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyFavoritesState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.bookmark_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Bookmark resources to find them here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAllResources() {
    return [
      {
        "title": "Morning Prayers",
        "subtitle": "Start Your Day Right",
        "category": "Prayers",
        "description": "Collection of traditional morning prayers including the Our Father, Hail Mary, and Glory Be.",
        "duration": "10 min",
        "difficulty": "Beginner",
        "icon": Icons.wb_sunny,
        "color": Colors.orange,
        "isBookmarked": true,
        "rating": 4.8,
        "downloads": 1250,
      },
      {
        "title": "Evening Prayer",
        "subtitle": "End in Peace",
        "category": "Prayers",
        "description": "Peaceful evening prayers for reflection and gratitude.",
        "duration": "15 min",
        "difficulty": "Beginner",
        "icon": Icons.bedtime,
        "color": Colors.indigo,
        "isBookmarked": false,
        "rating": 4.7,
        "downloads": 980,
      },
      {
        "title": "Lectio Divina Guide",
        "subtitle": "Divine Reading",
        "category": "Meditation",
        "description": "Step-by-step guide to the ancient practice of meditative scripture reading.",
        "duration": "30 min",
        "difficulty": "Intermediate",
        "icon": Icons.menu_book,
        "color": Colors.blue,
        "isBookmarked": true,
        "rating": 4.9,
        "downloads": 2100,
      },
      {
        "title": "Rosary Meditation",
        "subtitle": "Mysteries of Faith",
        "category": "Meditation",
        "description": "Guided meditations on the Joyful, Sorrowful, Glorious, and Luminous Mysteries.",
        "duration": "20 min",
        "difficulty": "Beginner",
        "icon": Icons.circle_outlined,
        "color": Colors.purple,
        "isBookmarked": false,
        "rating": 4.6,
        "downloads": 1800,
      },
      {
        "title": "Understanding Saints",
        "subtitle": "Lives of Holiness",
        "category": "Saints",
        "description": "In-depth articles about the lives and teachings of Catholic saints.",
        "duration": "5-10 min",
        "difficulty": "Beginner",
        "icon": Icons.person,
        "color": Colors.green,
        "isBookmarked": true,
        "rating": 4.5,
        "downloads": 1450,
      },
      {
        "title": "Catholic Theology",
        "subtitle": "Deep Dive",
        "category": "Articles",
        "description": "Advanced theological concepts explained in accessible language.",
        "duration": "15-20 min",
        "difficulty": "Advanced",
        "icon": Icons.school,
        "color": Colors.red,
        "isBookmarked": false,
        "rating": 4.7,
        "downloads": 950,
      },
      {
        "title": "Bible Study Guides",
        "subtitle": "Scripture Deep Dive",
        "category": "Study Materials",
        "description": "Comprehensive guides for studying books of the Bible.",
        "duration": "45 min",
        "difficulty": "Intermediate",
        "icon": Icons.library_books,
        "color": Colors.brown,
        "isBookmarked": true,
        "rating": 4.8,
        "downloads": 2300,
      },
      {
        "title": "Catechism Study",
        "subtitle": "Learn Your Faith",
        "category": "Study Materials",
        "description": "Interactive study materials based on the Catechism of the Catholic Church.",
        "duration": "60 min",
        "difficulty": "Intermediate",
        "icon": Icons.quiz,
        "color": Colors.teal,
        "isBookmarked": false,
        "rating": 4.6,
        "downloads": 1650,
      },
      {
        "title": "Daily Devotions",
        "subtitle": "Spiritual Growth",
        "category": "Devotions",
        "description": "Daily reflections and prayers for spiritual development.",
        "duration": "10 min",
        "difficulty": "Beginner",
        "icon": Icons.favorite,
        "color": Colors.pink,
        "isBookmarked": true,
        "rating": 4.9,
        "downloads": 3200,
      },
      {
        "title": "Novenas",
        "subtitle": "Nine Days of Prayer",
        "category": "Devotions",
        "description": "Traditional nine-day prayer devotions to various saints and Mary.",
        "duration": "15 min",
        "difficulty": "Beginner",
        "icon": Icons.calendar_view_week,
        "color": Colors.cyan,
        "isBookmarked": false,
        "rating": 4.4,
        "downloads": 1100,
      },
      {
        "title": "Mass Readings",
        "subtitle": "Daily Liturgy",
        "category": "Liturgy",
        "description": "Today's Mass readings with reflections and commentary.",
        "duration": "10 min",
        "difficulty": "Beginner",
        "icon": Icons.church,
        "color": Colors.deepOrange,
        "isBookmarked": true,
        "rating": 4.8,
        "downloads": 2800,
      },
      {
        "title": "Liturgical Calendar",
        "subtitle": "Church Year",
        "category": "Liturgy",
        "description": "Complete guide to the liturgical seasons and feast days.",
        "duration": "5 min",
        "difficulty": "Beginner",
        "icon": Icons.date_range,
        "color": Colors.amber,
        "isBookmarked": false,
        "rating": 4.5,
        "downloads": 900,
      },
      {
        "title": "Gospel Reflections",
        "subtitle": "Daily Insights",
        "category": "Scripture",
        "description": "Daily reflections on the Gospel readings with practical applications.",
        "duration": "12 min",
        "difficulty": "Beginner",
        "icon": Icons.auto_stories,
        "color": Colors.lightBlue,
        "isBookmarked": true,
        "rating": 4.7,
        "downloads": 1900,
      },
      {
        "title": "Psalms for Prayer",
        "subtitle": "Songs of the Heart",
        "category": "Scripture",
        "description": "Selected psalms with meditation guides for personal prayer.",
        "duration": "20 min",
        "difficulty": "Beginner",
        "icon": Icons.music_note,
        "color": Colors.deepPurple,
        "isBookmarked": false,
        "rating": 4.6,
        "downloads": 1350,
      },
      {
        "title": "Saint of the Day",
        "subtitle": "Daily Inspiration",
        "category": "Saints",
        "description": "Learn about a different saint each day with their story and prayers.",
        "duration": "5 min",
        "difficulty": "Beginner",
        "icon": Icons.today,
        "color": Colors.lightGreen,
        "isBookmarked": true,
        "rating": 4.8,
        "downloads": 2650,
      },
    ];
  }

  List<Map<String, dynamic>> _getFilteredResources() {
    var resources = _getAllResources();
    
    if (_selectedCategory != 'All') {
      resources = resources.where((resource) => resource['category'] == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      resources = resources.where((resource) => 
        resource['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        resource['subtitle'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        resource['description'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return resources;
  }

  Widget _buildResourceCard(Map<String, dynamic> resource) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showResourceDetails(context, resource),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and bookmark
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (resource['color'] as Color).withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: resource['color'] as Color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      resource['icon'] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resource['isBookmarked'] = !resource['isBookmarked'];
                      });
                    },
                    child: Icon(
                      resource['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
                      color: resource['isBookmarked'] ? resource['color'] as Color : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resource['title'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      resource['subtitle'],
                      style: TextStyle(
                        fontSize: 12,
                        color: resource['color'] as Color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: Text(
                        resource['description'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Metadata row
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          resource['duration'],
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(Icons.star, size: 14, color: Colors.amber),
                            const SizedBox(width: 2),
                            Text(
                              resource['rating'].toString(),
                              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Difficulty badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(resource['difficulty']).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _getDifficultyColor(resource['difficulty']),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        resource['difficulty'],
                        style: TextStyle(
                          fontSize: 10,
                          color: _getDifficultyColor(resource['difficulty']),
                          fontWeight: FontWeight.w600,
                        ),
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
  }

  Widget _buildResourceListTile(Map<String, dynamic> resource) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: () => _showResourceDetails(context, resource),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (resource['color'] as Color).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            resource['icon'] as IconData,
            color: resource['color'] as Color,
            size: 24,
          ),
        ),
        title: Text(
          resource['title'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              resource['subtitle'],
              style: TextStyle(
                color: resource['color'] as Color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(resource['description']),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  resource['duration'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  resource['rating'].toString(),
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(resource['difficulty']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: _getDifficultyColor(resource['difficulty']),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    resource['difficulty'],
                    style: TextStyle(
                      fontSize: 10,
                      color: _getDifficultyColor(resource['difficulty']),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              resource['isBookmarked'] = !resource['isBookmarked'];
            });
          },
          child: Icon(
            resource['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
            color: resource['isBookmarked'] ? resource['color'] as Color : Colors.grey,
          ),
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return Colors.green;
      case 'Intermediate':
        return Colors.orange;
      case 'Advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showResourceDetails(BuildContext context, Map<String, dynamic> resource) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: resource['color'] as Color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      resource['icon'] as IconData,
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
                          resource['title'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          resource['subtitle'],
                          style: TextStyle(
                            fontSize: 16,
                            color: resource['color'] as Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        resource['isBookmarked'] = !resource['isBookmarked'];
                      });
                    },
                    child: Icon(
                      resource['isBookmarked'] ? Icons.bookmark : Icons.bookmark_border,
                      color: resource['isBookmarked'] ? resource['color'] as Color : Colors.grey,
                      size: 28,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Metadata
              Row(
                children: [
                  _buildMetadataChip(Icons.access_time, resource['duration']),
                  const SizedBox(width: 12),
                  _buildMetadataChip(Icons.star, resource['rating'].toString()),
                  const SizedBox(width: 12),
                  _buildMetadataChip(Icons.download, '${resource['downloads']}'),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Description
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        resource['description'],
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Add open resource logic
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: resource['color'] as Color,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Open Resource',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () {
                              // Add share logic
                            },
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: resource['color'] as Color),
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Icon(
                              Icons.share,
                              color: resource['color'] as Color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetadataChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            
            const Text(
              'Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            
            ListTile(
              leading: const Icon(Icons.sort),
              title: const Text('Sort Resources'),
              onTap: () {
                Navigator.pop(context);
                _showSortDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_list),
              title: const Text('Advanced Filters'),
              onTap: () {
                Navigator.pop(context);
                _showFiltersDialog(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Download All Favorites'),
              onTap: () {
                Navigator.pop(context);
                _downloadFavorites();
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sort Resources'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Title (A-Z)'),
              leading: Radio(value: 1, groupValue: 1, onChanged: (v) {}),
            ),
            ListTile(
              title: const Text('Rating (High to Low)'),
              leading: Radio(value: 2, groupValue: 1, onChanged: (v) {}),
            ),
            ListTile(
              title: const Text('Duration (Short to Long)'),
              leading: Radio(value: 3, groupValue: 1, onChanged: (v) {}),
            ),
            ListTile(
              title: const Text('Downloads (Most Popular)'),
              leading: Radio(value: 4, groupValue: 1, onChanged: (v) {}),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showFiltersDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Advanced Filters'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Difficulty Level:', style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: const Text('Beginner'),
              value: true,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('Intermediate'),
              value: true,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('Advanced'),
              value: false,
              onChanged: (v) {},
            ),
            const SizedBox(height: 16),
            const Text('Duration:', style: TextStyle(fontWeight: FontWeight.bold)),
            CheckboxListTile(
              title: const Text('Under 15 minutes'),
              value: true,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('15-30 minutes'),
              value: true,
              onChanged: (v) {},
            ),
            CheckboxListTile(
              title: const Text('Over 30 minutes'),
              value: false,
              onChanged: (v) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Reset'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  void _showAddResourceDialog(BuildContext context) {
    final titleController = TextEditingController();
    final subtitleController = TextEditingController();
    final descriptionController = TextEditingController();
    String selectedCategory = 'Prayers';
    String selectedDifficulty = 'Beginner';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Resource'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(
                  labelText: 'Subtitle',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories.where((c) => c != 'All').map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedCategory = value ?? 'Prayers';
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedDifficulty,
                decoration: const InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(),
                ),
                items: ['Beginner', 'Intermediate', 'Advanced'].map((difficulty) {
                  return DropdownMenuItem(
                    value: difficulty,
                    child: Text(difficulty),
                  );
                }).toList(),
                onChanged: (value) {
                  selectedDifficulty = value ?? 'Beginner';
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && 
                  subtitleController.text.isNotEmpty && 
                  descriptionController.text.isNotEmpty) {
                // Here you would typically add the resource to your data source
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Resource added successfully!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add Resource'),
          ),
        ],
      ),
    );
  }

  void _downloadFavorites() {
    final favorites = _getAllResources().where((r) => r['isBookmarked'] == true).toList();
    
    if (favorites.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No favorites to download'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Download Favorites'),
        content: Text('Download ${favorites.length} favorite resources for offline access?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _startDownload(favorites);
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  void _startDownload(List<Map<String, dynamic>> resources) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text('Downloading ${resources.length} resources...'),
          ],
        ),
      ),
    );

    // Simulate download process
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pop(context); // Close download dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully downloaded ${resources.length} resources!'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'View',
            onPressed: () {
              // Navigate to downloads
            },
          ),
        ),
      );
    });
  }
}