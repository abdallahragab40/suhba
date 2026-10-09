import 'package:flutter/material.dart';

/// Replaces the grey (release) / red (debug) error box when a widget fails
/// to build in release mode, so a single broken widget never blanks the
/// screen.
///
/// It may be built outside the app's Theme and Localizations, so it relies
/// on neither: a quiet icon in the current text color, labelled in Arabic.
class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key});

  static const semanticLabel = 'تعذّر عرض هذا الجزء';

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      child: const Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.broken_image_outlined,
            size: 24,
            color: Color(0x80888784),
          ),
        ),
      ),
    );
  }
}
