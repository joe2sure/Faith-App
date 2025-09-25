// Calendar Widget (keeping the existing one but with responsive improvements)
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCalendar extends StatefulWidget {
  @override
  Custom_CalendarState createState() => Custom_CalendarState();
}

class Custom_CalendarState extends State<CustomCalendar> {
  DateTime _focusedMonth = DateTime(2025, 8);

  final Map<DateTime, Map<String, dynamic>> _events = {
    DateTime(2025, 8, 9): {
      "title": "St. Teresa Benedicta",
      "color": Colors.blue,
    },
    DateTime(2025, 8, 15): {
      "title": "Assumption of Mary",
      "color": Colors.orange,
    },
    DateTime(2025, 8, 22): {
      "title": "Queenship of Mary",
      "color": Colors.orange,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  setState(() {
                    _focusedMonth =
                        DateTime(_focusedMonth.year, _focusedMonth.month - 1);
                  });
                },
              ),
              Text(
                DateFormat.yMMMM().format(_focusedMonth),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  setState(() {
                    _focusedMonth =
                        DateTime(_focusedMonth.year, _focusedMonth.month + 1);
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: ["S", "M", "T", "W", "T", "F", "S"]
                .map((e) => Expanded(
                      child: Center(
                          child: Text(
                        e,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                    ))
                .toList(),
          ),

          const SizedBox(height: 8),

          _buildCalendarGrid(),

          const SizedBox(height: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _events.entries
                .where((entry) =>
                    entry.key.year == _focusedMonth.year &&
                    entry.key.month == _focusedMonth.month)
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: entry.value["color"],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${DateFormat.MMMd().format(entry.key)} - ${entry.value["title"]}",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final lastDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0);

    int startWeekday = firstDayOfMonth.weekday % 7;
    List<Widget> dayWidgets = [];

    for (int i = 0; i < startWeekday; i++) {
      dayWidgets.add(Container());
    }

    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      DateTime currentDate =
          DateTime(_focusedMonth.year, _focusedMonth.month, day);

      bool hasEvent = _events.containsKey(currentDate);

      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: hasEvent
                ? _events[currentDate]!["color"].withOpacity(0.2)
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "$day",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: hasEvent ? _events[currentDate]!["color"] : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: dayWidgets,
    );
  }
}