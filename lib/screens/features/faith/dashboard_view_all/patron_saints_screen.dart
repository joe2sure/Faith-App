import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/dashboard_read_biography.dart';

class PatronSaintsScreen extends StatefulWidget {
  const PatronSaintsScreen({super.key});

  @override
  State<PatronSaintsScreen> createState() => _PatronSaintsScreenState();
}

class _PatronSaintsScreenState extends State<PatronSaintsScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  // Patron saints data organized by professions/vocations
  final Map<String, List<Map<String, String>>> _patronSaintsData = {
    'Accountants': [
      {'name': 'St. Matthew', 'reason': 'Former tax collector', 'feastDay': 'September 21'}
    ],
    'Actors': [
      {'name': 'St. Genesius', 'reason': 'Martyred actor', 'feastDay': 'August 25'}
    ],
    'Architects': [
      {'name': 'St. Thomas Aquinas', 'reason': 'Builder of theological structure', 'feastDay': 'January 28'}
    ],
    'Artists': [
      {'name': 'St. Luke', 'reason': 'Painter of icons', 'feastDay': 'October 18'}
    ],
    'Attorneys': [
      {'name': 'St. Thomas More', 'reason': 'Lawyer and statesman', 'feastDay': 'June 22'}
    ],
    'Bakers': [
      {'name': 'St. Elizabeth of Hungary', 'reason': 'Provided bread to poor', 'feastDay': 'November 17'}
    ],
    'Bankers': [
      {'name': 'St. Matthew', 'reason': 'Handled money', 'feastDay': 'September 21'}
    ],
    'Booksellers': [
      {'name': 'St. John of God', 'reason': 'Sold religious books', 'feastDay': 'March 8'}
    ],
    'Builders': [
      {'name': 'St. Vincent Ferrer', 'reason': 'Builder of faith', 'feastDay': 'April 5'}
    ],
    'Carpenters': [
      {'name': 'St. Joseph', 'reason': 'Carpenter by trade', 'feastDay': 'March 19'}
    ],
    'Chefs': [
      {'name': 'St. Lawrence', 'reason': 'Martyred on a gridiron', 'feastDay': 'August 10'}
    ],
    'Doctors': [
      {'name': 'St. Luke', 'reason': 'Physician', 'feastDay': 'October 18'},
      {'name': 'St. Cosmas and Damian', 'reason': 'Physician brothers', 'feastDay': 'September 26'}
    ],
    'Engineers': [
      {'name': 'St. Joseph', 'reason': 'Master craftsman', 'feastDay': 'March 19'}
    ],
    'Farmers': [
      {'name': 'St. Isidore', 'reason': 'Farm worker', 'feastDay': 'May 15'}
    ],
    'Firefighters': [
      {'name': 'St. Florian', 'reason': 'Extinguished fires', 'feastDay': 'May 4'}
    ],
    'Fishermen': [
      {'name': 'St. Peter', 'reason': 'Former fisherman', 'feastDay': 'June 29'},
      {'name': 'St. Andrew', 'reason': 'Former fisherman', 'feastDay': 'November 30'}
    ],
    'Journalists': [
      {'name': 'St. Francis de Sales', 'reason': 'Writer and publisher', 'feastDay': 'January 24'}
    ],
    'Lawyers': [
      {'name': 'St. Ivo', 'reason': 'Judge and lawyer', 'feastDay': 'May 19'}
    ],
    'Librarians': [
      {'name': 'St. Jerome', 'reason': 'Translated the Bible', 'feastDay': 'September 30'}
    ],
    'Military': [
      {'name': 'St. Joan of Arc', 'reason': 'Military leader', 'feastDay': 'May 30'},
      {'name': 'St. Michael the Archangel', 'reason': 'Defender', 'feastDay': 'September 29'}
    ],
    'Musicians': [
      {'name': 'St. Cecilia', 'reason': 'Sang to God', 'feastDay': 'November 22'}
    ],
    'Nurses': [
      {'name': 'St. Agatha', 'reason': 'Healer', 'feastDay': 'February 5'},
      {'name': 'St. Camillus de Lellis', 'reason': 'Founded nursing order', 'feastDay': 'July 14'}
    ],
    'Pharmacists': [
      {'name': 'St. James the Greater', 'reason': 'Associated with healing', 'feastDay': 'July 25'}
    ],
    'Police Officers': [
      {'name': 'St. Michael the Archangel', 'reason': 'Protector', 'feastDay': 'September 29'}
    ],
    'Scientists': [
      {'name': 'St. Albert the Great', 'reason': 'Natural scientist', 'feastDay': 'November 15'}
    ],
    'Students': [
      {'name': 'St. Thomas Aquinas', 'reason': 'Great teacher', 'feastDay': 'January 28'}
    ],
    'Teachers': [
      {'name': 'St. John Baptist de La Salle', 'reason': 'Founded schools', 'feastDay': 'April 7'}
    ],
    'Writers': [
      {'name': 'St. Francis de Sales', 'reason': 'Prolific writer', 'feastDay': 'January 24'}
    ],
  };

  List<String> get _categories {
    final cats = ['All', ..._patronSaintsData.keys.toList()];
    cats.sort();
    return cats;
  }

  List<MapEntry<String, List<Map<String, String>>>> get _filteredPatronSaints {
    var filtered = _patronSaintsData.entries.toList();

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((entry) {
        final matchesProfession = entry.key.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesSaint = entry.value.any((saint) => 
          saint['name']!.toLowerCase().contains(_searchQuery.toLowerCase()));
        return matchesProfession || matchesSaint;
      }).toList();
    }

    // Filter by selected category
    if (_selectedCategory != 'All') {
      filtered = filtered.where((entry) => entry.key == _selectedCategory).toList();
    }

    // Sort alphabetically by profession
    filtered.sort((a, b) => a.key.compareTo(b.key));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Patron Saints',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Header Info Card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.work_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Find Your Patron Saint',
                        style: AppTextStyles.h5.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Discover saints for your profession or vocation',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search professions or saints...',
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                prefixIcon: const Icon(Icons.search, color: AppColors.primaryPurple),
                filled: true,
                fillColor: AppColors.backgroundLight,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Category Filter
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length > 10 ? 10 : _categories.length,
              itemBuilder: (context, index) {
                if (index >= _categories.length) return const SizedBox.shrink();
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isSelected ? null : AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isSelected ? Colors.white : AppColors.textPrimary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_filteredPatronSaints.length} Professions',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Patron Saints List
          Expanded(
            child: _filteredPatronSaints.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No results found',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredPatronSaints.length,
                    itemBuilder: (context, index) {
                      final entry = _filteredPatronSaints[index];
                      final profession = entry.key;
                      final saints = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primaryPurple.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Theme(
                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: AppColors.blueGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.work,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              profession,
                              style: AppTextStyles.h5.copyWith(
                                color: AppColors.primaryPurple,
                              ),
                            ),
                            subtitle: Text(
                              '${saints.length} Patron Saint${saints.length > 1 ? 's' : ''}',
                              style: AppTextStyles.bodySmall,
                            ),
                            children: saints.map((saint) {
                              return Container(
                                margin: const EdgeInsets.only(top: 12),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primaryPurple.withOpacity(0.1),
                                      AppColors.primaryBlue.withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            gradient: AppColors.primaryGradient,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                saint['name']!,
                                                style: AppTextStyles.bodyMedium.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.primaryPurple,
                                                ),
                                              ),
                                              Text(
                                                'Feast: ${saint['feastDay']}',
                                                style: AppTextStyles.bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      saint['reason']!,
                                      style: AppTextStyles.bodySmall.copyWith(
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SaintBiographyScreen(
                                                saintName: saint['name']!,
                                                feastDay: saint['feastDay']!,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.auto_stories, size: 16),
                                        label: const Text('Read Biography'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryPurple,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
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