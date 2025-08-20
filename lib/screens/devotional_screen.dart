import 'package:church_app/widgets/constants.dart';
import 'package:flutter/material.dart';

class DevotionalsScreen extends StatelessWidget {
  const DevotionalsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar(
        title: 'Devotionals',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          const SizedBox(height: 12),
          _PrayerStreakCard(),
          const SectionHeader(title: "Today's Devotions"),
          for (int i = 0; i < 3; i++)
            DevotionTile(
              title:
                  ['Mass Readings', 'Divine Office', 'Interactive Rosary'][i],
              subtitle:
                  [
                    'Today\'s Scripture',
                    'Morning Prayer',
                    'Joyful Mysteries',
                  ][i],
              imageUrl: randomPhoto(1200, 700),
              progress: i == 2 ? 0.3 : null,
              actionLabel:
                  i == 1
                      ? 'Pray Now'
                      : i == 2
                      ? 'Resume'
                      : 'Read Now',
            ),
          const SectionHeader(title: 'Quick Prayers'),
          const QuickGrid(),
          const QuoteCard(),
          const VirtualCandles(),
        ],
      ),
    );
  }
}



class VirtualCandles extends StatelessWidget {
  const VirtualCandles({super.key});
  @override
  Widget build(BuildContext context) {
    final labels = ['Peace', 'Healing', 'Family', 'Hope', 'Love'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'Virtual Candles', trailing: '47 lit today'),
        RoundedCard(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: 18,
                runSpacing: 12,
                children: [
                  for (final l in labels)
                    Column(
                      children: [
                        const Icon(
                          Icons.emoji_objects,
                          size: 36,
                          color: Color(0xFFFFB74D),
                        ),
                        const SizedBox(height: 6),
                        Text(l),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD6B259),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Light a Candle',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class DevotionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final double? progress;
  final String actionLabel;
  const DevotionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.progress,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16 / 5,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),
                if (progress != null) ...[
                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  const SizedBox(height: 12),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Material(
                          color: const Color(0xFF0D2856).withOpacity(0.2),
                          shape: const CircleBorder(),
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Icon(
                                Icons.play_arrow,
                                color: Color(0xFF0D2856),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 3),
                        const Text('Listen'),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},

                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D2856),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      child: Text('Read Now'),
                    ),
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



class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});
  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      color: const Color(0xFFFFF5D7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFE39A),
            child: Icon(Icons.format_quote, color: Color(0xFF0D2856)),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '"The world offers you comfort, but you were not made for comfort. You were made for greatness."',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1D2433),
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '— Pope Benedict XVI',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D2856),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



class QuickGrid extends StatelessWidget {
  const QuickGrid({super.key});
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Divine Mercy', Icons.favorite_border, '3:00 PM Prayer,', Colors.red),
      ('Angelus', Icons.timelapse, '12:00 PM Prayer', const Color(0xFF0D2856)),
      (
        'Light Candle',
        Icons.emoji_objects_outlined,
        'Virtual Prayer',
        Colors.yellow,
      ),
      ('Prayer Circle', Icons.groups_outlined, 'Join Community', Colors.green),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.7,
        ),
        itemCount: items.length,
        itemBuilder: (context, i) {
          final it = items[i];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: (it.$4 as Color).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Icon(it.$2, size: 28, color: it.$4 as Color),
                ),
                const SizedBox(height: 8),
                Text(
                  it.$1,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(it.$3, style: const TextStyle(color: Colors.black54)),
              ],
            ),
          );
        },
      ),
    );
  }
}




class _PrayerStreakCard extends StatelessWidget {
  const _PrayerStreakCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0D2856), Color.fromARGB(255, 18, 63, 148)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Prayer Streak',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const Icon(
                        Icons.local_fire_department,
                        color: Color.fromARGB(255, 225, 88, 14),
                        size: 40,
                      ),
                    ],
                  ),

                  SizedBox(height: 6),
                  Text(
                    '27 days in a row',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}