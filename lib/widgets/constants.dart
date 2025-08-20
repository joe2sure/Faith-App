
import 'package:flutter/material.dart';

class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const AppTopBar({super.key, required this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF0D2856),
      foregroundColor: Colors.white,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      centerTitle: false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  const SectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1D2433),
            ),
          ),
          const Spacer(),
          if (trailing != null)
            Text(
              trailing!,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E63FF),
              ),
            ),
        ],
      ),
    );
  }
}


class RoundedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? color;
  const RoundedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final EdgeInsets padding;
  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D2856),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: padding,
      ),
      onPressed: onPressed,
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}

String randomPhoto([int w = 1200, int h = 800]) =>
    'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=$w&q=80&h=$h';