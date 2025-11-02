import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';

class PrayerDetailScreen extends StatefulWidget {
  final Map<String, dynamic> prayer;

  const PrayerDetailScreen({
    super.key,
    required this.prayer,
  });

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> with SingleTickerProviderStateMixin {
  final Color _primaryBlue = const Color(0xFF4A90E2);
  final Color _deepPurple = const Color(0xFF6B5B95);
  final Color _softTeal = const Color(0xFF50B5B0);
  
  bool _isPlaying = false;
  bool _isFavorite = false;
  late AnimationController _playAnimationController;

  // Full prayer content based on title
  final Map<String, String> _prayerContents = {
    "Our Father": """Our Father, who art in heaven,
hallowed be thy name;
thy kingdom come;
thy will be done on earth as it is in heaven.

Give us this day our daily bread;
and forgive us our trespasses
as we forgive those who trespass against us;
and lead us not into temptation,
but deliver us from evil.

Amen.""",
    "Hail Mary": """Hail Mary, full of grace,
the Lord is with thee;
blessed art thou among women,
and blessed is the fruit of thy womb, Jesus.

Holy Mary, Mother of God,
pray for us sinners,
now and at the hour of our death.

Amen.""",
    "Glory Be": """Glory be to the Father,
and to the Son,
and to the Holy Spirit.

As it was in the beginning,
is now, and ever shall be,
world without end.

Amen.""",
    "Guardian Angel": """Angel of God, my guardian dear,
to whom God's love commits me here,
ever this day be at my side,
to light and guard, to rule and guide.

Amen.""",
    "St. Michael": """Saint Michael the Archangel,
defend us in battle.
Be our protection against the wickedness
and snares of the devil.

May God rebuke him, we humbly pray;
and do thou, O Prince of the Heavenly Host,
by the power of God,
cast into hell Satan and all the evil spirits
who prowl about the world seeking the ruin of souls.

Amen.""",
    "Angelus": """The Angel of the Lord declared unto Mary.
And she conceived of the Holy Spirit.

Hail Mary, full of grace...

Behold the handmaid of the Lord.
Be it done unto me according to thy word.

Hail Mary, full of grace...

And the Word was made Flesh.
And dwelt among us.

Hail Mary, full of grace...

Pray for us, O holy Mother of God.
That we may be made worthy of the promises of Christ.

Let us pray:
Pour forth, we beseech Thee, O Lord,
Thy grace into our hearts,
that we to whom the Incarnation of Christ Thy Son
was made known by the message of an angel,
may by His Passion and Cross
be brought to the glory of His Resurrection.

Through the same Christ our Lord.
Amen.""",
  };

  @override
  void initState() {
    super.initState();
    _playAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _playAnimationController.dispose();
    super.dispose();
  }

  String get _prayerContent {
    return _prayerContents[widget.prayer["title"]] ?? widget.prayer["content"] ?? "Prayer content not available.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildHeader(),
                _buildActionButtons(),
                _buildPrayerContent(),
                const SizedBox(height: 20),
                _buildRelatedPrayers(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: _deepPurple,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isFavorite = !_isFavorite;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_isFavorite ? "Added to favorites" : "Removed from favorites"),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: _shareContent,
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_deepPurple, _primaryBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_deepPurple.withOpacity(0.15), _primaryBlue.withOpacity(0.15)],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: _deepPurple,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            widget.prayer["title"]!,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _deepPurple,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: _primaryBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.access_time, size: 16, color: _primaryBlue),
                const SizedBox(width: 6),
                Text(
                  widget.prayer["duration"]!,
                  style: TextStyle(
                    fontSize: 14,
                    color: _primaryBlue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _togglePlayPause,
              icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: _playAnimationController,
                size: 20,
              ),
              label: Text(_isPlaying ? "Pause" : "Listen"),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _startGuidedPrayer,
              icon: const Icon(Icons.self_improvement, size: 20),
              label: const Text("Guided"),
              style: OutlinedButton.styleFrom(
                foregroundColor: _deepPurple,
                side: BorderSide(color: _deepPurple, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerContent() {
    return Container(
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.menu_book, color: _deepPurple, size: 20),
              const SizedBox(width: 8),
              Text(
                "Prayer Text",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: _deepPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _prayerContent,
            style: TextStyle(
              fontSize: 16,
              height: 1.8,
              color: Colors.grey.shade800,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedPrayers() {
    final relatedPrayers = [
      {"title": "Morning Offering", "duration": "2 min"},
      {"title": "Act of Contrition", "duration": "1 min"},
      {"title": "Prayer for Peace", "duration": "2 min"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            "Related Prayers",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: _deepPurple,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: relatedPrayers.length,
            itemBuilder: (context, index) {
              final prayer = relatedPrayers[index];
              return Container(
                width: 160,
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prayer["title"]!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 12, color: Colors.grey.shade600),
                        const SizedBox(width: 4),
                        Text(
                          prayer["duration"]!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _playAnimationController.forward();
      } else {
        _playAnimationController.reverse();
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isPlaying ? "Playing audio..." : "Audio paused"),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _startGuidedPrayer() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.self_improvement, color: _deepPurple),
            const SizedBox(width: 12),
            const Text("Guided Prayer"),
          ],
        ),
        content: const Text(
          "This feature will guide you through the prayer with timed pauses for reflection. Would you like to begin?",
          style: TextStyle(height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Starting guided prayer..."),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text("Begin"),
          ),
        ],
      ),
    );
  }

  void _shareContent() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Share Prayer",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _deepPurple,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                _buildShareOption(Icons.facebook, "Facebook", Colors.blue),
                _buildShareOption(Icons.message, "WhatsApp", const Color(0xFF25D366)),
                _buildShareOption(Icons.send, "Telegram", const Color(0xFF0088cc)),
                _buildShareOption(Icons.link, "Copy Link", _primaryBlue),
                _buildShareOption(Icons.email, "Email", _softTeal),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sharing via $label..."),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}