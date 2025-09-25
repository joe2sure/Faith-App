import 'package:flutter/material.dart';

class CatholicDocumentsScreen extends StatefulWidget {
  const CatholicDocumentsScreen({super.key});

  @override
  State<CatholicDocumentsScreen> createState() => _CatholicDocumentsScreenState();
}

class _CatholicDocumentsScreenState extends State<CatholicDocumentsScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Catechism',
    'Canon Law',
    'Vatican II',
    'Social Teaching',
    'Church Fathers',
    'Papal Documents'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catholic Documents'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: Colors.blue,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Search Catholic documents...',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  if (_searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                      child: const Icon(Icons.clear, color: Colors.grey),
                    ),
                ],
              ),
            ),
          ),

          // Category Filter
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _categories[index] == _selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = _categories[index];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Documents List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _getFilteredDocuments().length,
              itemBuilder: (context, index) {
                final document = _getFilteredDocuments()[index];
                return _buildDocumentCard(document);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getAllDocuments() {
    return [
      {
        "title": "Catechism of the Catholic Church",
        "subtitle": "Complete Catholic Teaching",
        "category": "Catechism",
        "description": "The official summary of Catholic doctrine covering faith, sacraments, commandments, and prayer.",
        "downloadSize": "2.1 MB",
        "pages": 598,
        "language": "English",
        "icon": Icons.book,
        "color": Colors.blue,
        "isDownloaded": false,
      },
      {
        "title": "Code of Canon Law",
        "subtitle": "Church Legal Framework",
        "category": "Canon Law",
        "description": "The current canon law of the Catholic Church, revised in 1983.",
        "downloadSize": "1.8 MB",
        "pages": 456,
        "language": "English",
        "icon": Icons.gavel,
        "color": Colors.green,
        "isDownloaded": true,
      },
      {
        "title": "Sacrosanctum Concilium",
        "subtitle": "Constitution on Sacred Liturgy",
        "category": "Vatican II",
        "description": "Vatican II document on the reform and promotion of the liturgy.",
        "downloadSize": "0.8 MB",
        "pages": 45,
        "language": "English",
        "icon": Icons.church,
        "color": Colors.purple,
        "isDownloaded": false,
      },
      {
        "title": "Lumen Gentium",
        "subtitle": "Dogmatic Constitution on the Church",
        "category": "Vatican II",
        "description": "Vatican II's teaching on the nature and universal mission of the Church.",
        "downloadSize": "1.2 MB",
        "pages": 89,
        "language": "English",
        "icon": Icons.people,
        "color": Colors.orange,
        "isDownloaded": true,
      },
      {
        "title": "Rerum Novarum",
        "subtitle": "On Capital and Labor",
        "category": "Social Teaching",
        "description": "Pope Leo XIII's encyclical on the rights and duties of capital and labor.",
        "downloadSize": "0.5 MB",
        "pages": 32,
        "language": "English",
        "icon": Icons.work,
        "color": Colors.red,
        "isDownloaded": false,
      },
      {
        "title": "Caritas in Veritate",
        "subtitle": "Charity in Truth",
        "category": "Social Teaching",
        "description": "Pope Benedict XVI's encyclical on integral human development.",
        "downloadSize": "1.0 MB",
        "pages": 78,
        "language": "English",
        "icon": Icons.favorite,
        "color": Colors.pink,
        "isDownloaded": false,
      },
      {
        "title": "Confessions",
        "subtitle": "St. Augustine",
        "category": "Church Fathers",
        "description": "The autobiographical work of St. Augustine, detailing his spiritual journey.",
        "downloadSize": "1.5 MB",
        "pages": 234,
        "language": "English",
        "icon": Icons.auto_stories,
        "color": Colors.brown,
        "isDownloaded": true,
      },
      {
        "title": "Summa Theologica",
        "subtitle": "St. Thomas Aquinas (Excerpts)",
        "category": "Church Fathers",
        "description": "Selected passages from Aquinas' masterwork on systematic theology.",
        "downloadSize": "3.2 MB",
        "pages": 567,
        "language": "English",
        "icon": Icons.school,
        "color": Colors.indigo,
        "isDownloaded": false,
      },
      {
        "title": "Evangelii Gaudium",
        "subtitle": "The Joy of the Gospel",
        "category": "Papal Documents",
        "description": "Pope Francis' apostolic exhortation on proclaiming the Gospel.",
        "downloadSize": "1.3 MB",
        "pages": 98,
        "language": "English",
        "icon": Icons.celebration,
        "color": Colors.amber,
        "isDownloaded": false,
      },
      {
        "title": "Laudato Si'",
        "subtitle": "On Care for Our Common Home",
        "category": "Papal Documents",
        "description": "Pope Francis' encyclical on environmental issues and human ecology.",
        "downloadSize": "1.4 MB",
        "pages": 112,
        "language": "English",
        "icon": Icons.eco,
        "color": Colors.green,
        "isDownloaded": true,
      },
    ];
  }

  List<Map<String, dynamic>> _getFilteredDocuments() {
    var documents = _getAllDocuments();
    
    if (_selectedCategory != 'All') {
      documents = documents.where((doc) => doc['category'] == _selectedCategory).toList();
    }
    
    if (_searchQuery.isNotEmpty) {
      documents = documents.where((doc) => 
        doc['title'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        doc['subtitle'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        doc['description'].toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    
    return documents;
  }

  Widget _buildDocumentCard(Map<String, dynamic> document) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (document['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    document['icon'] as IconData,
                    color: document['color'] as Color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document['title'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document['subtitle'],
                        style: TextStyle(
                          fontSize: 14,
                          color: document['color'] as Color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (document['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    document['category'],
                    style: TextStyle(
                      fontSize: 12,
                      color: document['color'] as Color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              document['description'],
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.description, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  '${document['pages']} pages',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.file_download, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  document['downloadSize'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(width: 16),
                Icon(Icons.language, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  document['language'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (document['isDownloaded'])
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.menu_book, size: 18),
                      label: const Text('Read'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: document['color'] as Color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Download'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: document['color'] as Color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.preview, size: 18),
                  label: const Text('Preview'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: document['color'] as Color,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
}
