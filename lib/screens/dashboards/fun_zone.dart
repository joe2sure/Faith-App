import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/themes/text_styles.dart';
import '../../common/reusable_widget.dart';
import '../../common/constants.dart';
import '../features/fun_zone/bible_trivia_screen.dart';
import '../features/fun_zone/catechism_quiz_screen.dart';
import '../features/fun_zone/catholic_crossword_screen.dart';
import '../features/fun_zone/collections_detail_screen.dart';
// import '../fun_zone/bible_trivia_screen.dart';
// import '../fun_zone/catechism_quiz_screen.dart';
// import '../fun_zone/catholic_crossword_screen.dart';
// import '../fun_zone/collections_detail_screen.dart';

class FunZoneScreen extends StatefulWidget {
  const FunZoneScreen({super.key});

  @override
  State<FunZoneScreen> createState() => _FunZoneScreenState();
}

class _FunZoneScreenState extends State<FunZoneScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerAnimationController;
  late Animation<double> _headerSlideAnimation;
  int _streakDays = 12;
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _headerSlideAnimation = Tween<double>(begin: -100, end: 0).animate(
      CurvedAnimation(
        parent: _headerAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const AppTopBar(
        title: 'Fun Zone',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SizedBox(height: 8),
          _buildWelcomeHeader(),
          const SizedBox(height: 20),
          const _UserProfileBanner(),
          const SizedBox(height: 20),
          _SectionTitle(title: 'Featured for you'),
          const _FeaturedGameCarousel(),
          const SizedBox(height: 24),
          _SectionTitle(title: 'Recommended games', action: 'See more'),
          const _RecommendedGamesList(),
          const SizedBox(height: 24),
          _SectionTitle(title: 'Faith Knowledge'),
          const _CatechismQuizCard(),
          const SizedBox(height: 24),
          _SectionTitle(title: 'Top charts', action: 'See all'),
          const _TopChartsSection(),
          const SizedBox(height: 24),
          _SectionTitle(title: 'New & updated', action: 'See more'),
          const _NewUpdatedGamesList(),
          const SizedBox(height: 24),
          _buildCategoryTabs(),
          const SizedBox(height: 16),
          _buildCategoryContent(),
          const SizedBox(height: 24),
          _SectionTitle(title: 'Collections', action: 'View all'),
          const _CollectionsGrid(),
        ],
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return AnimatedBuilder(
      animation: _headerSlideAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _headerSlideAnimation.value),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Play & Learn!",
                        style: AppTextStyles.h2.copyWith(color: AppColors.primaryPurpleDark),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Discover faith-building games",
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
                StreakBadge(streakCount: _streakDays),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryTabs() {
    final categories = ['All', 'Trivia', 'Educational', 'Puzzle', 'Prayer', 'Stories'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: categories.map((cat) {
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) setState(() => _selectedCategory = cat);
              },
              selectedColor: AppColors.primaryPurple,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryContent() {
    final Map<String, List<Map<String, String>>> catData = {
      'Trivia': [
        {'title': 'Bible Facts', 'subtitle': 'Daily trivia questions', 'image': 'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?q=80&w=200'},
      ],
      'Puzzle': [
        {'title': 'Mosaic Faith', 'subtitle': 'Piece together scripture', 'image': 'https://images.unsplash.com/photo-1632345033857-4589d7ca9653?q=80&w=200'},
      ],
      'Stories': [
        {'title': 'Parable Journey', 'subtitle': 'Interactive story mode', 'image': 'https://images.unsplash.com/photo-1544427920-c49ccfb85579?q=80&w=200'},
      ],
    };

    final content = catData[_selectedCategory] ?? [];

    if (content.isEmpty && _selectedCategory != 'All') {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(child: Text("More $_selectedCategory games coming soon!", style: AppTextStyles.bodySmall)),
      );
    }

    if (_selectedCategory == 'All') {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: content.length,
        itemBuilder: (context, index) {
          final item = content[index];
          return Container(
            width: 260,
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(item['image']!, width: 80, height: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(item['title']!, style: AppTextStyles.h5),
                      Text(item['subtitle']!, style: AppTextStyles.caption, maxLines: 2),
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

class _UserProfileBanner extends StatelessWidget {
  const _UserProfileBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.blueGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Your Gaming Stats', style: AppTextStyles.h4.copyWith(color: Colors.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stars, color: AppColors.accentGold, size: 16),
                    const SizedBox(width: 4),
                    Text('Level 5', style: AppTextStyles.label.copyWith(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('Games Played', '47', Icons.gamepad),
              _buildStatCard('High Score', '12,450', Icons.emoji_events),
              _buildStatCard('Achievements', '23', Icons.workspace_premium),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(value, style: AppTextStyles.h5.copyWith(color: Colors.white)),
        Text(label, style: AppTextStyles.caption.copyWith(color: Colors.white70)),
      ],
    );
  }
}

class _FeaturedGameCarousel extends StatelessWidget {
  const _FeaturedGameCarousel();

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'title': 'Bible Trivia Challenge',
        'subtitle': 'Test your biblical knowledge',
        'image': 'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?q=80&w=400',
        'screen': const BibleTriviaScreen(),
      },
      {
        'title': 'Saints Quest',
        'subtitle': 'Learn about Catholic saints',
        'image': 'https://images.unsplash.com/photo-1544427920-c49ccfb85579?q=80&w=400',
      },
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Container(
            width: 300,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: AppColors.shadowLight, blurRadius: 10, offset: const Offset(0, 4)),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
                  child: Image.network(game['image'] as String, width: 120, height: 180, fit: BoxFit.cover),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(game['title'] as String, style: AppTextStyles.h5, maxLines: 2),
                            const SizedBox(height: 4),
                            Text(game['subtitle'] as String, style: AppTextStyles.caption, maxLines: 2),
                          ],
                        ),
                        AppButton(
                          text: 'Play',
                          onPressed: () {
                            if (game['screen'] != null) {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => game['screen'] as Widget));
                            }
                          },
                        ),
                      ],
                    ),
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

class _RecommendedGamesList extends StatelessWidget {
  const _RecommendedGamesList();

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'title': 'Catholic Crosswords',
        'subtitle': 'Faith puzzles',
        'image': 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?q=80&w=300',
        'screen': const CatholicCrosswordScreen(),
      },
      {
        'title': 'Rosary Guide',
        'subtitle': 'Interactive prayer',
        'image': 'https://images.unsplash.com/photo-1601058268499-e52658b8bb88?q=80&w=300',
      },
      {
        'title': 'Prayer Journey',
        'subtitle': 'Daily devotions',
        'image': 'https://images.unsplash.com/photo-1507434965515-61970f2bd7c6?q=80&w=300',
      },
    ];

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return GestureDetector(
            onTap: () {
              if (game['screen'] != null) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => game['screen'] as Widget));
              }
            },
            child: Container(
              width: 130,
              margin: const EdgeInsets.only(right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(game['image'] as String, width: 130, height: 130, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Text(game['title'] as String, style: AppTextStyles.subtitle, maxLines: 2),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CatechismQuizCard extends StatelessWidget {
  const _CatechismQuizCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GradientCard(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CatechismQuizScreen())),
        child: Row(
          children: [
            const Icon(Icons.school, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Catechism Quiz", style: AppTextStyles.h5.copyWith(color: Colors.white)),
                  Text("Test your faith knowledge", style: AppTextStyles.caption.copyWith(color: Colors.white70)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _TopChartsSection extends StatelessWidget {
  const _TopChartsSection();

  @override
  Widget build(BuildContext context) {
    final charts = [
      {'rank': '1', 'name': 'Bible Stories', 'image': 'https://images.unsplash.com/photo-1544427920-c49ccfb85579?q=80&w=100'},
      {'rank': '2', 'name': 'Scripture Rush', 'image': 'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?q=80&w=100'},
      {'rank': '3', 'name': 'Praise Party', 'image': 'https://images.unsplash.com/photo-1519750783826-e2420f4d687f?q=80&w=100'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: charts.map((item) {
          return ListTile(
            leading: Text(item['rank']!, style: AppTextStyles.h4.copyWith(color: AppColors.primaryPurple)),
            title: Text(item['name']!, style: AppTextStyles.bodyMedium),
            trailing: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item['image']!, width: 40, height: 40, fit: BoxFit.cover),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _NewUpdatedGamesList extends StatelessWidget {
  const _NewUpdatedGamesList();

  @override
  Widget build(BuildContext context) {
    final games = [
      {'title': 'Angel Quest', 'status': 'NEW', 'image': 'https://images.unsplash.com/photo-1507434965515-61970f2bd7c6?q=80&w=300'},
      {'title': 'Faith Builder', 'status': 'UPDATED', 'image': 'https://images.unsplash.com/photo-1585776245991-cf89dd7fc73a?q=80&w=300'},
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(game['image']!, width: 140, height: 140, fit: BoxFit.cover),
                ),
                const SizedBox(height: 8),
                Text(game['title']!, style: AppTextStyles.label, maxLines: 1),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CollectionsGrid extends StatelessWidget {
  const _CollectionsGrid();

  @override
  Widget build(BuildContext context) {
    final collections = [
      {'name': 'Advent', 'image': 'https://images.unsplash.com/photo-1543589077-47d81606c1bf?q=80&w=200'},
      {'name': 'Saints', 'image': 'https://images.unsplash.com/photo-1544427920-c49ccfb85579?q=80&w=200'},
      {'name': 'Liturgy', 'image': 'https://images.unsplash.com/photo-1519750783826-e2420f4d687f?q=80&w=200'},
      {'name': 'Bible', 'image': 'https://images.unsplash.com/photo-1504052434569-70ad5836ab65?q=80&w=200'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
        ),
        itemCount: collections.length,
        itemBuilder: (context, index) {
          final collection = collections[index];
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CollectionsDetailScreen(name: collection['name']!))),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(collection['image']!),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
              child: Center(
                child: Text(collection['name']!, style: AppTextStyles.h5.copyWith(color: Colors.white)),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final String? action;
  final VoidCallback? onTap;

  const _SectionTitle({required this.title, this.action, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.h4.copyWith(color: AppColors.primaryPurpleDark)),
          if (action != null)
            GestureDetector(
              onTap: onTap ?? () {},
              child: Text(action!,
                  style: AppTextStyles.subtitle.copyWith(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}



// import 'dart:async';

// import 'package:faith_plus/common/constants.dart';
// import 'package:flutter/material.dart';

// class FunZoneScreen extends StatefulWidget {
//   const FunZoneScreen({super.key});

//   @override
//   State<FunZoneScreen> createState() => _FunZoneScreenState();
// }

// class _FunZoneScreenState extends State<FunZoneScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _headerAnimationController;
//   late AnimationController _floatingAnimationController;

//   late Animation<double> _headerSlideAnimation;
//   late Animation<double> _floatingAnimation;

//   int _streakDays = 12;

//   final Color _primaryBlue = const Color(0xFF4A90E2);
//   final Color _softTeal = const Color(0xFF50B5B0);
//   final Color _warmGold = const Color(0xFFD4A574);
//   final Color _roseRed = const Color(0xFFD97687);
//   final Color _sageGreen = const Color(0xFF7CB798);
//   final Color _deepPurple = const Color(0xFF6B5B95);

//   @override
//   void initState() {
//     super.initState();

//     // Header slide-in animation controller
//     _headerAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );

//     // Floating badge animation controller
//     _floatingAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 2000),
//     )..repeat(reverse: true); // Repeats up/down float

//     // Header slide: from -100 to 0 (slides down from above)
//     _headerSlideAnimation = Tween<double>(begin: -100, end: 0).animate(
//       CurvedAnimation(
//         parent: _headerAnimationController,
//         curve: Curves.easeOutCubic,
//       ),
//     );

//     // Floating animation: subtle up/down movement
//     _floatingAnimation = Tween<double>(begin: -10, end: 10).animate(
//       CurvedAnimation(
//         parent: _floatingAnimationController,
//         curve: Curves.easeInOut,
//       ),
//     );

//     // Start header animation
//     _headerAnimationController.forward();
//   }

//   @override
//   void dispose() {
//     _headerAnimationController.dispose();
//     _floatingAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF8F9FA),
//       appBar: const AppTopBar(
//         title: 'Fun Zone',
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 16),
//             child: Icon(Icons.search),
//           ),
//         ],
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(bottom: 24),
//         children: [
//           SizedBox(height: 8),
//           _buildWelcomeHeader(),
//           const SizedBox(height: 20),
//           _UserProfileBanner(),
//           SizedBox(height: 20),
//           _SectionTitle(title: 'Featured for you'),
//           _FeaturedGameCarousel(),
//           SizedBox(height: 24),
//           _SectionTitle(title: 'Recommended games', action: 'See more'),
//           _RecommendedGamesList(),
//           SizedBox(height: 24),
//           _SectionTitle(title: 'Top charts', action: 'See all'),
//           _TopChartsSection(),
//           SizedBox(height: 24),
//           _SectionTitle(title: 'New & updated', action: 'See more'),
//           _NewUpdatedGamesList(),
//           SizedBox(height: 24),
//           _CategoryChipsRow(),
//           SizedBox(height: 24),
//           _SectionTitle(title: 'Collections', action: 'View all'),
//           _CollectionsGrid(),
//         ],
//       ),
//     );
//   }

//   Widget _buildWelcomeHeader() {
//     return AnimatedBuilder(
//       animation: _headerSlideAnimation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _headerSlideAnimation.value),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Play & Learn!",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: _deepPurple,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Discover faith-building games",
//                         style: TextStyle(
//                             fontSize: 14, color: Colors.grey.shade600),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _buildGameBadge(),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildGameBadge() {
//     return AnimatedBuilder(
//       animation: _floatingAnimationController,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(0, _floatingAnimation.value / 2),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                   colors: [const Color(0xFFEC4899), const Color(0xFFF59E0B)]),
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                     color: const Color(0xFFEC4899).withOpacity(0.3),
//                     blurRadius: 12,
//                     offset: const Offset(0, 4)),
//               ],
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.sports_esports, color: Colors.white, size: 20),
//                 const SizedBox(width: 6),
//                 Text("$_streakDays Games",
//                     style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14)),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class _UserProfileBanner extends StatelessWidget {
//   const _UserProfileBanner();

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: const Color(0xFF667EEA).withOpacity(0.3),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Your Gaming Stats',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: const [
//                     Icon(Icons.stars, color: Colors.amber, size: 16),
//                     SizedBox(width: 4),
//                     Text(
//                       'Level 5',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildStatCard('Games Played', '47', Icons.gamepad),
//               _buildStatCard('High Score', '12,450', Icons.emoji_events),
//               _buildStatCard('Achievements', '23', Icons.workspace_premium),
//             ],
//           ),
//           const SizedBox(height: 16),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 Icon(Icons.trending_up, color: Colors.amber, size: 18),
//                 SizedBox(width: 8),
//                 Text(
//                   'You\'re in the top 15% this week!',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatCard(String label, String value, IconData icon) {
//     return Column(
//       children: [
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.2),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Icon(icon, color: Colors.white, size: 24),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white.withOpacity(0.9),
//             fontSize: 11,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String title;
//   final String? action;
//   final VoidCallback? onTap;

//   const _SectionTitle({required this.title, this.action, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                   color: Color(0xFF6B5B95),
//                   fontSize: 20,
//                   fontWeight: FontWeight.w600)),
//           if (action != null)
//             GestureDetector(
//               onTap: onTap ?? () {},
//               child: Text(action!,
//                   style: const TextStyle(
//                       color: Color(0xFF4A90E2),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500)),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _FeaturedGameCarousel extends StatelessWidget {
//   const _FeaturedGameCarousel();

//   @override
//   Widget build(BuildContext context) {
//     final games = [
//       {
//         'title': 'Bible Trivia Challenge',
//         'subtitle': 'Test your biblical knowledge',
//         'rating': '4.8',
//         'downloads': '10K+'
//       },
//       {
//         'title': 'Saints Quest',
//         'subtitle': 'Learn about Catholic saints',
//         'rating': '4.9',
//         'downloads': '5K+'
//       },
//       {
//         'title': 'Scripture Memory',
//         'subtitle': 'Memorize verses daily',
//         'rating': '4.7',
//         'downloads': '8K+'
//       },
//     ];

//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: games.length,
//         itemBuilder: (context, index) {
//           final game = games[index];
//           return Container(
//             width: 340,
//             margin: const EdgeInsets.only(right: 16),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.06),
//                   blurRadius: 8,
//                   offset: const Offset(0, 2),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(12),
//                     bottomLeft: Radius.circular(12),
//                   ),
//                   child: Image.network(
//                     randomPhoto(400, 400),
//                     width: 140,
//                     height: 200,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               game['title']!,
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF1F2937),
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               game['subtitle']!,
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 color: Color(0xFF6B7280),
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 const Icon(Icons.star,
//                                     color: Color(0xFFFBBF24), size: 16),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   game['rating']!,
//                                   style: const TextStyle(
//                                     fontSize: 13,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF1F2937),
//                                   ),
//                                 ),
//                                 const SizedBox(width: 12),
//                                 Text(
//                                   game['downloads']!,
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Color(0xFF6B7280),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 12),
//                             SizedBox(
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 onPressed: () {
//                                   // Navigate to game play screen
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content:
//                                           Text('Launching ${game['title']}...'),
//                                       duration: const Duration(seconds: 1),
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: const Color(0xFF667EEA),
//                                   foregroundColor: Colors.white,
//                                   elevation: 0,
//                                   padding:
//                                       const EdgeInsets.symmetric(vertical: 10),
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                 ),
//                                 child: const Text(
//                                   'Play Now',
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 14,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _RecommendedGamesList extends StatelessWidget {
//   const _RecommendedGamesList();

//   @override
//   Widget build(BuildContext context) {
//     final games = List.generate(
//         5,
//         (i) => {
//               'title': [
//                 'Scripture Word Search',
//                 'Catholic Crosswords',
//                 'Rosary Guide',
//                 'Saint Matching',
//                 'Prayer Timer'
//               ][i],
//               'subtitle': [
//                 'Find biblical words',
//                 'Faith puzzles',
//                 'Interactive prayer',
//                 'Match saints',
//                 'Track prayers'
//               ][i],
//               'rating': ['4.6', '4.7', '4.9', '4.5', '4.8'][i],
//               'size': ['25MB', '18MB', '32MB', '22MB', '15MB'][i],
//             });

//     return SizedBox(
//       height: 280,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: games.length,
//         itemBuilder: (context, index) {
//           final game = games[index];
//           return GestureDetector(
//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Loading ${game['title']}...'),
//                   duration: const Duration(seconds: 1),
//                 ),
//               );
//             },
//             child: Container(
//               width: 140,
//               margin: const EdgeInsets.only(right: 12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       randomPhoto(300, 300),
//                       width: 140,
//                       height: 140,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     game['title']!,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                       color: Color(0xFF1F2937),
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     game['subtitle']!,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF6B7280),
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, color: Color(0xFFFBBF24), size: 14),
//                       const SizedBox(width: 2),
//                       Text(
//                         game['rating']!,
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF1F2937),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     game['size']!,
//                     style: const TextStyle(
//                       fontSize: 11,
//                       color: Color(0xFF9CA3AF),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _TopChartsSection extends StatelessWidget {
//   const _TopChartsSection();

//   @override
//   Widget build(BuildContext context) {
//     final games = [
//       {
//         'rank': '1',
//         'title': 'Bible Stories',
//         'subtitle': 'Interactive stories',
//         'rating': '4.9',
//         'category': 'Educational'
//       },
//       {
//         'rank': '2',
//         'title': 'Faith Quiz',
//         'subtitle': 'Test your knowledge',
//         'rating': '4.8',
//         'category': 'Trivia'
//       },
//       {
//         'rank': '3',
//         'title': 'Prayer Journey',
//         'subtitle': 'Daily devotions',
//         'rating': '4.7',
//         'category': 'Lifestyle'
//       },
//     ];

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: games.asMap().entries.map((entry) {
//           final game = entry.value;
//           final isLast = entry.key == games.length - 1;

//           return Column(
//             children: [
//               ListTile(
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                 leading: Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.1),
//                         blurRadius: 4,
//                       ),
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       randomPhoto(200, 200),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 title: Row(
//                   children: [
//                     Container(
//                       width: 20,
//                       height: 20,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF667EEA),
//                         borderRadius: BorderRadius.circular(4),
//                       ),
//                       child: Text(
//                         game['rank']!,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Text(
//                         game['title']!,
//                         style: const TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: Color(0xFF1F2937),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 subtitle: Padding(
//                   padding: const EdgeInsets.only(left: 28, top: 4),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         game['subtitle']!,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Color(0xFF6B7280),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(Icons.star,
//                               color: Color(0xFFFBBF24), size: 14),
//                           const SizedBox(width: 2),
//                           Text(
//                             game['rating']!,
//                             style: const TextStyle(
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                               color: Color(0xFF1F2937),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           Text(
//                             game['category']!,
//                             style: const TextStyle(
//                               fontSize: 11,
//                               color: Color(0xFF9CA3AF),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 trailing: TextButton(
//                   onPressed: () {},
//                   style: TextButton.styleFrom(
//                     backgroundColor: const Color(0xFFF3F4F6),
//                     foregroundColor: const Color(0xFF667EEA),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Play',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ),
//               ),
//               if (!isLast) const Divider(height: 1, indent: 88, endIndent: 16),
//             ],
//           );
//         }).toList(),
//       ),
//     );
//   }
// }

//   class _NewUpdatedGamesList extends StatefulWidget {
//     const _NewUpdatedGamesList();

//     @override
//     State<_NewUpdatedGamesList> createState() => _NewUpdatedGamesListState();
//   }

//   class _NewUpdatedGamesListState extends State<_NewUpdatedGamesList> {
//     final games = [
//       {
//         'title': 'Bible Heroes',
//         'status': 'NEW',
//         'color': const Color(0xFFEC4899),
//         'icon': Icons.military_tech
//       },
//       {
//         'title': 'Praise Party',
//         'status': 'UPDATED',
//         'color': const Color(0xFF8B5CF6),
//         'icon': Icons.music_note
//       },
//       {
//         'title': 'Faith Builder',
//         'status': 'NEW',
//         'color': const Color(0xFFF59E0B),
//         'icon': Icons.construction
//       },
//       {
//         'title': 'Scripture Rush',
//         'status': 'UPDATED',
//         'color': const Color(0xFF10B981),
//         'icon': Icons.flash_on
//       },
//       {
//         'title': 'Angel Quest',
//         'status': 'NEW',
//         'color': const Color(0xFF3B82F6),
//         'icon': Icons.auto_awesome
//       },
//       {
//         'title': 'Prayer Power',
//         'status': 'UPDATED',
//         'color': const Color(0xFFEF4444),
//         'icon': Icons.favorite
//       },
//     ];

//     @override
//     Widget build(BuildContext context) {
//       return SizedBox(
//         height: 200,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           itemCount: games.length,
//           itemBuilder: (context, index) {
//             final game = games[index];
//             final isNew = game['status'] == 'NEW';

//             return GestureDetector(
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Starting ${game['title']}...'),
//                     duration: const Duration(seconds: 1),
//                   ),
//                 );
//               },
//               child: Container(
//                 width: 140,
//                 margin: const EdgeInsets.only(right: 12),
//                 child: Column(
//                   children: [
//                     Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         // Main game card with gradient
//                         Container(
//                           width: 140,
//                           height: 140,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 (game['color'] as Color).withOpacity(0.7),
//                                 game['color'] as Color,
//                               ],
//                               begin: Alignment.topLeft,
//                               end: Alignment.bottomRight,
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: (game['color'] as Color).withOpacity(0.4),
//                                 blurRadius: 12,
//                                 offset: const Offset(0, 6),
//                               ),
//                             ],
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(20),
//                             child: Stack(
//                               children: [
//                                 // Background pattern
//                                 Positioned.fill(
//                                   child: Opacity(
//                                     opacity: 0.2,
//                                     child: Image.network(
//                                       randomPhoto(300, 300),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                                 // Icon overlay
//                                 Center(
//                                   child: Container(
//                                     width: 60,
//                                     height: 60,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.3),
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(
//                                       game['icon'] as IconData,
//                                       color: Colors.white,
//                                       size: 32,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // NEW/UPDATED Badge
//                         Positioned(
//                           top: -8,
//                           right: -8,
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8,
//                               vertical: 4,
//                             ),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                 colors: isNew
//                                     ? [
//                                         const Color(0xFFFFD700),
//                                         const Color(0xFFFFA500)
//                                       ]
//                                     : [
//                                         const Color(0xFF06B6D4),
//                                         const Color(0xFF0284C7)
//                                       ],
//                               ),
//                               borderRadius: BorderRadius.circular(12),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: (isNew
//                                           ? const Color(0xFFFFD700)
//                                           : const Color(0xFF06B6D4))
//                                       .withOpacity(0.5),
//                                   blurRadius: 8,
//                                   offset: const Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   isNew ? Icons.new_releases : Icons.update,
//                                   color: Colors.white,
//                                   size: 12,
//                                 ),
//                                 const SizedBox(width: 3),
//                                 Text(
//                                   game['status'] as String,
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: 0.5,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         // Sparkle effect
//                         if (isNew)
//                           Positioned(
//                             top: 10,
//                             left: 10,
//                             child: Icon(
//                               Icons.auto_awesome,
//                               color: Colors.white.withOpacity(0.8),
//                               size: 20,
//                             ),
//                           ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     // Game title
//                     Text(
//                       game['title'] as String,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF1F2937),
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 4),
//                     // Play button
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 12,
//                         vertical: 4,
//                       ),
//                       decoration: BoxDecoration(
//                         color: (game['color'] as Color).withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.play_arrow,
//                             size: 14,
//                             color: game['color'] as Color,
//                           ),
//                           const SizedBox(width: 2),
//                           Text(
//                             'PLAY',
//                             style: TextStyle(
//                               fontSize: 11,
//                               fontWeight: FontWeight.bold,
//                               color: game['color'] as Color,
//                               letterSpacing: 0.5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     }
//   }

// class _CategoryChipsRow extends StatelessWidget {
//   const _CategoryChipsRow();

//   @override
//   Widget build(BuildContext context) {
//     final categories = [
//       'All',
//       'Trivia',
//       'Educational',
//       'Puzzle',
//       'Prayer',
//       'Stories'
//     ];

//     return SizedBox(
//       height: 40,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           final isFirst = index == 0;
//           return Container(
//             margin: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               label: Text(categories[index]),
//               selected: isFirst,
//               onSelected: (selected) {},
//               backgroundColor: const Color(0xFFF3F4F6),
//               selectedColor: const Color(0xFF667EEA),
//               labelStyle: TextStyle(
//                 color: isFirst ? Colors.white : const Color(0xFF4B5563),
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14,
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//                 side: BorderSide.none,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class _CollectionsGrid extends StatelessWidget {
//   const _CollectionsGrid();

//   @override
//   Widget build(BuildContext context) {
//     final collections = [
//       {
//         'title': 'Family Games',
//         'icon': Icons.family_restroom,
//         'color': const Color(0xFFEC4899)
//       },
//       {
//         'title': 'Quick Play',
//         'icon': Icons.flash_on,
//         'color': const Color(0xFFF59E0B)
//       },
//       {
//         'title': 'Daily Devotions',
//         'icon': Icons.today,
//         'color': const Color(0xFF8B5CF6)
//       },
//       {
//         'title': 'Learning Path',
//         'icon': Icons.school,
//         'color': const Color(0xFF10B981)
//       },
//     ];

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1.5,
//         ),
//         itemCount: collections.length,
//         itemBuilder: (context, index) {
//           final collection = collections[index];
//           return Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   (collection['color'] as Color).withOpacity(0.8),
//                   collection['color'] as Color,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: (collection['color'] as Color).withOpacity(0.3),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Opening ${collection['title']} games...'),
//                       duration: const Duration(seconds: 1),
//                     ),
//                   );
//                 },
//                 borderRadius: BorderRadius.circular(12),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(
//                         collection['icon'] as IconData,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                       Text(
//                         collection['title'] as String,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
