import 'package:flutter/material.dart';

class BibleVersionsScreen extends StatefulWidget {
  const BibleVersionsScreen({super.key});

  @override
  State<BibleVersionsScreen> createState() => _BibleVersionsScreenState();
}

class _BibleVersionsScreenState extends State<BibleVersionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bible Versions & Commentaries'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Popular'),
            Tab(text: 'Languages'),
            Tab(text: 'Study Bibles'),
            Tab(text: 'Audio'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value.toLowerCase();
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search Bible versions and commentaries...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                          _searchQuery = '';
                        });
                      },
                    ),
                ],
              ),
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVersionsList(_getPopularVersions()),
                _buildVersionsList(_getLanguageVersions()),
                _buildVersionsList(_getStudyBibles()),
                _buildVersionsList(_getAudioBibles()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionsList(List<Map<String, dynamic>> versions) {
    final filteredVersions = _searchQuery.isEmpty
        ? versions
        : versions.where((version) {
            return version["title"].toLowerCase().contains(_searchQuery) ||
                version["subtitle"].toLowerCase().contains(_searchQuery) ||
                version["description"].toLowerCase().contains(_searchQuery);
          }).toList();

    if (filteredVersions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Try a different search term',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredVersions.length,
      itemBuilder: (context, index) {
        return _buildVersionCard(filteredVersions[index]);
      },
    );
  }

  List<Map<String, dynamic>> _getPopularVersions() {
    return [
      {
        "title": "New American Bible (NAB)",
        "subtitle": "Catholic Standard Version",
        "language": "English",
        "description": "Official Bible used in the Catholic Church in the United States. Features modern language and scholarly translation.",
        "size": "15.2 MB",
        "features": ["Cross-references", "Footnotes", "Maps"],
        "rating": 4.8,
        "downloads": "2M+",
        "type": "bible"
      },
      {
        "title": "Douay-Rheims Bible",
        "subtitle": "Traditional Catholic Translation",
        "language": "English",
        "description": "Classic Catholic English translation from the Latin Vulgate. Beloved for its traditional language and accuracy.",
        "size": "12.8 MB",
        "features": ["Traditional Language", "Deuterocanonical Books", "Historical Notes"],
        "rating": 4.9,
        "downloads": "1.5M+",
        "type": "bible"
      },
      {
        "title": "Jerusalem Bible",
        "subtitle": "Catholic Study Bible",
        "language": "English",
        "description": "Scholarly Catholic translation with extensive notes and commentary from French biblical scholars.",
        "size": "28.5 MB",
        "features": ["Extensive Notes", "Cross-references", "Maps", "Study Aids"],
        "rating": 4.7,
        "downloads": "800K+",
        "type": "study"
      },
      {
        "title": "New Jerusalem Bible",
        "subtitle": "Updated Catholic Translation",
        "language": "English",
        "description": "Revised edition of the Jerusalem Bible with updated scholarship and inclusive language options.",
        "size": "25.3 MB",
        "features": ["Modern Translation", "Updated Notes", "Inclusive Language"],
        "rating": 4.6,
        "downloads": "600K+",
        "type": "bible"
      },
    ];
  }

  List<Map<String, dynamic>> _getLanguageVersions() {
    return [
      {
        "title": "Biblia de Jerusalén",
        "subtitle": "Spanish Catholic Bible",
        "language": "Spanish",
        "description": "Spanish translation of the Jerusalem Bible with Catholic commentary and extensive study notes.",
        "size": "22.1 MB",
        "features": ["Notas de Estudio", "Referencias Cruzadas", "Mapas"],
        "rating": 4.8,
        "downloads": "1.2M+",
        "type": "study"
      },
      {
        "title": "Bible de Jérusalem",
        "subtitle": "French Catholic Bible",
        "language": "French",
        "description": "Original French Catholic translation with scholarly notes from École Biblique de Jérusalem.",
        "size": "26.7 MB",
        "features": ["Notes Savantes", "Références", "Cartes"],
        "rating": 4.9,
        "downloads": "900K+",
        "type": "study"
      },
      {
        "title": "Bibbia di Gerusalemme",
        "subtitle": "Italian Catholic Bible",
        "language": "Italian",
        "description": "Italian Catholic translation with comprehensive commentary and study materials.",
        "size": "24.3 MB",
        "features": ["Note di Studio", "Riferimenti", "Mappe"],
        "rating": 4.7,
        "downloads": "750K+",
        "type": "study"
      },
      {
        "title": "Bíblia de Jerusalém",
        "subtitle": "Portuguese Catholic Bible",
        "language": "Portuguese",
        "description": "Portuguese Catholic translation widely used in Brazil and Portugal.",
        "size": "21.8 MB",
        "features": ["Notas de Estudo", "Referências", "Mapas"],
        "rating": 4.8,
        "downloads": "1.1M+",
        "type": "study"
      },
      {
        "title": "Einheitsübersetzung",
        "subtitle": "German Catholic Bible",
        "language": "German",
        "description": "Standard German Catholic Bible translation used in liturgy and study.",
        "size": "19.4 MB",
        "features": ["Liturgische Texte", "Anmerkungen", "Karten"],
        "rating": 4.6,
        "downloads": "650K+",
        "type": "bible"
      },
    ];
  }

  List<Map<String, dynamic>> _getStudyBibles() {
    return [
      {
        "title": "Catholic Study Bible (NAB)",
        "subtitle": "Complete Study Edition",
        "language": "English",
        "description": "New American Bible with extensive Catholic commentary, study notes, and supplementary materials.",
        "size": "45.2 MB",
        "features": ["Full Commentary", "Study Articles", "Maps", "Timeline", "Concordance"],
        "rating": 4.9,
        "downloads": "1.8M+",
        "type": "study"
      },
      {
        "title": "Ignatius Catholic Study Bible",
        "subtitle": "RSV with Scott Hahn Commentary",
        "language": "English",
        "description": "Study Bible with commentary by Scott Hahn and Curtis Mitch, featuring Catholic interpretation.",
        "size": "52.7 MB",
        "features": ["Scott Hahn Commentary", "Catholic Interpretation", "Study Questions"],
        "rating": 4.8,
        "downloads": "1.3M+",
        "type": "study"
      },
      {
        "title": "Haydock Catholic Commentary",
        "subtitle": "Traditional Commentary",
        "language": "English",
        "description": "Classical Catholic biblical commentary from the 19th century, still highly regarded.",
        "size": "38.9 MB",
        "features": ["Traditional Interpretation", "Church Fathers Quotes", "Historical Context"],
        "rating": 4.7,
        "downloads": "400K+",
        "type": "commentary"
      },
      {
        "title": "Navarre Bible Commentary",
        "subtitle": "University of Navarre",
        "language": "English",
        "description": "Comprehensive commentary series from the University of Navarre with spiritual and theological insights.",
        "size": "67.3 MB",
        "features": ["Comprehensive Commentary", "Spiritual Insights", "Theological Analysis"],
        "rating": 4.9,
        "downloads": "850K+",
        "type": "commentary"
      },
      {
        "title": "Catholic Commentary on Sacred Scripture",
        "subtitle": "Baker Academic Series",
        "language": "English",
        "description": "Modern Catholic commentary series with contemporary scholarship and pastoral insights.",
        "size": "41.6 MB",
        "features": ["Modern Scholarship", "Pastoral Application", "Study Guides"],
        "rating": 4.6,
        "downloads": "320K+",
        "type": "commentary"
      },
    ];
  }

  List<Map<String, dynamic>> _getAudioBibles() {
    return [
      {
        "title": "NAB Audio Bible",
        "subtitle": "Professional Narration",
        "language": "English",
        "description": "Complete New American Bible narrated by professional voice actors with background music.",
        "size": "1.2 GB",
        "features": ["Professional Narration", "Background Music", "Offline Playback"],
        "rating": 4.8,
        "downloads": "900K+",
        "type": "audio"
      },
      {
        "title": "Douay-Rheims Audio",
        "subtitle": "Traditional Reading",
        "language": "English",
        "description": "Audio version of the classic Catholic translation with reverent narration.",
        "size": "980 MB",
        "features": ["Traditional Text", "Clear Narration", "Chapter Navigation"],
        "rating": 4.7,
        "downloads": "600K+",
        "type": "audio"
      },
      {
        "title": "Spanish Audio Bible",
        "subtitle": "Biblia Católica Reina-Valera",
        "language": "Spanish",
        "description": "Spanish Catholic Bible audio narration with clear pronunciation and pacing.",
        "size": "1.1 GB",
        "features": ["Narración Clara", "Navegación por Capítulos", "Reproducción Offline"],
        "rating": 4.9,
        "downloads": "1.5M+",
        "type": "audio"
      },
      {
        "title": "French Audio Bible",
        "subtitle": "Bible Louis Segond Catholique",
        "language": "French",
        "description": "French Catholic Bible audio with professional French narration.",
        "size": "1.0 GB",
        "features": ["Narration Professionnelle", "Navigation Facile", "Qualité HD"],
        "rating": 4.6,
        "downloads": "450K+",
        "type": "audio"
      },
    ];
  }

  Widget _buildVersionCard(Map<String, dynamic> version) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getTypeColor(version["type"]).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getTypeIcon(version["type"]),
                    color: _getTypeColor(version["type"]),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        version["title"]!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        version["subtitle"]!,
                        style: TextStyle(
                          fontSize: 14,
                          color: _getTypeColor(version["type"]),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    version["language"]!,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              version["description"]!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),

            const SizedBox(height: 12),

            // Features
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: (version["features"] as List<String>)
                  .map((feature) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          feature,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 12),

            // Stats
            Row(
              children: [
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      version["rating"].toString(),
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.download, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      version["downloads"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Row(
                  children: [
                    Icon(Icons.storage, color: Colors.grey[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      version["size"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showDownloadDialog(version);
                    },
                    icon: const Icon(Icons.download, size: 18),
                    label: const Text('Download'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getTypeColor(version["type"]),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showPreviewDialog(version);
                    },
                    icon: const Icon(Icons.preview, size: 18),
                    label: const Text('Preview'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _getTypeColor(version["type"]),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'bible':
        return Colors.blue;
      case 'study':
        return Colors.green;
      case 'commentary':
        return Colors.orange;
      case 'audio':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'bible':
        return Icons.menu_book;
      case 'study':
        return Icons.school;
      case 'commentary':
        return Icons.comment;
      case 'audio':
        return Icons.headphones;
      default:
        return Icons.menu_book;
    }
  }

  void _showDownloadDialog(Map<String, dynamic> version) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Download ${version["title"]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Size: ${version["size"]}'),
              const SizedBox(height: 8),
              const Text('This will download the complete version including:'),
              const SizedBox(height: 8),
              ...((version["features"] as List<String>).map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(left: 16, bottom: 4),
                  child: Row(
                    children: [
                      const Icon(Icons.check, size: 16, color: Colors.green),
                      const SizedBox(width: 8),
                      Text(feature),
                    ],
                  ),
                ),
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Downloading ${version["title"]}...'),
                    backgroundColor: _getTypeColor(version["type"]),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getTypeColor(version["type"]),
              ),
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }

  void _showPreviewDialog(Map<String, dynamic> version) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text('Preview ${version["title"]}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'John 3:16\n\n"For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life."',
                  style: TextStyle(
                    fontSize: 16,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('This is a sample preview of the biblical text.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showDownloadDialog(version);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _getTypeColor(version["type"]),
              ),
              child: const Text('Download'),
            ),
          ],
        );
      },
    );
  }
}