import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/themes/text_styles.dart';


class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final bool isLoading;
  
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.isLoading = false,
  });
  
  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : icon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, size: 18),
                      const SizedBox(width: 8),
                      Text(text, style: AppTextStyles.button),
                    ],
                  )
                : Text(text, style: AppTextStyles.button),
      );
    } else {
      return OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryPurple,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: AppColors.primaryPurple, width: 1.5),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 8),
                  Text(text, style: AppTextStyles.button),
                ],
              )
            : Text(text, style: AppTextStyles.button),
      );
    }
  }
}

class StreakBadge extends StatelessWidget {
  final int streakCount;
  final bool isFloating;
  
  const StreakBadge({
    super.key,
    required this.streakCount,
    this.isFloating = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.local_fire_department, color: Colors.white, size: 20),
          const SizedBox(width: 6),
          Text(
            "$streakCount Day${streakCount != 1 ? 's' : ''}",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final List<Color>? gradientColors;
  final double borderRadius;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  
  const GradientCard({
    super.key,
    required this.child,
    this.gradientColors,
    this.borderRadius = 16,
    this.padding,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors ?? [AppColors.primaryPurple, AppColors.primaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: (gradientColors?[0] ?? AppColors.primaryPurple).withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback? onActionTap;
  
  const SectionHeader({
    super.key,
    required this.title,
    required this.actionText,
    this.onActionTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyles.h4.copyWith(color: AppColors.primaryPurple)),
          GestureDetector(
            onTap: onActionTap,
            child: Text(
              actionText,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primaryPurple,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final double size;
  final bool isOutlined;
  
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.size = 20,
    this.isOutlined = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : (color ?? AppColors.primaryPurple).withOpacity(0.1),
        border: isOutlined ? Border.all(color: color ?? AppColors.primaryPurple, width: 1.5) : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: color ?? AppColors.primaryPurple, size: size),
        padding: const EdgeInsets.all(8),
      ),
    );
  }
}

class FaithCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final List<Widget>? actions;
  final Color? color;
  
  const FaithCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.leading,
    this.onTap,
    this.actions,
    this.color,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: (color ?? AppColors.primaryPurple).withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyles.h5.copyWith(color: color ?? AppColors.primaryPurple)),
                        const SizedBox(height: 4),
                        Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
              if (actions != null) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}




// class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final List<Widget>? actions;
//   final Widget? leading;
//   final bool centerTitle;
  
//   const AppTopBar({
//     super.key,
//     required this.title,
//     this.actions,
//     this.leading,
//     this.centerTitle = false,
//   });
  
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: Text(title, style: AppTextStyles.h4.copyWith(color: Colors.white)),
//       centerTitle: centerTitle,
//       backgroundColor: AppColors.primaryPurple,
//       foregroundColor: Colors.white,
//       elevation: 0,
//       leading: leading,
//       actions: actions,
//       flexibleSpace: Container(
//         decoration: const BoxDecoration(
//           gradient: AppColors.primaryGradient,
//         ),
//       ),
//     );
//   }
// }