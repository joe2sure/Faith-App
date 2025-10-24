import 'package:flutter/material.dart';
// import 'package:church_app/common/constants.dart';

class FullCalendarScreen extends StatefulWidget {
  const FullCalendarScreen({super.key});

  @override
  State<FullCalendarScreen> createState() => _FullCalendarScreenState();
}

class _FullCalendarScreenState extends State<FullCalendarScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime currentMonth = DateTime.now();
  String selectedSeason = 'All Seasons';

  final List<String> liturgicalSeasons = [
    'All Seasons',
    'Advent',
    'Christmas',
    'Ordinary Time',
    'Lent',
    'Easter',
    'Pentecost'
  ];

  // Sample liturgical calendar data
  final Map<String, Map<String, dynamic>> liturgicalEvents = {
    '2024-01-01': {
      'event': 'Mary, Mother of God',
      'season': 'Christmas',
      'rank': 'Solemnity',
      'color': 'white',
      'readings': ['Nm 6:22-27', 'Gal 4:4-7', 'Lk 2:16-21']
    },
    '2024-01-06': {
      'event': 'Epiphany of the Lord',
      'season': 'Christmas',
      'rank': 'Solemnity',
      'color': 'white',
      'readings': ['Is 60:1-6', 'Eph 3:2-3a,5-6', 'Mt 2:1-12']
    },
    '2024-02-14': {
      'event': 'Ash Wednesday',
      'season': 'Lent',
      'rank': 'Special',
      'color': 'violet',
      'readings': ['Jl 2:12-18', '2 Cor 5:20—6:2', 'Mt 6:1-6,16-18']
    },
    '2024-03-24': {
      'event': 'Palm Sunday',
      'season': 'Lent',
      'rank': 'Sunday',
      'color': 'red',
      'readings': ['Is 50:4-7', 'Phil 2:6-11', 'Mt 26:14—27:66']
    },
    '2024-03-31': {
      'event': 'Easter Sunday',
      'season': 'Easter',
      'rank': 'Solemnity',
      'color': 'white',
      'readings': ['Acts 10:34a,37-43', 'Col 3:1-4', 'Jn 20:1-9']
    },
    '2024-05-09': {
      'event': 'Ascension of the Lord',
      'season': 'Easter',
      'rank': 'Solemnity',
      'color': 'white',
      'readings': ['Acts 1:1-11', 'Eph 1:17-23', 'Mt 28:16-20']
    },
    '2024-05-19': {
      'event': 'Pentecost Sunday',
      'season': 'Pentecost',
      'rank': 'Solemnity',
      'color': 'red',
      'readings': ['Acts 2:1-11', '1 Cor 12:3b-7,12-13', 'Jn 20:19-23']
    },
    '2024-12-01': {
      'event': 'First Sunday of Advent',
      'season': 'Advent',
      'rank': 'Sunday',
      'color': 'violet',
      'readings': ['Is 63:16b-17,19b; 64:2-7', '1 Cor 1:3-9', 'Mk 13:33-37']
    },
    '2024-12-25': {
      'event': 'Nativity of the Lord',
      'season': 'Christmas',
      'rank': 'Solemnity',
      'color': 'white',
      'readings': ['Is 9:1-6', 'Ti 2:11-14', 'Lk 2:1-14']
    },
  };

  Color getSeasonColor(String season) {
    switch (season.toLowerCase()) {
      case 'advent':
      case 'lent':
        return Colors.purple.shade600;
      case 'christmas':
      case 'easter':
        return Colors.yellow.shade700;
      case 'ordinary time':
        return Colors.green.shade600;
      case 'pentecost':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  Color getLiturgicalColor(String color) {
    switch (color.toLowerCase()) {
      case 'white':
        return Colors.yellow.shade700;
      case 'red':
        return Colors.red.shade600;
      case 'violet':
        return Colors.purple.shade600;
      case 'green':
        return Colors.green.shade600;
      case 'rose':
        return Colors.pink.shade400;
      default:
        return Colors.grey.shade600;
    }
  }

  Map<String, dynamic>? getEventForDate(DateTime date) {
    final dateKey = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return liturgicalEvents[dateKey];
  }

  List<DateTime> getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(month.year, month.month, index + 1),
    );
  }

  bool shouldShowEvent(Map<String, dynamic> event) {
    if (selectedSeason == 'All Seasons') return true;
    return event['season'] == selectedSeason;
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDaysInMonth(currentMonth);
    final selectedEvent = getEventForDate(selectedDate);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Liturgical Calendar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.today),
            onPressed: () {
              setState(() {
                currentMonth = DateTime.now();
                selectedDate = DateTime.now();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Season filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: liturgicalSeasons.length,
              itemBuilder: (context, index) {
                final season = liturgicalSeasons[index];
                final isSelected = season == selectedSeason;
                
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: FilterChip(
                    label: Text(season),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedSeason = season;
                      });
                    },
                    backgroundColor: Colors.grey.shade100,
                    selectedColor: getSeasonColor(season).withOpacity(0.2),
                    checkmarkColor: getSeasonColor(season),
                    labelStyle: TextStyle(
                      color: isSelected ? getSeasonColor(season) : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Month navigation
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
                    });
                  },
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  '${_getMonthName(currentMonth.month)} ${currentMonth.year}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
                    });
                  },
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),

          // Calendar grid
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Weekday headers
                  Row(
                    children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                        .map((day) => Expanded(
                              child: Center(
                                child: Text(
                                  day,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  
                  // Calendar grid
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                      ),
                      itemCount: _getTotalCalendarCells(),
                      itemBuilder: (context, index) {
                        final date = _getDateForIndex(index);
                        if (date == null) return Container();
                        
                        final event = getEventForDate(date);
                        final isToday = _isSameDay(date, DateTime.now());
                        final isSelected = _isSameDay(date, selectedDate);
                        final showEvent = event != null && shouldShowEvent(event);
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? Colors.blue.shade100
                                  : showEvent
                                      ? getLiturgicalColor(event!['color']).withOpacity(0.1)
                                      : Colors.transparent,
                              border: isToday 
                                  ? Border.all(color: Colors.blue, width: 2)
                                  : showEvent
                                      ? Border.all(color: getLiturgicalColor(event!['color']), width: 1)
                                      : Border.all(color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                                    color: showEvent 
                                        ? getLiturgicalColor(event!['color'])
                                        : Colors.black87,
                                    fontSize: 16,
                                  ),
                                ),
                                if (showEvent)
                                  Container(
                                    width: 6,
                                    height: 6,
                                    margin: const EdgeInsets.only(top: 2),
                                    decoration: BoxDecoration(
                                      color: getLiturgicalColor(event!['color']),
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
              ),
            ),
          ),

          // Event details section
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: selectedEvent != null && shouldShowEvent(selectedEvent)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 40,
                              decoration: BoxDecoration(
                                color: getLiturgicalColor(selectedEvent['color']),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    selectedEvent['event'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '${selectedEvent['season']} • ${selectedEvent['rank']}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: getSeasonColor(selectedEvent['season']),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: getLiturgicalColor(selectedEvent['color']).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                selectedEvent['color'].toUpperCase(),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: getLiturgicalColor(selectedEvent['color']),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 16),
                        
                        Text(
                          'Scripture Readings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                        
                        Expanded(
                          child: ListView.builder(
                            itemCount: selectedEvent['readings'].length,
                            itemBuilder: (context, index) {
                              final reading = selectedEvent['readings'][index];
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey.shade200),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: getLiturgicalColor(selectedEvent['color']).withOpacity(0.2),
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: getLiturgicalColor(selectedEvent['color']),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        reading,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
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
                            Icons.calendar_today,
                            size: 48,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No liturgical event',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
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

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int _getTotalCalendarCells() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final daysInMonth = lastDayOfMonth.day;
    return ((firstWeekday + daysInMonth) / 7).ceil() * 7;
  }

  DateTime? _getDateForIndex(int index) {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    final dayNumber = index - firstWeekday + 1;
    
    if (dayNumber < 1) return null;
    
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    if (dayNumber > lastDayOfMonth.day) return null;
    
    return DateTime(currentMonth.year, currentMonth.month, dayNumber);
  }
}