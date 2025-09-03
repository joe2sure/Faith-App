// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:church_app/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FaithDashboardScreen extends StatelessWidget {
  const FaithDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        
        title: 'Catholic Faith',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Icon(Icons.notifications),
          ),
           Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          // Welcome Card
          Padding(padding: EdgeInsets.symmetric(horizontal: 16),
          
         child: Container(
         padding: EdgeInsets.all(20),
         decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(22),
         ),
         child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // texts on the left
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to Faith",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Explore Catholic teachings, scriptures and spiritual resources",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  
                  ),
                ),
            
              ],
            ),
          
            ),
         
              Icon(
              Icons.add,
              color: Colors.white,
              size: 24,
            ),
          ],
         )
         ),
          ),

          // Bible & Scripture
          SizedBox(height: 23),
         Padding(
  padding: EdgeInsets.symmetric(horizontal: 17),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text('Bible & Scripture',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
      ),
      Text('View All',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      ), // right-side text; fill later
    ],
  ),
),






// Bible and Scriptures
 

// Bible and Scriptures
SizedBox(height: 15),
CarouselSlider(
  options: CarouselOptions(
    height: 320, // total height
    autoPlay: true, // auto swipe
    autoPlayInterval: Duration(seconds: 4),
    enlargeCenterPage: true,
    viewportFraction: 0.9, // leaves space at the ends
    enableInfiniteScroll: true,
  ),
  items: [
    // Card 1
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/Image_fx (1).jpg",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Bible Reading",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Today`s Scripture",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Mathew 13: 1-23 - The Parable of the Sower",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.bookmark_border, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Save", style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 20),
                  Icon(Icons.share, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Share", style: TextStyle(color: Colors.grey)),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                    ),
                    child: const Text(
                      "Read Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),

    // Card 2
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/Image_fx (1).jpg",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Bible Reading",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Today`s Scripture",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "John 3:16 - For God so loved the world...",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.bookmark_border, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Save", style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 20),
                  Icon(Icons.share, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Share", style: TextStyle(color: Colors.grey)),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                    ),
                    child: const Text(
                      "Read Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),

    // Card 3
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  child: Image.asset(
                    "assets/images/Image_fx (1).jpg",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Daily Bible Reading",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Today`s Scripture",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          shadows: [
                            Shadow(blurRadius: 3, color: Colors.black),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Psalm 23 - The Lord is my Shepherd",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.bookmark_border, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Save", style: TextStyle(color: Colors.grey)),
                  SizedBox(width: 20),
                  Icon(Icons.share, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("Share", style: TextStyle(color: Colors.grey)),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                    ),
                    child: const Text(
                      "Read Now",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  ],
),









   
        

// Old testament and New testament 
    SizedBox(height: 20),
   // ...existing code...
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Old Testament Card
    Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Image_fx (4).jpg",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 6),
          const Text(
            "Old Testament",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "39 Books",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
    // New Testament Card
    Container(
      width: 170,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Image_fx (4).jpg",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          const Text(
            "New Testament",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "27 Books",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  ],
),
// ...existing code...








      // Catholic Teachings
          SizedBox(height: 24),
         Padding(
  padding: EdgeInsets.symmetric(horizontal: 17),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text('Catholic Teachings',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
      ),
      Text('Explore',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      ), // right-side text; fill later
    ],
  ),
),





// catechism
SizedBox(height: 14),
// After your SizedBox widget, add this:
// After your SizedBox widget, add this:
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0), // space at the ends
  child: Wrap(
    spacing: 16, // space between items (horizontally)
    runSpacing: 16, // space between rows (vertically)
    alignment: WrapAlignment.center, // keep items centered
    children: [
      // 1st container
      Container(
        width: 170, // fixed width
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                "assets/images/Image_fx (1).jpg",
                height: 90, // fixed image height
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Catechism",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Core Teachings",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 2nd container
      Container(
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                "assets/images/Image_fx (1).jpg",
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Encyclicals",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Papal Letters",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 3rd container
      Container(
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                "assets/images/Image_fx (1).jpg",
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Church Documents",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Official Texts",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 4th container
      Container(
        width: 170,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                "assets/images/Image_fx (1).jpg",
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Fundamental Beliefs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Core Faith",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                    ),
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












































































   // Saints & Feast Days
          SizedBox(height: 23),
         Padding(
  padding: EdgeInsets.symmetric(horizontal: 17),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text('Saints & Feast Days',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
      ),
      Text('Calendar',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      ), // right-side text; fill later
    ],
  ),
),



// saints & feast days
    SizedBox(height: 15),  
    Padding(padding: EdgeInsets.symmetric(horizontal: 14), // space at the ends  
    child: Card(
      shape: 
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with texts inside
          Stack(
            children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Image.asset(
              "assets/images/Image_fx (1).jpg",
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // texts in the image
          Positioned(
            left: 12,
            bottom: 15,
         
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Saint of the Day",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.white,
                  shadows: [
                    Shadow(blurRadius: 3, color: Colors.black),
                  ],
                
                ),
              ),
              SizedBox(height: 4),
              Text(
                "St. Teresa Benedicta",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                   shadows: [
                    Shadow(blurRadius: 3, color: Colors.black),
                  ],
                ),
              ),
            ],
          ),
          ),
            ]
          ),
          
              Padding(
                padding: EdgeInsets.all(12.0),
              child: Text(
                "Patron Saint of Europe, Philosopher and martyr",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                 // decoration: TextDecoration.underline,
                ),
              ),
              ),
      
          
          
          // bottom row with save, share and button
          Padding(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.calendar_month, size: 20, color: Colors.grey),
              SizedBox(width: 4),
              Text("Aug 9", style: TextStyle(color: Colors.grey)),
              SizedBox(width: 20),
              Icon(Icons.favorite_border, size: 20, color: Colors.grey),
              const SizedBox(width: 4),
              const Text("Pray", style: TextStyle(color: Colors.grey)),
              Spacer(),
              ElevatedButton(onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
              ),
               child: const Text("Read Biography",
               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
               ),
              ),
            ],
          ),
          )
        ],
      ),
    ),
    ),
   
        

