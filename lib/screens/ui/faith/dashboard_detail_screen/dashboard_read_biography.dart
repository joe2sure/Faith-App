import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SaintBiographyScreen extends StatefulWidget {
  final String saintName;
  final String feastDay;
  
  const SaintBiographyScreen({
    super.key,
    required this.saintName,
    required this.feastDay,
  });

  @override
  State<SaintBiographyScreen> createState() => _SaintBiographyScreenState();
}

class _SaintBiographyScreenState extends State<SaintBiographyScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeAnimationController;
  late AnimationController _heartAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _heartAnimation;
  
  bool _isFavorite = false;
  bool _isPraying = false;
  double _fontSize = 16.0;
  
  // Sample saint data - in real app, this would come from an API or database
  final Map<String, Map<String, dynamic>> _saintData = {
    "St. Teresa Benedicta": {
      "fullName": "Saint Teresa Benedicta of the Cross (Edith Stein)",
      "birth": "October 12, 1891",
      "death": "August 9, 1942",
      "feastDay": "August 9",
      "patronOf": "Europe, Philosophers, Martyrs, Loss of parents",
      "canonized": "October 11, 1998 by Pope John Paul II",
      "image": "assets/images/Image_fx (1).jpg",
      "shortDescription": "German-Jewish philosopher who converted to Christianity, became a Carmelite nun, and died in Auschwitz.",
      "earlyLife": "Edith Stein was born into a Jewish family in Breslau, Prussia (now Wrocław, Poland). She was an outstanding student and became one of the first women to receive a doctorate in philosophy. As a young woman, she was an atheist, but through her philosophical studies and personal experiences, she gradually opened her heart to faith.",
      "conversion": "Her conversion to Christianity began through reading the autobiography of Saint Teresa of Ávila. After reading it in one night, she said, 'This is the truth.' She was baptized as a Catholic in 1922, taking the name Teresa Benedicta.",
      "religiousLife": "In 1933, she entered the Discalced Carmelite convent in Cologne, Germany, taking the religious name Teresa Benedicta of the Cross. She continued her philosophical and theological writings, seeking to bridge the gap between faith and reason.",
      "martyrdom": "Due to her Jewish heritage, she was arrested by the Nazis in 1942 and deported to Auschwitz concentration camp, where she died in the gas chambers. She is considered a martyr who died for her faith and in solidarity with her Jewish people.",
      "legacy": "She was canonized in 1998 and declared a co-patron saint of Europe in 1999. Her writings on phenomenology, women's issues, and the relationship between faith and reason continue to influence scholars and believers today.",
      "prayer": "Saint Teresa Benedicta, help us to seek truth with courage and follow Christ with unwavering faith. Intercede for us that we may embrace the cross with love and find in suffering a path to unity with our Savior. Amen.",
      "quotes": [
        "The woman's soul is fashioned as a shelter in which other souls may unfold.",
        "Do not accept anything as the truth if it lacks love. And do not accept anything as love which lacks truth.",
        "The nation doesn't simply need what we have. It needs what we are.",
        "Every moment is the right moment; every moment is a gift from God."
      ]
    }
  };

  @override
  void initState() {
    super.initState();
    
    _fadeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _heartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeAnimationController, curve: Curves.easeIn),
    );
    
    _heartAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _heartAnimationController, curve: Curves.elasticOut),
    );
    
    _fadeAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    _heartAnimationController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    
    if (_isFavorite) {
      _heartAnimationController.forward().then((_) {
        _heartAnimationController.reverse();
      });
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _startPraying() {
    setState(() {
      _isPraying = true;
    });
    
    // Simulate prayer time
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isPraying = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Prayer completed. May St. Teresa Benedicta intercede for you.'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    });
  }

  void _shareBiography() {
    final saint = _saintData[widget.saintName];
    if (saint != null) {
      String shareText = "${saint['fullName']}\n";
      shareText += "Feast Day: ${saint['feastDay']}\n\n";
      shareText += "${saint['shortDescription']}\n\n";
      shareText += "\"${saint['quotes'][0]}\"\n\n";
      shareText += "Pray for us, ${widget.saintName}!";
      
      // In a real app, you would use share_plus package
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Biography shared')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final saint = _saintData[widget.saintName];
    
    if (saint == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Saint Biography'),
        ),
        body: const Center(
          child: Text('Saint information not found'),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Header with Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            stretch: true,
            backgroundColor: Colors.blue[600],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.saintName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    saint['image'],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.blue, size: 16),
                          const SizedBox(height: 4),
                          Text(
                            saint['feastDay'],
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              AnimatedBuilder(
                animation: _heartAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _isFavorite ? _heartAnimation.value : 1.0,
                    child: IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: _shareBiography,
              ),
            ],
          ),
          
          // Biography Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saint Info Card
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade50, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            saint['fullName'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildInfoRow(Icons.cake, 'Born:', saint['birth']),
                          _buildInfoRow(Icons.calendar_month, 'Died:', saint['death']),
                          _buildInfoRow(Icons.stars, 'Canonized:', saint['canonized']),
                          _buildInfoRow(Icons.shield, 'Patron of:', saint['patronOf']),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Font Size Control
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.text_decrease),
                          onPressed: _fontSize > 12
                              ? () => setState(() => _fontSize -= 2)
                              : null,
                        ),
                        const Text('Font Size'),
                        IconButton(
                          icon: const Icon(Icons.text_increase),
                          onPressed: _fontSize < 24
                              ? () => setState(() => _fontSize += 2)
                              : null,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Biography Sections
                    _buildBiographySection('Early Life', saint['earlyLife']),
                    _buildBiographySection('Conversion', saint['conversion']),
                    _buildBiographySection('Religious Life', saint['religiousLife']),
                    _buildBiographySection('Martyrdom', saint['martyrdom']),
                    _buildBiographySection('Legacy', saint['legacy']),
                    
                    const SizedBox(height: 24),
                    
                    // Quotes Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.amber[200]!, width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.format_quote, color: Colors.amber[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Quotes',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...saint['quotes'].map<Widget>((quote) => Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              '"$quote"',
                              style: TextStyle(
                                fontSize: _fontSize,
                                fontStyle: FontStyle.italic,
                                color: Colors.amber[800],
                                height: 1.4,
                              ),
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Prayer Section
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purple.shade100, Colors.purple.shade50],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.auto_awesome, color: Colors.purple[700]),
                              const SizedBox(width: 8),
                              Text(
                                'Prayer to ${widget.saintName}',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple[700],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            saint['prayer'],
                            style: TextStyle(
                              fontSize: _fontSize,
                              height: 1.5,
                              color: Colors.purple[800],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Center(
                            child: ElevatedButton.icon(
                              onPressed: _isPraying ? null : _startPraying,
                              icon: _isPraying
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Icon(Icons.favorite, color: Colors.white),
                              label: Text(
                                _isPraying ? 'Praying...' : 'Pray Now',
                                style: const TextStyle(color: Colors.white),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[600],
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.blue[600]),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBiographySection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: _fontSize,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}