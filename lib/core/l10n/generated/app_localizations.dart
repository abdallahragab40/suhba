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
  /// **'سِيَر الصحابة'**
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
  /// **'مسودة — لم يُراجَع'**
  String get draftBadge;

  /// Banner shown while the app runs on unreviewed (draft) content.
  ///
  /// In ar, this message translates to:
  /// **'محتوى تجريبي لم يُراجَع علميًا بعد'**
  String get draftBannerTitle;

  /// Explanation under the draft banner.
  ///
  /// In ar, this message translates to:
  /// **'النصوص والمصادر هنا للتطوير والمراجعة، ولا تُعتمد قبل أن يراجعها مختص.'**
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
  /// **'هذا المحتوى مسودة لم يراجعها مختص بعد؛ التصنيف والمواضع مبدئية.'**
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

  /// Shown until a verified Qur'an dataset is bundled.
  ///
  /// In ar, this message translates to:
  /// **'يُعرض نص الآية هنا من مصحف رقمي معتمد عند إضافته.'**
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
  /// **'سِيَر الصحابة تطبيق تعليمي يعرض سير صحابة النبي ﷺ وقصصهم، معزوّةً إلى مصادرها.'**
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
  /// **'لم يُراجَع المحتوى بعد. النصوص الحالية للتطوير والمراجعة، ولن تُنشر قبل أن يراجعها مختص مؤهل.'**
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