// Old testament and New testament 
    SizedBox(height: 20),
   // ...existing code...
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // Old Testament Card
    Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Image_fx (4).jpg",
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 6),
          const Text(
            "Saints Directory",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "500+ Saints",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
    // New Testament Card
    Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Image_fx (4).jpg",
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          const Text(
            "Feast Calendar",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Liturgical Year",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
    Container(
      width: 130,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            "assets/images/Image_fx (4).jpg",
            width: 40,
            height: 40,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 8),
          const Text(
            "Patron Saints",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Finf Your Saint",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ),
  ],
),
// ...existing code...





          // Church Calendar
          const SectionHeader(
            title: 'Church Calendar',
            trailing: 'Full Calendar',
          ),
          // Realtime Calendar Widget
          RoundedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show current month and year dynamically
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
                  child: Text(
                    '${_monthName(DateTime.now().month)} ${DateTime.now().year}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Simple calendar grid for current month
                _SimpleCalendar(),
                const SizedBox(height: 8),
                // Today and upcoming feast days (example, could be dynamic)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Today: ${_todayFeast()}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      const Text('Aug 15 - Assumption of Mary'),
                      const Text('Aug 22 - Queenship of Mary'),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Helper widgets and functions for the calendar
          // Place these outside the build method, e.g. at the bottom of the file:
          const SizedBox(height: 16),































































      // Spiritual Resources
          SizedBox(height: 24),
         Padding(
  padding: EdgeInsets.symmetric(horizontal: 17),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: const [
      Text('Spiritual Resources',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
      ),
      Text('Browse All',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 14,
      ),
      ), // right-side text; fill later
    ],
  ),
),





