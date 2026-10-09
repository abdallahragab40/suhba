import 'package:flutter/widgets.dart';

/// Corner radii.
abstract final class AppRadii {
  /// Chips and small controls.
  static const sm = Radius.circular(8);

  /// Cards.
  static const md = Radius.circular(16);

  /// Hero and media frames (as on the reference site).
  static const lg = Radius.circular(24);

  /// Pills and badges.
  static const pill = Radius.circular(999);
}
