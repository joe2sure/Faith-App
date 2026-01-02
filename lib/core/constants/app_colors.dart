import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - Based on your requirements
  static const Color primaryBlue = Color(0xFF5B7C99);
  static const Color primaryBlueDark = Color(0xFF3E5469);
  static const Color primaryPurple = Color(0xFF9B7EBD);
  static const Color primaryPurpleDark = Color(0xFF6B5B95);
  
  // Secondary Colors
  static const Color secondaryBlue = Color(0xFF7A9BB5);
  static const Color secondaryPurple = Color(0xFFB399D0);
  
  // Accent Colors
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color accentTeal = Color(0xFF5C9EAD);
  static const Color accentRose = Color(0xFFB88B9D);
  static const Color accentCoral = Color(0xFFE8998D);
  
  // Neutral Colors
  static const Color backgroundLight = Color(0xFFF5F7FA);
  static const Color backgroundWhite = Colors.white;
  static const Color textPrimary = Color(0xFF2C3E50);
  static const Color textSecondary = Color(0xFF7F8C8D);
  static const Color divider = Color(0xFFE8EEF2);
  
  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPurpleDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient blueGradient = LinearGradient(
    colors: [primaryBlue, primaryBlueDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient mixedGradient = LinearGradient(
    colors: [primaryBlue, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFE8C468), accentGold],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  // Feature Specific Colors
  static const Color morningPrayer = Color(0xFF9B7EBD);
  static const Color scriptureReading = Color(0xFF5B7C99);
  static const Color rosary = Color(0xFF6B5B95);
  static const Color eveningReflection = Color(0xFF3E5469);
  
  // Status Colors
  static const Color success = Color(0xFF5C9E7F);
  static const Color warning = Color(0xFFD4AF37);
  static const Color error = Color(0xFFB85C5C);
  static const Color info = primaryBlue;
  
  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.08);
  static Color shadowMedium = Colors.black.withOpacity(0.12);
  static Color shadowDark = Colors.black.withOpacity(0.16);
}




// import 'package:flutter/material.dart';

// class AppColors {
//   // Primary Colors
//   static const Color primaryPurple = Color(0xFF673AB7); // Deep Purple
//   static const Color primaryBlue = Color(0xFF2196F3); // Primary Blue
  
//   // Secondary Colors
//   static const Color secondaryPurple = Color(0xFF9575CD); // Light Purple
//   static const Color secondaryBlue = Color(0xFF64B5F6); // Light Blue
  
//   // Accent Colors
//   static const Color accentGold = Color(0xFFFFB74D);
//   static const Color accentTeal = Color(0xFF4DB6AC);
//   static const Color accentRose = Color(0xFFE57373);
  
//   // Neutral Colors
//   static const Color backgroundLight = Color(0xFFFAFAFA);
//   static const Color backgroundWhite = Colors.white;
//   static const Color textPrimary = Color(0xFF212121);
//   static const Color textSecondary = Color(0xFF757575);
//   static const Color divider = Color(0xFFE0E0E0);
  
//   // Gradient Colors
//   static const LinearGradient primaryGradient = LinearGradient(
//     colors: [primaryPurple, primaryBlue],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
  
//   static const LinearGradient secondaryGradient = LinearGradient(
//     colors: [secondaryPurple, secondaryBlue],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
  
//   static const LinearGradient goldGradient = LinearGradient(
//     colors: [Color(0xFFFFD54F), Color(0xFFFFB74D)],
//     begin: Alignment.topLeft,
//     end: Alignment.bottomRight,
//   );
  
//   // Feature Specific Colors
//   static const Color morningPrayer = Color(0xFFFF9800);
//   static const Color scriptureReading = primaryBlue;
//   static const Color rosary = primaryPurple;
//   static const Color eveningReflection = Color(0xFF607D8B);
  
//   // Status Colors
//   static const Color success = Color(0xFF4CAF50);
//   static const Color warning = Color(0xFFFFC107);
//   static const Color error = Color(0xFFF44336);
//   static const Color info = primaryBlue;
  
//   // Shadow Colors
//   static Color shadowLight = Colors.black.withOpacity(0.08);
//   static Color shadowMedium = Colors.black.withOpacity(0.12);
//   static Color shadowDark = Colors.black.withOpacity(0.16);
// }