// catechism
SizedBox(height: 14),
// After your SizedBox widget, add this:
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0), // space at the ends
  child: Wrap(
    spacing: 16, // space between items (horizontally)
    runSpacing: 16, // space between rows (vertically)
    alignment: WrapAlignment.center, // keep items centered
    children: [
      // 1st container
      Container(
        width: 170,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/Image_fx (1).jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Prayer Collection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Traditional Prayers",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),

      // 2nd container
      Container(
        width: 170,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/Image_fx (1).jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Meditation Guides",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Spiritual Practice",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),

      // 3rd container
      Container(
        width: 170,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/Image_fx (1).jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Spiritual Articles",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Faith Insights",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),

      // 4th container
      Container(
        width: 170,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/Image_fx (1).jpg",
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Study Materials",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Learning Resources",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    ],
  ),
),
          // // Spiritual Resources
          // const SectionHeader(
          //   title: 'Spiritual Resources',
          //   trailing: 'View All',
          // ),
          // GridView.count(
          //   crossAxisCount: 2,
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   crossAxisSpacing: 0,
          //   mainAxisSpacing: 0,
          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          //   children: const [
          //     _MiniCard(
          //       title: 'Prayer Collection',
          //       count: 'Traditional Prayers',
          //     ),
          //     _MiniCard(title: 'Meditation Guides', count: 'Daily Reflections'),
          //     _MiniCard(title: 'Spiritual Articles', count: 'Inspiring Reads'),
          //     _MiniCard(title: 'Study Materials', count: 'Learning Resources'),
          //   ],
          // ),
          // const SizedBox(height: 16),

          // // Daily Reflection
          // QuoteCard(),




          SizedBox(height: 20),

// Daily Reflection Container with padding
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0), // space at the ends
  child: Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber[200], // light background
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circle with icon
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.amber[600], // yellow background
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.lightbulb, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 12),

        // Text part
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Daily Reflection",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "\"Faith is taking the first step even when you don’t see the whole staircase. Trust in God’s plan and walk forward with courage.\"",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "— Reflection for Today",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
),

        ],
      ),
    );
  }
}



















class _SimpleCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday; // 1=Mon, 7=Sun

    // Build a list of day numbers, with leading blanks for the first week
    final List<Widget> dayWidgets = [];
    for (int i = 1; i < firstWeekday; i++) {
      dayWidgets.add(const SizedBox());
    }
    for (int day = 1; day <= daysInMonth; day++) {
      final isToday = day == now.day;
      dayWidgets.add(
        Container(
          margin: const EdgeInsets.all(2),
          decoration:
              isToday
                  ? BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  )
                  : null,
          child: Center(
            child: Text(
              '$day',
              style: TextStyle(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? Colors.blue : Colors.black,
              ),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          // Weekday headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Mon',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Tue',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Wed',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Thu',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Fri',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Sat',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                'Sun',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Calendar grid
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1.2,
            children: dayWidgets,
          ),
        ],
      ),
    );
  }
}

// (If you want, you can move them to a separate file for cleanliness)
String _monthName(int month) {
  const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return months[month - 1];
}

String _todayFeast() {
  // In a real app, lookup today's feast from a data source.
  // For demo, return a placeholder.
  final now = DateTime.now();
  if (now.month == 8 && now.day == 9) return 'St. Teresa Benedicta';
  if (now.month == 8 && now.day == 15) return 'Assumption of Mary';
  if (now.month == 8 && now.day == 22) return 'Queenship of Mary';
  return 'Ordinary Time';
}

class _ThreeMiniTilesRow extends StatelessWidget {
  const _ThreeMiniTilesRow();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder:
            (context, i) => Container(
              width: 160,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    // ignore: duplicate_ignore
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.network(
                        'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80', // quiz/brain

                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          'Daily Challenge',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'bible Stories',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300),
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
}

class _TwoGameTilesRow extends StatelessWidget {
  const _TwoGameTilesRow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: _GameTile(
              title: 'Scripture Word Search',
              subtitle: 'find hidden biblical words',
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _GameTile(
              title: 'Catholic Crosswords',
              subtitle: 'faith-based word puzzles',
            ),
          ),
        ],
      ),
    );
  }
}

