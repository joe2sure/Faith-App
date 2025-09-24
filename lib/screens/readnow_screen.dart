import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReadNowScreen extends StatelessWidget {
  const ReadNowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Daily Reading",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_border, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Top Section
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const FaIcon(FontAwesomeIcons.bookOpen, size: 28, color: Colors.blue),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "John 3:16",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "New International Version",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "\"For God so loved the world that he gave his one and only Son, "
                      "that whoever believes in him shall not perish but have eternal life.\"",
                      style: TextStyle(fontSize: 15, height: 1.4),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text("-", style: TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(width: 12),
                      const Text("Font Size", style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text("+", style: TextStyle(fontSize: 20)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),

            // 🔹 First text (left)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Today`s Reflection",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 First container (10 lines) with "Golden text"
Container(
  margin: const EdgeInsets.symmetric(horizontal: 20),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(10),
  ),
  child: const Text(
    "This verse is often called the \"Golden text\"\nof the Bible because it summarizes the\nentire message of Christianity in one\nsentence. It speaks of God`s immense love\nfor humanity and His ultimate sacrifice\n\nThe word \"world\" here doesn`t just mean\nthe planet Earth, but all of humanity. God`s\nlove extends to every person, regardless of\nthier background, nationality or\ncircumstances.",
    style: TextStyle(fontSize: 14, height: 1.4),
  ),
),
            const SizedBox(height: 18),

            // 🔹 Text under first container
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Prayer",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 Second container (7 lines)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Heavenly father, thank You for Your\nincredible love that You demonstrated by\nsending Your Son Jesus Christ. Help us to\ntruly understand the depth of Your love and\nto share it with others. May we live each day\nknowing that we are deeply loved by You\nAmen.",
                style: TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 Text under second container
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Related Vesrses",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 18),

            // 🔹 Third container (Romans 5:8) with left-aligned text and double quotes
Container(
  margin: const EdgeInsets.symmetric(horizontal: 20),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        "Romans 5:8",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      SizedBox(height: 8),
      Text(
        "\"But God demonstrates his own love for us in this: While we were still sinners, Christ died for us.\"",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14, height: 1.4),
      ),
    ],
  ),
),
            const SizedBox(height: 12),

            // 🔹 Fourth container (1 John 4:9) with left-aligned text and double quotes
Container(
  margin: const EdgeInsets.symmetric(horizontal: 20),
  padding: const EdgeInsets.all(12),
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(10),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        "1 John 4:9",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.blue),
      ),
      SizedBox(height: 8),
      Text(
        "\"This is how God showed his love among us: He sent his one and only Son into the world that we might live through him.\"",
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14, height: 1.4),
      ),
    ],
  ),
),
            const SizedBox(height: 76),
          ],
        ),
      ),
    );
  }
}