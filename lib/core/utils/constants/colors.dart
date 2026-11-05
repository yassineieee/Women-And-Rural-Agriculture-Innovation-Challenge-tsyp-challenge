
import 'package:flutter/material.dart';

// ============================================================
// 7RAYER (حراير) — COLOR PALETTE
// Main: Burgundy Red
// Secondary: Warm Gold
// Background: Warm Ivory
// Accent: Soft Rose
// ============================================================

// -------------------- PRIMARY COLORS --------------------

const Color primaryRed = Color(0xFF9F1833); // 7rayer Burgundy Red
const Color primaryGreen = Color(0xFF2AC17E); // Success Green

// Legacy name preserved for compatibility.
// It now uses the 7rayer burgundy color instead of blue.
const Color primaryBlue = Color(0xFF9F1833);

// -------------------- SECONDARY COLORS --------------------

const Color secondaryPurple = Color(0xFF7B243C); // Deep Burgundy
const Color secondaryOlive = Color(0xFF859D3F); // Natural Olive
const Color secondaryOrange = Color(0xFFD6A15B); // Warm Gold

// Legacy name preserved for compatibility.
const Color secondarySkyBlue = Color(0xFFC65E73); // Dusty Rose

// -------------------- COMMON COLORS --------------------

const Color error = Color(0xFFFF4C4C);
const Color success = Color(0xFF4CAF50);
const Color warning = Color(0xFFFFC107);
const Color info = Color(0xFF2196F3);
const Color transparent = Colors.transparent;

// -------------------- ACCENT COLORS --------------------

const Color accentRedText = Color(0xFF9F1833);

// -------------------- LIGHT THEME --------------------

const Color lightPrimary = Color(0xFF9F1833);
const Color lightAccent = Color(0xFFF4D7DC);
const Color lightBackground = Color(0xFFFFF8F3);
const Color lightSurface = Color(0xFFFFFFFF);
const Color lightText = Color(0xFF352B2E);

// -------------------- DARK THEME --------------------

const Color darkPrimary = Color(0xFFD5677D);
const Color darkAccent = Color(0xFFE8AEB8);
const Color darkBackground = Color(0xFF21151A);
const Color darkSurface = Color(0xFF342027);
const Color darkText = Color(0xFFFCECEF);

// ============================================================
// TC COLORS — MAIN APPLICATION THEME
// ============================================================

class TColors {

  // -------------------- APP THEME COLORS --------------------

  static const Color primary = Color(0xFF9F1833);
  static const Color secondary = Color(0xFFD6A15B);
  static const Color accent = Color(0xFFF4D7DC);

  // -------------------- TEXT COLORS --------------------

  static const Color textPrimary = Color(0xFF352B2E);
  static const Color textSecondary = Color(0xFF75656A);
  static const Color textWhite = Colors.white;

  // -------------------- BACKGROUND COLORS --------------------

  static const Color light = Color(0xFFFFF8F3);
  static const Color dark = Color(0xFF21151A);

  static const Color primaryBackground = Color(0xFFFFF8F3);

  // -------------------- CONTAINER COLORS --------------------

  static const Color lightContainer = Color(0xFFFFF0EA);

  static Color darkContainer =
      TColors.white.withValues(alpha: 0.1);

  // -------------------- BUTTON COLORS --------------------

  static const Color buttonPrimary = Color(0xFF9F1833);
  static const Color buttonSecondary = Color(0xFFD6A15B);
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  // -------------------- BORDER COLORS --------------------

  static const Color borderPrimary = Color(0xFFE8CFD3);
  static const Color borderSecondary = Color(0xFFF0E3E3);

  // -------------------- ERROR AND VALIDATION COLORS --------------------

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);

  // -------------------- NEUTRAL SHADES --------------------

  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