class _GameTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const _GameTile({required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: AspectRatio(
              aspectRatio: 16 / 10,
              child: Image.network(randomPhoto(800, 500), fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}




















































// class QuickGrid extends StatelessWidget {
//   const QuickGrid({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       ('Divine Mercy', Icons.favorite_border, '3:00 PM Prayer,', Colors.red),
//       ('Angelus', Icons.timelapse, '12:00 PM Prayer', const Color(0xFF0D2856)),
//       (
//         'Light Candle',
//         Icons.emoji_objects_outlined,
//         'Virtual Prayer',
//         Colors.yellow,
//       ),
//       ('Prayer Circle', Icons.groups_outlined, 'Join Community', Colors.green),
//     ];
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           childAspectRatio: 1.7,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, i) {
//           final it = items[i];
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.zero,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: (it.$4).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: Icon(it.$2, size: 28, color: it.$4),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   it.$1,
//                   style: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(it.$3, style: const TextStyle(color: Colors.black54)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



// class _MiniCard extends StatelessWidget {
//   final String title;
//   final String count;
//   const _MiniCard({required this.title, required this.count});

//   @override
//   Widget build(BuildContext context) {
//     // Use a random image for each card (replace with your own image logic if needed)
//     final imageUrl = randomPhoto(120, 120);

//     return RoundedCard(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: Image.network(
//               imageUrl,
//               width: 40,
//               height: 40,
//               fit: BoxFit.cover,
//               errorBuilder:
//                   (context, error, stackTrace) => const Icon(
//                     Icons.image_not_supported,
//                     size: 40,
//                     color: Colors.grey,
//                   ),
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
//           const SizedBox(height: 4),
//           Text(
//             count,
//             style: const TextStyle(color: Colors.black54, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuoteCard extends StatelessWidget {
//   const QuoteCard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return RoundedCard(
//       color: const Color(0xFFFFF5D7),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CircleAvatar(
//             backgroundColor: Color(0xFFFFE39A),
//             child: Icon(Icons.wb_sunny_outlined, color: Color(0xFF0D2856)),
//           ),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Daily Reflection",
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xFF0D2856),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Take a moment today to pause and reflect on God's presence in your life. Consider how you can bring kindness and hope to those around you, and trust that each small act of love makes a difference.",
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 15,
//                     fontStyle: FontStyle.italic,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF1D2433),
//                     height: 1.5,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   '— Pope Benedict XVI',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF0D2856),
//                     letterSpacing: 0.2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _PrayerStreakCard extends StatelessWidget {
//   const _PrayerStreakCard();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF0D2856), Color.fromARGB(255, 18, 63, 148)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(18),
//         child: Row(
//           children: [
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Prayer Streak',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       Icon(Icons.add_to_photos, color: Colors.white, size: 40),
//                     ],
//                   ),

//                   SizedBox(height: 6),
//                   Text(
//                     '27 days in a row',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

















































































































// import 'package:church_app/widgets/constants.dart';
// import 'package:flutter/material.dart';

// class FaithDashboardScreen extends StatelessWidget {
//   const FaithDashboardScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const AppTopBar(
//         title: 'Daily Devotionals',
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 8),
//             child: Icon(Icons.search),
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(Icons.notifications_none),
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(bottom: 24),
//         children: [
//           const SizedBox(height: 12),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Todays Date',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0D2856),
//                 ),
//               ),
//               Text(
//                 'Friday,August 9,2025',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF0D2856),
//                 ),
//               ),
//               Text(
//                 'Fest of St. Teresa Benedicta',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.orange,
//                 ),
//               ),
//             ],
//           ),

//           _PrayerStreakCard(),
//           const SectionHeader(title: "Today's Devotions"),
//           DevotionTile(
//             title: 'Mass Readings',
//             subtitle: "Today's Scripture",
//             imageUrl: randomPhoto(1200, 700),
//             actionLabel: 'Read Now',
//           ),
//           DevotionTile(
//             title: 'Divine Office',
//             subtitle: 'Morning Prayer',
//             imageUrl: randomPhoto(1200, 700),
//             actionLabel: 'Pray Now',
//           ),
//           DevotionTile(
//             title: 'Interactive Rosary',
//             subtitle: 'Joyful Mysteries',
//             imageUrl: randomPhoto(1200, 700),
//             progress: 0.6,
//             actionLabel: 'Resume',
//           ),
//           const SectionHeader(title: 'Quick Prayers'),
//           const QuickGrid(),
//           SizedBox(height: 16),
//           const QuoteCard(),
//           SizedBox(height: 16),
//           const VirtualCandles(),
//           const SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }

// class _PrayerStreakCard extends StatelessWidget {
//   const _PrayerStreakCard();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [Color(0xFF0D2856), Color.fromARGB(255, 18, 63, 148)],
//           ),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         padding: const EdgeInsets.all(18),
//         child: Row(
//           children: [
//             const SizedBox(width: 12),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         'Prayer Streak',
//                         style: TextStyle(color: Colors.white, fontSize: 18),
//                       ),
//                       const Icon(
//                         Icons.local_fire_department,
//                         color: Color.fromARGB(255, 225, 88, 14),
//                         size: 40,
//                       ),
//                     ],
//                   ),

//                   SizedBox(height: 6),
//                   Text(
//                     '27 days in a row',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SectionHeader extends StatelessWidget {
//   final String title;
//   final String? trailing;
//   const SectionHeader({super.key, required this.title, this.trailing});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF1D2433),
//             ),
//           ),
//           const Spacer(),
//           if (trailing != null)
//             Text(
//               trailing!,
//               style: const TextStyle(
//                 fontWeight: FontWeight.w600,
//                 color: Color(0xFF1E63FF),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class DevotionTile extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String imageUrl;
//   final double? progress;
//   final String actionLabel;
//   const DevotionTile({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.imageUrl,
//     this.progress,
//     required this.actionLabel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return RoundedCard(
//       padding: EdgeInsets.zero,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//             child: AspectRatio(
//               aspectRatio: 16 / 5,
//               child: Image.network(imageUrl, fit: BoxFit.cover),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(subtitle, style: const TextStyle(color: Colors.black54)),
//                 const SizedBox(height: 12),
//                 if (progress != null) ...[
//                   LinearProgressIndicator(
//                     value: progress,
//                     minHeight: 8,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   const SizedBox(height: 12),
//                 ],
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Material(
//                           color: const Color(0xFF0D2856).withOpacity(0.2),
//                           shape: const CircleBorder(),
//                           child: InkWell(
//                             customBorder: const CircleBorder(),
//                             onTap: () {},
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Icon(
//                                 Icons.play_arrow,
//                                 color: Color(0xFF0D2856),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 3),
//                         const Text('Listen'),
//                       ],
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},

//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF0D2856),
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         textStyle: const TextStyle(fontWeight: FontWeight.w600),
//                       ),
//                       child: Text('Read Now'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class QuickGrid extends StatelessWidget {
//   const QuickGrid({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       ('Divine Mercy', Icons.favorite_border, '3:00 PM Prayer,', Colors.red),
//       ('Angelus', Icons.timelapse, '12:00 PM Prayer', const Color(0xFF0D2856)),
//       (
//         'Light Candle',
//         Icons.emoji_objects_outlined,
//         'Virtual Prayer',
//         Colors.yellow,
//       ),
//       ('Prayer Circle', Icons.groups_outlined, 'Join Community', Colors.green),
//     ];
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           childAspectRatio: 1.7,
//         ),
//         itemCount: items.length,
//         itemBuilder: (context, i) {
//           final it = items[i];
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.08),
//                   blurRadius: 8,
//                   offset: Offset(0, 4),
//                 ),
//               ],
//             ),
//             margin: EdgeInsets.zero,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: (it.$4 as Color).withOpacity(0.2),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   padding: const EdgeInsets.all(8),
//                   child: Icon(it.$2, size: 28, color: it.$4 as Color),
//                 ),
//                 const SizedBox(height: 8),
//                 Text(
//                   it.$1,
//                   style: const TextStyle(fontWeight: FontWeight.w700),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(it.$3, style: const TextStyle(color: Colors.black54)),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class QuoteCard extends StatelessWidget {
//   const QuoteCard({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return RoundedCard(
//       color: const Color(0xFFFFF5D7),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const CircleAvatar(
//             backgroundColor: Color(0xFFFFE39A),
//             child: Icon(Icons.format_quote, color: Color(0xFF0D2856)),
//           ),
//           const SizedBox(width: 16),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   '"The world offers you comfort, but you were not made for comfort. You were made for greatness."',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 18,
//                     fontStyle: FontStyle.italic,
//                     fontWeight: FontWeight.w500,
//                     color: Color(0xFF1D2433),
//                     height: 1.5,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   '— Pope Benedict XVI',
//                   style: TextStyle(
//                     fontFamily: 'Montserrat',
//                     fontSize: 15,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF0D2856),
//                     letterSpacing: 0.2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VirtualCandles extends StatelessWidget {
//   const VirtualCandles({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final labels = ['Peace', 'Healing', 'Family', 'Hope', 'Love'];
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SectionHeader(title: 'Virtual Candles', trailing: '47 lit today'),
//         RoundedCard(
//           child: Column(
//             children: [
//               Wrap(
//                 alignment: WrapAlignment.spaceAround,
//                 spacing: 18,
//                 runSpacing: 12,
//                 children: [
//                   for (final l in labels)
//                     Column(
//                       children: [
//                         const Icon(
//                           Icons.emoji_objects,
//                           size: 36,
//                           color: Color(0xFFFFB74D),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(l),
//                       ],
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFD6B259),
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 14),
//                   ),
//                   onPressed: () {},
//                   child: const Text(
//                     'Light a Candle',
//                     style: TextStyle(fontWeight: FontWeight.w700),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
