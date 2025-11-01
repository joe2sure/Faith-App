import 'package:faith_plus/common/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(height: 100),
                _ProfileInfo(),
                SizedBox(height: 24),
                _StatsCards(),
                SizedBox(height: 20),
                _LevelProgressCard(),
                SizedBox(height: 20),
                _AchievementsBadges(),
                SizedBox(height: 20),
                _ActivityTimeline(),
                SizedBox(height: 20),
                _SettingsSection(),
                SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFF6366F1),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -50,
                right: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.share_outlined, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();
  
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -80),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 56,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Sarah Johnson',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            '@serahjohnson',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F9FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF6366F1).withOpacity(0.2),
              ),
            ),
            child: const Text(
              '"Walking with faith, learning through play, growing in His love every day."',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF4B5563),
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCards extends StatelessWidget {
  const _StatsCards();
  
  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        'value': '2,450',
        'label': 'Total Points',
        'icon': Icons.stars,
        'color': const Color(0xFFF59E0B),
        'bgColor': const Color(0xFFFEF3C7),
      },
      {
        'value': 'Level 8',
        'label': 'Current Level',
        'icon': Icons.emoji_events,
        'color': const Color(0xFF6366F1),
        'bgColor': const Color(0xFFE0E7FF),
      },
      {
        'value': '15',
        'label': 'Badges Earned',
        'icon': Icons.workspace_premium,
        'color': const Color(0xFFEC4899),
        'bgColor': const Color(0xFFFCE7F3),
      },
    ];
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: stats.map((stat) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: stat['bgColor'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      stat['icon'] as IconData,
                      color: stat['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    stat['value'] as String,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat['label'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LevelProgressCard extends StatelessWidget {
  const _LevelProgressCard();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Level Progress',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '75%',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '8',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.75,
                      child: Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '9',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '1,800 / 2,400 pts',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.trending_up, color: Colors.white, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '600 pts to next level',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AchievementsBadges extends StatelessWidget {
  const _AchievementsBadges();
  
  @override
  Widget build(BuildContext context) {
    final badges = [
      {'name': 'Bible Master', 'icon': Icons.menu_book, 'color': const Color(0xFF3B82F6)},
      {'name': 'Saint Scholar', 'icon': Icons.school, 'color': const Color(0xFF8B5CF6)},
      {'name': 'Prayer Warrior', 'icon': Icons.favorite, 'color': const Color(0xFFEC4899)},
      {'name': 'Memory Expert', 'icon': Icons.psychology, 'color': const Color(0xFF10B981)},
      {'name': 'Scripture Sage', 'icon': Icons.auto_stories, 'color': const Color(0xFFF59E0B)},
      {'name': 'Devotion Pro', 'icon': Icons.star, 'color': const Color(0xFFEF4444)},
    ];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Achievement Badges',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.85,
            ),
            itemCount: badges.length,
            itemBuilder: (context, index) {
              final badge = badges[index];
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: (badge['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (badge['color'] as Color).withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Icon(
                      badge['icon'] as IconData,
                      color: badge['color'] as Color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    badge['name'] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4B5563),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _ActivityTimeline extends StatelessWidget {
  const _ActivityTimeline();
  
  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Completed Bible Trivia Challenge',
        'subtitle': '2 hours ago',
        'points': '+150 pts',
        'icon': Icons.check_circle,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Earned "Saint Scholar" Badge',
        'subtitle': '5 hours ago',
        'points': 'Badge',
        'icon': Icons.workspace_premium,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'Played Saint Matching Game',
        'subtitle': 'Yesterday',
        'points': '+25 pts',
        'icon': Icons.gamepad,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Started 7-Day Prayer Streak',
        'subtitle': '2 days ago',
        'points': 'Streak',
        'icon': Icons.local_fire_department,
        'color': const Color(0xFFF59E0B),
      },
    ];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F2937),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See More',
                  style: TextStyle(
                    color: Color(0xFF6366F1),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...activities.map((activity) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (activity['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      color: activity['color'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'] as String,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          activity['subtitle'] as String,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: (activity['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      activity['points'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: activity['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  const _SettingsSection();
  
  @override
  Widget build(BuildContext context) {
    final settings = [
      {'icon': Icons.person_outline, 'title': 'Edit Profile', 'subtitle': 'Update your information'},
      {'icon': Icons.notifications_none, 'title': 'Notifications', 'subtitle': 'Manage notifications'},
      {'icon': Icons.lock_outline, 'title': 'Privacy Settings', 'subtitle': 'Control your privacy'},
      {'icon': Icons.help_outline, 'title': 'Help & Support', 'subtitle': 'Get help and support'},
      {'icon': Icons.info_outline, 'title': 'About App', 'subtitle': 'Version 2.1.0'},
    ];
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ...settings.map((setting) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  setting['icon'] as IconData,
                  color: const Color(0xFF6366F1),
                  size: 22,
                ),
              ),
              title: Text(
                setting['title'] as String,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              subtitle: Text(
                setting['subtitle'] as String,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF9CA3AF),
              ),
              onTap: () {},
            );
          }).toList(),
          const Divider(height: 24, indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, size: 20),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                  side: const BorderSide(color: Color(0xFFEF4444)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}





// import 'package:faith_plus/common/constants.dart';
// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const AppTopBar(title: 'Profile'),
//       body: ListView(
//         padding: const EdgeInsets.only(bottom: 24),
//         children: const [
//           SizedBox(height: 12),
//           _ProfileHeader(),
//           _StatsRow(),
//           _LevelProgress(),
//           _BadgesStrip(),
//           _RecentActivityList(),
//           _AccountSettingsList(),
//           SizedBox(height: 24),
//         ],
//       ),
//     );
//   }
// }

// class _ProfileHeader extends StatelessWidget {
//   const _ProfileHeader();
//   @override
//   Widget build(BuildContext context) {
//     return RoundedCard(
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 28,
//             backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
//           ),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Text(
//               'Sarah Johnson\n@serahjohnson\n"Walking with faith, learning through play, growing in His love every day."',
//             ),
//           ),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
//         ],
//       ),
//     );
//   }
// }

// class _StatsRow extends StatelessWidget {
//   const _StatsRow();
//   @override
//   Widget build(BuildContext context) {
//     final stats = [
//       ('2,450', 'Total Points'),
//       ('Level 8', 'Current Level'),
//       ('15', 'Badges Earned'),
//     ];
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           for (int i = 0; i < stats.length; i++) ...[
//             Expanded(
//               child: RoundedCard(
//                 margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
//                 child: Column(
//                   children: [
//                     Text(
//                       stats[i].$1,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w800,
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       stats[i].$2,
//                       style: const TextStyle(color: Colors.black54),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             if (i < stats.length - 1) const SizedBox(width: 12),
//           ],
//         ],
//       ),
//     );
//   }
// }

// class _LevelProgress extends StatelessWidget {
//   const _LevelProgress();
//   @override
//   Widget build(BuildContext context) {
//     return RoundedCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Game Statistics',
//             style: TextStyle(fontWeight: FontWeight.w700),
//           ),
//           const SizedBox(height: 12),
//           const Text('Level Progress'),
//           const SizedBox(height: 8),
//           LinearProgressIndicator(
//             value: 0.75,
//             minHeight: 10,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           const SizedBox(height: 8),
//           const Text(
//             'Level 8 · 75% · 2,400 pts needed',
//             style: TextStyle(color: Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _BadgesStrip extends StatelessWidget {
//   const _BadgesStrip();
//   @override
//   Widget build(BuildContext context) {
//     final badges = [
//       'Bible Master',
//       'Saint Scholar',
//       'Prayer Warrior',
//       'Memory Expert',
//       'Scripture Sage',
//     ];
//     return RoundedCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Achievement Badges',
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//               ),
//               Text(
//                 'View All',
//                 style: TextStyle(
//                   color: Color(0xFF1E63FF),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               children: [
//                 const SizedBox(width: 8),
//                 for (final b in badges)
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Column(
//                       children: [
//                         const CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Color(0xFFE8F3FF),
//                           child: Icon(Icons.emoji_events_outlined),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(b),
//                       ],
//                     ),
//                   ),
//                 const SizedBox(width: 8),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _RecentActivityList extends StatelessWidget {
//   const _RecentActivityList();
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       ('Completed Bible Trivia Challenge', '+150 pts'),
//       ('Earned "Saint Scholar" Badge', 'Badge'),
//       ('Played Saint Matching Game', '+25 pts'),
//       ('Started 7-Day Prayer Streak', 'Streak'),
//     ];
//     return RoundedCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   'Recent Activity',
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//               ),
//               Text(
//                 'See More',
//                 style: TextStyle(
//                   color: Color(0xFF1E63FF),
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           for (final it in items)
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const CircleAvatar(
//                 backgroundColor: Color(0xFFEFF2F8),
//                 child: Icon(Icons.check_circle_outline),
//               ),
//               title: Text(it.$1),
//               trailing: Text(
//                 it.$2,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF1E63FF),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// class _AccountSettingsList extends StatelessWidget {
//   const _AccountSettingsList();
//   @override
//   Widget build(BuildContext context) {
//     final items = [
//       (Icons.edit_outlined, 'Edit Profile'),
//       (Icons.notifications_none, 'Notifications'),
//       (Icons.lock_outline, 'Privacy Settings'),
//       (Icons.help_outline, 'Help & Support'),
//       (Icons.info_outline, 'About App'),
//     ];
//     return RoundedCard(
//       child: Column(
//         children: [
//           for (final it in items)
//             ListTile(
//               leading: Icon(it.$1),
//               title: Text(it.$2),
//               trailing: const Icon(Icons.chevron_right),
//               onTap: () {},
//             ),
//           const SizedBox(height: 4),
//           FilledButton.tonal(
//             style: FilledButton.styleFrom(foregroundColor: Colors.red),
//             onPressed: () {},
//             child: const Text('Sign Out'),
//           ),
//         ],
//       ),
//     );
//   }
// }
