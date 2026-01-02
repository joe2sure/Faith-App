import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';

class TestamentBooksScreen extends StatefulWidget {
  final String initialTab; // "Old Testament" or "New Testament"
  
  const TestamentBooksScreen({
    super.key,
    this.initialTab = "Old Testament",
  });

  @override
  State<TestamentBooksScreen> createState() => _TestamentBooksScreenState();
}

class _TestamentBooksScreenState extends State<TestamentBooksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, String>> oldTestamentBooks = [
    // Law (Torah/Pentateuch) - 5 books
    {"name": "Genesis", "chapters": "50", "category": "Law"},
    {"name": "Exodus", "chapters": "40", "category": "Law"},
    {"name": "Leviticus", "chapters": "27", "category": "Law"},
    {"name": "Numbers", "chapters": "36", "category": "Law"},
    {"name": "Deuteronomy", "chapters": "34", "category": "Law"},
    
    // Historical Books - 12 books
    {"name": "Joshua", "chapters": "24", "category": "History"},
    {"name": "Judges", "chapters": "21", "category": "History"},
    {"name": "Ruth", "chapters": "4", "category": "History"},
    {"name": "1 Samuel", "chapters": "31", "category": "History"},
    {"name": "2 Samuel", "chapters": "24", "category": "History"},
    {"name": "1 Kings", "chapters": "22", "category": "History"},
    {"name": "2 Kings", "chapters": "25", "category": "History"},
    {"name": "1 Chronicles", "chapters": "29", "category": "History"},
    {"name": "2 Chronicles", "chapters": "36", "category": "History"},
    {"name": "Ezra", "chapters": "10", "category": "History"},
    {"name": "Nehemiah", "chapters": "13", "category": "History"},
    {"name": "Esther", "chapters": "10", "category": "History"},
    
    // Deuterocanonical Historical Books - 3 books
    {"name": "Tobit", "chapters": "14", "category": "Deuterocanonical History"},
    {"name": "Judith", "chapters": "16", "category": "Deuterocanonical History"},
    {"name": "1 Maccabees", "chapters": "16", "category": "Deuterocanonical History"},
    {"name": "2 Maccabees", "chapters": "15", "category": "Deuterocanonical History"},
    
    // Wisdom Books - 5 books
    {"name": "Job", "chapters": "42", "category": "Wisdom"},
    {"name": "Psalms", "chapters": "150", "category": "Wisdom"},
    {"name": "Proverbs", "chapters": "31", "category": "Wisdom"},
    {"name": "Ecclesiastes", "chapters": "12", "category": "Wisdom"},
    {"name": "Song of Songs", "chapters": "8", "category": "Wisdom"},
    
    // Deuterocanonical Wisdom Books - 2 books
    {"name": "Wisdom", "chapters": "19", "category": "Deuterocanonical Wisdom"},
    {"name": "Sirach", "chapters": "51", "category": "Deuterocanonical Wisdom"},
    
    // Major Prophets - 5 books
    {"name": "Isaiah", "chapters": "66", "category": "Major Prophets"},
    {"name": "Jeremiah", "chapters": "52", "category": "Major Prophets"},
    {"name": "Lamentations", "chapters": "5", "category": "Major Prophets"},
    
    // Deuterocanonical addition to Jeremiah
    {"name": "Baruch", "chapters": "6", "category": "Major Prophets"},
    
    {"name": "Ezekiel", "chapters": "48", "category": "Major Prophets"},
    {"name": "Daniel", "chapters": "12", "category": "Major Prophets"},
    
    // Minor Prophets - 12 books
    {"name": "Hosea", "chapters": "14", "category": "Minor Prophets"},
    {"name": "Joel", "chapters": "3", "category": "Minor Prophets"},
    {"name": "Amos", "chapters": "9", "category": "Minor Prophets"},
    {"name": "Obadiah", "chapters": "1", "category": "Minor Prophets"},
    {"name": "Jonah", "chapters": "4", "category": "Minor Prophets"},
    {"name": "Micah", "chapters": "7", "category": "Minor Prophets"},
    {"name": "Nahum", "chapters": "3", "category": "Minor Prophets"},
    {"name": "Habakkuk", "chapters": "3", "category": "Minor Prophets"},
    {"name": "Zephaniah", "chapters": "3", "category": "Minor Prophets"},
    {"name": "Haggai", "chapters": "2", "category": "Minor Prophets"},
    {"name": "Zechariah", "chapters": "14", "category": "Minor Prophets"},
    {"name": "Malachi", "chapters": "4", "category": "Minor Prophets"},
  ];

  final List<Map<String, String>> newTestamentBooks = [
    {"name": "Matthew", "chapters": "28", "category": "Gospels"},
    {"name": "Mark", "chapters": "16", "category": "Gospels"},
    {"name": "Luke", "chapters": "24", "category": "Gospels"},
    {"name": "John", "chapters": "21", "category": "Gospels"},
    {"name": "Acts", "chapters": "28", "category": "History"},
    {"name": "Romans", "chapters": "16", "category": "Paul's Letters"},
    {"name": "1 Corinthians", "chapters": "16", "category": "Paul's Letters"},
    {"name": "2 Corinthians", "chapters": "13", "category": "Paul's Letters"},
    {"name": "Galatians", "chapters": "6", "category": "Paul's Letters"},
    {"name": "Ephesians", "chapters": "6", "category": "Paul's Letters"},
    {"name": "Philippians", "chapters": "4", "category": "Paul's Letters"},
    {"name": "Colossians", "chapters": "4", "category": "Paul's Letters"},
    {"name": "1 Thessalonians", "chapters": "5", "category": "Paul's Letters"},
    {"name": "2 Thessalonians", "chapters": "3", "category": "Paul's Letters"},
    {"name": "1 Timothy", "chapters": "6", "category": "Paul's Letters"},
    {"name": "2 Timothy", "chapters": "4", "category": "Paul's Letters"},
    {"name": "Titus", "chapters": "3", "category": "Paul's Letters"},
    {"name": "Philemon", "chapters": "1", "category": "Paul's Letters"},
    {"name": "Hebrews", "chapters": "13", "category": "General Letters"},
    {"name": "James", "chapters": "5", "category": "General Letters"},
    {"name": "1 Peter", "chapters": "5", "category": "General Letters"},
    {"name": "2 Peter", "chapters": "3", "category": "General Letters"},
    {"name": "1 John", "chapters": "5", "category": "General Letters"},
    {"name": "2 John", "chapters": "1", "category": "General Letters"},
    {"name": "3 John", "chapters": "1", "category": "General Letters"},
    {"name": "Jude", "chapters": "1", "category": "General Letters"},
    {"name": "Revelation", "chapters": "22", "category": "Prophecy"},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab == "New Testament" ? 1 : 0,
    );
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
        title: Text(
          'Biblical Books',
          style: AppTextStyles.h4.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          tabs: const [
            Tab(text: 'Old Testament'),
            Tab(text: 'New Testament'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBooksTab(oldTestamentBooks, "Old Testament"),
          _buildBooksTab(newTestamentBooks, "New Testament"),
        ],
      ),
    );
  }

  Widget _buildBooksTab(List<Map<String, String>> books, String testament) {
    // Group books by category
    Map<String, List<Map<String, String>>> groupedBooks = {};
    for (var book in books) {
      String category = book['category']!;
      if (!groupedBooks.containsKey(category)) {
        groupedBooks[category] = [];
      }
      groupedBooks[category]!.add(book);
    }

    // Determine colors based on testament
    final gradientColors = testament == "Old Testament"
        ? [AppColors.primaryPurple, AppColors.primaryPurpleDark]
        : [AppColors.primaryBlue, AppColors.primaryBlueDark];
    
    final primaryColor = testament == "Old Testament"
        ? AppColors.primaryPurple
        : AppColors.primaryBlue;
    
    final categoryColor = testament == "Old Testament"
        ? AppColors.primaryPurpleDark
        : AppColors.primaryBlueDark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Stats
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        testament,
                        style: AppTextStyles.h3.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${books.length} Books",
                        style: AppTextStyles.bodyLarge.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${groupedBooks.keys.length} Categories",
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.menu_book,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // Books by Category
          ...groupedBooks.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    entry.key,
                    style: AppTextStyles.h5.copyWith(
                      fontWeight: FontWeight.bold,
                      color: categoryColor,
                    ),
                  ),
                ),
                ...entry.value.map((book) => _buildBookCard(book, testament, primaryColor)),
                const SizedBox(height: 16),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book, String testament, Color primaryColor) {
    final cardColor = primaryColor.withOpacity(0.08);
    final textColor = testament == "Old Testament" 
        ? AppColors.primaryPurpleDark 
        : AppColors.primaryBlueDark;
    final iconBgColor = primaryColor.withOpacity(0.15);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor.withOpacity(0.2),
        ),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            Icons.book,
            color: textColor,
            size: 24,
          ),
        ),
        title: Text(
          book['name']!,
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          "${book['chapters']} chapters",
          style: AppTextStyles.bodySmall.copyWith(
            color: textColor.withOpacity(0.7),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            "Read",
            style: AppTextStyles.label.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          // Navigate to book reading screen
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Opening ${book['name']}..."),
              duration: const Duration(seconds: 2),
              backgroundColor: primaryColor,
            ),
          );
        },
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class TestamentBooksScreen extends StatefulWidget {
//   final String initialTab; // "Old Testament" or "New Testament"
  
//   const TestamentBooksScreen({
//     super.key,
//     this.initialTab = "Old Testament",
//   });

//   @override
//   State<TestamentBooksScreen> createState() => _TestamentBooksScreenState();
// }

// class _TestamentBooksScreenState extends State<TestamentBooksScreen>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   final List<Map<String, String>> oldTestamentBooks = [
//     {"name": "Genesis", "chapters": "50", "category": "Law"},
//     {"name": "Exodus", "chapters": "40", "category": "Law"},
//     {"name": "Leviticus", "chapters": "27", "category": "Law"},
//     {"name": "Numbers", "chapters": "36", "category": "Law"},
//     {"name": "Deuteronomy", "chapters": "34", "category": "Law"},
//     {"name": "Joshua", "chapters": "24", "category": "History"},
//     {"name": "Judges", "chapters": "21", "category": "History"},
//     {"name": "Ruth", "chapters": "4", "category": "History"},
//     {"name": "1 Samuel", "chapters": "31", "category": "History"},
//     {"name": "2 Samuel", "chapters": "24", "category": "History"},
//     {"name": "1 Kings", "chapters": "22", "category": "History"},
//     {"name": "2 Kings", "chapters": "25", "category": "History"},
//     {"name": "1 Chronicles", "chapters": "29", "category": "History"},
//     {"name": "2 Chronicles", "chapters": "36", "category": "History"},
//     {"name": "Ezra", "chapters": "10", "category": "History"},
//     {"name": "Nehemiah", "chapters": "13", "category": "History"},
//     {"name": "Esther", "chapters": "10", "category": "History"},
//     {"name": "Job", "chapters": "42", "category": "Wisdom"},
//     {"name": "Psalms", "chapters": "150", "category": "Wisdom"},
//     {"name": "Proverbs", "chapters": "31", "category": "Wisdom"},
//     {"name": "Ecclesiastes", "chapters": "12", "category": "Wisdom"},
//     {"name": "Song of Songs", "chapters": "8", "category": "Wisdom"},
//     {"name": "Isaiah", "chapters": "66", "category": "Major Prophets"},
//     {"name": "Jeremiah", "chapters": "52", "category": "Major Prophets"},
//     {"name": "Lamentations", "chapters": "5", "category": "Major Prophets"},
//     {"name": "Ezekiel", "chapters": "48", "category": "Major Prophets"},
//     {"name": "Daniel", "chapters": "12", "category": "Major Prophets"},
//     {"name": "Hosea", "chapters": "14", "category": "Minor Prophets"},
//     {"name": "Joel", "chapters": "3", "category": "Minor Prophets"},
//     {"name": "Amos", "chapters": "9", "category": "Minor Prophets"},
//     {"name": "Obadiah", "chapters": "1", "category": "Minor Prophets"},
//     {"name": "Jonah", "chapters": "4", "category": "Minor Prophets"},
//     {"name": "Micah", "chapters": "7", "category": "Minor Prophets"},
//     {"name": "Nahum", "chapters": "3", "category": "Minor Prophets"},
//     {"name": "Habakkuk", "chapters": "3", "category": "Minor Prophets"},
//     {"name": "Zephaniah", "chapters": "3", "category": "Minor Prophets"},
//     {"name": "Haggai", "chapters": "2", "category": "Minor Prophets"},
//     {"name": "Zechariah", "chapters": "14", "category": "Minor Prophets"},
//     {"name": "Malachi", "chapters": "4", "category": "Minor Prophets"},
//   ];

//   final List<Map<String, String>> newTestamentBooks = [
//     {"name": "Matthew", "chapters": "28", "category": "Gospels"},
//     {"name": "Mark", "chapters": "16", "category": "Gospels"},
//     {"name": "Luke", "chapters": "24", "category": "Gospels"},
//     {"name": "John", "chapters": "21", "category": "Gospels"},
//     {"name": "Acts", "chapters": "28", "category": "History"},
//     {"name": "Romans", "chapters": "16", "category": "Paul's Letters"},
//     {"name": "1 Corinthians", "chapters": "16", "category": "Paul's Letters"},
//     {"name": "2 Corinthians", "chapters": "13", "category": "Paul's Letters"},
//     {"name": "Galatians", "chapters": "6", "category": "Paul's Letters"},
//     {"name": "Ephesians", "chapters": "6", "category": "Paul's Letters"},
//     {"name": "Philippians", "chapters": "4", "category": "Paul's Letters"},
//     {"name": "Colossians", "chapters": "4", "category": "Paul's Letters"},
//     {"name": "1 Thessalonians", "chapters": "5", "category": "Paul's Letters"},
//     {"name": "2 Thessalonians", "chapters": "3", "category": "Paul's Letters"},
//     {"name": "1 Timothy", "chapters": "6", "category": "Paul's Letters"},
//     {"name": "2 Timothy", "chapters": "4", "category": "Paul's Letters"},
//     {"name": "Titus", "chapters": "3", "category": "Paul's Letters"},
//     {"name": "Philemon", "chapters": "1", "category": "Paul's Letters"},
//     {"name": "Hebrews", "chapters": "13", "category": "General Letters"},
//     {"name": "James", "chapters": "5", "category": "General Letters"},
//     {"name": "1 Peter", "chapters": "5", "category": "General Letters"},
//     {"name": "2 Peter", "chapters": "3", "category": "General Letters"},
//     {"name": "1 John", "chapters": "5", "category": "General Letters"},
//     {"name": "2 John", "chapters": "1", "category": "General Letters"},
//     {"name": "3 John", "chapters": "1", "category": "General Letters"},
//     {"name": "Jude", "chapters": "1", "category": "General Letters"},
//     {"name": "Revelation", "chapters": "22", "category": "Prophecy"},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(
//       length: 2,
//       vsync: this,
//       initialIndex: widget.initialTab == "New Testament" ? 1 : 0,
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Biblical Books',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//         elevation: 0,
//         bottom: TabBar(
//           controller: _tabController,
//           indicatorColor: Colors.white,
//           labelColor: Colors.white,
//           unselectedLabelColor: Colors.white70,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           tabs: const [
//             Tab(text: 'Old Testament'),
//             Tab(text: 'New Testament'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           _buildBooksTab(oldTestamentBooks, "Old Testament"),
//           _buildBooksTab(newTestamentBooks, "New Testament"),
//         ],
//       ),
//     );
//   }

//   Widget _buildBooksTab(List<Map<String, String>> books, String testament) {
//     // Group books by category
//     Map<String, List<Map<String, String>>> groupedBooks = {};
//     for (var book in books) {
//       String category = book['category']!;
//       if (!groupedBooks.containsKey(category)) {
//         groupedBooks[category] = [];
//       }
//       groupedBooks[category]!.add(book);
//     }

//     return SingleChildScrollView(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Stats
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: testament == "Old Testament" 
//                     ? [Colors.purple.shade600, Colors.purple.shade400]
//                     : [Colors.blue.shade600, Colors.blue.shade400],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(16),
//               boxShadow: [
//                 BoxShadow(
//                   color: (testament == "Old Testament" ? Colors.purple : Colors.blue)
//                       .withOpacity(0.3),
//                   blurRadius: 15,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         testament,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "${books.length} Books",
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "${groupedBooks.keys.length} Categories",
//                         style: const TextStyle(
//                           color: Colors.white70,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white.withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.menu_book,
//                     color: Colors.white,
//                     size: 32,
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Books by Category
//           ...groupedBooks.entries.map((entry) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: Text(
//                     entry.key,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: testament == "Old Testament" 
//                           ? Colors.purple.shade700 
//                           : Colors.blue.shade700,
//                     ),
//                   ),
//                 ),
//                 ...entry.value.map((book) => _buildBookCard(book, testament)),
//                 const SizedBox(height: 16),
//               ],
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookCard(Map<String, String> book, String testament) {
//     Color cardColor = testament == "Old Testament" 
//         ? Colors.purple.shade50 
//         : Colors.blue.shade50;
//     Color textColor = testament == "Old Testament" 
//         ? Colors.purple.shade700 
//         : Colors.blue.shade700;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         color: cardColor,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: (testament == "Old Testament" ? Colors.purple : Colors.blue)
//               .withOpacity(0.2),
//         ),
//       ),
//       child: ListTile(
//         leading: Container(
//           width: 50,
//           height: 50,
//           decoration: BoxDecoration(
//             color: testament == "Old Testament" 
//                 ? Colors.purple.shade100 
//                 : Colors.blue.shade100,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             Icons.book,
//             color: textColor,
//             size: 24,
//           ),
//         ),
//         title: Text(
//           book['name']!,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: textColor,
//             fontSize: 16,
//           ),
//         ),
//         subtitle: Text(
//           "${book['chapters']} chapters",
//           style: TextStyle(
//             color: textColor.withOpacity(0.7),
//           ),
//         ),
//         trailing: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           decoration: BoxDecoration(
//             color: testament == "Old Testament" 
//                 ? Colors.purple.shade600 
//                 : Colors.blue.shade600,
//             borderRadius: BorderRadius.circular(20),
//           ),
//           child: const Text(
//             "Read",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//               fontSize: 12,
//             ),
//           ),
//         ),
//         onTap: () {
//           // Navigate to book reading screen
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text("Opening ${book['name']}..."),
//               duration: const Duration(seconds: 2),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }