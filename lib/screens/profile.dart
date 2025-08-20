
import 'package:church_app/widgets/constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(title: 'Profile'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: const [
          SizedBox(height: 12),
          _ProfileHeader(),
          _StatsRow(),
          _LevelProgress(),
          _BadgesStrip(),
          _RecentActivityList(),
          _AccountSettingsList(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Sarah Johnson\n@serahjohnson\n"Walking with faith, learning through play, growing in His love every day."',
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
        ],
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();
  @override
  Widget build(BuildContext context) {
    final stats = [
      ('2,450', 'Total Points'),
      ('Level 8', 'Current Level'),
      ('15', 'Badges Earned'),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (int i = 0; i < stats.length; i++) ...[
            Expanded(
              child: RoundedCard(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                child: Column(
                  children: [
                    Text(
                      stats[i].$1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stats[i].$2,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ),
            if (i < stats.length - 1) const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _LevelProgress extends StatelessWidget {
  const _LevelProgress();
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Game Statistics',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          const Text('Level Progress'),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.75,
            minHeight: 10,
            borderRadius: BorderRadius.circular(8),
          ),
          const SizedBox(height: 8),
          const Text(
            'Level 8 · 75% · 2,400 pts needed',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _BadgesStrip extends StatelessWidget {
  const _BadgesStrip();
  @override
  Widget build(BuildContext context) {
    final badges = [
      'Bible Master',
      'Saint Scholar',
      'Prayer Warrior',
      'Memory Expert',
      'Scripture Sage',
    ];
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Achievement Badges',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF1E63FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 8),
                for (final b in badges)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Color(0xFFE8F3FF),
                          child: Icon(Icons.emoji_events_outlined),
                        ),
                        const SizedBox(height: 6),
                        Text(b),
                      ],
                    ),
                  ),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentActivityList extends StatelessWidget {
  const _RecentActivityList();
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Completed Bible Trivia Challenge', '+150 pts'),
      ('Earned "Saint Scholar" Badge', 'Badge'),
      ('Played Saint Matching Game', '+25 pts'),
      ('Started 7-Day Prayer Streak', 'Streak'),
    ];
    return RoundedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                child: Text(
                  'Recent Activity',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Text(
                'See More',
                style: TextStyle(
                  color: Color(0xFF1E63FF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          for (final it in items)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFEFF2F8),
                child: Icon(Icons.check_circle_outline),
              ),
              title: Text(it.$1),
              trailing: Text(
                it.$2,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1E63FF),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AccountSettingsList extends StatelessWidget {
  const _AccountSettingsList();
  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.edit_outlined, 'Edit Profile'),
      (Icons.notifications_none, 'Notifications'),
      (Icons.lock_outline, 'Privacy Settings'),
      (Icons.help_outline, 'Help & Support'),
      (Icons.info_outline, 'About App'),
    ];
    return RoundedCard(
      child: Column(
        children: [
          for (final it in items)
            ListTile(
              leading: Icon(it.$1),
              title: Text(it.$2),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          const SizedBox(height: 4),
          FilledButton.tonal(
            style: FilledButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () {},
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}