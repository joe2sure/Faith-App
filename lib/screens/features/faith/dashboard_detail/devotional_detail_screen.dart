import 'package:flutter/material.dart';
import '../../../../common/reusable_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/themes/text_styles.dart';

class DevotionalDetailScreen extends StatefulWidget {
  final String title;
  final String time;
  final String duration;
  final String description;
  final IconData icon;
  final List<Color> colors;

  const DevotionalDetailScreen({
    super.key,
    required this.title,
    required this.time,
    required this.duration,
    required this.description,
    required this.icon,
    required this.colors,
  });

  @override
  State<DevotionalDetailScreen> createState() => _DevotionalDetailScreenState();
}

class _DevotionalDetailScreenState extends State<DevotionalDetailScreen> {
  bool _isReading = false;
  bool _isListening = false;
  double _progress = 0.0;

  final Map<String, List<String>> _devotionalContent = {
    "Morning Prayer": [
      "Heavenly Father, as the dawn breaks and light fills the sky, I come before You with a grateful heart.",
      "Thank You for the gift of this new day, for the breath in my lungs, and for Your unfailing love that surrounds me.",
      "Guide my steps today, Lord. Help me to walk in Your ways and to reflect Your light to everyone I encounter.",
      "Grant me wisdom in my decisions, patience in my challenges, and compassion in my interactions.",
      "May every word I speak and every action I take bring glory to Your name.",
      "I surrender this day to You, trusting in Your perfect plan for my life. In Jesus' name, Amen.",
    ],
    "Scripture Reading": [
      "The Word of God is living and active, sharper than any two-edged sword.",
      "Today's Reading: John 15:5 - 'I am the vine; you are the branches. If you remain in me and I in you, you will bear much fruit; apart from me you can do nothing.'",
      "Reflection: Just as a branch cannot bear fruit by itself unless it remains in the vine, we cannot live fruitful spiritual lives apart from Christ.",
      "Our connection to Jesus is the source of our spiritual vitality, strength, and purpose.",
      "When we abide in Him through prayer, worship, and obedience to His Word, His life flows through us.",
      "This produces the fruit of the Spirit: love, joy, peace, patience, kindness, goodness, faithfulness, gentleness, and self-control.",
      "Action: Today, consciously remain connected to Christ through prayer and meditation on His Word.",
    ],
    "Rosary": [
      "The Holy Rosary is a powerful meditation on the life of Christ through the eyes of Mary.",
      "Today's Mystery: The Joyful Mysteries",
      "First Mystery: The Annunciation - Mary's 'Yes' to God's plan",
      "Reflection: Like Mary, we are called to say 'yes' to God's will in our lives, even when we don't fully understand His plans.",
      "Second Mystery: The Visitation - Mary serves Elizabeth",
      "Reflection: After receiving God's blessing, Mary immediately goes to serve others. True faith leads to action.",
      "As you pray each Hail Mary, contemplate Mary's faith, humility, and total surrender to God's will.",
      "Ask for the grace to imitate her virtues in your own life.",
    ],
    "Evening Reflection": [
      "As this day draws to a close, I pause to reflect on God's presence in my life.",
      "Examination of Conscience: How did I experience God today? Where did I see His hand at work?",
      "Were there moments when I responded to others with love and patience? Were there times I fell short?",
      "Gratitude: I thank You, Lord, for three specific blessings from today...",
      "Forgiveness: I ask Your forgiveness for the ways I have failed to love You and others today.",
      "Surrender: I release into Your hands all worries, anxieties, and concerns about tomorrow.",
      "As I prepare for rest, I trust that You watch over me through the night. Grant me peaceful sleep and renew my strength for tomorrow.",
      "In Your merciful name, Amen.",
    ],
  };

  @override
  Widget build(BuildContext context) {
    final content = _devotionalContent[widget.title] ?? [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 3, color: Colors.black26)],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      bottom: -30,
                      child: Icon(
                        widget.icon,
                        size: 180,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to saved devotionals')),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sharing devotional...')),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoItem(Icons.access_time, widget.time),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[300],
                          ),
                          _buildInfoItem(Icons.timer, widget.duration),
                          Container(
                            width: 1,
                            height: 30,
                            color: Colors.grey[300],
                          ),
                          _buildInfoItem(Icons.calendar_today, 'Daily'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    widget.description,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Control Buttons
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: _isReading ? 'Pause Reading' : 'Start Reading',
                          onPressed: () {
                            setState(() {
                              _isReading = !_isReading;
                              _isListening = false;
                            });
                          },
                          icon: _isReading ? Icons.pause : Icons.play_arrow,
                          isPrimary: true,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          text: _isListening ? 'Stop Audio' : 'Listen',
                          onPressed: () {
                            setState(() {
                              _isListening = !_isListening;
                              _isReading = false;
                            });
                          },
                          icon: _isListening ? Icons.stop : Icons.headphones,
                          isPrimary: false,
                        ),
                      ),
                    ],
                  ),

                  if (_isReading || _isListening) ...[
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: _progress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(widget.colors[0]),
                    ),
                  ],

                  const SizedBox(height: 32),

                  // Content
                  Text(
                    'Devotional Content',
                    style: AppTextStyles.h4.copyWith(color: widget.colors[1]),
                  ),

                  const SizedBox(height: 16),

                  ...content.asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: widget.colors[0].withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: widget.colors[0].withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          entry.value,
                          style: AppTextStyles.bodyMedium.copyWith(
                            height: 1.8,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 24),

                  // Complete Button
                  Center(
                    child: AppButton(
                      text: 'Mark as Complete',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text('Devotional Complete!'),
                            content: const Text(
                              'Great job! You\'ve completed today\'s devotional. Keep up your spiritual journey!',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Continue'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.colors[0],
                                ),
                                child: const Text('Done'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icons.check_circle,
                      isPrimary: true,
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: widget.colors[0]),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}