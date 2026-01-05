import 'package:flutter/material.dart';
import 'package:faith_plus/common/constants.dart';
import 'package:faith_plus/core/constants/app_colors.dart';

class CollectionsDetailScreen extends StatelessWidget {
  final String name;
  const CollectionsDetailScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppTopBar(title: "$name Collection"),
      body: Center(
        child: Text("Showing all games in $name collection..."),
      ),
    );
  }
}
