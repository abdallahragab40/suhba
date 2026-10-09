import 'package:flutter/widgets.dart';

/// Motion tokens. Motion explains or guides; it is never decorative.
abstract final class AppMotion {
  /// The reference site's single easing curve: cubic-bezier(.22, 1, .36, 1).
  static const Curve easeStandard = Cubic(0.22, 1, 0.36, 1);

  static const short = Duration(milliseconds: 150);
  static const medium = Duration(milliseconds: 250);
  static const long = Duration(milliseconds: 400);

  /// [duration], or zero when the user has asked to reduce motion.
  static Duration resolve(BuildContext context, Duration duration) =>
      MediaQuery.disableAnimationsOf(context) ? Duration.zero : duration;
}
