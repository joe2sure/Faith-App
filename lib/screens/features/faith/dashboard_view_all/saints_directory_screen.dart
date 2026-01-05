import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/dashboard_read_biography.dart';

class SaintsDirectoryScreen extends StatefulWidget {
  const SaintsDirectoryScreen({super.key});

  @override
  State<SaintsDirectoryScreen> createState() => _SaintsDirectoryScreenState();
}

class _SaintsDirectoryScreenState extends State<SaintsDirectoryScreen> {
  String _searchQuery = '';
  String _selectedLetter = 'All';

  // Sample saints data - in real app, this would come from a database
  final List<Map<String, String>> _allSaints = [
    {'name': 'St. Agnes', 'title': 'Virgin and Martyr', 'feastDay': 'January 21', 'era': '291-304 AD'},
    {'name': 'St. Ambrose', 'title': 'Bishop and Doctor', 'feastDay': 'December 7', 'era': '340-397 AD'},
    {'name': 'St. Anthony of Padua', 'title': 'Doctor of the Church', 'feastDay': 'June 13', 'era': '1195-1231'},
    {'name': 'St. Augustine', 'title': 'Bishop and Doctor', 'feastDay': 'August 28', 'era': '354-430 AD'},
    {'name': 'St. Benedict', 'title': 'Abbot', 'feastDay': 'July 11', 'era': '480-547 AD'},
    {'name': 'St. Bernadette', 'title': 'Virgin', 'feastDay': 'April 16', 'era': '1844-1879'},
    {'name': 'St. Catherine of Siena', 'title': 'Virgin and Doctor', 'feastDay': 'April 29', 'era': '1347-1380'},
    {'name': 'St. Cecilia', 'title': 'Virgin and Martyr', 'feastDay': 'November 22', 'era': '2nd-3rd Century'},
    {'name': 'St. Clare of Assisi', 'title': 'Virgin', 'feastDay': 'August 11', 'era': '1194-1253'},
    {'name': 'St. Dominic', 'title': 'Priest', 'feastDay': 'August 8', 'era': '1170-1221'},
    {'name': 'St. Francis of Assisi', 'title': 'Deacon', 'feastDay': 'October 4', 'era': '1181-1226'},
    {'name': 'St. Francis Xavier', 'title': 'Priest', 'feastDay': 'December 3', 'era': '1506-1552'},
    {'name': 'St. Ignatius of Loyola', 'title': 'Priest', 'feastDay': 'July 31', 'era': '1491-1556'},
    {'name': 'St. Jerome', 'title': 'Priest and Doctor', 'feastDay': 'September 30', 'era': '347-420 AD'},
    {'name': 'St. Joan of Arc', 'title': 'Virgin', 'feastDay': 'May 30', 'era': '1412-1431'},
    {'name': 'St. John Paul II', 'title': 'Pope', 'feastDay': 'October 22', 'era': '1920-2005'},
    {'name': 'St. Joseph', 'title': 'Spouse of Mary', 'feastDay': 'March 19', 'era': '1st Century'},
    {'name': 'St. Lucy', 'title': 'Virgin and Martyr', 'feastDay': 'December 13', 'era': '283-304 AD'},
    {'name': 'St. Margaret Mary', 'title': 'Virgin', 'feastDay': 'October 16', 'era': '1647-1690'},
    {'name': 'St. Maria Goretti', 'title': 'Virgin and Martyr', 'feastDay': 'July 6', 'era': '1890-1902'},
    {'name': 'St. Monica', 'title': 'Mother', 'feastDay': 'August 27', 'era': '331-387 AD'},
    {'name': 'St. Patrick', 'title': 'Bishop', 'feastDay': 'March 17', 'era': '385-461 AD'},
    {'name': 'St. Paul', 'title': 'Apostle', 'feastDay': 'June 29', 'era': '5-67 AD'},
    {'name': 'St. Peter', 'title': 'Apostle', 'feastDay': 'June 29', 'era': '1-67 AD'},
    {'name': 'St. Rose of Lima', 'title': 'Virgin', 'feastDay': 'August 23', 'era': '1586-1617'},
    {'name': 'St. Teresa Benedicta', 'title': 'Virgin and Martyr', 'feastDay': 'August 9', 'era': '1891-1942'},
    {'name': 'St. Teresa of Avila', 'title': 'Virgin and Doctor', 'feastDay': 'October 15', 'era': '1515-1582'},
    {'name': 'St. Therese of Lisieux', 'title': 'Virgin and Doctor', 'feastDay': 'October 1', 'era': '1873-1897'},
    {'name': 'St. Thomas Aquinas', 'title': 'Priest and Doctor', 'feastDay': 'January 28', 'era': '1225-1274'},
  ];

  List<Map<String, String>> get _filteredSaints {
    var filtered = _allSaints;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((saint) =>
          saint['name']!.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    // Filter by selected letter
    if (_selectedLetter != 'All') {
      filtered = filtered.where((saint) =>
          saint['name']!.startsWith('St. $_selectedLetter')).toList();
    }

    // Sort alphabetically
    filtered.sort((a, b) => a['name']!.compareTo(b['name']!));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final alphabet = ['All', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 
                      'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 
                      'V', 'W', 'X', 'Y', 'Z'];

    return Scaffold(
      appBar: const AppTopBar(
        title: 'Saints Directory',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search saints...',
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

          // Alphabet Filter
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: alphabet.length,
              itemBuilder: (context, index) {
                final letter = alphabet[index];
                final isSelected = _selectedLetter == letter;
                
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLetter = letter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      gradient: isSelected ? AppColors.primaryGradient : null,
                      color: isSelected ? null : AppColors.backgroundLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: AppTextStyles.bodyMedium.copyWith(
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

          // Saints Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '${_filteredSaints.length} Saints',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Saints List
          Expanded(
            child: _filteredSaints.isEmpty
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
                          'No saints found',
                          style: AppTextStyles.h5.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredSaints.length,
                    itemBuilder: (context, index) {
                      final saint = _filteredSaints[index];
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryPurple.withOpacity(0.1),
                              AppColors.primaryBlue.withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primaryPurple.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
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
                            borderRadius: BorderRadius.circular(16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  // Avatar
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: AppColors.primaryGradient,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  
                                  // Saint Info
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          saint['name']!,
                                          style: AppTextStyles.h5.copyWith(
                                            color: AppColors.primaryPurple,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          saint['title']!,
                                          style: AppTextStyles.bodySmall.copyWith(
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: AppColors.primaryBlue,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              saint['feastDay']!,
                                              style: AppTextStyles.bodySmall.copyWith(
                                                color: AppColors.primaryBlue,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Icon(
                                              Icons.history,
                                              size: 14,
                                              color: AppColors.textSecondary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              saint['era']!,
                                              style: AppTextStyles.bodySmall.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  
                                  // Arrow Icon
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryPurple.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: 16,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                ],
                              ),
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