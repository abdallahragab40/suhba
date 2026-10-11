@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siyar_sahaba/core/design_system/theme/app_theme.dart';

import '../../helpers/pump_app.dart';

/// The Material components the app relies on, in the light, dark and
/// feature themes, so a palette change shows everywhere at once: buttons,
/// switches, slider, progress, chips, segments, text field, snack bar,
/// dialog and navigation bar.
void main() {
  setUpAll(loadAppFonts);

  for (final (name, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
    ('feature', AppTheme.feature),
  ]) {
    testWidgets('system components, $name', (tester) async {
      tester.view
        ..devicePixelRatio = 1
        ..physicalSize = const Size(390, 900);
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(title: const Text('العنوان')),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      FilledButton(
                        onPressed: () {},
                        child: const Text('متابعة'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('إلغاء'),
                      ),
                      TextButton(onPressed: () {}, child: const Text('المزيد')),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Switch(value: true, onChanged: (_) {}),
                      Switch(value: false, onChanged: (_) {}),
                      Checkbox(value: true, onChanged: (_) {}),
                      RadioGroup<int>(
                        groupValue: 1,
                        onChanged: (_) {},
                        child: const Radio<int>(value: 1),
                      ),
                    ],
                  ),
                  Slider(value: 0.6, onChanged: (_) {}),
                  const LinearProgressIndicator(value: 0.4),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      ChoiceChip(
                        label: const Text('الكل'),
                        selected: true,
                        onSelected: (_) {},
                      ),
                      ChoiceChip(
                        label: const Text('الأنصار'),
                        selected: false,
                        onSelected: (_) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<int>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 0, label: Text('تلقائي')),
                      ButtonSegment(value: 1, label: Text('فاتح')),
                      ButtonSegment(value: 2, label: Text('داكن')),
                    ],
                    selected: const {0},
                    onSelectionChanged: (_) {},
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    autofocus: true,
                    decoration: InputDecoration(labelText: 'ابحث'),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    child: ListTile(
                      leading: Icon(Icons.history),
                      title: Text('سجل القراءة'),
                      subtitle: Text('نصّان'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const AlertDialog(
                    title: Text('مسح المحفوظات؟'),
                    content: Text('سيُحذف عنصران من هذا الجهاز.'),
                    actions: [
                      TextButton(onPressed: null, child: Text('إلغاء')),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: NavigationBar(
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: 'الرئيسية',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.menu_book),
                    label: 'السيرة',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.people),
                    label: 'الصحابة',
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      ScaffoldMessenger.of(tester.element(find.byType(ListView))).showSnackBar(
        SnackBar(
          content: const Text('تم الاستيراد.'),
          action: SnackBarAction(label: 'تراجع', onPressed: () {}),
        ),
      );
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/system_components_$name.png'),
      );
    });
  }
}
