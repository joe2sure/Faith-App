import 'package:flutter/material.dart';

class CatholicDocumentDetailScreen extends StatefulWidget {
  final String documentTitle;
  final String documentSubtitle;

  const CatholicDocumentDetailScreen({
    super.key,
    required this.documentTitle,
    required this.documentSubtitle,
  });

  @override
  State<CatholicDocumentDetailScreen> createState() => _CatholicDocumentDetailScreenState();
}

class _CatholicDocumentDetailScreenState extends State<CatholicDocumentDetailScreen> {
  bool isBookmarked = false;

  // Sample document content based on the document type
  Map<String, Object> getDocumentContent() {
    final documents = {
      "Catechism of the Catholic Church": {
        "description": "The official teaching of the Catholic Church, providing a comprehensive summary of Catholic doctrine and beliefs.",
        "sections": [
          {"title": "Part I: The Profession of Faith", "items": ["The Creed", "Sacred Scripture", "Sacred Tradition", "The Trinity"]},
          {"title": "Part II: The Celebration of the Christian Mystery", "items": ["The Sacramental Economy", "The Seven Sacraments", "Liturgical Life"]},
          {"title": "Part III: Life in Christ", "items": ["Human Dignity", "The Moral Law", "The Ten Commandments", "Social Justice"]},
          {"title": "Part IV: Christian Prayer", "items": ["Prayer in Christian Life", "The Lord's Prayer", "Contemplative Prayer"]}
        ],
        "keyPoints": [
          "Foundation of Catholic teaching",
          "Organized in four main parts",
          "Based on Scripture and Tradition",
          "Universal teaching tool"
        ]
      },
      "Canon Law": {
        "description": "The system of laws and legal principles made and enforced by the hierarchical authorities of the Catholic Church.",
        "sections": [
          {"title": "Book I: General Norms", "items": ["Laws", "Custom", "Decrees", "Instructions"]},
          {"title": "Book II: The People of God", "items": ["Rights and Duties", "Hierarchical Constitution", "Institutes of Consecrated Life"]},
          {"title": "Book III: The Teaching Function", "items": ["Preaching", "Catholic Education", "Communications"]},
          {"title": "Book IV: The Sanctifying Function", "items": ["Sacraments", "Sacred Places", "Sacred Times"]}
        ],
        "keyPoints": [
          "Church governance structure",
          "Rights and obligations",
          "Sacramental regulations",
          "Administrative procedures"
        ]
      },
      "Vatican Council II": {
        "description": "The 21st Ecumenical Council that addressed the Church's relationship with the modern world and brought significant reforms.",
        "sections": [
          {"title": "Dogmatic Constitutions", "items": ["Dei Verbum (Divine Revelation)", "Lumen Gentium (The Church)"]},
          {"title": "Pastoral Constitution", "items": ["Gaudium et Spes (Church in Modern World)"]},
          {"title": "Constitutions on Liturgy", "items": ["Sacrosanctum Concilium (Sacred Liturgy)"]},
          {"title": "Decrees and Declarations", "items": ["Ecumenism", "Religious Freedom", "Non-Christian Religions"]}
        ],
        "keyPoints": [
          "Modernization of the Church",
          "Liturgical reforms",
          "Ecumenical dialogue",
          "Social engagement"
        ]
      },
      "Catholic Social Doctrine": {
        "description": "The Church's teaching on social, economic, and political issues based on the Gospel and natural law.",
        "sections": [
          {"title": "Foundational Principles", "items": ["Human Dignity", "Common Good", "Subsidiarity", "Solidarity"]},
          {"title": "Economic Justice", "items": ["Workers' Rights", "Property Rights", "Fair Wages", "Economic Development"]},
          {"title": "Political Order", "items": ["Democracy", "Human Rights", "International Relations", "Peace"]},
          {"title": "Contemporary Issues", "items": ["Environment", "Globalization", "Technology", "Migration"]}
        ],
        "keyPoints": [
          "Justice and human rights",
          "Care for the poor",
          "Environmental stewardship",
          "Global solidarity"
        ]
      },
      "Church Fathers": {
        "description": "The writings and teachings of early Christian theologians and bishops who helped shape Catholic doctrine.",
        "sections": [
          {"title": "Apostolic Fathers", "items": ["St. Clement of Rome", "St. Ignatius of Antioch", "St. Polycarp"]},
          {"title": "Greek Fathers", "items": ["St. John Chrysostom", "St. Basil the Great", "St. Gregory Nazianzen"]},
          {"title": "Latin Fathers", "items": ["St. Augustine", "St. Jerome", "St. Ambrose", "St. Gregory the Great"]},
          {"title": "Key Themes", "items": ["Trinity", "Incarnation", "Scripture Interpretation", "Christian Life"]}
        ],
        "keyPoints": [
          "Early Church development",
          "Theological foundations",
          "Biblical interpretation",
          "Spiritual wisdom"
        ]
      },
      "Papal Encyclicals": {
        "description": "Official papal letters addressing important matters of faith, morals, and social issues to the universal Church.",
        "sections": [
          {"title": "Social Encyclicals", "items": ["Rerum Novarum", "Centesimus Annus", "Caritas in Veritate"]},
          {"title": "Theological Encyclicals", "items": ["Deus Caritas Est", "Spe Salvi", "Lumen Fidei"]},
          {"title": "Environmental", "items": ["Laudato Si'", "Care for Creation"]},
          {"title": "Recent Teachings", "items": ["Fratelli Tutti", "Evangelii Gaudium"]}
        ],
        "keyPoints": [
          "Papal teaching authority",
          "Contemporary issues",
          "Moral guidance",
          "Universal application"
        ]
      }
    };

    return documents[widget.documentTitle] ?? {
      "description": "Catholic Church document providing guidance and teaching for the faithful.",
      "sections": [
        {"title": "Introduction", "items": ["Overview", "Purpose", "Context"]},
        {"title": "Main Content", "items": ["Core Teachings", "Applications", "Examples"]},
        {"title": "Conclusion", "items": ["Summary", "Implementation", "Further Study"]}
      ],
      "keyPoints": [
        "Catholic teaching",
        "Spiritual guidance",
        "Practical application",
        "Faith formation"
      ]
    };
  }

