import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/screens/features/faith/dashboard_detail/dashboard_read_biography.dart';

class SaintsCalendarScreen extends StatefulWidget {
  const SaintsCalendarScreen({super.key});

  @override
  State<SaintsCalendarScreen> createState() => _SaintsCalendarScreenState();
}

class _SaintsCalendarScreenState extends State<SaintsCalendarScreen> {
  int selectedYear = DateTime.now().year;
  int? selectedMonth;

  final List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Enhanced saints data
  final Map<String, Map<String, dynamic>> saintsData = {
    '01-01': {
      'name': 'Mary, Mother of God',
      'type': 'Solemnity',
      'bio': 'The Blessed Virgin Mary, Mother of Jesus Christ and Mother of the Church. This solemnity celebrates her divine maternity.',
      'virtue': 'Obedience and Humility',
      'prayer': 'Holy Mary, Mother of God, pray for us sinners now and at the hour of our death.',
    },
    '01-03': {
      'name': 'Most Holy Name of Jesus',
      'type': 'Optional Memorial',
      'bio': 'This memorial honors the holy name of Jesus, given to Him eight days after His birth.',
      'virtue': 'Reverence',
      'prayer': 'Jesus, Name above all names, we praise and glorify Your holy name.',
    },
    '01-28': {
      'name': 'St. Thomas Aquinas',
      'type': 'Memorial',
      'bio': 'Dominican friar and priest, Doctor of the Church. Known as the "Angelic Doctor" for his brilliant theological works.',
      'virtue': 'Wisdom and Learning',
      'prayer': 'St. Thomas Aquinas, patron of students, pray for us.',
    },
    '03-17': {
      'name': 'St. Patrick',
      'type': 'Memorial',
      'bio': 'Bishop and patron saint of Ireland. Brought Christianity to Ireland in the 5th century.',
      'virtue': 'Evangelization',
      'prayer': 'St. Patrick, drive from us all evil and protect us in faith.',
    },
    '03-19': {
      'name': 'St. Joseph',
      'type': 'Solemnity',
      'bio': 'Husband of the Blessed Virgin Mary and foster father of Jesus. Patron of the Universal Church.',
      'virtue': 'Fatherhood and Protection',
      'prayer': 'St. Joseph, terror of demons, pray for us.',
    },
    '08-09': {
      'name': 'St. Teresa Benedicta (Edith Stein)',
      'type': 'Feast',
      'bio': 'Carmelite nun, philosopher, and martyr. Jewish convert who died in Auschwitz. Co-patroness of Europe.',
      'virtue': 'Courage and Faith',
      'prayer': 'St. Teresa Benedicta, pray for us in times of persecution.',
    },
    '08-10': {
      'name': 'St. Lawrence',
      'type': 'Feast',
      'bio': 'Deacon and martyr of Rome. Known for his charity to the poor and his courageous martyrdom.',
      'virtue': 'Charity and Courage',
      'prayer': 'St. Lawrence, patron of the poor, intercede for us.',
    },
    '08-15': {
      'name': 'Assumption of the Blessed Virgin Mary',
      'type': 'Solemnity',
      'bio': 'This solemnity celebrates Mary being taken up body and soul into heavenly glory.',
      'virtue': 'Hope in Resurrection',
      'prayer': 'Mary, assumed into heaven, pray for us.',
    },
    '10-01': {
      'name': 'St. Therese of Lisieux',
      'type': 'Memorial',
      'bio': 'Carmelite nun and Doctor of the Church. Known for her "Little Way" of spiritual childhood.',
      'virtue': 'Simplicity and Trust',
      'prayer': 'St. Therese, shower us with roses from heaven.',
    },
    '10-04': {
      'name': 'St. Francis of Assisi',
      'type': 'Memorial',
      'bio': 'Founder of the Franciscan Order. Known for his love of nature and the poor.',
      'virtue': 'Poverty and Peace',
      'prayer': 'Lord, make me an instrument of your peace.',
    },
    '11-01': {
      'name': 'All Saints',
      'type': 'Solemnity',
      'bio': 'This solemnity honors all saints, known and unknown, who are in heaven.',
      'virtue': 'Holiness',
      'prayer': 'Holy men and women of God, pray for us.',
    },
    '12-08': {
      'name': 'Immaculate Conception',
      'type': 'Solemnity',
      'bio': 'This solemnity celebrates Mary being conceived without original sin.',
      'virtue': 'Purity',
      'prayer': 'O Mary, conceived without sin, pray for us.',
    },
    '12-25': {
      'name': 'Nativity of the Lord',
      'type': 'Solemnity',
      'bio': 'The birth of Jesus Christ, the Son of God, in Bethlehem.',
      'virtue': 'Joy and Wonder',
      'prayer': 'Glory to God in the highest, and peace to His people on earth.',
    },
  };

