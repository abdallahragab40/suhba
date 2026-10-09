// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سِيَر الصحابة';

  @override
  String get designGalleryTitle => 'معرض نظام التصميم';

  @override
  String get themeModeSystem => 'حسب النظام';

  @override
  String get themeModeLight => 'المظهر الفاتح';

  @override
  String get themeModeDark => 'المظهر الداكن';

  @override
  String get changeThemeTooltip => 'تغيير المظهر';

  @override
  String get tabHome => 'الرئيسية';

  @override
  String get tabCompanions => 'الصحابة';

  @override
  String get tabSaved => 'المحفوظات';

  @override
  String get tabSettings => 'الإعدادات';

  @override
  String get underConstructionTitle => 'قيد الإنشاء';

  @override
  String get underConstructionMessage =>
      'ستُضاف هذه الشاشة في مرحلة لاحقة من التطوير.';

  @override
  String get notFoundTitle => 'الصفحة غير موجودة';

  @override
  String get notFoundMessage => 'قد يكون الرابط قديمًا أو غير صحيح.';

  @override
  String get goHome => 'العودة إلى الرئيسية';

  @override
  String get errorTitle => 'تعذّر عرض هذا المحتوى';

  @override
  String get errorMessage => 'حدث خطأ غير متوقع. حاول مرة أخرى.';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loading => 'جارٍ التحميل';

  @override
  String get reliabilityEstablished => 'ثابت';

  @override
  String get reliabilityReported => 'رواية تاريخية';

  @override
  String get reliabilityDisputed => 'مختلف فيه';

  @override
  String get reliabilityUnknown => 'غير معروف';

  @override
  String reliabilitySemantics(String level) {
    return 'درجة الثبوت: $level';
  }

  @override
  String get reliabilityProvisional => 'تصنيف مبدئي بانتظار المراجعة';

  @override
  String dateHijriYear(String year) {
    return '$year هـ';
  }

  @override
  String dateBeforeHijraYear(String year) {
    return '$year قبل الهجرة';
  }

  @override
  String dateGregorianYear(String year) {
    return '$year م';
  }

  @override
  String dateHijriRange(String start, String end) {
    return '$start – $end هـ';
  }

  @override
  String dateBeforeHijraRange(String start, String end) {
    return '$start – $end قبل الهجرة';
  }

  @override
  String dateGregorianRange(String start, String end) {
    return '$start – $end م';
  }

  @override
  String dateSpan(String start, String end) {
    return '$start – $end';
  }

  @override
  String dateDayMonthYear(String day, String month, String year) {
    return '$day $month $year';
  }

  @override
  String dateMonthYear(String month, String year) {
    return '$month $year';
  }

  @override
  String dateApprox(String date) {
    return 'نحو سنة $date';
  }

  @override
  String dateWithGregorian(String hijri, String gregorian) {
    return '$hijri / $gregorian';
  }

  @override
  String get dateUnknown => 'غير معروف على وجه التحقيق';

  @override
  String hijriMonthName(String month) {
    String _temp0 = intl.Intl.selectLogic(month, {
      '1': 'المحرّم',
      '2': 'صفر',
      '3': 'ربيع الأول',
      '4': 'ربيع الآخر',
      '5': 'جمادى الأولى',
      '6': 'جمادى الآخرة',
      '7': 'رجب',
      '8': 'شعبان',
      '9': 'رمضان',
      '10': 'شوّال',
      '11': 'ذو القعدة',
      '12': 'ذو الحجة',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String quranRef(String surah, String ayah) {
    return '$surah: $ayah';
  }

  @override
  String quranRefRange(String surah, String from, String to) {
    return '$surah: $from–$to';
  }

  @override
  String percent(String value) {
    return '$value٪';
  }

  @override
  String get draftBadge => 'مسودة — لم يُراجَع';

  @override
  String get draftBannerTitle => 'محتوى تجريبي لم يُراجَع علميًا بعد';

  @override
  String get draftBannerMessage =>
      'النصوص والمصادر هنا للتطوير والمراجعة، ولا تُعتمد قبل أن يراجعها مختص.';

  @override
  String get directoryAll => 'الكل';

  @override
  String get directoryEmpty => 'لا يوجد صحابة في هذا التصنيف بعد.';

  @override
  String get companionNotFound => 'لم نجد هذا الصحابي.';

  @override
  String get backToDirectory => 'العودة إلى الصحابة';

  @override
  String get profileAtAGlance => 'في سطور';

  @override
  String get profileBirth => 'المولد';

  @override
  String get profileDeath => 'الوفاة';

  @override
  String get profileDeathPlace => 'مكان الوفاة';

  @override
  String get profileSectionsKicker => 'السيرة';

  @override
  String get profileSectionsTitle => 'فصول السيرة';

  @override
  String get profileTimelineKicker => 'التسلسل';

  @override
  String get profileTimelineTitle => 'محطات من حياته';

  @override
  String get profileTimelineTitleFemale => 'محطات من حياتها';

  @override
  String get profileStoriesKicker => 'حكايات';

  @override
  String get profileStoriesTitle => 'قصص من السيرة';

  @override
  String get profileRelatedKicker => 'الصلات';

  @override
  String get profileRelatedTitle => 'ذوو صلة';

  @override
  String get profileReferencesKicker => 'المصادر';

  @override
  String get profileReferencesTitle => 'مراجع هذه السيرة';

  @override
  String get relationFather => 'الأب';

  @override
  String get relationMother => 'الأم';

  @override
  String get relationChild => 'من الأبناء';

  @override
  String get relationSpouse => 'من الأزواج';

  @override
  String get relationSibling => 'من الإخوة';

  @override
  String get relationRelative => 'من الأقارب';

  @override
  String get relationTeacher => 'من شيوخه';

  @override
  String get relationStudent => 'من تلاميذه';

  @override
  String get relationBrotherhood => 'أخوه في المؤاخاة';

  @override
  String get citationsTitle => 'مصادر هذه المعلومة';

  @override
  String citationsButton(String count) {
    return 'عرض المصادر ($count)';
  }

  @override
  String get citationLocatorPending => 'الموضع بانتظار التحقق';

  @override
  String citationVolume(String volume) {
    return 'ج $volume';
  }

  @override
  String citationPage(String page) {
    return 'ص $page';
  }

  @override
  String citationHadithNumber(String number) {
    return 'رقم $number';
  }

  @override
  String citationAuthorDeath(String author, String year) {
    return '$author (ت $year هـ)';
  }

  @override
  String citationGrading(String grade, String gradedBy) {
    return '$grade — $gradedBy';
  }

  @override
  String get gradeSahih => 'صحيح';

  @override
  String get gradeHasan => 'حسن';

  @override
  String get gradeDaif => 'ضعيف';

  @override
  String get citationUnknownSource => 'مصدر غير معروف';

  @override
  String get citationDraftNotice =>
      'هذا المحتوى مسودة لم يراجعها مختص بعد؛ التصنيف والمواضع مبدئية.';

  @override
  String get reliabilityExplainEstablished =>
      'من القرآن الكريم، أو حديث صحيح أو حسن، أو مما اتفق عليه المؤرخون.';

  @override
  String get reliabilityExplainReported =>
      'وردت في كتب السيرة والتاريخ، ولم يُحكم على إسنادها.';

  @override
  String get reliabilityExplainDisputed =>
      'تعدّدت فيه الروايات أو اختلف فيه أهل العلم.';

  @override
  String get reliabilityExplainUnknown => 'لم يثبت على وجه التحقيق.';

  @override
  String storyReadingMinutes(int count, String minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$minutes دقيقة قراءة',
      few: '$minutes دقائق قراءة',
      two: 'دقيقتا قراءة',
      one: 'دقيقة قراءة',
    );
    return '$_temp0';
  }

  @override
  String get profileAtAGlanceKicker => 'تعريف';

  @override
  String get readerNextSection => 'القسم التالي';

  @override
  String get readerPreviousSection => 'القسم السابق';

  @override
  String get readerSectionSources => 'مصادر هذا القسم';

  @override
  String get readerSettings => 'إعدادات القراءة';

  @override
  String readerTextSize(String size) {
    return 'حجم خط القراءة: $size';
  }

  @override
  String get readerTextSample => 'هذا نصٌّ لمعاينة حجم خط القراءة.';

  @override
  String get readerDigits => 'الأرقام';

  @override
  String get digitsArabicIndic => 'عربية (١٢٣)';

  @override
  String get digitsWestern => 'غربية (123)';

  @override
  String quranReference(String ref) {
    return 'قال الله تعالى — $ref';
  }

  @override
  String get quranTextPending =>
      'يُعرض نص الآية هنا من مصحف رقمي معتمد عند إضافته.';

  @override
  String get hadithLabel => 'حديث';

  @override
  String get reportLabel => 'رواية';

  @override
  String get quoteTextPending => 'النص بانتظار نقله من المصدر المعتمد.';

  @override
  String get disputeLabel => 'مسألة مختلف فيها';

  @override
  String disputeShowOpinions(String count) {
    return 'عرض الأقوال ($count)';
  }

  @override
  String disputeOpinion(String n) {
    return 'القول $n';
  }

  @override
  String get lessonLabel => 'درس وعبرة';

  @override
  String get sectionNotFound => 'لم نجد هذا القسم.';

  @override
  String get storyNotFound => 'لم نجد هذه القصة.';

  @override
  String get profileFullTimeline => 'الخط الزمني كاملًا';

  @override
  String get timelineTitle => 'الخط الزمني';

  @override
  String get eraPreIslam => 'قبل الإسلام';

  @override
  String get eraMakkan => 'العهد المكي';

  @override
  String get eraMadinan => 'العهد المدني';

  @override
  String get eraAfterProphet => 'بعد وفاة النبي ﷺ';

  @override
  String get eraKicker => 'المرحلة';

  @override
  String get timelineOpenSection => 'اقرأ في السيرة';

  @override
  String timelineEvent(String name) {
    return 'الحدث: $name';
  }

  @override
  String get storyChaptersKicker => 'الفصول';

  @override
  String get storyChaptersTitle => 'فصول القصة';

  @override
  String get storyStart => 'ابدأ القراءة';

  @override
  String storyChapterOf(String n, String total) {
    return 'الفصل $n من $total';
  }

  @override
  String get storyNextChapter => 'الفصل التالي';

  @override
  String get storyPreviousChapter => 'الفصل السابق';

  @override
  String get storyEnd => 'انتهت القصة';

  @override
  String get storyCompanions => 'صحابة في هذه القصة';

  @override
  String get bookmarkAdd => 'حفظ';

  @override
  String get bookmarkRemove => 'إزالة من المحفوظات';

  @override
  String get bookmarkSaved => 'حُفظ في المحفوظات';

  @override
  String get bookmarkRemoved => 'أُزيل من المحفوظات';

  @override
  String get continueKicker => 'تابع';

  @override
  String get continueTitle => 'تابع القراءة';

  @override
  String progressRead(String percent) {
    return 'قُرئ $percent';
  }

  @override
  String get savedKicker => 'المحفوظات';

  @override
  String get savedTitle => 'ما حفظته';

  @override
  String get savedCompanions => 'الصحابة';

  @override
  String get savedSections => 'أقسام السيرة';

  @override
  String get savedStories => 'القصص';

  @override
  String get savedChapters => 'فصول القصص';

  @override
  String get savedEmptyTitle => 'لا توجد محفوظات بعد';

  @override
  String get savedEmptyMessage =>
      'احفظ صحابيًّا أو قسمًا من السيرة أو قصة لتجده هنا.';

  @override
  String get searchTooltip => 'بحث';

  @override
  String get searchHint => 'ابحث باسم أو لقب أو عنوان أو عبارة…';

  @override
  String get searchStart =>
      'ابحث في أسماء الصحابة وألقابهم وكناهم، وفي عناوين السيرة والقصص ونصوصها.';

  @override
  String searchNoResults(String query) {
    return 'لا نتائج لـ «$query»';
  }

  @override
  String get searchRecent => 'عمليات بحث سابقة';

  @override
  String get searchClear => 'مسح';

  @override
  String get searchKindCompanions => 'الصحابة';

  @override
  String get searchKindStories => 'القصص';

  @override
  String get searchKindSections => 'أقسام السيرة';

  @override
  String get searchKindChapters => 'فصول القصص';

  @override
  String get homeFeaturedKicker => 'صحابي اليوم';

  @override
  String get homeReadBiography => 'اقرأ السيرة';

  @override
  String get homeCategoriesKicker => 'التصنيفات';

  @override
  String get homeCategoriesTitle => 'تصفّح الصحابة';

  @override
  String get homeStoriesKicker => 'حكايات';

  @override
  String get homeStoriesTitle => 'قصص مختارة';

  @override
  String get settingsAppearance => 'المظهر';

  @override
  String get settingsReading => 'القراءة';

  @override
  String get settingsContent => 'المحتوى';

  @override
  String settingsContentVersion(String version) {
    return 'إصدار المحتوى: $version';
  }

  @override
  String get settingsChannelDraft => 'محتوى تجريبي (مسودة)';

  @override
  String get settingsChannelPublished => 'محتوى منشور';

  @override
  String get settingsAbout => 'عن التطبيق والمنهج';

  @override
  String get settingsSources => 'المصادر المعتمدة';

  @override
  String get settingsLicenses => 'التراخيص';

  @override
  String get aboutIntro =>
      'سِيَر الصحابة تطبيق تعليمي يعرض سير صحابة النبي ﷺ وقصصهم، معزوّةً إلى مصادرها.';

  @override
  String get aboutMethodTitle => 'المنهج';

  @override
  String get aboutMethodBody =>
      'يسير التطبيق على منهج أهل السنة والجماعة في عرض السيرة والتاريخ، ويعزو كل معلومة إلى مصدرها، ويميّز بين الثابت والمروي والمختلف فيه وما لم يثبت. وتركّز هذه النسخة على السيرة والفضائل والمآثر وأهم الأحداث، ولا تتناول تفاصيل الفتنة.';

  @override
  String get aboutReliabilityTitle => 'درجات الثبوت';

  @override
  String get aboutReviewTitle => 'حالة المراجعة';

  @override
  String get aboutReviewDraft =>
      'لم يُراجَع المحتوى بعد. النصوص الحالية للتطوير والمراجعة، ولن تُنشر قبل أن يراجعها مختص مؤهل.';

  @override
  String get aboutReviewPublished =>
      'راجع المحتوى المنشور مختصون مؤهلون قبل نشره.';

  @override
  String get aboutImagesTitle => 'الصور';

  @override
  String get aboutImagesBody =>
      'لا يتضمن التطبيق صورًا أو رسومًا للصحابة أو للنبي ﷺ، وتُستخدم بدلًا منها الزخارف الهندسية والخط العربي. ولا توجد صور فوتوغرافية فيه حاليًا.';

  @override
  String get sourceTypeQuran => 'القرآن الكريم';

  @override
  String get sourceTypeHadith => 'كتب الحديث';

  @override
  String get sourceTypeBiographical => 'كتب التراجم';

  @override
  String get sourceTypeHistory => 'كتب التاريخ';

  @override
  String get sourceTypeSira => 'كتب السيرة';

  @override
  String get sourceTypeTafsir => 'كتب التفسير';

  @override
  String get sourceTypeOther => 'مصادر أخرى';

  @override
  String homeCategoryCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n صحابيًّا',
      few: '$n صحابة',
      two: 'صحابيان',
      one: 'صحابي واحد',
      zero: 'لا صحابة بعد',
    );
    return '$_temp0';
  }

  @override
  String get savedLoadErrorMessage =>
      'تعذّر تحميل المحفوظات. لم يُحذف شيء منها؛ حاول مرة أخرى.';

  @override
  String get savedItemLoading => 'جارٍ التحميل…';

  @override
  String get savedItemLoadError => 'تعذّر تحميل هذا العنصر';

  @override
  String get savedItemUnavailableTitle => 'لم يعد هذا العنصر متاحًا';

  @override
  String get savedItemUnavailableMessage =>
      'حُذف من المحتوى في تحديث سابق، ويمكنك إزالته من المحفوظات.';

  @override
  String get bookmarkUpdateFailed => 'تعذّر حفظ التغيير. حاول مرة أخرى.';

  @override
  String get progressSaveFailed => 'تعذّر حفظ موضع القراءة.';

  @override
  String get readerPassageChanged =>
      'تغيّر هذا النص منذ قراءتك الأخيرة، فعرضناه من أوله.';

  @override
  String get readerRestorePosition => 'موضعي السابق';

  @override
  String get errorUnsupportedContent =>
      'هذا المحتوى بصيغة أحدث مما يقرؤه هذا الإصدار من التطبيق. حدّث التطبيق لعرضه.';

  @override
  String get readerMarkComplete => 'أنهيتُ القراءة';

  @override
  String get readerCompleted => 'أتممتَ قراءة هذا النص.';

  @override
  String get readerReadAgain => 'اقرأه من جديد';

  @override
  String get profileStartReading => 'ابدأ قراءة السيرة';

  @override
  String get profileContinueReading => 'تابع القراءة';

  @override
  String get profileBiographyFinishedMale => 'أتممتَ قراءة سيرته.';

  @override
  String get profileBiographyFinishedFemale => 'أتممتَ قراءة سيرتها.';

  @override
  String get profileReadFromStart => 'اقرأها من البداية';

  @override
  String get profileBiographyNotWrittenMale =>
      'لم تُكتب سيرته المفصّلة بعد؛ يعرض هذا الملف تعريفًا موجزًا ومصادره.';

  @override
  String get profileBiographyNotWrittenFemale =>
      'لم تُكتب سيرتها المفصّلة بعد؛ يعرض هذا الملف تعريفًا موجزًا ومصادره.';

  @override
  String get passageFinished => 'مكتمل';

  @override
  String get readerSectionContents => 'فهرس الأقسام';

  @override
  String get readerChapterContents => 'فهرس الفصول';

  @override
  String get readerReadingNow => 'تقرؤه الآن';

  @override
  String profileSectionCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n قسمًا',
      few: '$n أقسام',
      two: 'قسمان',
      one: 'قسم واحد',
    );
    return '$_temp0';
  }

  @override
  String profileResumeDetail(String title, String percent) {
    return '$title · قُرئ $percent';
  }

  @override
  String get searchScopeAll => 'الكل';

  @override
  String get searchScopeCompanions => 'الصحابة';

  @override
  String get searchScopeBiographies => 'السِّيَر';

  @override
  String get searchScopeStories => 'القصص';

  @override
  String get searchIncomplete =>
      'تعذّر تحميل بعض المحتوى، فقد تكون النتائج ناقصة.';

  @override
  String get searchFilterLabel => 'تصفية النتائج';

  @override
  String searchNoResultsIncomplete(String query) {
    return 'لا نتائج لـ «$query» فيما أمكن تحميله من المحتوى.';
  }

  @override
  String searchWithin(String name) {
    return 'في: $name';
  }

  @override
  String get undo => 'تراجع';

  @override
  String get historyTitle => 'سجل القراءة';

  @override
  String get historyEmpty => 'لم تُتمّ قراءة شيء بعد.';

  @override
  String get historyReset => 'إعادة تعيين التقدّم';

  @override
  String get continueRemove => 'إزالة من «تابع القراءة»';

  @override
  String get bookmarkRemovedUndo => 'أُزيل من المحفوظات.';

  @override
  String get settingsYourData => 'بيانات القراءة على هذا الجهاز';

  @override
  String get settingsClearHistory => 'مسح سجل القراءة';

  @override
  String get settingsClearSaved => 'مسح المحفوظات';

  @override
  String get settingsNothingToClear => 'لا شيء لمسحه';

  @override
  String get clearHistoryTitle => 'مسح سجل القراءة؟';

  @override
  String get clearSavedTitle => 'مسح المحفوظات؟';

  @override
  String get clearConfirm => 'مسح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get historyCleared => 'مُسح سجل القراءة.';

  @override
  String get savedCleared => 'مُسحت المحفوظات.';

  @override
  String historyResetDone(String title) {
    return 'أُعيد تعيين تقدّمك في «$title».';
  }

  @override
  String historyFinishedOn(String date) {
    return 'أُتمّت في $date';
  }

  @override
  String countTexts(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n نصًّا',
      few: '$n نصوص',
      two: 'نصّان',
      one: 'نص واحد',
    );
    return '$_temp0';
  }

  @override
  String countItems(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n عنصرًا',
      few: '$n عناصر',
      two: 'عنصران',
      one: 'عنصر واحد',
    );
    return '$_temp0';
  }

  @override
  String clearHistoryMessage(String what) {
    return 'سيُحذف موضع القراءة وعلامة الإتمام لـ$what من هذا الجهاز، ولا يمكن التراجع عن ذلك. لن تتأثر المحفوظات ولا الإعدادات.';
  }

  @override
  String clearSavedMessage(String what) {
    return 'سيُحذف $what من المحفوظات على هذا الجهاز، ولا يمكن التراجع عن ذلك. لن يتأثر سجل القراءة ولا الإعدادات.';
  }
}
