import 'package:flutter/material.dart';

class PrayersViewAllScreen extends StatefulWidget {
  const PrayersViewAllScreen({super.key});

  @override
  State<PrayersViewAllScreen> createState() => _PrayersViewAllScreenState();
}

class _PrayersViewAllScreenState extends State<PrayersViewAllScreen> {
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  final Color _softTeal = const Color(0xFF50B5B0);
  
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Traditional", "Marian", "Saints", "Protection", "Healing"];

  final List<Map<String, dynamic>> _allPrayers = [
    {"title": "Our Father", "duration": "2 min", "category": "Traditional", "content": "Our Father prayer...", "audioUrl": "our_father.mp3", "icon": Icons.church, "color": Color(0xFF4A90E2)},
    {"title": "Hail Mary", "duration": "1 min", "category": "Marian", "content": "Hail Mary prayer...", "audioUrl": "hail_mary.mp3", "icon": Icons.favorite, "color": Color(0xFFD97687)},
    {"title": "Glory Be", "duration": "30 sec", "category": "Traditional", "content": "Glory Be prayer...", "audioUrl": "glory_be.mp3", "icon": Icons.star, "color": Color(0xFFFFB74D)},
    {"title": "Guardian Angel", "duration": "1 min", "category": "Protection", "content": "Guardian Angel prayer...", "audioUrl": "guardian_angel.mp3", "icon": Icons.shield, "color": Color(0xFF7CB798)},
    {"title": "St. Michael", "duration": "2 min", "category": "Protection", "content": "St. Michael prayer...", "audioUrl": "st_michael.mp3", "icon": Icons.security, "color": Color(0xFF5B7C99)},
    {"title": "Angelus", "duration": "3 min", "category": "Marian", "content": "Angelus prayer...", "audioUrl": "angelus.mp3", "icon": Icons.notifications_active, "color": Color(0xFF9B7EBD)},
    {"title": "Memorare", "duration": "1 min", "category": "Marian", "content": "Memorare prayer...", "audioUrl": "memorare.mp3", "icon": Icons.favorite_border, "color": Color(0xFFD97687)},
    {"title": "Act of Contrition", "duration": "1 min", "category": "Traditional", "content": "Act of Contrition...", "audioUrl": "contrition.mp3", "icon": Icons.healing, "color": Color(0xFF4A90E2)},
    {"title": "Prayer to St. Joseph", "duration": "2 min", "category": "Saints", "content": "St. Joseph prayer...", "audioUrl": "st_joseph.mp3", "icon": Icons.family_restroom, "color": Color(0xFFD4A574)},
    {"title": "Divine Mercy Chaplet", "duration": "15 min", "category": "Traditional", "content": "Divine Mercy...", "audioUrl": "divine_mercy.mp3", "icon": Icons.water_drop, "color": Color(0xFF50B5B0)},
    {"title": "Prayer for Healing", "duration": "3 min", "category": "Healing", "content": "Healing prayer...", "audioUrl": "healing.mp3", "icon": Icons.healing, "color": Color(0xFF7CB798)},
    {"title": "St. Francis Prayer", "duration": "2 min", "category": "Saints", "content": "St. Francis prayer...", "audioUrl": "st_francis.mp3", "icon": Icons.nature, "color": Color(0xFF8B7355)},
  ];

  List<Map<String, dynamic>> get _filteredPrayers {
    if (_selectedCategory == "All") return _allPrayers;
    return _allPrayers.where((p) => p["category"] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "All Prayers",
          style: TextStyle(
            color: _deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = category),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? LinearGradient(colors: [_primaryBlue, _softTeal])
                          : null,
                      color: isSelected ? null : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: isSelected
                              ? _primaryBlue.withOpacity(0.3)
                              : Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
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
          ),

          const SizedBox(height: 20),

          // Prayer Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${_filteredPrayers.length} Prayers",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.sort, color: _deepPurple),
                  onSelected: (value) {
                    // Handle sorting
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: "name", child: Text("Sort by Name")),
                    const PopupMenuItem(value: "duration", child: Text("Sort by Duration")),
                    const PopupMenuItem(value: "category", child: Text("Sort by Category")),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Prayer Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredPrayers.length,
              itemBuilder: (context, index) {
                return _buildPrayerCard(_filteredPrayers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerCard(Map<String, dynamic> prayer) {
    final color = prayer["color"] as Color;
    return GestureDetector(
      onTap: () {
        // Navigate to prayer detail - Add your navigation here
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  prayer["icon"] as IconData,
                  color: color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                prayer["title"] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  prayer["category"] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        prayer["duration"] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: color,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Search Prayers"),
        content: TextField(
          decoration: InputDecoration(
            hintText: "Search by name...",
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
          ),
          onChanged: (value) {
            // Handle search
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }
}