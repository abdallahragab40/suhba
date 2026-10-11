import 'package:flutter/widgets.dart';
import 'package:suhba/core/text/honorifics.dart';
import 'package:suhba/shared/content/domain/catalog.dart';
import 'package:suhba/shared/content/domain/companion.dart';
import 'package:suhba/shared/content/domain/localized_text.dart';

extension LocalizedTextInContext on LocalizedText {
  /// The text in the app's current language.
  String of(BuildContext context) =>
      resolve(Localizations.localeOf(context).languageCode);
}

/// رضي الله عنه / عنها for a Companion of [gender].
String companionHonorific(Gender gender) => Honorifics.companion(
  gender == Gender.female ? HonorificSubject.woman : HonorificSubject.man,
);

/// The honorific for a person outside the catalog, or null for none.
String? personHonorific(Person person) => switch (person.honorific) {
  PersonHonorific.sahabi => companionHonorific(person.gender ?? Gender.male),
  PersonHonorific.prophet => Honorifics.prophet,
  PersonHonorific.alayhiSalam => Honorifics.alayhiSalam,
  PersonHonorific.none => null,
};
