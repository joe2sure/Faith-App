import 'package:flutter/material.dart';
import 'package:faith_plus/core/constants/app_colors.dart';
import 'package:faith_plus/core/themes/text_styles.dart';
import 'package:faith_plus/common/reusable_widget.dart';
import 'package:faith_plus/common/constants.dart';

class CatholicCrosswordScreen extends StatelessWidget {
  const CatholicCrosswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: AppBar(
          backgroundColor: const Color(0xFF0D2856),
          foregroundColor: Colors.white,
          title: const Text("Catholic Crossword"),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: AppColors.accentGold,
            tabs: [
              Tab(text: "Virtues & Vices"),
              Tab(text: "Know Your Saints"),
              Tab(text: "Bible People"),
              Tab(text: "Liturgy Scramble"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _VirtuesTab(),
            _SaintsTab(),
            _BibleMatchTab(),
            _LiturgyScrambleTab(),
          ],
        ),
      ),
    );
  }
}

class _VirtuesTab extends StatelessWidget {
  const _VirtuesTab();
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildPuzzleItem("Identifying Virtues", "The opposite of Pride is..."),
        _buildPuzzleItem("Fruits of the Spirit", "Found in Galatians 5..."),
        _buildPuzzleItem("Capital Sins", "There are seven..."),
      ],
    );
  }
  Widget _buildPuzzleItem(String title, String hint) {
    return Card(child: ListTile(title: Text(title), subtitle: Text(hint), trailing: const Icon(Icons.edit)));
  }
}

class _SaintsTab extends StatelessWidget {
  const _SaintsTab();
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Match Saint with Virtue/Status (Martyr, Virgin, etc.)", style: AppTextStyles.bodyMedium));
  }
}

class _BibleMatchTab extends StatelessWidget {
  const _BibleMatchTab();
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Match People and Places from the Bible", style: AppTextStyles.bodyMedium));
  }
}

class _LiturgyScrambleTab extends StatelessWidget {
  const _LiturgyScrambleTab();
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Scramble Game: Identify Liturgy Seasons & Objects", style: AppTextStyles.bodyMedium));
  }
}
