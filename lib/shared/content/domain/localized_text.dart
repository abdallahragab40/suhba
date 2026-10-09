import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_text.freezed.dart';

/// Text in Arabic (always present) and, later, English.
@freezed
abstract class LocalizedText with _$LocalizedText {
  const factory LocalizedText({required String ar, String? en}) =
      _LocalizedText;

  const LocalizedText._();

  /// The text for [languageCode], falling back to Arabic.
  String resolve(String languageCode) => languageCode == 'en' ? (en ?? ar) : ar;
}
