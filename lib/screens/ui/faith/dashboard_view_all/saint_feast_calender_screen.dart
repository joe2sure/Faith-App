import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'package:faith_plus/screens/ui/faith/dashboard_detail/dashboard_read_biography.dart';

class SaintsCalendarScreen extends StatefulWidget {
  const SaintsCalendarScreen({super.key});

  @override
  State<SaintsCalendarScreen> createState() => _SaintsCalendarScreenState();
}

class _SaintsCalendarScreenState extends State<SaintsCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDay = DateTime.now();
  PageController pageController = PageController();
  int currentMonthIndex = DateTime.now().month - 1;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Sample saints data - in a real app, this would come from a database
  final Map<String, List<Map<String, String>>> saintsData = {
    '2024-01-01': [
      {'name': 'Mary, Mother of God', 'type': 'Solemnity', 'color': 'red'}
    ],
    '2024-01-03': [
      {'name': 'Most Holy Name of Jesus', 'type': 'Optional Memorial', 'color': 'blue'}
    ],
    '2024-08-09': [
      {'name': 'St. Teresa Benedicta', 'type': 'Memorial', 'color': 'orange'}
    ],
    '2024-08-10': [
      {'name': 'St. Lawrence', 'type': 'Feast', 'color': 'red'}
    ],
    '2024-08-15': [
      {'name': 'Assumption of the Blessed Virgin Mary', 'type': 'Solemnity', 'color': 'red'}
    ],
    '2024-12-25': [
      {'name': 'Nativity of the Lord', 'type': 'Solemnity', 'color': 'red'}
    ],
  };

  Color getColorForType(String type) {
    switch (type.toLowerCase()) {
      case 'solemnity':
        return Colors.red.shade600;
      case 'feast':
        return Colors.red.shade400;
      case 'memorial':
        return Colors.orange.shade600;
      case 'optional memorial':
        return Colors.blue.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  List<Map<String, String>> getSaintsForDate(DateTime date) {
    final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return saintsData[dateKey] ?? [];
  }

  Widget buildCalendarGrid(int monthIndex) {
    final year = DateTime.now().year;
    final month = monthIndex + 1;
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;

    return Column(
      children: [
        // Month header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Text(
            '${months[monthIndex]} $year',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        
        // Days of week header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ),
        
        const SizedBox(height: 10),
        
        // Calendar grid
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 42, // 6 weeks × 7 days
            itemBuilder: (context, index) {
              final dayOffset = index - (firstWeekday % 7);
              final day = dayOffset + 1;
              
              if (day < 1 || day > daysInMonth) {
                return Container(); // Empty cell
              }
              
              final currentDate = DateTime(year, month, day);
              final saints = getSaintsForDate(currentDate);
              final isToday = currentDate.day == DateTime.now().day && 
                             currentDate.month == DateTime.now().month &&
                             currentDate.year == DateTime.now().year;
              final isSelected = currentDate.day == selectedDate.day && 
                               currentDate.month == selectedDate.month &&
                               currentDate.year == selectedDate.year;
              
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDate = currentDate;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? Colors.blue.shade100
                        : saints.isNotEmpty 
                            ? getColorForType(saints.first['type']!).withOpacity(0.1)
                            : Colors.transparent,
                    border: isToday 
                        ? Border.all(color: Colors.blue, width: 2)
                        : saints.isNotEmpty
                            ? Border.all(color: getColorForType(saints.first['type']!), width: 1)
                            : Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        day.toString(),
                        style: TextStyle(
                          fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                          color: saints.isNotEmpty 
                              ? getColorForType(saints.first['type']!)
                              : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      if (saints.isNotEmpty)
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: getColorForType(saints.first['type']!),
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

  @override
  Widget build(BuildContext context) {
    final selectedSaints = getSaintsForDate(selectedDate);
    
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Saints & Feast Days Calendar',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Calendar section
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentMonthIndex = index;
                });
              },
              itemCount: 12,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: buildCalendarGrid(index),
                );
              },
            ),
          ),
          
          // Legend
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildLegendItem('Solemnity', Colors.red.shade600),
                _buildLegendItem('Feast', Colors.red.shade400),
                _buildLegendItem('Memorial', Colors.orange.shade600),
                _buildLegendItem('Optional', Colors.blue.shade600),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Selected date details
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: selectedSaints.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedSaints.length,
                            itemBuilder: (context, index) {
                              final saint = selectedSaints[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: getColorForType(saint['type']!).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Icon(
                                      Icons.person,
                                      color: getColorForType(saint['type']!),
                                    ),
                                  ),
                                  title: Text(
                                    saint['name']!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    saint['type']!,
                                    style: TextStyle(
                                      color: getColorForType(saint['type']!),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SaintBiographyScreen(
                                            saintName: saint['name']!,
                                            feastDay: '${selectedDate.day}/${selectedDate.month}',
                                          ),
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: getColorForType(saint['type']!),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Read More',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_available,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No saints or feast days',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Text(
                            'for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
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
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}