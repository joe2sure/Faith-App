import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'devotional_practice_detail_screen.dart';

class DevotionalPracticesExploreScreen extends StatefulWidget {
  const DevotionalPracticesExploreScreen({super.key});

  @override
  State<DevotionalPracticesExploreScreen> createState() => _DevotionalPracticesExploreScreenState();
}

class _DevotionalPracticesExploreScreenState extends State<DevotionalPracticesExploreScreen> {
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  final Color _softTeal = const Color(0xFF50B5B0);
  final Color _warmGold = const Color(0xFFD4A574);
  final Color _roseRed = const Color(0xFFD97687);
  final Color _sageGreen = const Color(0xFF7CB798);

  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Prayer', 'Reading', 'Meditation', 'Worship'];

  final List<Map<String, dynamic>> _allPractices = [
    {
      "title": "Liturgy of Hours",
      "subtitle": "Daily Office",
      "description": "Join the universal prayer of the Church throughout the day",
      "icon": Icons.access_time,
      "count": "7 prayers",
      "color": Color(0xFF4A90E2),
      "category": "Prayer",
      "difficulty": "Intermediate",
      "duration": "15-30 min"
    },
    {
      "title": "Novenas",
      "subtitle": "9-Day Prayers",
      "description": "Powerful prayers repeated over nine consecutive days",
      "icon": Icons.calendar_today,
      "count": "15 available",
      "color": Color(0xFF6B5B95),
      "category": "Prayer",
      "difficulty": "Beginner",
      "duration": "10-15 min"
    },
    {
      "title": "Chaplets",
      "subtitle": "Divine Mercy & More",
      "description": "Traditional prayers using beads for contemplation",
      "icon": Icons.spa,
      "count": "8 chaplets",
      "color": Color(0xFFD97687),
      "category": "Prayer",
      "difficulty": "Beginner",
      "duration": "15-20 min"
    },
    {
      "title": "Lectio Divina",
      "subtitle": "Sacred Reading",
      "description": "Ancient practice of scriptural reading, meditation and prayer",
      "icon": Icons.auto_stories,
      "count": "Daily guide",
      "color": Color(0xFF50B5B0),
      "category": "Reading",
      "difficulty": "Intermediate",
      "duration": "20-30 min"
    },
    {
      "title": "Stations of the Cross",
      "subtitle": "Way of the Cross",
      "description": "Walk with Jesus through His Passion and death",
      "icon": Icons.add,
      "count": "14 stations",
      "color": Color(0xFF8B7355),
      "category": "Meditation",
      "difficulty": "Beginner",
      "duration": "30-45 min"
    },
    {
      "title": "Marian Prayers",
      "subtitle": "Honoring Mary",
      "description": "Prayers dedicated to the Blessed Virgin Mary",
      "icon": Icons.favorite,
      "count": "20+ prayers",
      "color": Color(0xFF7CB798),
      "category": "Prayer",
      "difficulty": "Beginner",
      "duration": "5-15 min"
    },
    {
      "title": "Adoration",
      "subtitle": "Eucharistic Presence",
      "description": "Spend time in the presence of the Blessed Sacrament",
      "icon": Icons.wb_sunny,
      "count": "Guide included",
      "color": Color(0xFFFFB75E),
      "category": "Worship",
      "difficulty": "Beginner",
      "duration": "30-60 min"
    },
    {
      "title": "Contemplative Prayer",
      "subtitle": "Silent Prayer",
      "description": "Rest in God's presence through silence and stillness",
      "icon": Icons.self_improvement,
      "count": "Daily practice",
      "color": Color(0xFF9B7EBD),
      "category": "Meditation",
      "difficulty": "Advanced",
      "duration": "20-30 min"
    },
  ];

  List<Map<String, dynamic>> get _filteredPractices {
    if (_selectedCategory == 'All') {
      return _allPractices;
    }
    return _allPractices.where((practice) => practice['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _deepPurple),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Devotional Practices',
          style: TextStyle(color: _deepPurple, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: _deepPurple),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: _deepPurple),
            onPressed: () => _showFilterOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryTabs(),
          Expanded(
            child: _filteredPractices.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredPractices.length,
                    itemBuilder: (context, index) {
                      return _buildPracticeCard(_filteredPractices[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = category),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: [_primaryBlue, _softTeal])
                    : null,
                color: isSelected ? null : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : _deepPurple,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPracticeCard(Map<String, dynamic> practice) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DevotionalPracticeDetailScreen(practice: practice),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: (practice["color"] as Color).withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: (practice["color"] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  practice["icon"] as IconData,
                  color: practice["color"] as Color,
                  size: 32,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      practice["title"] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      practice["subtitle"] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildBadge(practice["difficulty"] as String, _primaryBlue),
                        const SizedBox(width: 8),
                        _buildBadge(practice["duration"] as String, _softTeal),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No practices found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Filter Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            _buildFilterOption('Difficulty', ['All', 'Beginner', 'Intermediate', 'Advanced']),
            const SizedBox(height: 16),
            _buildFilterOption('Duration', ['All', 'Under 15 min', '15-30 min', 'Over 30 min']),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryBlue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String title, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _deepPurple,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: false,
              onSelected: (selected) {},
            );
          }).toList(),
        ),
      ],
    );
  }
}