  @override
  Widget build(BuildContext context) {
    final content = getDocumentContent();
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.documentTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isBookmarked = !isBookmarked;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isBookmarked 
                        ? "Document bookmarked!" 
                        : "Bookmark removed"
                  ),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Sharing document..."),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade600, Colors.blue.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.article,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.documentTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.documentSubtitle,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content['description'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            // Key Points Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Key Points",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...((content['keyPoints'] as List<String>).map((point) =>
                    Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade600,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              point,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Sections
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Document Sections",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...((content['sections'] as List<Map<String, dynamic>>).map((section) =>
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.folder_outlined,
                            color: Colors.blue.shade600,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          section['title'] as String,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            child: Column(
                              children: (section['items'] as List<String>).map((item) =>
                                Container(
                                  margin: const EdgeInsets.only(bottom: 8),
                                  child: InkWell(
                                    onTap: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("Opening: $item"),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey.shade200),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.description_outlined,
                                            size: 16,
                                            color: Colors.grey.shade600,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12,
                                            color: Colors.grey.shade400,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Starting guided reading..."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      label: const Text(
                        "Start Reading",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Downloading document..."),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: Icon(Icons.download, color: Colors.blue.shade600),
                      label: Text(
                        "Download",
                        style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.bold),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.blue.shade600),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Related Documents
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Related Documents",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        final relatedDocs = [
                          "Papal Encyclicals",
                          "Church Fathers",
                          "Vatican Council II",
                          "Catholic Social Doctrine"
                        ];
                        return Container(
                          width: 140,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CatholicDocumentDetailScreen(
                                    documentTitle: relatedDocs[index],
                                    documentSubtitle: "Related Document",
                                  ),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.article_outlined,
                                      color: Colors.blue.shade600,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    relatedDocs[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    "Explore",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}