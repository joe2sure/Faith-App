// ignore_for_file: deprecated_member_use

import 'package:faith_plus/common/constants.dart';
import 'package:flutter/material.dart';

class FunZoneScreen extends StatelessWidget {
  const FunZoneScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppTopBar(
        title: 'Fun Zone',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.local_police_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: const [
          SizedBox(height: 12),
          _FunWelcomeBanner(),
          SectionHeader(title: 'Featured Game', trailing: 'Play All'),
          _FeaturedGameCard(),
          SectionHeader(title: 'Bible Games', trailing: 'View All'),
          _TwoGameTilesRow(),
          SectionHeader(title: 'Saints & Stories', trailing: 'Explore'),
          _WideScrollCard(),
          SectionHeader(title: 'Prayer & Devotion', trailing: 'More'),
          _SmallMediaTile(),
          SectionHeader(title: 'Memory & Skills', trailing: 'Challenge'),
          _TwoPillTilesRow(),
          SectionHeader(title: 'Quick Games', trailing: 'See All'),
          _ThreeMiniTilesRow(),
          _DailyChallengeCard(),
        ],
      ),
    );
  }
}

class _FunWelcomeBanner extends StatelessWidget {
  const _FunWelcomeBanner();
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: SizedBox(
        height: 120,
        child: Stack(
          children: [
            // Background game image
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(randomPhoto(1200, 400), fit: BoxFit.cover),
              ),
            ),
            // Gradient overlay with opacity
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF8E24AA), // Purple with opacity
                        const Color(
                          0xFFE040FB,
                        ).withOpacity(0.7), // Pink with opacity
                      ],
                      // begin: Alignment.topLeft,
                      // end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Welcome to Fun Zone!\nLearn about faith through interactive games and activities.\nLevel 5  ·  12 Badges',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.4,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedGameCard extends StatelessWidget {
  const _FeaturedGameCard();
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=1300&q=80&h=700',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Black shadow at the bottom
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: 56,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black87, Colors.transparent],
                        ),
                      ),
                    ),
                  ),
                  // Game name on top of the shadow
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bible Trivia Challenge',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Test your biblical knowledge',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 6,
                                offset: Offset(0, 2),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: group icon + people, timer, stars, level
                Row(
                  children: [
                    Icon(Icons.group, color: Colors.blueGrey),
                    const SizedBox(width: 4),
                    Text(
                      '1,234 playing',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.timer, color: Colors.blueGrey),
                    const SizedBox(width: 4),
                    Text(
                      '5 min',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(width: 16),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star_border, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          'Easy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Progress bar and button in the same row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Progress',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 8),
                              Text(
                                '60%',
                                style: TextStyle(color: Colors.blueGrey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 0.6,
                              minHeight: 10,
                              backgroundColor: Colors.grey[200],
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    PrimaryButton(label: 'Continue', onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
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
              children: [
                Row(
                  children: List.generate(
                    3,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                  ),
                ),
                PrimaryButton(
                  label: 'Play',
                  onPressed: () {},
                  padding: EdgeInsets.symmetric(vertical: 8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WideScrollCard extends StatelessWidget {
  const _WideScrollCard();
  @override
  Widget build(BuildContext context) {
    // Example data for each card
    final games = [
      {
        'title': 'Saint Matching Game',
        'subtitle': 'Match saints to their stories',
        'players': '2,100 playing',
        'duration': '3 min',
        'difficulty': 'Easy',
        'image': randomPhoto(900, 600),
        'popular': true,
      },
      {
        'title': 'Bible Story Puzzle',
        'subtitle': 'Piece together the story',
        'players': '1,500 playing',
        'duration': '4 min',
        'difficulty': 'Medium',
        'image': randomPhoto(900, 600),
        'popular': false,
      },
      {
        'title': 'Saints Quiz',
        'subtitle': 'Test your saint knowledge',
        'players': '1,800 playing',
        'duration': '5 min',
        'difficulty': 'Hard',
        'image': randomPhoto(900, 600),
        'popular': true,
      },
      {
        'title': 'Virtue Memory',
        'subtitle': 'Find matching virtues',
        'players': '1,200 playing',
        'duration': '2 min',
        'difficulty': 'Easy',
        'image': randomPhoto(900, 600),
        'popular': false,
      },
      {
        'title': 'Saints Timeline',
        'subtitle': 'Order the saints in history',
        'players': '900 playing',
        'duration': '6 min',
        'difficulty': 'Medium',
        'image': randomPhoto(900, 600),
        'popular': true,
      },
    ];

    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: games.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) {
          final game = games[i];
          return Container(
            width: 310,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image with gradient and "Popular" badge
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          game['image'] as String,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    // Gradient shadow at the bottom
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      height: 36,
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                      ),
                    ),
                    // "Popular" badge at top left
                    if (game['popular'] == true)
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.whatshot,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Popular',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    // Game title on image
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            game['title'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),

                          Text(
                            game['subtitle'] as String,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              shadows: [
                                Shadow(
                                  color: Colors.black54,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top row: group icon + people, timer, stars, level
                      Row(
                        children: [
                          Icon(Icons.group, color: Colors.blueGrey),
                          const SizedBox(width: 4),
                          Text(
                            '1,234 playing',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.timer, color: Colors.blueGrey),
                          const SizedBox(width: 4),
                          Text(
                            '5 min',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              Icon(
                                Icons.star_border,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Easy',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Progress bar and button in the same row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'Best Score',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '800pts',
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: LinearProgressIndicator(
                                    value: 0.6,
                                    minHeight: 10,
                                    backgroundColor: Colors.grey[200],
                                    color: Colors.orange,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          PrimaryButton(label: 'Play Now', onPressed: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SmallMediaTile extends StatelessWidget {
  const _SmallMediaTile();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: SizedBox(
          height: 80,
          child: Stack(
            children: [
              // You can position the image anywhere in the Stack
              Positioned(
                left: 0,
                top: 8,
                bottom: 8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                  ),
                  child: Image.network(
                    randomPhoto(400, 300),
                    width: 84,
                    height: 64,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Favourite icon
              Positioned(
                top: 12,
                right: 16,
                child: Material(
                  color: const Color(
                    0xFFB39DDB,
                  ).withOpacity(0.18), // light purple with low opacity
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.purple,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              // Content
              Positioned.fill(
                left: 96, // 84 image + 12 spacing
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 12.0,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and subtitle
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Virtual Rosary Guide',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'An interactive prayer companion',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Second row: stars and button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 18,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.amberAccent,
                                size: 18,
                              ),
                              Text('New Age'),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: MaterialButton(
                                color: Colors.purple, // light purple background
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 10,
                                ),
                                onPressed: () {},

                                child: const Text(
                                  'Start Praying',
                                  style: TextStyle(
                                    color: Colors.white, // deep purple text
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
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
    );
  }
}

class _TwoPillTilesRow extends StatelessWidget {
  const _TwoPillTilesRow();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: const [
          Expanded(
            child: _PillTile(
              title: 'Memory Cards',
              c: Color(0xFFE8F3FF),
              imageUrl:
                  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80', // cards/flashcards
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: _PillTile(
              title: 'Faith Quiz',
              c: Color(0xFFFFF1E8),
              imageUrl:
                  'https://images.unsplash.com/photo-1503676382389-4809596d5290?auto=format&fit=crop&w=400&q=80', // quiz/brain
            ),
          ),
        ],
      ),
    );
  }
}

class _PillTile extends StatelessWidget {
  final String title;
  final Color c;
  final String imageUrl;
  const _PillTile({
    required this.title,
    required this.c,
    required this.imageUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: c,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amberAccent, size: 20),
              const Text('Easy'),
              const Spacer(),
              MaterialButton(
                minWidth: 50,
                color: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                onPressed: () {},
                child: const Text(
                  'Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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

class _DailyChallengeCard extends StatelessWidget {
  const _DailyChallengeCard();
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF35C2FF), Color(0xFF2B74FF)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Complete today\'s Bible trivia challenge and earn bonus points!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF2B74FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: const Text('Accept'),
            ),
          ],
        ),
      ),
    );
  }
}
