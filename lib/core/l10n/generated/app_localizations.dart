import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Working app name, shown in the app bar and the task switcher.
  ///
  /// In ar, this message translates to:
  /// **'صُحبة'**
  String get appTitle;

  /// Title of the developer-facing design system gallery.
  ///
  /// In ar, this message translates to:
  /// **'معرض نظام التصميم'**
  String get designGalleryTitle;

  /// Theme option that follows the device setting.
  ///
  /// In ar, this message translates to:
  /// **'حسب النظام'**
  String get themeModeSystem;

  /// Light theme option.
  ///
  /// In ar, this message translates to:
  /// **'المظهر الفاتح'**
  String get themeModeLight;

  /// Dark theme option.
  ///
  /// In ar, this message translates to:
  /// **'المظهر الداكن'**
  String get themeModeDark;

  /// Tooltip and accessibility label of the button that cycles the theme mode.
  ///
  /// In ar, this message translates to:
  /// **'تغيير المظهر'**
  String get changeThemeTooltip;

  /// Bottom navigation: home tab.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get tabHome;

  /// Bottom navigation: companions directory tab.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get tabCompanions;

  /// Bottom navigation: bookmarks and continue-reading tab.
  ///
  /// In ar, this message translates to:
  /// **'المحفوظات'**
  String get tabSaved;

  /// Bottom navigation: settings tab.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get tabSettings;

  /// Placeholder title for screens not built yet.
  ///
  /// In ar, this message translates to:
  /// **'قيد الإنشاء'**
  String get underConstructionTitle;

  /// Placeholder message for screens not built yet.
  ///
  /// In ar, this message translates to:
  /// **'ستُضاف هذه الشاشة في مرحلة لاحقة من التطوير.'**
  String get underConstructionMessage;

  /// Title shown for an unknown route or deep link.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة غير موجودة'**
  String get notFoundTitle;

  /// Explanation shown for an unknown route.
  ///
  /// In ar, this message translates to:
  /// **'قد يكون الرابط قديمًا أو غير صحيح.'**
  String get notFoundMessage;

  /// Button that returns to the home tab.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى الرئيسية'**
  String get goHome;

  /// Title of the generic error view.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر عرض هذا المحتوى'**
  String get errorTitle;

  /// Message of the generic error view.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ غير متوقع. حاول مرة أخرى.'**
  String get errorMessage;

  /// Retry button.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get retry;

  /// Accessibility label for loading placeholders.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل'**
  String get loading;

  /// Reliability level: established in the sources.
  ///
  /// In ar, this message translates to:
  /// **'ثابت'**
  String get reliabilityEstablished;

  /// Reliability level: a historical report.
  ///
  /// In ar, this message translates to:
  /// **'رواية تاريخية'**
  String get reliabilityReported;

  /// Reliability level: disputed.
  ///
  /// In ar, this message translates to:
  /// **'مختلف فيه'**
  String get reliabilityDisputed;

  /// Reliability level: not reliably documented.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف'**
  String get reliabilityUnknown;

  /// Screen-reader label of a reliability badge.
  ///
  /// In ar, this message translates to:
  /// **'درجة الثبوت: {level}'**
  String reliabilitySemantics(String level);

  /// Shown on reliability badges of unreviewed (draft) content.
  ///
  /// In ar, this message translates to:
  /// **'تصنيف مبدئي بانتظار المراجعة'**
  String get reliabilityProvisional;

  /// A year after the Hijrah.
  ///
  /// In ar, this message translates to:
  /// **'{year} هـ'**
  String dateHijriYear(String year);

  /// A year before the Hijrah.
  ///
  /// In ar, this message translates to:
  /// **'{year} قبل الهجرة'**
  String dateBeforeHijraYear(String year);

  /// A Gregorian year.
  ///
  /// In ar, this message translates to:
  /// **'{year} م'**
  String dateGregorianYear(String year);

  /// A span of years after the Hijrah.
  ///
  /// In ar, this message translates to:
  /// **'{start} – {end} هـ'**
  String dateHijriRange(String start, String end);

  /// A span of years before the Hijrah.
  ///
  /// In ar, this message translates to:
  /// **'{start} – {end} قبل الهجرة'**
  String dateBeforeHijraRange(String start, String end);

  /// A span of Gregorian years.
  ///
  /// In ar, this message translates to:
  /// **'{start} – {end} م'**
  String dateGregorianRange(String start, String end);

  /// A span between two fully formatted dates (e.g. across the Hijrah).
  ///
  /// In ar, this message translates to:
  /// **'{start} – {end}'**
  String dateSpan(String start, String end);

  /// Day, Hijri month name and formatted year.
  ///
  /// In ar, this message translates to:
  /// **'{day} {month} {year}'**
  String dateDayMonthYear(String day, String month, String year);

  /// Hijri month name and formatted year.
  ///
  /// In ar, this message translates to:
  /// **'{month} {year}'**
  String dateMonthYear(String month, String year);

  /// An approximate date.
  ///
  /// In ar, this message translates to:
  /// **'نحو سنة {date}'**
  String dateApprox(String date);

  /// Hijri date followed by the Gregorian year.
  ///
  /// In ar, this message translates to:
  /// **'{hijri} / {gregorian}'**
  String dateWithGregorian(String hijri, String gregorian);

  /// A date that is not reliably documented.
  ///
  /// In ar, this message translates to:
  /// **'غير معروف على وجه التحقيق'**
  String get dateUnknown;

  /// Hijri month name by number (1–12).
  ///
  /// In ar, this message translates to:
  /// **'{month, select, 1{المحرّم} 2{صفر} 3{ربيع الأول} 4{ربيع الآخر} 5{جمادى الأولى} 6{جمادى الآخرة} 7{رجب} 8{شعبان} 9{رمضان} 10{شوّال} 11{ذو القعدة} 12{ذو الحجة} other{}}'**
  String hijriMonthName(String month);

  /// A Qur'an reference to one ayah.
  ///
  /// In ar, this message translates to:
  /// **'{surah}: {ayah}'**
  String quranRef(String surah, String ayah);

  /// A Qur'an reference to a run of ayahs.
  ///
  /// In ar, this message translates to:
  /// **'{surah}: {from}–{to}'**
  String quranRefRange(String surah, String from, String to);

  /// A percentage.
  ///
  /// In ar, this message translates to:
  /// **'{value}٪'**
  String percent(String value);

  /// Label on every item whose content has not been approved by a qualified reviewer.
  ///
  /// In ar, this message translates to:
  /// **'مسودة'**
  String get draftBadge;

  /// Banner shown while the app runs on unreviewed (draft) content.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى قيد المراجعة'**
  String get draftBannerTitle;

  /// Explanation under the draft banner.
  ///
  /// In ar, this message translates to:
  /// **'لم يكتمل الاعتماد العلمي بعد. تفاصيل المنهج في «عن التطبيق».'**
  String get draftBannerMessage;

  /// Category filter: show every companion.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get directoryAll;

  /// Empty state of a filtered directory.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد صحابة في هذا التصنيف بعد.'**
  String get directoryEmpty;

  /// Shown for an unknown companion link.
  ///
  /// In ar, this message translates to:
  /// **'لم نجد هذا الصحابي.'**
  String get companionNotFound;

  /// Button on the companion-not-found state.
  ///
  /// In ar, this message translates to:
  /// **'العودة إلى الصحابة'**
  String get backToDirectory;

  /// Profile section title for key facts.
  ///
  /// In ar, this message translates to:
  /// **'في سطور'**
  String get profileAtAGlance;

  /// Fact label.
  ///
  /// In ar, this message translates to:
  /// **'المولد'**
  String get profileBirth;

  /// Fact label.
  ///
  /// In ar, this message translates to:
  /// **'الوفاة'**
  String get profileDeath;

  /// Fact label.
  ///
  /// In ar, this message translates to:
  /// **'مكان الوفاة'**
  String get profileDeathPlace;

  /// Kicker above the list of biography sections.
  ///
  /// In ar, this message translates to:
  /// **'السيرة'**
  String get profileSectionsKicker;

  /// Title of the list of biography sections.
  ///
  /// In ar, this message translates to:
  /// **'فصول السيرة'**
  String get profileSectionsTitle;

  /// Kicker above the timeline preview.
  ///
  /// In ar, this message translates to:
  /// **'التسلسل'**
  String get profileTimelineKicker;

  /// Title of the timeline preview (male).
  ///
  /// In ar, this message translates to:
  /// **'محطات من حياته'**
  String get profileTimelineTitle;

  /// Title of the timeline preview (female).
  ///
  /// In ar, this message translates to:
  /// **'محطات من حياتها'**
  String get profileTimelineTitleFemale;

  /// Kicker above the stories list.
  ///
  /// In ar, this message translates to:
  /// **'حكايات'**
  String get profileStoriesKicker;

  /// Title of the stories list.
  ///
  /// In ar, this message translates to:
  /// **'قصص من السيرة'**
  String get profileStoriesTitle;

  /// Kicker above related people.
  ///
  /// In ar, this message translates to:
  /// **'الصلات'**
  String get profileRelatedKicker;

  /// Title of the related people list.
  ///
  /// In ar, this message translates to:
  /// **'ذوو صلة'**
  String get profileRelatedTitle;

  /// Kicker above the reference list.
  ///
  /// In ar, this message translates to:
  /// **'المصادر'**
  String get profileReferencesKicker;

  /// Title of the reference list.
  ///
  /// In ar, this message translates to:
  /// **'مراجع هذه السيرة'**
  String get profileReferencesTitle;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'الأب'**
  String get relationFather;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'الأم'**
  String get relationMother;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من الأبناء'**
  String get relationChild;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من الأزواج'**
  String get relationSpouse;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من الإخوة'**
  String get relationSibling;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من الأقارب'**
  String get relationRelative;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من شيوخه'**
  String get relationTeacher;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'من تلاميذه'**
  String get relationStudent;

  /// Relation label.
  ///
  /// In ar, this message translates to:
  /// **'أخوه في المؤاخاة'**
  String get relationBrotherhood;

  /// Title of the citation sheet.
  ///
  /// In ar, this message translates to:
  /// **'مصادر هذه المعلومة'**
  String get citationsTitle;

  /// Screen-reader label of a citation marker.
  ///
  /// In ar, this message translates to:
  /// **'عرض المصادر ({count})'**
  String citationsButton(String count);

  /// Shown when a citation's volume/page/number has not been checked.
  ///
  /// In ar, this message translates to:
  /// **'الموضع بانتظار التحقق'**
  String get citationLocatorPending;

  /// Citation volume.
  ///
  /// In ar, this message translates to:
  /// **'ج {volume}'**
  String citationVolume(String volume);

  /// Citation page.
  ///
  /// In ar, this message translates to:
  /// **'ص {page}'**
  String citationPage(String page);

  /// Hadith number.
  ///
  /// In ar, this message translates to:
  /// **'رقم {number}'**
  String citationHadithNumber(String number);

  /// Author with death year.
  ///
  /// In ar, this message translates to:
  /// **'{author} (ت {year} هـ)'**
  String citationAuthorDeath(String author, String year);

  /// A hadith grading and who made it.
  ///
  /// In ar, this message translates to:
  /// **'{grade} — {gradedBy}'**
  String citationGrading(String grade, String gradedBy);

  /// Hadith grade.
  ///
  /// In ar, this message translates to:
  /// **'صحيح'**
  String get gradeSahih;

  /// Hadith grade.
  ///
  /// In ar, this message translates to:
  /// **'حسن'**
  String get gradeHasan;

  /// Hadith grade.
  ///
  /// In ar, this message translates to:
  /// **'ضعيف'**
  String get gradeDaif;

  /// Fallback when a cited source is missing.
  ///
  /// In ar, this message translates to:
  /// **'مصدر غير معروف'**
  String get citationUnknownSource;

  /// Notice in the citation sheet for draft content.
  ///
  /// In ar, this message translates to:
  /// **'إحالات قيد المراجعة.'**
  String get citationDraftNotice;

  /// Explains the established level.
  ///
  /// In ar, this message translates to:
  /// **'من القرآن الكريم، أو حديث صحيح أو حسن، أو مما اتفق عليه المؤرخون.'**
  String get reliabilityExplainEstablished;

  /// Explains the reported level.
  ///
  /// In ar, this message translates to:
  /// **'وردت في كتب السيرة والتاريخ، ولم يُحكم على إسنادها.'**
  String get reliabilityExplainReported;

  /// Explains the disputed level.
  ///
  /// In ar, this message translates to:
  /// **'تعدّدت فيه الروايات أو اختلف فيه أهل العلم.'**
  String get reliabilityExplainDisputed;

  /// Explains the unknown level.
  ///
  /// In ar, this message translates to:
  /// **'لم يثبت على وجه التحقيق.'**
  String get reliabilityExplainUnknown;

  /// Reading time; count drives the plural form, minutes is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{دقيقة قراءة} =2{دقيقتا قراءة} few{{minutes} دقائق قراءة} other{{minutes} دقيقة قراءة}}'**
  String storyReadingMinutes(int count, String minutes);

  /// Kicker above the key facts of a profile.
  ///
  /// In ar, this message translates to:
  /// **'تعريف'**
  String get profileAtAGlanceKicker;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'القسم التالي'**
  String get readerNextSection;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'القسم السابق'**
  String get readerPreviousSection;

  /// Heading of the source list at the end of a section.
  ///
  /// In ar, this message translates to:
  /// **'مصادر هذا القسم'**
  String get readerSectionSources;

  /// Title and tooltip of the reading settings sheet.
  ///
  /// In ar, this message translates to:
  /// **'إعدادات القراءة'**
  String get readerSettings;

  /// Slider label; size is the formatted point size.
  ///
  /// In ar, this message translates to:
  /// **'حجم خط القراءة: {size}'**
  String readerTextSize(String size);

  /// Preview sentence in the reading settings.
  ///
  /// In ar, this message translates to:
  /// **'هذا نصٌّ لمعاينة حجم خط القراءة.'**
  String get readerTextSample;

  /// Label of the digit style choice.
  ///
  /// In ar, this message translates to:
  /// **'الأرقام'**
  String get readerDigits;

  /// Arabic-Indic digits option.
  ///
  /// In ar, this message translates to:
  /// **'عربية (١٢٣)'**
  String get digitsArabicIndic;

  /// Western digits option.
  ///
  /// In ar, this message translates to:
  /// **'غربية (123)'**
  String get digitsWestern;

  /// Heading of a Qur'an quotation; ref is e.g. التوبة: ٤٠.
  ///
  /// In ar, this message translates to:
  /// **'قال الله تعالى — {ref}'**
  String quranReference(String ref);

  /// Shown only if the bundled Qur'an text cannot be loaded.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر عرض نص الآية الآن، والمرجع أعلاه.'**
  String get quranTextPending;

  /// Kicker of a hadith quotation.
  ///
  /// In ar, this message translates to:
  /// **'حديث'**
  String get hadithLabel;

  /// Kicker of a historical report quotation.
  ///
  /// In ar, this message translates to:
  /// **'رواية'**
  String get reportLabel;

  /// Shown when a quotation's exact wording has not been copied from the source yet.
  ///
  /// In ar, this message translates to:
  /// **'النص بانتظار نقله من المصدر المعتمد.'**
  String get quoteTextPending;

  /// Kicker of a dispute note.
  ///
  /// In ar, this message translates to:
  /// **'مسألة مختلف فيها'**
  String get disputeLabel;

  /// Expands a dispute note.
  ///
  /// In ar, this message translates to:
  /// **'عرض الأقوال ({count})'**
  String disputeShowOpinions(String count);

  /// Label of one opinion.
  ///
  /// In ar, this message translates to:
  /// **'القول {n}'**
  String disputeOpinion(String n);

  /// Kicker of an editorial lesson.
  ///
  /// In ar, this message translates to:
  /// **'درس وعبرة'**
  String get lessonLabel;

  /// Unknown section link.
  ///
  /// In ar, this message translates to:
  /// **'لم نجد هذا القسم.'**
  String get sectionNotFound;

  /// Unknown story link.
  ///
  /// In ar, this message translates to:
  /// **'لم نجد هذه القصة.'**
  String get storyNotFound;

  /// Button from the profile to the timeline.
  ///
  /// In ar, this message translates to:
  /// **'الخط الزمني كاملًا'**
  String get profileFullTimeline;

  /// Timeline screen title.
  ///
  /// In ar, this message translates to:
  /// **'الخط الزمني'**
  String get timelineTitle;

  /// Timeline era.
  ///
  /// In ar, this message translates to:
  /// **'قبل الإسلام'**
  String get eraPreIslam;

  /// Timeline era.
  ///
  /// In ar, this message translates to:
  /// **'العهد المكي'**
  String get eraMakkan;

  /// Timeline era.
  ///
  /// In ar, this message translates to:
  /// **'العهد المدني'**
  String get eraMadinan;

  /// Timeline era.
  ///
  /// In ar, this message translates to:
  /// **'بعد وفاة النبي ﷺ'**
  String get eraAfterProphet;

  /// Kicker above each era of the timeline.
  ///
  /// In ar, this message translates to:
  /// **'المرحلة'**
  String get eraKicker;

  /// Opens the biography section linked to a timeline entry.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ في السيرة'**
  String get timelineOpenSection;

  /// Names the historical event linked to a timeline entry.
  ///
  /// In ar, this message translates to:
  /// **'الحدث: {name}'**
  String timelineEvent(String name);

  /// Kicker above a story's chapter list.
  ///
  /// In ar, this message translates to:
  /// **'الفصول'**
  String get storyChaptersKicker;

  /// Title of a story's chapter list.
  ///
  /// In ar, this message translates to:
  /// **'فصول القصة'**
  String get storyChaptersTitle;

  /// Opens the first chapter.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ القراءة'**
  String get storyStart;

  /// Chapter position.
  ///
  /// In ar, this message translates to:
  /// **'الفصل {n} من {total}'**
  String storyChapterOf(String n, String total);

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الفصل التالي'**
  String get storyNextChapter;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الفصل السابق'**
  String get storyPreviousChapter;

  /// Shown after the last chapter.
  ///
  /// In ar, this message translates to:
  /// **'انتهت القصة'**
  String get storyEnd;

  /// Heading of the companions linked to a story.
  ///
  /// In ar, this message translates to:
  /// **'صحابة في هذه القصة'**
  String get storyCompanions;

  /// Tooltip: save this item.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get bookmarkAdd;

  /// Tooltip: unsave this item.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من المحفوظات'**
  String get bookmarkRemove;

  /// Snackbar after saving.
  ///
  /// In ar, this message translates to:
  /// **'حُفظ في المحفوظات'**
  String get bookmarkSaved;

  /// Snackbar after unsaving.
  ///
  /// In ar, this message translates to:
  /// **'أُزيل من المحفوظات'**
  String get bookmarkRemoved;

  /// Kicker above continue reading.
  ///
  /// In ar, this message translates to:
  /// **'تابع'**
  String get continueKicker;

  /// Title of the continue-reading list.
  ///
  /// In ar, this message translates to:
  /// **'تابع القراءة'**
  String get continueTitle;

  /// Reading progress; percent is formatted.
  ///
  /// In ar, this message translates to:
  /// **'قُرئ {percent}'**
  String progressRead(String percent);

  /// Kicker above saved items.
  ///
  /// In ar, this message translates to:
  /// **'المحفوظات'**
  String get savedKicker;

  /// Title above saved items.
  ///
  /// In ar, this message translates to:
  /// **'ما حفظته'**
  String get savedTitle;

  /// Saved group.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get savedCompanions;

  /// Saved group.
  ///
  /// In ar, this message translates to:
  /// **'أقسام السيرة'**
  String get savedSections;

  /// Saved group.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get savedStories;

  /// Saved group.
  ///
  /// In ar, this message translates to:
  /// **'فصول القصص'**
  String get savedChapters;

  /// Empty saved screen title.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد محفوظات بعد'**
  String get savedEmptyTitle;

  /// Empty saved screen message.
  ///
  /// In ar, this message translates to:
  /// **'احفظ صحابيًّا أو قسمًا من السيرة أو قصة لتجده هنا.'**
  String get savedEmptyMessage;

  /// Search button tooltip.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get searchTooltip;

  /// Search field hint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم أو لقب أو عنوان أو عبارة…'**
  String get searchHint;

  /// Shown before typing.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في أسماء الصحابة وألقابهم وكناهم، وفي عناوين السيرة والقصص ونصوصها.'**
  String get searchStart;

  /// No search results.
  ///
  /// In ar, this message translates to:
  /// **'لا نتائج لـ «{query}»'**
  String searchNoResults(String query);

  /// Heading of recent queries (kept in memory only).
  ///
  /// In ar, this message translates to:
  /// **'عمليات بحث سابقة'**
  String get searchRecent;

  /// Clears the search field.
  ///
  /// In ar, this message translates to:
  /// **'مسح'**
  String get searchClear;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get searchKindCompanions;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get searchKindStories;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'أقسام السيرة'**
  String get searchKindSections;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'فصول القصص'**
  String get searchKindChapters;

  /// Kicker on the home hero (changes daily).
  ///
  /// In ar, this message translates to:
  /// **'صحابي اليوم'**
  String get homeFeaturedKicker;

  /// Opens the featured companion.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ السيرة'**
  String get homeReadBiography;

  /// Kicker above categories.
  ///
  /// In ar, this message translates to:
  /// **'التصنيفات'**
  String get homeCategoriesKicker;

  /// Title above categories.
  ///
  /// In ar, this message translates to:
  /// **'تصفّح الصحابة'**
  String get homeCategoriesTitle;

  /// Kicker above stories.
  ///
  /// In ar, this message translates to:
  /// **'حكايات'**
  String get homeStoriesKicker;

  /// Title above stories.
  ///
  /// In ar, this message translates to:
  /// **'قصص مختارة'**
  String get homeStoriesTitle;

  /// Settings group.
  ///
  /// In ar, this message translates to:
  /// **'المظهر'**
  String get settingsAppearance;

  /// Settings group.
  ///
  /// In ar, this message translates to:
  /// **'القراءة'**
  String get settingsReading;

  /// Settings group.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى'**
  String get settingsContent;

  /// Bundled content version.
  ///
  /// In ar, this message translates to:
  /// **'إصدار المحتوى: {version}'**
  String settingsContentVersion(String version);

  /// Content channel.
  ///
  /// In ar, this message translates to:
  /// **'محتوى تجريبي (مسودة)'**
  String get settingsChannelDraft;

  /// Content channel.
  ///
  /// In ar, this message translates to:
  /// **'محتوى منشور'**
  String get settingsChannelPublished;

  /// Opens the about page.
  ///
  /// In ar, this message translates to:
  /// **'عن التطبيق والمنهج'**
  String get settingsAbout;

  /// Opens the sources directory.
  ///
  /// In ar, this message translates to:
  /// **'المصادر المعتمدة'**
  String get settingsSources;

  /// Opens the licence page.
  ///
  /// In ar, this message translates to:
  /// **'التراخيص'**
  String get settingsLicenses;

  /// About: introduction.
  ///
  /// In ar, this message translates to:
  /// **'صُحبة تطبيق تعليمي يعرض سيرة النبي ﷺ وسِيَر أصحابه وقصصهم، معزوّةً كلها إلى مصادرها.'**
  String get aboutIntro;

  /// About section.
  ///
  /// In ar, this message translates to:
  /// **'المنهج'**
  String get aboutMethodTitle;

  /// About: methodology.
  ///
  /// In ar, this message translates to:
  /// **'يسير التطبيق على منهج أهل السنة والجماعة في عرض السيرة والتاريخ، ويعزو كل معلومة إلى مصدرها، ويميّز بين الثابت والمروي والمختلف فيه وما لم يثبت. وتركّز هذه النسخة على السيرة والفضائل والمآثر وأهم الأحداث، ولا تتناول تفاصيل الفتنة.'**
  String get aboutMethodBody;

  /// About section.
  ///
  /// In ar, this message translates to:
  /// **'درجات الثبوت'**
  String get aboutReliabilityTitle;

  /// About section.
  ///
  /// In ar, this message translates to:
  /// **'حالة المراجعة'**
  String get aboutReviewTitle;

  /// About: draft status.
  ///
  /// In ar, this message translates to:
  /// **'لم يعتمد المحتوى مختص مؤهل بعد. تشير «مراجعة أولية» إلى فحص تحريري ومقارنة أخبار بمصادرها، ولا تعني التحقق الكامل من كل خبر أو اعتماد أسانيد جميع الروايات. وتشير «مسودة» إلى محتوى لم يخضع لهذه المراجعة بعد. يبقى الاعتماد النهائي لمختص مؤهل.'**
  String get aboutReviewDraft;

  /// About: published status.
  ///
  /// In ar, this message translates to:
  /// **'راجع المحتوى المنشور مختصون مؤهلون قبل نشره.'**
  String get aboutReviewPublished;

  /// About section.
  ///
  /// In ar, this message translates to:
  /// **'الصور'**
  String get aboutImagesTitle;

  /// About: images policy.
  ///
  /// In ar, this message translates to:
  /// **'لا يتضمن التطبيق صورًا أو رسومًا للصحابة أو للنبي ﷺ، وتُستخدم بدلًا منها الزخارف الهندسية والخط العربي. ولا توجد صور فوتوغرافية فيه حاليًا.'**
  String get aboutImagesBody;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'القرآن الكريم'**
  String get sourceTypeQuran;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'كتب الحديث'**
  String get sourceTypeHadith;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'كتب التراجم'**
  String get sourceTypeBiographical;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'كتب التاريخ'**
  String get sourceTypeHistory;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'كتب السيرة'**
  String get sourceTypeSira;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'كتب التفسير'**
  String get sourceTypeTafsir;

  /// Source group.
  ///
  /// In ar, this message translates to:
  /// **'مصادر أخرى'**
  String get sourceTypeOther;

  /// Number of companions in a category; n is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =0{لا صحابة بعد} =1{صحابي واحد} =2{صحابيان} few{{n} صحابة} other{{n} صحابيًّا}}'**
  String homeCategoryCount(int count, String n);

  /// Saved screen: the saved items or positions failed to load.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل المحفوظات. لم يُحذف شيء منها؛ حاول مرة أخرى.'**
  String get savedLoadErrorMessage;

  /// Saved item placeholder while its content loads.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ التحميل…'**
  String get savedItemLoading;

  /// Saved item whose content failed to load (it is kept).
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل هذا العنصر'**
  String get savedItemLoadError;

  /// Saved item whose target was removed from the content.
  ///
  /// In ar, this message translates to:
  /// **'لم يعد هذا العنصر متاحًا'**
  String get savedItemUnavailableTitle;

  /// Explains an unavailable saved item.
  ///
  /// In ar, this message translates to:
  /// **'حُذف من المحتوى في تحديث سابق، ويمكنك إزالته من المحفوظات.'**
  String get savedItemUnavailableMessage;

  /// Snackbar when saving or removing a bookmark fails.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر حفظ التغيير. حاول مرة أخرى.'**
  String get bookmarkUpdateFailed;

  /// Snackbar when saving the reading position fails.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر حفظ موضع القراءة.'**
  String get progressSaveFailed;

  /// Reader notice: the saved position belongs to an older version of the text.
  ///
  /// In ar, this message translates to:
  /// **'تغيّر هذا النص منذ قراءتك الأخيرة، فعرضناه من أوله.'**
  String get readerPassageChanged;

  /// Snackbar action: jump to the position saved for the older text.
  ///
  /// In ar, this message translates to:
  /// **'موضعي السابق'**
  String get readerRestorePosition;

  /// Error message when bundled content is in a format this app version cannot read.
  ///
  /// In ar, this message translates to:
  /// **'هذا المحتوى بصيغة أحدث مما يقرؤه هذا الإصدار من التطبيق. حدّث التطبيق لعرضه.'**
  String get errorUnsupportedContent;

  /// Button at the end of a passage: mark it as read.
  ///
  /// In ar, this message translates to:
  /// **'أنهيتُ القراءة'**
  String get readerMarkComplete;

  /// Shown at the end of a passage that is marked as read.
  ///
  /// In ar, this message translates to:
  /// **'أتممتَ قراءة هذا النص.'**
  String get readerCompleted;

  /// Button: forget the progress of a finished passage and start over.
  ///
  /// In ar, this message translates to:
  /// **'اقرأه من جديد'**
  String get readerReadAgain;

  /// Profile: start the biography at its first section.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ قراءة السيرة'**
  String get profileStartReading;

  /// Profile: resume the biography.
  ///
  /// In ar, this message translates to:
  /// **'تابع القراءة'**
  String get profileContinueReading;

  /// Profile: every section of his biography is finished.
  ///
  /// In ar, this message translates to:
  /// **'أتممتَ قراءة سيرته.'**
  String get profileBiographyFinishedMale;

  /// Profile: every section of her biography is finished.
  ///
  /// In ar, this message translates to:
  /// **'أتممتَ قراءة سيرتها.'**
  String get profileBiographyFinishedFemale;

  /// Profile: open the first section of a finished biography.
  ///
  /// In ar, this message translates to:
  /// **'اقرأها من البداية'**
  String get profileReadFromStart;

  /// Profile of a companion without a written biography. Promises no date.
  ///
  /// In ar, this message translates to:
  /// **'لم تُكتب سيرته المفصّلة بعد؛ يعرض هذا الملف تعريفًا موجزًا ومصادره.'**
  String get profileBiographyNotWrittenMale;

  /// Profile of a companion without a written biography. Promises no date.
  ///
  /// In ar, this message translates to:
  /// **'لم تُكتب سيرتها المفصّلة بعد؛ يعرض هذا الملف تعريفًا موجزًا ومصادره.'**
  String get profileBiographyNotWrittenFemale;

  /// Marker (and its spoken label) for a finished section or chapter.
  ///
  /// In ar, this message translates to:
  /// **'مكتمل'**
  String get passageFinished;

  /// Reader app bar button and sheet title: the biography's sections.
  ///
  /// In ar, this message translates to:
  /// **'فهرس الأقسام'**
  String get readerSectionContents;

  /// Reader app bar button and sheet title: the story's chapters.
  ///
  /// In ar, this message translates to:
  /// **'فهرس الفصول'**
  String get readerChapterContents;

  /// Contents sheet: marks the passage currently open.
  ///
  /// In ar, this message translates to:
  /// **'تقرؤه الآن'**
  String get readerReadingNow;

  /// Number of sections in a biography; n is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{قسم واحد} =2{قسمان} few{{n} أقسام} other{{n} قسمًا}}'**
  String profileSectionCount(int count, String n);

  /// Profile: the section to resume and how much of it was read (percent is formatted).
  ///
  /// In ar, this message translates to:
  /// **'{title} · قُرئ {percent}'**
  String profileResumeDetail(String title, String percent);

  /// Search filter chip: every kind of result.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get searchScopeAll;

  /// Search filter chip: companions only.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get searchScopeCompanions;

  /// Search filter chip: biography sections only.
  ///
  /// In ar, this message translates to:
  /// **'السِّيَر'**
  String get searchScopeBiographies;

  /// Search filter chip: stories and their chapters.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get searchScopeStories;

  /// Search: some files failed to load; results may be missing.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل بعض المحتوى، فقد تكون النتائج ناقصة.'**
  String get searchIncomplete;

  /// Spoken label of the search filter chips.
  ///
  /// In ar, this message translates to:
  /// **'تصفية النتائج'**
  String get searchFilterLabel;

  /// Search: nothing found, but some content failed to load.
  ///
  /// In ar, this message translates to:
  /// **'لا نتائج لـ «{query}» فيما أمكن تحميله من المحتوى.'**
  String searchNoResultsIncomplete(String query);

  /// Search filter chip: results within one companion's biography or one story; tap to remove.
  ///
  /// In ar, this message translates to:
  /// **'في: {name}'**
  String searchWithin(String name);

  /// Snack bar action: put back what was just removed.
  ///
  /// In ar, this message translates to:
  /// **'تراجع'**
  String get undo;

  /// Title of the finished-reading screen, and links to it.
  ///
  /// In ar, this message translates to:
  /// **'سجل القراءة'**
  String get historyTitle;

  /// Reading history with nothing finished.
  ///
  /// In ar, this message translates to:
  /// **'لم تُتمّ قراءة شيء بعد.'**
  String get historyEmpty;

  /// Button: forget the progress of one passage.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تعيين التقدّم'**
  String get historyReset;

  /// Button on an unfinished passage: forget its position.
  ///
  /// In ar, this message translates to:
  /// **'إزالة من «تابع القراءة»'**
  String get continueRemove;

  /// Snack bar after removing a saved item (with undo).
  ///
  /// In ar, this message translates to:
  /// **'أُزيل من المحفوظات.'**
  String get bookmarkRemovedUndo;

  /// Settings group: the reader's own data.
  ///
  /// In ar, this message translates to:
  /// **'بيانات القراءة على هذا الجهاز'**
  String get settingsYourData;

  /// Settings: delete every reading position and finished mark.
  ///
  /// In ar, this message translates to:
  /// **'مسح سجل القراءة'**
  String get settingsClearHistory;

  /// Settings: delete every saved item.
  ///
  /// In ar, this message translates to:
  /// **'مسح المحفوظات'**
  String get settingsClearSaved;

  /// Subtitle when there is no data of that kind.
  ///
  /// In ar, this message translates to:
  /// **'لا شيء لمسحه'**
  String get settingsNothingToClear;

  /// Confirmation dialog title.
  ///
  /// In ar, this message translates to:
  /// **'مسح سجل القراءة؟'**
  String get clearHistoryTitle;

  /// Confirmation dialog title.
  ///
  /// In ar, this message translates to:
  /// **'مسح المحفوظات؟'**
  String get clearSavedTitle;

  /// Confirmation dialog: the destructive button.
  ///
  /// In ar, this message translates to:
  /// **'مسح'**
  String get clearConfirm;

  /// Dialog: cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// Snack bar after clearing the history.
  ///
  /// In ar, this message translates to:
  /// **'مُسح سجل القراءة.'**
  String get historyCleared;

  /// Snack bar after clearing saved items.
  ///
  /// In ar, this message translates to:
  /// **'مُسحت المحفوظات.'**
  String get savedCleared;

  /// Snack bar after resetting one passage (with undo).
  ///
  /// In ar, this message translates to:
  /// **'أُعيد تعيين تقدّمك في «{title}».'**
  String historyResetDone(String title);

  /// When a passage was finished; date is formatted.
  ///
  /// In ar, this message translates to:
  /// **'أُتمّت في {date}'**
  String historyFinishedOn(String date);

  /// Number of passages with saved progress; n is formatted.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{نص واحد} =2{نصّان} few{{n} نصوص} other{{n} نصًّا}}'**
  String countTexts(int count, String n);

  /// Number of saved items; n is formatted.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{عنصر واحد} =2{عنصران} few{{n} عناصر} other{{n} عنصرًا}}'**
  String countItems(int count, String n);

  /// Confirmation dialog body; what is the formatted count.
  ///
  /// In ar, this message translates to:
  /// **'سيُحذف موضع القراءة وعلامة الإتمام لـ{what} من هذا الجهاز، ولا يمكن التراجع عن ذلك. لن تتأثر المحفوظات ولا الإعدادات.'**
  String clearHistoryMessage(String what);

  /// Confirmation dialog body; what is the formatted count.
  ///
  /// In ar, this message translates to:
  /// **'سيُحذف {what} من المحفوظات على هذا الجهاز، ولا يمكن التراجع عن ذلك. لن يتأثر سجل القراءة ولا الإعدادات.'**
  String clearSavedMessage(String what);

  /// Navigation: the Prophetic Seerah section.
  ///
  /// In ar, this message translates to:
  /// **'السيرة'**
  String get tabSeerah;

  /// Navigation: events, places, visuals and stories.
  ///
  /// In ar, this message translates to:
  /// **'استكشف'**
  String get tabExplore;

  /// Marker for year 1 AH on a proportional time axis.
  ///
  /// In ar, this message translates to:
  /// **'الهجرة'**
  String get timelineHijrahMark;

  /// Heading for timeline records whose date is not known; they are not placed on the axis.
  ///
  /// In ar, this message translates to:
  /// **'بلا تاريخ محدد'**
  String get timelineUndated;

  /// Screen-reader label of a schematic map; count is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'خريطة تخطيطية لـ{count} مواضع، وتليها قائمة بها'**
  String mapSemantics(String count);

  /// Map zoom-in button tooltip.
  ///
  /// In ar, this message translates to:
  /// **'تكبير الخريطة'**
  String get mapZoomIn;

  /// Map zoom-out button tooltip.
  ///
  /// In ar, this message translates to:
  /// **'تصغير الخريطة'**
  String get mapZoomOut;

  /// Small map badge, after a north arrow icon: north is up (maps are never mirrored).
  ///
  /// In ar, this message translates to:
  /// **'الشمال'**
  String get mapNorth;

  /// Map legend: the site is identified today.
  ///
  /// In ar, this message translates to:
  /// **'موضع معروف'**
  String get mapLegendIdentified;

  /// Map legend: only the area is known.
  ///
  /// In ar, this message translates to:
  /// **'موضع تقريبي'**
  String get mapLegendApproximate;

  /// Map legend: scholars differ on where it was.
  ///
  /// In ar, this message translates to:
  /// **'موضع مختلف فيه'**
  String get mapLegendUncertain;

  /// Map legend for dashed route legs.
  ///
  /// In ar, this message translates to:
  /// **'صلة بين محطتين، لا الطريق الفعلي'**
  String get mapApproximatePath;

  /// Note under every map.
  ///
  /// In ar, this message translates to:
  /// **'خريطة تخطيطية للتوضيح، وليست رسمًا مساحيًّا دقيقًا.'**
  String get mapSchematicNote;

  /// Relation type: companionship (e.g. the Prophet ﷺ and Abu Bakr).
  ///
  /// In ar, this message translates to:
  /// **'صاحبه'**
  String get relationCompanion;

  /// Number of a step in a sequence explainer; n is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'الخطوة {n}'**
  String sequenceStep(String n);

  /// Shown on a sequence step whose order the sources do not settle.
  ///
  /// In ar, this message translates to:
  /// **'موضعها من الترتيب غير قطعي'**
  String get sequenceOrderUncertain;

  /// Label on a drawn landscape, so it is not taken for a photo of the place.
  ///
  /// In ar, this message translates to:
  /// **'رسم توضيحي'**
  String get sceneIllustration;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'خط زمني'**
  String get visualTypeTimeline;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'خريطة'**
  String get visualTypeMap;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'صلات'**
  String get visualTypeRelationships;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'تسلسل الأحداث'**
  String get visualTypeSequence;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'مراحل زمنية'**
  String get visualTypePeriods;

  /// Infographic type.
  ///
  /// In ar, this message translates to:
  /// **'بطاقة مكان'**
  String get visualTypePlacePanel;

  /// Shown where a passage refers to a visual that is not bundled.
  ///
  /// In ar, this message translates to:
  /// **'هذا الرسم غير متاح في هذا الإصدار.'**
  String get visualNotFound;

  /// Toggle: show the infographic as a chart.
  ///
  /// In ar, this message translates to:
  /// **'الرسم'**
  String get visualShowChart;

  /// Toggle: show the infographic as an equivalent text list.
  ///
  /// In ar, this message translates to:
  /// **'قائمة'**
  String get visualShowList;

  /// Heading for an infographic's uncertainty notes.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات على الدقة'**
  String get visualNotes;

  /// Label before the citation marker of an infographic.
  ///
  /// In ar, this message translates to:
  /// **'مصادر الرسم'**
  String get visualSources;

  /// Opens an inline infographic on its own page.
  ///
  /// In ar, this message translates to:
  /// **'عرض كامل'**
  String get visualOpen;

  /// Heading of a journey's legs in the map list view.
  ///
  /// In ar, this message translates to:
  /// **'محطات الطريق'**
  String get mapRouteTitle;

  /// One leg of a journey.
  ///
  /// In ar, this message translates to:
  /// **'من {from} إلى {to}'**
  String mapRouteLeg(String from, String to);

  /// Relation in list form: the relation label, then the other person; e.g. "من الأبناء · أبو بكر الصديق".
  ///
  /// In ar, this message translates to:
  /// **'{relation} · {person}'**
  String visualRelationOf(String relation, String person);

  /// Name of the Seerah section (app bar).
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية'**
  String get seerahSectionName;

  /// Shown when the build has no Seerah section.
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية غير متاحة في هذا الإصدار.'**
  String get seerahUnavailable;

  /// Kicker above the Seerah chapter list.
  ///
  /// In ar, this message translates to:
  /// **'الرحلة'**
  String get seerahJourneyKicker;

  /// Title of the Seerah chapter journey.
  ///
  /// In ar, this message translates to:
  /// **'فصول السيرة بالترتيب'**
  String get seerahJourneyTitle;

  /// Note under the journey title; n is the formatted chapter count.
  ///
  /// In ar, this message translates to:
  /// **'{n} فصلًا من المولد إلى الوفاة، مقسّمة على مراحل الزمن.'**
  String seerahJourneyNote(String n);

  /// Button opening the Seerah timeline.
  ///
  /// In ar, this message translates to:
  /// **'السيرة على خط الزمن'**
  String get seerahOpenTimeline;

  /// Kicker above the thematic essays.
  ///
  /// In ar, this message translates to:
  /// **'موضوعات'**
  String get seerahTopicsKicker;

  /// Title of the thematic essays list.
  ///
  /// In ar, this message translates to:
  /// **'من شمائله وهديه ﷺ'**
  String get seerahTopicsTitle;

  /// Kicker above the featured events.
  ///
  /// In ar, this message translates to:
  /// **'الأرشيف'**
  String get seerahEventsKicker;

  /// Title of the featured events on the Seerah hub.
  ///
  /// In ar, this message translates to:
  /// **'أحداث فارقة'**
  String get seerahEventsTitle;

  /// Kicker above the featured places.
  ///
  /// In ar, this message translates to:
  /// **'الأطلس'**
  String get seerahPlacesKicker;

  /// Title of the featured places.
  ///
  /// In ar, this message translates to:
  /// **'أماكن السيرة'**
  String get seerahPlacesTitle;

  /// Kicker above related companions.
  ///
  /// In ar, this message translates to:
  /// **'الصحبة'**
  String get seerahCompanionsKicker;

  /// Title of the related companions on the Seerah hub.
  ///
  /// In ar, this message translates to:
  /// **'صحابة في هذه السيرة'**
  String get seerahCompanionsTitle;

  /// Kicker above the methodology note.
  ///
  /// In ar, this message translates to:
  /// **'المنهج'**
  String get seerahMethodKicker;

  /// Title of the methodology note.
  ///
  /// In ar, this message translates to:
  /// **'كيف كُتبت هذه السيرة'**
  String get seerahMethodTitle;

  /// Link to the sources directory.
  ///
  /// In ar, this message translates to:
  /// **'كل المصادر'**
  String get seerahAllSources;

  /// Button resuming the Seerah at a chapter; title is the chapter title.
  ///
  /// In ar, this message translates to:
  /// **'تابع: {title}'**
  String seerahContinue(String title);

  /// Button starting the Seerah at chapter one.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ السيرة'**
  String get seerahStart;

  /// Button on Home opening the Seerah section.
  ///
  /// In ar, this message translates to:
  /// **'افتح السيرة النبوية'**
  String get seerahOpenSection;

  /// Small hint under the Seerah opening that more follows below.
  ///
  /// In ar, this message translates to:
  /// **'اثنا عشر فصلًا'**
  String get seerahScrollHint;

  /// Chapter number and time label in lists.
  ///
  /// In ar, this message translates to:
  /// **'الفصل {number} · {date}'**
  String seerahChapterLabel(String number, String date);

  /// Number of visuals in a chapter; n is the formatted number.
  ///
  /// In ar, this message translates to:
  /// **'{count, plural, =1{رسم توضيحي} =2{رسمان} few{{n} رسوم} other{{n} رسمًا}}'**
  String seerahVisualCount(int count, String n);

  /// Note on passages the editor marked as samples.
  ///
  /// In ar, this message translates to:
  /// **'هذا نص تجريبي مختصر، ولم يُكتب بالتفصيل المقصود بعد.'**
  String get coverageSample;

  /// Note on skeleton items.
  ///
  /// In ar, this message translates to:
  /// **'لم يُكتب هذا النص بعد.'**
  String get coverageSkeleton;

  /// Short label on sample passages in lists.
  ///
  /// In ar, this message translates to:
  /// **'نص تجريبي'**
  String get coverageSampleShort;

  /// Kicker of the ink feature band.
  ///
  /// In ar, this message translates to:
  /// **'حدث فارق'**
  String get seerahFeatureKicker;

  /// Title of the Hijrah feature band.
  ///
  /// In ar, this message translates to:
  /// **'الهجرة: من مكة إلى المدينة'**
  String get seerahFeatureTitle;

  /// Button opening the Hijrah chapter.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ فصل الهجرة'**
  String get seerahFeatureRead;

  /// Seerah chapter not found.
  ///
  /// In ar, this message translates to:
  /// **'هذا الفصل غير موجود.'**
  String get seerahChapterNotFound;

  /// Seerah topic not found.
  ///
  /// In ar, this message translates to:
  /// **'هذا الموضوع غير موجود.'**
  String get seerahTopicNotFound;

  /// Kicker in the chapter reader.
  ///
  /// In ar, this message translates to:
  /// **'الفصل {number} من {total} · {date}'**
  String seerahChapterOf(String number, String total, String date);

  /// Kicker in the topic reader.
  ///
  /// In ar, this message translates to:
  /// **'موضوع {number} من {total}'**
  String seerahTopicOf(String number, String total);

  /// Contents sheet title in the Seerah chapter reader.
  ///
  /// In ar, this message translates to:
  /// **'فصول السيرة'**
  String get seerahContents;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الفصل السابق'**
  String get seerahPreviousChapter;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الفصل التالي'**
  String get seerahNextChapter;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الموضوع السابق'**
  String get seerahPreviousTopic;

  /// Reader navigation.
  ///
  /// In ar, this message translates to:
  /// **'الموضوع التالي'**
  String get seerahNextTopic;

  /// Title of the Seerah timeline page.
  ///
  /// In ar, this message translates to:
  /// **'السيرة على خط الزمن'**
  String get seerahTimelineTitle;

  /// Related events heading.
  ///
  /// In ar, this message translates to:
  /// **'أحداث في هذا الفصل'**
  String get relatedEvents;

  /// Related places heading.
  ///
  /// In ar, this message translates to:
  /// **'أماكن'**
  String get relatedPlaces;

  /// Related companions heading.
  ///
  /// In ar, this message translates to:
  /// **'صحابة ذوو صلة'**
  String get relatedCompanions;

  /// Related Seerah chapters heading.
  ///
  /// In ar, this message translates to:
  /// **'من فصول السيرة'**
  String get relatedChapters;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'هجرة'**
  String get eventTypeHijrah;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'غزوة'**
  String get eventTypeBattle;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'صلح'**
  String get eventTypeTreaty;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'بيعة'**
  String get eventTypePledge;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'ولاية'**
  String get eventTypeAppointment;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'وفاة'**
  String get eventTypeDeath;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'وحي'**
  String get eventTypeRevelation;

  /// Event type (e.g. to Abyssinia).
  ///
  /// In ar, this message translates to:
  /// **'هجرة جماعية'**
  String get eventTypeMigration;

  /// Event type (mosque, brotherhood, delegations).
  ///
  /// In ar, this message translates to:
  /// **'بناء المجتمع'**
  String get eventTypeCommunity;

  /// Event type.
  ///
  /// In ar, this message translates to:
  /// **'حدث'**
  String get eventTypeOther;

  /// App bar of the event page.
  ///
  /// In ar, this message translates to:
  /// **'حدث من السيرة'**
  String get eventPageTitle;

  /// Event not found.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحدث غير موجود.'**
  String get eventNotFound;

  /// Heading: what led to the event.
  ///
  /// In ar, this message translates to:
  /// **'ما قبله'**
  String get eventContext;

  /// Heading: what came of the event.
  ///
  /// In ar, this message translates to:
  /// **'ما بعده'**
  String get eventOutcome;

  /// Heading: participants of an event.
  ///
  /// In ar, this message translates to:
  /// **'ممن شهده'**
  String get eventParticipants;

  /// Heading: Seerah chapters that tell the event.
  ///
  /// In ar, this message translates to:
  /// **'في السيرة النبوية'**
  String get eventInSeerah;

  /// App bar of the place page.
  ///
  /// In ar, this message translates to:
  /// **'مكان من السيرة'**
  String get placePageTitle;

  /// Place not found.
  ///
  /// In ar, this message translates to:
  /// **'هذا المكان غير موجود.'**
  String get placeNotFound;

  /// Modern name of a place.
  ///
  /// In ar, this message translates to:
  /// **'اليوم: {name}'**
  String placeToday(String name);

  /// Heading of the place map.
  ///
  /// In ar, this message translates to:
  /// **'على الخريطة'**
  String get placeOnMap;

  /// Heading of events at a place.
  ///
  /// In ar, this message translates to:
  /// **'أحداث في هذا المكان'**
  String get placeEvents;

  /// Heading of visuals of a place.
  ///
  /// In ar, this message translates to:
  /// **'رسوم تعرض هذا المكان'**
  String get placeVisuals;

  /// App bar of a visual page.
  ///
  /// In ar, this message translates to:
  /// **'رسم توضيحي'**
  String get visualPageTitle;

  /// Explore filter.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get exploreAll;

  /// Explore filter.
  ///
  /// In ar, this message translates to:
  /// **'الأحداث'**
  String get exploreEvents;

  /// Explore filter.
  ///
  /// In ar, this message translates to:
  /// **'الأماكن'**
  String get explorePlaces;

  /// Explore filter.
  ///
  /// In ar, this message translates to:
  /// **'الرسوم'**
  String get exploreVisuals;

  /// Explore filter.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get exploreStories;

  /// Intro line on Explore.
  ///
  /// In ar, this message translates to:
  /// **'أرشيف الأحداث، وأماكن السيرة، والرسوم التوضيحية، والقصص: ادخل من أيها شئت.'**
  String get exploreIntro;

  /// Explore section kicker.
  ///
  /// In ar, this message translates to:
  /// **'الأرشيف'**
  String get exploreEventsKicker;

  /// Explore section title.
  ///
  /// In ar, this message translates to:
  /// **'سجل الأحداث'**
  String get exploreEventsTitle;

  /// Note under the event archive.
  ///
  /// In ar, this message translates to:
  /// **'مرتبة بتواريخها كما سجّلتها المصادر، بدقتها.'**
  String get exploreEventsNote;

  /// Event archive group.
  ///
  /// In ar, this message translates to:
  /// **'قبل الهجرة'**
  String get exploreBeforeHijrah;

  /// Event archive group.
  ///
  /// In ar, this message translates to:
  /// **'بعد الهجرة'**
  String get exploreAfterHijrah;

  /// Explore section kicker.
  ///
  /// In ar, this message translates to:
  /// **'رسوم توضيحية'**
  String get exploreVisualsKicker;

  /// Explore section title.
  ///
  /// In ar, this message translates to:
  /// **'خرائط وخطوط زمنية وصلات'**
  String get exploreVisualsTitle;

  /// Explore section kicker.
  ///
  /// In ar, this message translates to:
  /// **'الأطلس'**
  String get explorePlacesKicker;

  /// Explore section title.
  ///
  /// In ar, this message translates to:
  /// **'أماكن السيرة'**
  String get explorePlacesTitle;

  /// Explore section kicker.
  ///
  /// In ar, this message translates to:
  /// **'حكايات'**
  String get exploreStoriesKicker;

  /// Explore section title.
  ///
  /// In ar, this message translates to:
  /// **'قصص من السيرة'**
  String get exploreStoriesTitle;

  /// Saved group: Seerah chapters.
  ///
  /// In ar, this message translates to:
  /// **'من فصول السيرة'**
  String get savedSeerahChapters;

  /// Saved group: Seerah themes.
  ///
  /// In ar, this message translates to:
  /// **'من موضوعات السيرة'**
  String get savedSeerahTopics;

  /// Home section kicker.
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية'**
  String get homeSeerahKicker;

  /// Home: the next Seerah chapters to read.
  ///
  /// In ar, this message translates to:
  /// **'الفصول القادمة'**
  String get homeSeerahTitle;

  /// Home link to the Seerah hub.
  ///
  /// In ar, this message translates to:
  /// **'كل الفصول'**
  String get homeAllChapters;

  /// Home: the companion-of-the-day section title.
  ///
  /// In ar, this message translates to:
  /// **'تعرّف على صحابي'**
  String get homeDiscoverTitle;

  /// Home section kicker.
  ///
  /// In ar, this message translates to:
  /// **'الأطلس'**
  String get homeAtlasKicker;

  /// Home: the atlas section title.
  ///
  /// In ar, this message translates to:
  /// **'أين جرت الأحداث'**
  String get homeAtlasTitle;

  /// Home section kicker.
  ///
  /// In ar, this message translates to:
  /// **'الأرشيف'**
  String get homeArchiveKicker;

  /// Home: selected events title.
  ///
  /// In ar, this message translates to:
  /// **'أحداث مختارة'**
  String get homeArchiveTitle;

  /// Home link to the event archive.
  ///
  /// In ar, this message translates to:
  /// **'سجل الأحداث كاملًا'**
  String get homeAllEvents;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'فصول السيرة النبوية'**
  String get searchKindSeerahChapters;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'موضوعات السيرة'**
  String get searchKindSeerahTopics;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'أحداث'**
  String get searchKindEvents;

  /// Search result group.
  ///
  /// In ar, this message translates to:
  /// **'أماكن'**
  String get searchKindPlaces;

  /// Search scope filter.
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية'**
  String get searchScopeSeerah;

  /// Search scope filter.
  ///
  /// In ar, this message translates to:
  /// **'الأحداث والأماكن'**
  String get searchScopeArchive;

  /// Profile section kicker: where the companion appears beyond their biography.
  ///
  /// In ar, this message translates to:
  /// **'في السيرة'**
  String get profileConnectionsKicker;

  /// Profile section title for Seerah chapters, events and visuals involving the companion (gender-neutral).
  ///
  /// In ar, this message translates to:
  /// **'في فصول السيرة وأحداثها'**
  String get profileConnectionsTitle;

  /// Profile: shared events the companion took part in (gender-neutral).
  ///
  /// In ar, this message translates to:
  /// **'من الأحداث المشتركة'**
  String get profileEvents;

  /// Profile: visuals that show the companion.
  ///
  /// In ar, this message translates to:
  /// **'رسوم توضيحية'**
  String get profileVisuals;

  /// Small source line under a quoted Qur'an passage.
  ///
  /// In ar, this message translates to:
  /// **'الرسم العثماني من مشروع تنزيل'**
  String get quranTextSource;

  /// Heading of the Qur'an text credit on the sources page.
  ///
  /// In ar, this message translates to:
  /// **'نص القرآن الكريم'**
  String get sourcesQuranTextTitle;

  /// Credit for the bundled Qur'an text; url is tanzil.net.
  ///
  /// In ar, this message translates to:
  /// **'تُعرض الآيات بالرسم العثماني من مشروع تنزيل ({url})، كما هي دون أي تغيير، برخصة المشاع الإبداعي: نسب المصنَّف ٣٫٠. يحفظ التطبيق الآيات المقتبسة فقط، ولا يتصل بالإنترنت.'**
  String sourcesQuranTextBody(String url);

  /// Expands the Tanzil copyright notice.
  ///
  /// In ar, this message translates to:
  /// **'نص الترخيص'**
  String get sourcesQuranNotice;

  /// Title of the relationship explorer.
  ///
  /// In ar, this message translates to:
  /// **'الصلات والأنساب'**
  String get relationsTitle;

  /// Intro of the relationship explorer.
  ///
  /// In ar, this message translates to:
  /// **'من يتصل بمن من أهل السيرة: النسب والمصاهرة والصحبة والمؤاخاة، ومع كل صلة مصدرها. تظهر كل صلة عند الطرفين.'**
  String get relationsIntro;

  /// Explorer title when showing one person.
  ///
  /// In ar, this message translates to:
  /// **'صلات {name}'**
  String relationsFilteredTitle(String name);

  /// Clears the person filter in the relationship explorer.
  ///
  /// In ar, this message translates to:
  /// **'عرض صلات الجميع'**
  String get relationsShowEveryone;

  /// Shown when some companion files failed to load.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل بعض الملفات، فقد تكون هذه القائمة ناقصة.'**
  String get relationsIncomplete;

  /// Empty state of the relationship explorer.
  ///
  /// In ar, this message translates to:
  /// **'لا صلات مسجّلة هنا بعد.'**
  String get relationsEmpty;

  /// Relation group.
  ///
  /// In ar, this message translates to:
  /// **'النسب والقرابة'**
  String get relationCategoryKinship;

  /// Relation group.
  ///
  /// In ar, this message translates to:
  /// **'الزواج'**
  String get relationCategoryMarriage;

  /// Relation group.
  ///
  /// In ar, this message translates to:
  /// **'الصحبة والمؤاخاة'**
  String get relationCategoryCompanionship;

  /// Relation group.
  ///
  /// In ar, this message translates to:
  /// **'العلم والرواية'**
  String get relationCategoryLearning;

  /// Semantic hint for a person heading that opens a profile.
  ///
  /// In ar, this message translates to:
  /// **'فتح صفحة {name}'**
  String relationsOpenProfile(String name);

  /// Explore: kicker above the relations entry.
  ///
  /// In ar, this message translates to:
  /// **'صلات'**
  String get exploreRelationsKicker;

  /// Explore: title of the relations entry.
  ///
  /// In ar, this message translates to:
  /// **'الأنساب والمصاهرات والصحبة'**
  String get exploreRelationsTitle;

  /// Explore: body of the relations entry.
  ///
  /// In ar, this message translates to:
  /// **'تصفّح صلات أهل السيرة بعضهم ببعض، مجمّعة بحسب نوعها، ومع كل صلة مصدرها.'**
  String get exploreRelationsBody;

  /// Profile: link to the relationship explorer filtered to this companion.
  ///
  /// In ar, this message translates to:
  /// **'كل صلاته في مستكشف الصلات'**
  String get profileAllRelations;

  /// Citation sheet: shares the passage as text with its sources.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة المقطع مع مصادره'**
  String get citationShareAction;

  /// Shared text: heading of the source list.
  ///
  /// In ar, this message translates to:
  /// **'المصادر:'**
  String get shareSourcesHeading;

  /// Shared text: the claim's reliability.
  ///
  /// In ar, this message translates to:
  /// **'درجة الخبر: {label}'**
  String shareReliability(String label);

  /// Shared text: draft warning; always included for unreviewed content.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى قيد المراجعة ولم يكتمل اعتماده العلمي.'**
  String get shareDraftNotice;

  /// Shared text: last line.
  ///
  /// In ar, this message translates to:
  /// **'من تطبيق {appName}'**
  String shareFromApp(String appName);

  /// Settings: export saved items and positions to a file.
  ///
  /// In ar, this message translates to:
  /// **'تصدير بيانات القراءة'**
  String get settingsExport;

  /// Settings: export subtitle.
  ///
  /// In ar, this message translates to:
  /// **'ملف بالمحفوظات ومواضع القراءة، تحفظه أو تنقله إلى جهاز آخر.'**
  String get settingsExportSubtitle;

  /// Settings: import a reading-data file.
  ///
  /// In ar, this message translates to:
  /// **'استيراد بيانات القراءة'**
  String get settingsImport;

  /// Settings: import subtitle.
  ///
  /// In ar, this message translates to:
  /// **'يضيف ما في الملف إلى ما على هذا الجهاز، ولا يحذف شيئًا.'**
  String get settingsImportSubtitle;

  /// Share subject of the export file.
  ///
  /// In ar, this message translates to:
  /// **'بيانات القراءة من {appName}'**
  String exportSubject(String appName);

  /// Import confirmation title.
  ///
  /// In ar, this message translates to:
  /// **'استيراد بيانات القراءة'**
  String get importConfirmTitle;

  /// Import confirmation: what will change.
  ///
  /// In ar, this message translates to:
  /// **'سيُضاف من المحفوظات: {items}، ومن مواضع القراءة: {texts}. ويبقى ما سواه على هذا الجهاز كما هو، ولا يُحذف شيء.'**
  String importConfirmMessage(String items, String texts);

  /// Import confirmation button.
  ///
  /// In ar, this message translates to:
  /// **'استيراد'**
  String get importConfirm;

  /// Import: the file adds nothing.
  ///
  /// In ar, this message translates to:
  /// **'لا جديد في هذا الملف؛ كل ما فيه موجود على هذا الجهاز.'**
  String get importNothingNew;

  /// Import finished.
  ///
  /// In ar, this message translates to:
  /// **'تم الاستيراد.'**
  String get importDone;

  /// Import failed while writing.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر إكمال الاستيراد. ما أُضيف قبل الخطأ باقٍ، ولم يُحذف شيء.'**
  String get importFailed;

  /// Export failed.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تصدير البيانات.'**
  String get exportFailed;

  /// Import refused: dialog title.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر استيراد الملف'**
  String get importRefusedTitle;

  /// Import refused: not JSON or too large.
  ///
  /// In ar, this message translates to:
  /// **'هذا ليس ملف بيانات صالحًا، أو أنه أكبر مما يُقبل.'**
  String get importRefusedNotJson;

  /// Import refused: not an export.
  ///
  /// In ar, this message translates to:
  /// **'هذا الملف ليس تصديرًا لبيانات القراءة من هذا التطبيق.'**
  String get importRefusedNotAnExport;

  /// Import refused: newer version.
  ///
  /// In ar, this message translates to:
  /// **'صُدّر هذا الملف من إصدار أحدث من التطبيق؛ حدّث التطبيق ثم أعد المحاولة.'**
  String get importRefusedNewer;

  /// Import refused: an invalid record; {where} is a technical path.
  ///
  /// In ar, this message translates to:
  /// **'في الملف سجل غير صالح ({where})، فلم يُستورد شيء.'**
  String importRefusedInvalid(String where);

  /// Dismisses an information dialog.
  ///
  /// In ar, this message translates to:
  /// **'حسنًا'**
  String get dialogOk;

  /// Import: the chosen file could not be read.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر فتح الملف، ولم يتغير شيء.'**
  String get importReadFailed;

  /// Settings: short label, follow the system theme.
  ///
  /// In ar, this message translates to:
  /// **'تلقائي'**
  String get themeShortSystem;

  /// Settings: short label, light theme.
  ///
  /// In ar, this message translates to:
  /// **'فاتح'**
  String get themeShortLight;

  /// Settings: short label, dark theme.
  ///
  /// In ar, this message translates to:
  /// **'داكن'**
  String get themeShortDark;

  /// About: link to the open-source licence notices.
  ///
  /// In ar, this message translates to:
  /// **'تراخيص البرمجيات المستخدمة'**
  String get aboutLicensesLink;

  /// Badge on items that had a preliminary review but no scholar approval.
  ///
  /// In ar, this message translates to:
  /// **'مراجعة أولية'**
  String get draftBadgePreliminary;

  /// No description provided for @welcomeSkip.
  ///
  /// In ar, this message translates to:
  /// **'تخطَّ'**
  String get welcomeSkip;

  /// No description provided for @welcomeNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get welcomeNext;

  /// No description provided for @welcomeStart.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ'**
  String get welcomeStart;

  /// No description provided for @welcomePageLabel.
  ///
  /// In ar, this message translates to:
  /// **'الصفحة {current} من {total}'**
  String welcomePageLabel(String current, String total);

  /// No description provided for @welcome1Kicker.
  ///
  /// In ar, this message translates to:
  /// **'مرحبًا بك'**
  String get welcome1Kicker;

  /// No description provided for @welcome1Body.
  ///
  /// In ar, this message translates to:
  /// **'سيرة النبي ﷺ وسِيَر أصحابه وقصصهم، مرويّةً على ترتيب الزمن، ومعزوّةً كلّها إلى مصادرها.'**
  String get welcome1Body;

  /// No description provided for @welcome2Kicker.
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية'**
  String get welcome2Kicker;

  /// No description provided for @welcome2Title.
  ///
  /// In ar, this message translates to:
  /// **'من مكة إلى المدينة'**
  String get welcome2Title;

  /// No description provided for @welcome2Body.
  ///
  /// In ar, this message translates to:
  /// **'فصول السيرة على ترتيب الزمن، مع خطّ زمني للأحداث، وأطلس للأماكن، ورسوم توضيحية تقرّب المشاهد.'**
  String get welcome2Body;

  /// No description provided for @welcome3Kicker.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get welcome3Kicker;

  /// No description provided for @welcome3Title.
  ///
  /// In ar, this message translates to:
  /// **'سِيَر أصحابه وقصصهم'**
  String get welcome3Title;

  /// No description provided for @welcome3Body.
  ///
  /// In ar, this message translates to:
  /// **'العشرة المبشّرون بالجنة بسير كاملة، ونخبة من الصحابة والصحابيات بملفات مختصرة، وقصص من السيرة تُقرأ في جلسة.'**
  String get welcome3Body;

  /// No description provided for @welcome4Kicker.
  ///
  /// In ar, this message translates to:
  /// **'المنهج'**
  String get welcome4Kicker;

  /// No description provided for @welcome4Title.
  ///
  /// In ar, this message translates to:
  /// **'كلّ خبر بمصدره'**
  String get welcome4Title;

  /// No description provided for @welcome4Body.
  ///
  /// In ar, this message translates to:
  /// **'تُعزى الأخبار إلى كتب الحديث والسيرة، وتُبيَّن درجتها: ثابت، أو رواية تاريخية، أو مختلف فيه. والمحتوى في مراجعة أولية، ولا يُعتمد قبل أن يعتمده عالم مختص. ويعمل التطبيق كلّه دون اتصال.'**
  String get welcome4Body;

  /// No description provided for @quizTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختبر معلوماتك'**
  String get quizTitle;

  /// No description provided for @quizSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أسئلة جديدة في كل جولة، من الصحابة والسيرة، وكل إجابة تُحيلك إلى موضعها.'**
  String get quizSubtitle;

  /// No description provided for @quizModeMixed.
  ///
  /// In ar, this message translates to:
  /// **'جولة منوّعة'**
  String get quizModeMixed;

  /// No description provided for @quizModeMixedHint.
  ///
  /// In ar, this message translates to:
  /// **'من الصحابة والسيرة معًا'**
  String get quizModeMixedHint;

  /// No description provided for @quizModeCompanions.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get quizModeCompanions;

  /// No description provided for @quizModeCompanionsHint.
  ///
  /// In ar, this message translates to:
  /// **'الكنى والألقاب والأنساب والقصص'**
  String get quizModeCompanionsHint;

  /// No description provided for @quizModeSeerah.
  ///
  /// In ar, this message translates to:
  /// **'السيرة النبوية'**
  String get quizModeSeerah;

  /// No description provided for @quizModeSeerahHint.
  ///
  /// In ar, this message translates to:
  /// **'الأحداث وتواريخها وأماكنها وترتيبها'**
  String get quizModeSeerahHint;

  /// No description provided for @quizBest.
  ///
  /// In ar, this message translates to:
  /// **'أفضل نتيجة: {score} من {total}'**
  String quizBest(String score, String total);

  /// No description provided for @quizNoBest.
  ///
  /// In ar, this message translates to:
  /// **'لم تُلعب بعد'**
  String get quizNoBest;

  /// No description provided for @quizNote.
  ///
  /// In ar, this message translates to:
  /// **'تُولَّد الأسئلة في كل مرة من محتوى التطبيق نفسه، وهو في مراجعة أولية.'**
  String get quizNote;

  /// No description provided for @quizProgress.
  ///
  /// In ar, this message translates to:
  /// **'السؤال {current} من {total}'**
  String quizProgress(String current, String total);

  /// No description provided for @quizStreak.
  ///
  /// In ar, this message translates to:
  /// **'{count} متتالية'**
  String quizStreak(String count);

  /// No description provided for @quizCorrect.
  ///
  /// In ar, this message translates to:
  /// **'أحسنت!'**
  String get quizCorrect;

  /// No description provided for @quizWrong.
  ///
  /// In ar, this message translates to:
  /// **'ليست هذه'**
  String get quizWrong;

  /// No description provided for @quizAnswerWas.
  ///
  /// In ar, this message translates to:
  /// **'الإجابة الصحيحة: {answer}'**
  String quizAnswerWas(String answer);

  /// No description provided for @quizReadMore.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ المزيد'**
  String get quizReadMore;

  /// No description provided for @quizNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get quizNext;

  /// No description provided for @quizSeeResult.
  ///
  /// In ar, this message translates to:
  /// **'النتيجة'**
  String get quizSeeResult;

  /// No description provided for @quizScore.
  ///
  /// In ar, this message translates to:
  /// **'{score} من {total}'**
  String quizScore(String score, String total);

  /// No description provided for @quizResult3.
  ///
  /// In ar, this message translates to:
  /// **'ما شاء الله، معرفة راسخة!'**
  String get quizResult3;

  /// No description provided for @quizResult2.
  ///
  /// In ar, this message translates to:
  /// **'أحسنت، معرفة طيبة.'**
  String get quizResult2;

  /// No description provided for @quizResult1.
  ///
  /// In ar, this message translates to:
  /// **'بداية طيبة، والقراءة تزيدك.'**
  String get quizResult1;

  /// No description provided for @quizResult0.
  ///
  /// In ar, this message translates to:
  /// **'لا بأس، اقرأ ثم أعد المحاولة.'**
  String get quizResult0;

  /// No description provided for @quizNewBest.
  ///
  /// In ar, this message translates to:
  /// **'أفضل نتيجة لك حتى الآن'**
  String get quizNewBest;

  /// No description provided for @quizPlayAgain.
  ///
  /// In ar, this message translates to:
  /// **'جولة جديدة'**
  String get quizPlayAgain;

  /// No description provided for @quizReview.
  ///
  /// In ar, this message translates to:
  /// **'راجع إجاباتك'**
  String get quizReview;

  /// No description provided for @quizDone.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء'**
  String get quizDone;

  /// No description provided for @quizAboutCompanions.
  ///
  /// In ar, this message translates to:
  /// **'عن الصحابة'**
  String get quizAboutCompanions;

  /// No description provided for @quizAboutSeerah.
  ///
  /// In ar, this message translates to:
  /// **'عن السيرة'**
  String get quizAboutSeerah;

  /// No description provided for @quizYourAnswer.
  ///
  /// In ar, this message translates to:
  /// **'إجابتك: {answer}'**
  String quizYourAnswer(String answer);

  /// No description provided for @quizTileTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختبر معلوماتك'**
  String get quizTileTitle;

  /// No description provided for @quizTileSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'أسئلة جديدة في كل جولة من الصحابة والسيرة'**
  String get quizTileSubtitle;

  /// No description provided for @quizQKunyaMale.
  ///
  /// In ar, this message translates to:
  /// **'مَن كنيتُه «{subject}»؟'**
  String quizQKunyaMale(String subject);

  /// No description provided for @quizQKunyaFemale.
  ///
  /// In ar, this message translates to:
  /// **'مَن كنيتُها «{subject}»؟'**
  String quizQKunyaFemale(String subject);

  /// No description provided for @quizQKunyaOf.
  ///
  /// In ar, this message translates to:
  /// **'ما كنية {subject}؟'**
  String quizQKunyaOf(String subject);

  /// No description provided for @quizQTitleMale.
  ///
  /// In ar, this message translates to:
  /// **'مَن لُقِّب بـ«{subject}»؟'**
  String quizQTitleMale(String subject);

  /// No description provided for @quizQTitleFemale.
  ///
  /// In ar, this message translates to:
  /// **'مَن لُقِّبت بـ«{subject}»؟'**
  String quizQTitleFemale(String subject);

  /// No description provided for @quizQDeathMale.
  ///
  /// In ar, this message translates to:
  /// **'أين توفي {subject}؟'**
  String quizQDeathMale(String subject);

  /// No description provided for @quizQDeathFemale.
  ///
  /// In ar, this message translates to:
  /// **'أين توفيت {subject}؟'**
  String quizQDeathFemale(String subject);

  /// No description provided for @quizQMember.
  ///
  /// In ar, this message translates to:
  /// **'أيّ هؤلاء يُعدّ في «{subject}»؟'**
  String quizQMember(String subject);

  /// No description provided for @quizQFather.
  ///
  /// In ar, this message translates to:
  /// **'مَن والد {subject}؟'**
  String quizQFather(String subject);

  /// No description provided for @quizQMother.
  ///
  /// In ar, this message translates to:
  /// **'مَن أمّ {subject}؟'**
  String quizQMother(String subject);

  /// No description provided for @quizQStory.
  ///
  /// In ar, this message translates to:
  /// **'أيّ هؤلاء من أصحاب قصة «{subject}»؟'**
  String quizQStory(String subject);

  /// No description provided for @quizQEventYear.
  ///
  /// In ar, this message translates to:
  /// **'في أيّ سنة كان حدث «{subject}»؟'**
  String quizQEventYear(String subject);

  /// No description provided for @quizQEarliestEvent.
  ///
  /// In ar, this message translates to:
  /// **'أيّ هذه الأحداث كان أولًا؟'**
  String get quizQEarliestEvent;

  /// No description provided for @quizQEventPlace.
  ///
  /// In ar, this message translates to:
  /// **'أين كان حدث «{subject}»؟'**
  String quizQEventPlace(String subject);

  /// No description provided for @quizQEventAtPlace.
  ///
  /// In ar, this message translates to:
  /// **'أيّ هذه الأحداث كان في {subject}؟'**
  String quizQEventAtPlace(String subject);

  /// No description provided for @quizQEarliestChapter.
  ///
  /// In ar, this message translates to:
  /// **'أيّ هذه الفصول يأتي أولًا في السيرة؟'**
  String get quizQEarliestChapter;

  /// No description provided for @quizOutOf.
  ///
  /// In ar, this message translates to:
  /// **'من {total}'**
  String quizOutOf(String total);

  /// Home: kicker of the current Hijri month's events.
  ///
  /// In ar, this message translates to:
  /// **'هذا الشهر'**
  String get homeThisMonthKicker;

  /// Home: title of the current Hijri month's events.
  ///
  /// In ar, this message translates to:
  /// **'في {month} من السيرة'**
  String homeThisMonthTitle(String month);

  /// Home: today's Umm al-Qura date under the month's events.
  ///
  /// In ar, this message translates to:
  /// **'اليوم {day} {month} {year} هـ بتقويم أم القرى، وقد يختلف يومًا عن بداية الشهر برؤية الهلال في بلدك.'**
  String homeThisMonthNote(String day, String month, String year);

  /// Title of the visiting page.
  ///
  /// In ar, this message translates to:
  /// **'أماكن المدينة ومكة'**
  String get visitTitle;

  /// Visiting page: city choice.
  ///
  /// In ar, this message translates to:
  /// **'المدينة'**
  String get visitMadinah;

  /// Visiting page: city choice.
  ///
  /// In ar, this message translates to:
  /// **'مكة'**
  String get visitMakkah;

  /// Visiting page introduction.
  ///
  /// In ar, this message translates to:
  /// **'أماكن من السيرة وحياة الصحابة في المدينة ومكة وما حولهما، مع ما جرى فيها ومصادره. الصفحة تعرّف بتاريخ هذه الأماكن، وليست دليلًا للمناسك ولا لآداب الزيارة.'**
  String get visitIntro;

  /// Visiting page: button that reads the reader's position.
  ///
  /// In ar, this message translates to:
  /// **'رتّبها بحسب قربها مني'**
  String get visitNearMe;

  /// Visiting page: while reading the position.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ تحديد موقعك…'**
  String get visitLocating;

  /// Visiting page: location services off.
  ///
  /// In ar, this message translates to:
  /// **'خدمة الموقع متوقفة في جهازك، فشغّلها ثم أعد المحاولة.'**
  String get visitLocationOff;

  /// Visiting page: permission declined.
  ///
  /// In ar, this message translates to:
  /// **'لم يُسمح بالوصول إلى موقعك، فبقيت الأماكن مرتبة بحسب قربها من الحرم.'**
  String get visitLocationDenied;

  /// Visiting page: permission permanently declined.
  ///
  /// In ar, this message translates to:
  /// **'الوصول إلى موقعك ممنوع لهذا التطبيق، ويمكنك السماح به من إعدادات الجهاز.'**
  String get visitLocationDeniedForever;

  /// Visiting page: no position returned.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحديد موقعك الآن، فحاول مرة أخرى.'**
  String get visitLocationFailed;

  /// Visiting page: opens the app's device settings.
  ///
  /// In ar, this message translates to:
  /// **'فتح الإعدادات'**
  String get visitOpenSettings;

  /// Visiting page: ordered from the reader.
  ///
  /// In ar, this message translates to:
  /// **'الأماكن مرتبة بحسب قربها منك.'**
  String get visitOrderedFromYou;

  /// Visiting page: the reader is elsewhere.
  ///
  /// In ar, this message translates to:
  /// **'لست في {city} الآن، فالأماكن مرتبة بحسب قربها من الحرم.'**
  String visitNotInCity(String city);

  /// Visiting page: location privacy note.
  ///
  /// In ar, this message translates to:
  /// **'يُستعمل موقعك على جهازك فقط لترتيب القائمة، ولا يُحفظ ولا يُرسل إلى أي جهة.'**
  String get visitPrivacy;

  /// Visiting page: no places in the city.
  ///
  /// In ar, this message translates to:
  /// **'لا أماكن مسجّلة في {city} بعد.'**
  String visitNoPlaces(String city);

  /// Visiting page: distance under 1 km.
  ///
  /// In ar, this message translates to:
  /// **'على أقل من كيلومتر منك'**
  String get visitUnderOneKm;

  /// Visiting page: rounded distance in km.
  ///
  /// In ar, this message translates to:
  /// **'على نحو {km} كم منك'**
  String visitKmAway(String km);

  /// Explore: body of the visiting entry.
  ///
  /// In ar, this message translates to:
  /// **'أماكن السيرة في المدينة ومكة وما حولهما على خريطة واحدة، ويمكن ترتيبها بحسب قربها منك.'**
  String get exploreVisitBody;

  /// Place page: heading of the linked companions.
  ///
  /// In ar, this message translates to:
  /// **'صحابة ارتبط ذكرهم بالمكان'**
  String get placeCompanions;

  /// Place page: opens the visiting page on the city.
  ///
  /// In ar, this message translates to:
  /// **'أماكن أخرى في {city}'**
  String placeVisitCity(String city);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