  Color getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'solemnity':
        return AppColors.accentRose;
      case 'feast':
        return AppColors.primaryPurple;
      case 'memorial':
        return AppColors.primaryBlue;
      case 'optional memorial':
        return AppColors.accentTeal;
      default:
        return AppColors.textSecondary;
    }
  }

  Map<String, dynamic>? getSaintForDate(int month, int day) {
    final key = '${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
    return saintsData[key];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Saints & Feast Days',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Year Selector
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedYear--;
                      selectedMonth = null;
                    });
                  },
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 32),
                ),
                Column(
                  children: [
                    Text(
                      selectedYear.toString(),
                      style: AppTextStyles.h2.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Liturgical Calendar',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      selectedYear++;
                      selectedMonth = null;
                    });
                  },
                  icon: const Icon(Icons.chevron_right, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),

          // Legend
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Wrap(
              spacing: 16,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                _buildLegendItem('Solemnity', AppColors.accentRose),
                _buildLegendItem('Feast', AppColors.primaryPurple),
                _buildLegendItem('Memorial', AppColors.primaryBlue),
                _buildLegendItem('Optional', AppColors.accentTeal),
              ],
            ),
          ),

          // Month Grid
          Expanded(
            child: selectedMonth == null
                ? _buildMonthGrid()
                : _buildDayGrid(selectedMonth!),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.2,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        final month = index + 1;
        final monthSaints = saintsData.entries.where((e) {
          final parts = e.key.split('-');
          return int.parse(parts[0]) == month;
        }).length;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedMonth = month;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryPurple.withOpacity(0.8),
                  AppColors.primaryBlue.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryPurple.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  monthNames[index],
                  style: AppTextStyles.h5.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$monthSaints Feast${monthSaints != 1 ? 's' : ''}',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDayGrid(int month) {
    final daysInMonth = DateTime(selectedYear, month + 1, 0).day;
    final firstWeekday = DateTime(selectedYear, month, 1).weekday % 7;

    return Column(
      children: [
        // Month Header with Back Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedMonth = null;
                  });
                },
                icon: const Icon(Icons.arrow_back, color: AppColors.primaryPurple),
              ),
              Expanded(
                child: Text(
                  '${monthNames[month - 1]} $selectedYear',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),

        // Days of Week
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: AppTextStyles.bodySmall.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),

        // Calendar Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              childAspectRatio: 0.8,
            ),
            itemCount: 42,
            itemBuilder: (context, index) {
              final dayOffset = index - firstWeekday;
              final day = dayOffset + 1;

              if (day < 1 || day > daysInMonth) {
                return Container();
              }

              final saintData = getSaintForDate(month, day);
              final hasEvent = saintData != null;
              final isToday = selectedYear == DateTime.now().year &&
                  month == DateTime.now().month &&
                  day == DateTime.now().day;

              return GestureDetector(
                onTap: hasEvent
                    ? () {
                        _showSaintDetailsBottomSheet(context, saintData, day);
                      }
                    : null,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: hasEvent
                        ? LinearGradient(
                            colors: [
                              getColorForType(saintData['type']).withOpacity(0.3),
                              getColorForType(saintData['type']).withOpacity(0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : null,
                    border: Border.all(
                      color: isToday
                          ? AppColors.primaryPurple
                          : hasEvent
                              ? getColorForType(saintData['type']).withOpacity(0.5)
                              : AppColors.divider,
                      width: isToday ? 2 : 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                          color: hasEvent
                              ? getColorForType(saintData['type'])
                              : AppColors.textPrimary,
                        ),
                      ),
                      if (hasEvent)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: getColorForType(saintData['type']),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showSaintDetailsBottomSheet(BuildContext context, Map<String, dynamic> saintData, int day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Header
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                getColorForType(saintData['type']),
                                getColorForType(saintData['type']).withOpacity(0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.person,
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
                                saintData['name'],
                                style: AppTextStyles.h4.copyWith(
                                  color: getColorForType(saintData['type']),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: getColorForType(saintData['type']).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  saintData['type'],
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: getColorForType(saintData['type']),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Date
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryPurple,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${monthNames[selectedMonth! - 1]} $day, $selectedYear',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Biography
                    _buildSection('Biography', saintData['bio'], Icons.auto_stories),

                    const SizedBox(height: 16),

                    // Virtue
                    _buildSection('Virtue', saintData['virtue'], Icons.star),

                    const SizedBox(height: 16),

                    // Prayer
                    _buildSection('Prayer', saintData['prayer'], Icons.church),

                    const SizedBox(height: 24),

                    // Action Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaintBiographyScreen(
                              saintName: saintData['name'],
                              feastDay: '${monthNames[selectedMonth! - 1]} $day',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: getColorForType(saintData['type']),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.menu_book),
                          const SizedBox(width: 8),
                          Text(
                            'Read Full Biography',
                            style: AppTextStyles.button,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryPurple, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppTextStyles.h5.copyWith(
                color: AppColors.primaryPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            content,
            style: AppTextStyles.bodyMedium.copyWith(
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:faith_plus/common/constants.dart';
// import 'package:faith_plus/screens/features/faith/dashboard_detail/dashboard_read_biography.dart';

// class SaintsCalendarScreen extends StatefulWidget {
//   const SaintsCalendarScreen({super.key});

//   @override
//   State<SaintsCalendarScreen> createState() => _SaintsCalendarScreenState();
// }

// class _SaintsCalendarScreenState extends State<SaintsCalendarScreen> {
//   DateTime selectedDate = DateTime.now();
//   DateTime focusedDay = DateTime.now();
//   PageController pageController = PageController();
//   int currentMonthIndex = DateTime.now().month - 1;

//   final List<String> months = [
//     'January', 'February', 'March', 'April', 'May', 'June',
//     'July', 'August', 'September', 'October', 'November', 'December'
//   ];

//   // Sample saints data - in a real app, this would come from a database
//   final Map<String, List<Map<String, String>>> saintsData = {
//     '2024-01-01': [
//       {'name': 'Mary, Mother of God', 'type': 'Solemnity', 'color': 'red'}
//     ],
//     '2024-01-03': [
//       {'name': 'Most Holy Name of Jesus', 'type': 'Optional Memorial', 'color': 'blue'}
//     ],
//     '2024-08-09': [
//       {'name': 'St. Teresa Benedicta', 'type': 'Memorial', 'color': 'orange'}
//     ],
//     '2024-08-10': [
//       {'name': 'St. Lawrence', 'type': 'Feast', 'color': 'red'}
//     ],
//     '2024-08-15': [
//       {'name': 'Assumption of the Blessed Virgin Mary', 'type': 'Solemnity', 'color': 'red'}
//     ],
//     '2024-12-25': [
//       {'name': 'Nativity of the Lord', 'type': 'Solemnity', 'color': 'red'}
//     ],
//   };

//   Color getColorForType(String type) {
//     switch (type.toLowerCase()) {
//       case 'solemnity':
//         return Colors.red.shade600;
//       case 'feast':
//         return Colors.red.shade400;
//       case 'memorial':
//         return Colors.orange.shade600;
//       case 'optional memorial':
//         return Colors.blue.shade600;
//       default:
//         return Colors.grey.shade600;
//     }
//   }

//   List<Map<String, String>> getSaintsForDate(DateTime date) {
//     final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
//     return saintsData[dateKey] ?? [];
//   }

//   Widget buildCalendarGrid(int monthIndex) {
//     final year = DateTime.now().year;
//     final month = monthIndex + 1;
//     final firstDayOfMonth = DateTime(year, month, 1);
//     final lastDayOfMonth = DateTime(year, month + 1, 0);
//     final firstWeekday = firstDayOfMonth.weekday;
//     final daysInMonth = lastDayOfMonth.day;

//     return Column(
//       children: [
//         // Month header
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           child: Text(
//             '${months[monthIndex]} $year',
//             style: const TextStyle(
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//               color: Colors.blue,
//             ),
//           ),
//         ),
        
//         // Days of week header
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
//                 .map((day) => Expanded(
//                       child: Center(
//                         child: Text(
//                           day,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             color: Colors.grey.shade600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     ))
//                 .toList(),
//           ),
//         ),
        
//         const SizedBox(height: 10),
        
//         // Calendar grid
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 7,
//               childAspectRatio: 1,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
//             ),
//             itemCount: 42, // 6 weeks × 7 days
//             itemBuilder: (context, index) {
//               final dayOffset = index - (firstWeekday % 7);
//               final day = dayOffset + 1;
              
//               if (day < 1 || day > daysInMonth) {
//                 return Container(); // Empty cell
//               }
              
//               final currentDate = DateTime(year, month, day);
//               final saints = getSaintsForDate(currentDate);
//               final isToday = currentDate.day == DateTime.now().day && 
//                              currentDate.month == DateTime.now().month &&
//                              currentDate.year == DateTime.now().year;
//               final isSelected = currentDate.day == selectedDate.day && 
//                                currentDate.month == selectedDate.month &&
//                                currentDate.year == selectedDate.year;
              
//               return GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selectedDate = currentDate;
//                   });
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: isSelected 
//                         ? Colors.blue.shade100
//                         : saints.isNotEmpty 
//                             ? getColorForType(saints.first['type']!).withOpacity(0.1)
//                             : Colors.transparent,
//                     border: isToday 
//                         ? Border.all(color: Colors.blue, width: 2)
//                         : saints.isNotEmpty
//                             ? Border.all(color: getColorForType(saints.first['type']!), width: 1)
//                             : Border.all(color: Colors.grey.shade300, width: 0.5),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         day.toString(),
//                         style: TextStyle(
//                           fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
//                           color: saints.isNotEmpty 
//                               ? getColorForType(saints.first['type']!)
//                               : Colors.black87,
//                           fontSize: 16,
//                         ),
//                       ),
//                       if (saints.isNotEmpty)
//                         Container(
//                           width: 4,
//                           height: 4,
//                           margin: const EdgeInsets.only(top: 2),
//                           decoration: BoxDecoration(
//                             color: getColorForType(saints.first['type']!),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final selectedSaints = getSaintsForDate(selectedDate);
    
//     return Scaffold(
//       appBar: const AppTopBar(
//         title: 'Saints & Feast Days Calendar',
//         showBackButton: true,
//       ),
//       body: Column(
//         children: [
//           // Calendar section
//           Expanded(
//             flex: 3,
//             child: PageView.builder(
//               controller: pageController,
//               onPageChanged: (index) {
//                 setState(() {
//                   currentMonthIndex = index;
//                 });
//               },
//               itemCount: 12,
//               itemBuilder: (context, index) {
//                 return SingleChildScrollView(
//                   child: buildCalendarGrid(index),
//                 );
//               },
//             ),
//           ),
          
//           // Legend
//           Container(
//             padding: const EdgeInsets.all(16),
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade50,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildLegendItem('Solemnity', Colors.red.shade600),
//                 _buildLegendItem('Feast', Colors.red.shade400),
//                 _buildLegendItem('Memorial', Colors.orange.shade600),
//                 _buildLegendItem('Optional', Colors.blue.shade600),
//               ],
//             ),
//           ),
          
//           const SizedBox(height: 16),
          
//           // Selected date details
//           Expanded(
//             flex: 2,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               child: selectedSaints.isNotEmpty
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         Expanded(
//                           child: ListView.builder(
//                             itemCount: selectedSaints.length,
//                             itemBuilder: (context, index) {
//                               final saint = selectedSaints[index];
//                               return Card(
//                                 margin: const EdgeInsets.only(bottom: 12),
//                                 elevation: 2,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ListTile(
//                                   leading: Container(
//                                     width: 50,
//                                     height: 50,
//                                     decoration: BoxDecoration(
//                                       color: getColorForType(saint['type']!).withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(25),
//                                     ),
//                                     child: Icon(
//                                       Icons.person,
//                                       color: getColorForType(saint['type']!),
//                                     ),
//                                   ),
//                                   title: Text(
//                                     saint['name']!,
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   subtitle: Text(
//                                     saint['type']!,
//                                     style: TextStyle(
//                                       color: getColorForType(saint['type']!),
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                   trailing: ElevatedButton(
//                                     onPressed: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => SaintBiographyScreen(
//                                             saintName: saint['name']!,
//                                             feastDay: '${selectedDate.day}/${selectedDate.month}',
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                     style: ElevatedButton.styleFrom(
//                                       backgroundColor: getColorForType(saint['type']!),
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(8),
//                                       ),
//                                     ),
//                                     child: const Text(
//                                       'Read More',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.event_available,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           Text(
//                             'No saints or feast days',
//                             style: TextStyle(
//                               fontSize: 18,
//                               color: Colors.grey.shade600,
//                             ),
//                           ),
//                           Text(
//                             'for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey.shade500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLegendItem(String label, Color color) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           width: 12,
//           height: 12,
//           decoration: BoxDecoration(
//             color: color,
//             shape: BoxShape.circle,
//           ),
//         ),
//         const SizedBox(width: 4),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 12),
//         ),
//       ],
//     );
//   }
// }