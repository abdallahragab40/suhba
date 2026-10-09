import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/text/arabic_normalizer.dart';
import 'package:siyar_sahaba/core/text/honorifics.dart';

void main() {
  group('ArabicNormalizer', () {
    final cases = <(String, String, String)>[
      ('hamza on alef', 'أبو بكر', 'ابو بكر'),
      ('tanween and kasra', 'أبو بكرٍ', 'ابو بكر'),
      ('shadda and fatha', 'الصِّدِّيق', 'الصديق'),
      ('alef with hamza below', 'إبراهيم', 'ابراهيم'),
      ('alef madda', 'آل عمران', 'ال عمران'),
      ('alef wasla', 'ٱلرحمن', 'الرحمن'),
      ('superscript alef', 'علىٰ', 'علي'),
      ('alef maqsura', 'موسى', 'موسي'),
      ('ta marbuta', 'مكّة', 'مكه'),
      ('waw with hamza', 'مسؤول', 'مسوول'),
      ('ya with hamza', 'رئيس', 'رييس'),
      ('lone hamza is kept', 'سماء', 'سماء'),
      ('tatweel', 'عـــمر', 'عمر'),
      ('Arabic-Indic digits', 'سنة ١٣', 'سنه 13'),
      ('Eastern Arabic-Indic digits', '۱۳', '13'),
      ('Persian kaf and ya', 'کتابی', 'كتابي'),
      ('Latin is lowercased', 'Abu BAKR', 'abu bakr'),
      ('Arabic comma and question mark', 'الهجرة، بدر؟', 'الهجره بدر'),
      ('brackets and dashes', '﴿ثاني اثنين﴾ - الغار', 'ثاني اثنين الغار'),
      ('whitespace is collapsed and trimmed', '  أبو   بكر  ', 'ابو بكر'),
      ('honorific ligature is dropped', 'النبي ﷺ', 'النبي'),
      ('empty', '', ''),
      ('only marks', 'ًٌٍ', ''),
    ];
    for (final (name, input, expected) in cases) {
      test(name, () => expect(ArabicNormalizer.normalize(input), expected));
    }

    test('spelling variants of the same name match', () {
      final variants = [
        'أبو بكرٍ الصِّدِّيق',
        'ابو بكر الصديق',
        'أَبُو بَكْر الصديق',
      ];
      expect(variants.map(ArabicNormalizer.normalize).toSet(), hasLength(1));
    });
  });

  group('Honorifics', () {
    test('forms by subject', () {
      expect(Honorifics.companion(HonorificSubject.man), 'رضي الله عنه');
      expect(Honorifics.companion(HonorificSubject.woman), 'رضي الله عنها');
      expect(Honorifics.companion(HonorificSubject.pair), 'رضي الله عنهما');
      expect(Honorifics.companion(HonorificSubject.group), 'رضي الله عنهم');
      expect(Honorifics.prophet, 'ﷺ');
    });

    test('subject from count and gender', () {
      expect(Honorifics.subjectFor(count: 1), HonorificSubject.man);
      expect(
        Honorifics.subjectFor(count: 1, allWomen: true),
        HonorificSubject.woman,
      );
      expect(Honorifics.subjectFor(count: 2), HonorificSubject.pair);
      expect(Honorifics.subjectFor(count: 10), HonorificSubject.group);
    });
  });
}
