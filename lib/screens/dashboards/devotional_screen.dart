// ignore_for_file: deprecated_member_use

import 'package:church_app/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glass/glass.dart';

class DevotionalsScreen extends StatelessWidget {
  const DevotionalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        //backgroundColor: Colors.pink,
        body: SingleChildScrollView(
            // padding: EdgeInsets.only(bottom: 500),
            child: Column(children: [
          // First Container
          Container(
            height: 270,
            padding: const EdgeInsets.all(16),
            color: Colors.blue,
            child: Column(
              children: [
                // Top Row: Avatar and Texts
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        const CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.church, color: Colors.blue, size: 30),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "St Micheal's",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0),
                        Text(
                          "Parish",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Daily Devotional",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 0),
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Right side: Current time texts at top right
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        SizedBox(height: 10),
                        Text(
                          "Current Time",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "12:39:22",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "PM",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                // Glassmorphism Container at the bottom
                Center(
                  child: Container(
                    width: 340,
                    height: 120,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        // Left side texts
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Wednesday, September 3",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "2025",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Oridinary Time - Week 32",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Right side texts with custom spacing
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 13),
                            const Text(
                              "Liturgical",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            const SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18), // Move second text right
                              child: const Text(
                                "Color",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: const [
                                Icon(Icons.circle,
                                    color: Colors.green, size: 10),
                                SizedBox(width: 6),
                                Text(
                                  "Green",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).asGlass(
                    tintColor: Colors.white.withOpacity(0.3),
                    clipBorderRadius: BorderRadius.circular(12),
                    blurX: 20,
                    blurY: 20,
                  ),
                ),
              ],
            ),
          ),

// First Container
          const SizedBox(height: 20),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 18), // space at the ends
            child: Container(
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Left side: Location icon and texts
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.location_on,
                          color: Colors.red, size: 25),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Chicago, IL",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Archdiocese of Chicago",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Right side: Sun icon and texts
                  Row(
                    children: [
                      const Icon(Icons.wb_sunny,
                          color: Colors.orange, size: 25),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            " 72\u00B0F",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Sunny",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),

// Second Container
          SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 18), // Space outside container (ends)
            child: Container(
              height: 320,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              // Reduce horizontal padding inside the container for more space for the 3 vertical containers
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Centered Calendar icon and texts
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 18,
                        left: 32,
                        right: 8), // Reduce left/right padding
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.calendar_today,
                            color: Colors.blue, size: 28),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Today's Mass Schedule",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 0),
                            Text(
                              "St. Micheal`s Catholic Church",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10), // Reduce vertical space
                  // Middle: 3 vertical containers with centered text
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2), // Reduce horizontal padding inside
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First vertical container
                        Container(
                          height: 125,
                          width: 88, // Slightly wider for better fit
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4), // Reduce inner padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("6:30",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("AM",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Daily Mass",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Fr.",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Martinez",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 15), // Less space between containers
                        // Second vertical container
                        Container(
                          height: 125,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("12:00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("PM",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Noon",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Mass",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Fr.",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("O Connor",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Third vertical container
                        Container(
                          height: 125,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.purple[50],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("6:00",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("PM",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Evening",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Mass",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Fr",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Johnson",
                                  style: TextStyle(fontSize: 10),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  // Bottom: Note and schedule in a container
                  Center(
                    child: Container(
                      width: 294,
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_rounded,
                              color: Colors.redAccent, size: 20),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Confession available 30 minutes",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 0),
                              Text(
                                "before each Mass",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

// Third Container
          const SizedBox(height: 30),

          // 🔹 Main Container
          Container(
              height: 760,
              margin: const EdgeInsets.symmetric(
                  horizontal: 16), // space from screen edges
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 🔹 Image with content overlay
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/Image_fx (1).jpg"), // your image
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16)),
                        color: Colors.black
                            .withOpacity(0.5), // dark overlay for readability
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row: Daily Scripture + Day
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Move Daily Scripture down and right
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      Icon(Icons.menu_book,
                                          color: Colors.white),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Daily Scripture",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Move Day 287 down and left
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, right: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.brown.shade700,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "Day 287",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Bottom Row: Verse + Progress
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Move Jeremiah and Old Testament up and right
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jeremiah 29:11",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Old Testament • Prophet",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Progress: Add text above 87%, move left and up
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, right: 5, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Reading Progress",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "87%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // ...existing code...

                  const SizedBox(height: 16),

                  // 🔹 4-line Quote Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "“For I know the plans I have for you,\n  "
                      "declares the Lord, plans for welfare\n "
                      "and not for evil, to give you a future\n and a hope.”",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue.shade700,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0),
                    child: Text(
                      "- Jeremiah 29:11",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blue.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔹 Bulb Container
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 26),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.lightbulb, color: Colors.amber.shade700),
                            const SizedBox(width: 5),
                            Text(
                              "Context",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "This verse was spoken to the isrealites\n"
                          "during their exile in babylon, offering\n"
                          "hope during a dark period of their\n"
                          "history.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16), // Reduce vertical space
                  // Middle: 3 vertical containers with centered text
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 2), // Reduce horizontal padding inside
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First vertical container
                        Container(
                          height: 75,
                          width: 88, // Slightly wider for better fit
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 4), // Reduce inner padding
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("6",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("This Week",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.green),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Less space between containers
                        // Second vertical container
                        Container(
                          height: 75,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("23",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Day Streak",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.deepPurple),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Third vertical container
                        Container(
                          height: 75,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.redAccent[50],
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text("98%",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 2),
                              Text("Year Goal",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.red),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 19),
                  // Bottom: Note and schedule in a container
                  Center(
                    child: Container(
                      width: 306,
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // center all items
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.book,
                              color: Colors.white, size: 22), // book icon
                          SizedBox(width: 8),
                          Text(
                            "Read Full Reflection",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.keyboard_arrow_down,
                              color: Colors.white, size: 22), // arrow
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 25),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.center, // center containers
                        children: [
                          // Save Container
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(77, 233, 228, 228),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.bookmark_border,
                                    size: 20, color: Colors.black),
                                SizedBox(width: 4),
                                Text("Save",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          //  SizedBox(width: 12),

                          // Share Container
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(77, 233, 228, 228),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.share,
                                    size: 20, color: Colors.black),
                                SizedBox(width: 4),
                                Text("Share",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                          SizedBox(width: 12),

                          // Discuss Container
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 11),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                Icon(Icons.chat_bubble_outline,
                                    size: 20, color: Colors.blue),
                                SizedBox(width: 4),
                                Text("Discuss",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),

// Fourth Container
          SizedBox(height: 20), // Your SizedBox before the container
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 740,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  // Main content
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Top Row: Image + Texts ---
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          Container(
                            width: 83,
                            height: 85,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/teresa.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Saint texts
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Saint Teresa of\nAvila",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Doctor of the Church, Mystic,\nReformer",
                                  style: TextStyle(fontSize: 13),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  "Feast Day: October   (1515-\n15                          1582)",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // --- Daily Inspiration Section ---
                      Container(
                        height: 140,
                        width: double.infinity,
                        //margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 195, 195),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily Inspiration",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "\"Let nothing disturb you, All things pass.\nGod does not change. Patience obtains\nall things. Whoever has God lacks\nnothing: God alone suffices.\"",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 241, 78, 70)),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // --- Patron Saint Section ---
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 220,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header with Icon + Text
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.star,
                                      size: 20, color: Colors.orange),
                                  SizedBox(width: 6),
                                  Text(
                                    "Patron Saint of:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // First Row of Tags (Sick People + New Tag)
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Spain",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.teal.shade100,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Text(
                                      "Writers",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Second Row of Tags (Religious Orders)
                              Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Headache Sufferers",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 0),
                              // Third Row of Tags (Spain)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "People in Religious Orders",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              SizedBox(height: 7),
                              // Third Row of Tags (Spain)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Sick People",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 19),
                      // Bottom: Note and schedule in a container
                      Center(
                        child: Container(
                          width: 306,
                          height: 55,
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // center all items
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Icon(Icons.person,
                                  color: Colors.white, size: 22), // book icon
                              SizedBox(width: 8),
                              Text(
                                "Read Full Biography",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.keyboard_arrow_down,
                                  color: Colors.white, size: 22), // arrow
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center, // center containers
                            children: [
                              // Save Container
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    FaIcon(FontAwesomeIcons.calendar,
                                        size: 20, color: Colors.black),
                                    SizedBox(width: 4),
                                    Text("Set\nReminder",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                              //  SizedBox(width: 12),

                              // Share Container
                              Container(
                                height: 65,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: const [
                                    Icon(Icons.share,
                                        size: 20, color: Colors.blue),
                                    SizedBox(width: 4),
                                    Text("Share",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12),

                              // Discuss Container
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 9),
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    FaIcon(FontAwesomeIcons.bookOpen,
                                        size: 20, color: Colors.purple),
                                    SizedBox(width: 4),
                                    Text("Learn\nMore",
                                        style: TextStyle(
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // 👉 Add your next container here
                      // Example:
                      // Container(
                      //   margin: const EdgeInsets.only(top: 16),
                      //   padding: const EdgeInsets.all(12),
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: const Text("Another Section Here"),
                      // ),
                    ],
                  ),

                  // --- Love icon back to top-right ---
                  Positioned(
                    top: 15,
                    right: 25,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite,
                          color: Colors.red, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ),

// Fifth Container
          const SizedBox(height: 30),

          // 🔹 Main Container
          Container(
            height: 820,
            margin: const EdgeInsets.symmetric(
                horizontal: 16), // space from screen edges
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: [
              // 🔹 Image with content overlay
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/Image_fx (1).jpg"), // your image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.black
                        .withOpacity(0.5), // dark overlay for readability
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row: Daily Scripture + Day
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Move Daily Scripture down and right
                            Padding(
                              padding: const EdgeInsets.only(top: 10, left: 5),
                              child: Row(
                                children: [
                                  Icon(Icons.timer, color: Colors.white),
                                  const SizedBox(width: 6),
                                  Text(
                                    "Prayer Timer",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Move Day 287 down and left
                            Padding(
                              padding: const EdgeInsets.only(top: 12, right: 5),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.brown.shade700,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "General Prayer",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Bottom Row: Verse + Progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Move Jeremiah and Old Testament up and right
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today`s progress",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "47 minutes",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Progress: Add text above 87%, move left and up
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0, right: 5, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Sessions",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "3",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // ...existing code...

              const SizedBox(height: 30),

// 🔹 Weekly Goal Progress Container
              Container(
                width: 310,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Weekly Goal Progress",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 15),
                        ),
                        Text(
                          "90%",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    LinearProgressIndicator(
                      value: 0.9,
                      color: Colors.green.shade700,
                      backgroundColor: Colors.green.shade200,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("180 minutes",
                            style:
                                TextStyle(color: Colors.green, fontSize: 13)),
                        Text("210 minutes goal",
                            style:
                                TextStyle(color: Colors.green, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

// 🔹 Timer Circle Container
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue.shade700, width: 8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "15:00",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        "15 min session",
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        "General Prayer",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 19),

// 🔹 Start Prayer & Reset Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(19),
                      ),
                    ),
                    child: Text("Start Prayer",
                        style: TextStyle(fontSize: 15, color: Colors.white)),
                  ),
                  const SizedBox(width: 16),
                  // Reset container
                  GestureDetector(
                    onTap: () {
                      // Add your reset logic here
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 23, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50, // background color
                        borderRadius: BorderRadius.circular(19),
                        //border: Border.all(color: Colors.red), // optional border
                      ),
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16), // Reduce vertical space
              // Middle: 3 vertical containers with centered text
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 2), // Reduce horizontal padding inside
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // First vertical container
                    Container(
                      height: 75,
                      width: 88, // Slightly wider for better fit
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4), // Reduce inner padding
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("47m",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                              textAlign: TextAlign.center),
                          SizedBox(height: 2),
                          Text("Today",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.green),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20), // Less space between containers
                    // Second vertical container
                    Container(
                      height: 75,
                      width: 88,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("20m",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                              textAlign: TextAlign.center),
                          SizedBox(height: 2),
                          Text("Longest",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.deepPurple),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    // Third vertical container
                    Container(
                      height: 75,
                      width: 88,
                      decoration: BoxDecoration(
                        color: Colors.redAccent[50],
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text("23",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                              textAlign: TextAlign.center),
                          SizedBox(height: 2),
                          Text("Day Streak",
                              style: TextStyle(fontSize: 13, color: Colors.red),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

// 🔹 Settings & History Containers
              Container(
                width: 310,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue), // optional border
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.slideshare,
                            size: 20, color: Colors.blue),
                        const SizedBox(width: 8),
                        Text(
                          "Timer Settings",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.blue),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: 310,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: Colors.purpleAccent), // optional border

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer, size: 20, color: Colors.purpleAccent),
                        const SizedBox(width: 8),
                        Text(
                          "Prayer History",
                          style: TextStyle(color: Colors.purpleAccent),
                        ),
                      ],
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.purpleAccent),
                  ],
                ),
              ),
            ]),
          ),

// Sixed  Container
          const SizedBox(height: 30),

          // 🔹 Main Container
          Container(
            height: 1600,
            margin: const EdgeInsets.symmetric(
                horizontal: 16), // space from screen edges
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(children: [
              // 🔹 Image with content overlay
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  image: DecorationImage(
                    image: AssetImage(
                        "assets/images/Image_fx (1).jpg"), // your image
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    color: Colors.black
                        .withOpacity(0.5), // dark overlay for readability
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      children: [
                        // 🔹 Existing Column (everything stays the same)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Daily Scripture
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 5),
                                  child: Row(
                                    children: [
                                      FaIcon(FontAwesomeIcons.trophy,
                                          color: Colors.white),
                                      const SizedBox(width: 6),
                                      Text(
                                        "Spiritual Progress",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Day/General Prayer
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 12, right: 5),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.brown.shade700,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      "Level 7",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const Spacer(),

                            // Bottom Row: Verse + Progress
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, left: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Overall progress",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "70%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, right: 5, bottom: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Achievements",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        "3",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // 🔹 New Bottom Center Texts
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 10, left: 21), // adjust if needed
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Current Streak",
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "12 days",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40), // existing SizedBox

// 🔹 Wrap in DefaultTabController
              DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    // 🔹 Styled TabBar
                    Container(
                      width: 310,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6), // space around tabs
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TabBar(
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        indicatorSize: TabBarIndicatorSize
                            .tab, // indicator matches tab size
                        indicatorColor:
                            Colors.transparent, // ✅ removes the underline
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text("Daily",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text("Weekly",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            alignment: Alignment.center,
                            child: const Text("Monthly",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      // ✅ Center the FaIcon
                                      child: FaIcon(
                                        FontAwesomeIcons.handHoldingHeart,
                                        color: Colors.white,
                                        size:
                                            20, // optional: control the icon size
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Prayer Time",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "47 of 60 minutes",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "78%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "12 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.8,
                            color: Colors.blue.shade700,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 23 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "13 minutes remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 208, 208),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      // ✅ Center the FaIcon
                                      child: FaIcon(
                                        FontAwesomeIcons.bookOpen,
                                        color: Colors.white,
                                        size:
                                            20, // optional: control the icon size
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Scripture Reading",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "6 of 7 days",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "86%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "6 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.9,
                            color: Colors.purple.shade700,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 28 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "1 days remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      // ✅ Center the FaIcon
                                      child: FaIcon(
                                        FontAwesomeIcons.slideshare,
                                        color: Colors.white,
                                        size:
                                            20, // optional: control the icon size
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Rosary Prayers",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "4 of 7 rosaries",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "57%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "4 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.5,
                            color: Colors.red,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 15 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "3 rosaries remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    // child: Center( // ✅ Center the FaIcon
                                    //   child: FaIcon(
                                    //     FontAwesomeIcons.bookOpen,
                                    //     color: Colors.white,
                                    //     size: 20, // optional: control the icon size
                                    //   ),
                                    // ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Mass Attendance",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "2 of 3 times",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "67%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "12 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.6,
                            color: Colors.green.shade700,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 8 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "1 times remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.yellow.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    // child: Center( // ✅ Center the FaIcon
                                    //   child: FaIcon(
                                    //     FontAwesomeIcons.bookOpen,
                                    //     color: Colors.white,
                                    //     size: 20, // optional: control the icon size
                                    //   ),
                                    // ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Meditation",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "3 of 5 sessions",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "60%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "12 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.5,
                            color: Colors.yellow.shade700,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 12 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "2 sessions remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

// 🔹 Weekly Goal Progress Container
                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 🔹 Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 🔹 Icon + Left Side Texts
                              Row(
                                children: [
                                  // Small Icon Container
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      // ✅ Center the FaIcon
                                      child: FaIcon(
                                        FontAwesomeIcons.heart,
                                        color: Colors.white,
                                        size:
                                            20, // optional: control the icon size
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Left side 2 lines text
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Acts of Charity",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "5 of 7 acts",
                                        style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              // 🔹 Right side 2 lines text
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: const [
                                  Text(
                                    "71%",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orangeAccent,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    "5 day streak",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          // 🔹 Linear Progress Bar
                          LinearProgressIndicator(
                            value: 0.6,
                            color: Colors.orangeAccent.shade700,
                            backgroundColor: Colors.white70,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          const SizedBox(height: 8),

                          // 🔹 Bottom Row Texts
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Best streak: 10 days",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                              Text(
                                "2 acts remaining",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    Container(
                      width: 310,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 198, 198),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.red), // optional border

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.timer, size: 20, color: Colors.red),
                              const SizedBox(width: 13),
                              Text(
                                "Achievements & Badges",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(Icons.keyboard_arrow_down, color: Colors.red),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
// 🔹 Main Container
                    Container(
                      width: 310,
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
                          // 🔹 Title Row
                          Row(
                            children: const [
                              FaIcon(FontAwesomeIcons.lightbulb,
                                  color: Colors.black, size: 16),
                              SizedBox(width: 8),
                              Text(
                                "Weekly Insights",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 🔹 Great Improvement Container
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.arrow_upward,
                                    color: Colors.green, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Great improvement!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Your prayer time increased by 23% this week",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 🔹 Almost There Container
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // const Icon(Icons.flag_outlined, color: Colors.orange, size: 20),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Almost there!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "You're 2 sessions away from your weekly goal",
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // 🔹 Consistency Key Container
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.event_note,
                                    color: Colors.purple, size: 20),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Consistency key",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        "Try to attend one more Mass this week",
                                        style: TextStyle(fontSize: 13),
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
                  ],
                ),
              ),
            ]),
          ),

          SizedBox(height: 30),
// 🔹 Main Container
          Container(
            width: 366,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // 🔹 Center the child containers
              children: [
                // 🔹 Title Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(left: 13), // 🔹 push right
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.favorite_border,
                              color: Colors.white, size: 18),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          "Prayer\nIntentions",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 19), // 🔹 move "Add Intention" left
                      child: const Text(
                        "Add\nIntention",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 🔹 Intention 1
                Container(
                  width: 310,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "For world peace and unity",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Requested by Maria Santos • 3 days\n ago",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 35), // 🔹 move icon slightly down
                        child: Row(
                          children: const [
                            Icon(Icons.favorite, color: Colors.blue, size: 16),
                            SizedBox(width: 4),
                            Text("247"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // 🔹 Intention 2
                Container(
                  width: 310,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Healing for my grandmother",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Requested by John Mitchell • 1 week \nago",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 35), // 🔹 adjust position
                        child: Row(
                          children: const [
                            Icon(Icons.favorite, color: Colors.green, size: 16),
                            SizedBox(width: 4),
                            Text("156"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                // 🔹 Intention 3
                Container(
                  width: 310,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "For all healthcare workers",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Requested by Parish Community • 2 \nweeks ago",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 35), // 🔹 tweak position
                        child: Row(
                          children: const [
                            Icon(Icons.favorite,
                                color: Colors.purple, size: 16),
                            SizedBox(width: 4),
                            Text("89"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 30),
// 🔹 Main Container
          Container(
            width: 366,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.center, // 🔹 Center the child containers
                children: [
                  // 🔹 Title Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                left: 13), // 🔹 push right
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Colors.purple,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              // ✅ Center the FaIcon
                              child: FaIcon(
                                FontAwesomeIcons.userFriends,
                                color: Colors.white,
                                size: 16, // optional: control the icon size
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Community Activities",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 19), // 🔹 move "Add Intention" left
                      //   child: const Text(
                      //     "Add\nIntention",
                      //     textAlign: TextAlign.right,
                      //     style: TextStyle(
                      //       color: Colors.pink,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const SizedBox(height: 16),

// 🔹 Intention 1
                  Container(
                    width: 310,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔹 Icon + Texts
                        Row(
                          children: [
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                // ✅ Center the FaIcon
                                child: FaIcon(
                                  FontAwesomeIcons.bookOpen,
                                  color: Colors.white,
                                  size: 16, // optional: control the icon size
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Bible Study Group",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 0),
                                Text(
                                  "Wednessdaays 7:00 PM. Parish\nHall",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // 🔹 Right-side container with text
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "join",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

// 🔹 Intention 2
                  Container(
                    width: 310,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔹 Icon + Texts
                        Row(
                          children: [
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Center(
                                // ✅ Center the FaIcon
                                child: FaIcon(
                                  FontAwesomeIcons.handHoldingHeart,
                                  color: Colors.white,
                                  size: 16, // optional: control the icon size
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Charity Drive",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 0),
                                Text(
                                  "Food Collection . Ends\nSunday",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // 🔹 Right-side container with text
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "Donate",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

// 🔹 Intention 3
                  Container(
                    width: 310,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 🔹 Icon + Texts
                        Row(
                          children: [
                            Container(
                              width: 33,
                              height: 33,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: const Icon(Icons.music_note,
                                  color: Colors.white, size: 16),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Youth Choir Practice",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 0),
                                Text(
                                  "Saturdays 10:00 AM . Church",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black54),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // 🔹 Right-side container with text
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            "Info",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ])));
  }
}

// class DevotionalsScreen extends StatelessWidget {
//   const DevotionalsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppTopBar(
//         title: 'Devotionals',
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(Icons.settings_outlined),
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(bottom: 24),
//         children: [
//           const SizedBox(height: 12),
//           _PrayerStreakCard(),
//           const SectionHeader(title: "Today's Devotions"),
//           for (int i = 0; i < 3; i++)
//             DevotionTile(
//               title:
//                   ['Mass Readings', 'Divine Office', 'Interactive Rosary'][i],
//               subtitle:
//                   [
//                     'Today\'s Scripture',
//                     'Morning Prayer',
//                     'Joyful Mysteries',
//                   ][i],
//               imageUrl: randomPhoto(1200, 700),
//               progress: i == 2 ? 0.3 : null,
//               actionLabel:
//                   i == 1
//                       ? 'Pray Now'
//                       : i == 2
//                       ? 'Resume'
//                       : 'Read Now',
//             ),
//           const SectionHeader(title: 'Quick Prayers'),
//           const QuickGrid(),
//           const QuoteCard(),
//           const VirtualCandles(),
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
//                       Icon(
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
