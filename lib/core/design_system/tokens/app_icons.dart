import 'package:flutter/material.dart';

/// Icons with a project rule attached.
///
/// Decision D5 bans depicting the Companions, and the 2026-11-16 review
/// (decision 4) counts stock person glyphs as depictions. Anything that
/// stands for the Companions uses these non-figurative icons, and a chip
/// that names a Companion carries no icon at all.
abstract final class AppIcons {
  /// The Companions directory: a list of names, not a group of people.
  static const companions = Icons.list_alt_outlined;
  static const companionsSelected = Icons.list_alt;

  /// "Companion not found" and similar empty states.
  static const companionMissing = Icons.manage_search_outlined;
}
