import 'package:meta/meta.dart';

/// Where a reader is in a passage.
///
/// [blockIndex] and [blockOffset] anchor the position to the content: the
/// block at the top of the screen and how far into it (0–1). They survive a
/// change of text size or screen width, which moves every block. Block
/// indices are only meaningful for the same revision of the passage, which
/// the caller checks. [fraction] (0–1 of the scrollable height) is the
/// fallback when there is no anchor.
@immutable
class PassagePosition {
  const PassagePosition({
    required this.fraction,
    this.blockIndex,
    this.blockOffset,
  });

  static const start = PassagePosition(fraction: 0);

  final double fraction;
  final int? blockIndex;
  final double? blockOffset;

  bool get hasAnchor => blockIndex != null && blockOffset != null;

  @override
  bool operator ==(Object other) =>
      other is PassagePosition &&
      other.fraction == fraction &&
      other.blockIndex == blockIndex &&
      other.blockOffset == blockOffset;

  @override
  int get hashCode => Object.hash(fraction, blockIndex, blockOffset);

  @override
  String toString() =>
      'PassagePosition($fraction, block $blockIndex @ $blockOffset)';
}
