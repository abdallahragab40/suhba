// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سِيَر';

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
  String get draftBannerTitle => 'لم يعتمد هذا المحتوى مختص بعد';

  @override
  String get draftBannerMessage =>
      'النصوص والمصادر هنا مسودة أو خضعت لمراجعة أولية، ولا تُعتمد قبل أن يعتمدها عالم مختص.';

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
      'لم يعتمد هذا المحتوى مختص بعد؛ التصنيف والمواضع مبدئية.';

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
  String get quranTextPending => 'تعذّر عرض نص الآية الآن، والمرجع أعلاه.';

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
      'سِيَر تطبيق تعليمي يعرض سيرة النبي ﷺ وسِيَر أصحابه وقصصهم، معزوّةً كلها إلى مصادرها.';

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
      'لم يعتمد المحتوى مختص مؤهل بعد. ما خضع منه لمراجعة أولية — رُوجع فيها كل خبر على مصدره وصُحّح ما وُجد من أخطاء — يُوسم بـ«مراجعة أولية»، وما لم يخضع لها بعدُ يُوسم بـ«مسودة». ولن يُنشر شيء قبل أن يعتمده مختص مؤهل.';

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

  @override
  String get tabSeerah => 'السيرة';

  @override
  String get tabExplore => 'استكشف';

  @override
  String get timelineHijrahMark => 'الهجرة';

  @override
  String get timelineUndated => 'بلا تاريخ محدد';

  @override
  String mapSemantics(String count) {
    return 'خريطة تخطيطية لـ$count مواضع، وتليها قائمة بها';
  }

  @override
  String get mapZoomIn => 'تكبير الخريطة';

  @override
  String get mapZoomOut => 'تصغير الخريطة';

  @override
  String get mapNorth => 'الشمال';

  @override
  String get mapLegendIdentified => 'موضع معروف';

  @override
  String get mapLegendApproximate => 'موضع تقريبي';

  @override
  String get mapLegendUncertain => 'موضع مختلف فيه';

  @override
  String get mapApproximatePath => 'صلة بين محطتين، لا الطريق الفعلي';

  @override
  String get mapSchematicNote =>
      'خريطة تخطيطية للتوضيح، وليست رسمًا مساحيًّا دقيقًا.';

  @override
  String get relationCompanion => 'صاحبه';

  @override
  String sequenceStep(String n) {
    return 'الخطوة $n';
  }

  @override
  String get sequenceOrderUncertain => 'موضعها من الترتيب غير قطعي';

  @override
  String get sceneIllustration => 'رسم توضيحي';

  @override
  String get visualTypeTimeline => 'خط زمني';

  @override
  String get visualTypeMap => 'خريطة';

  @override
  String get visualTypeRelationships => 'صلات';

  @override
  String get visualTypeSequence => 'تسلسل الأحداث';

  @override
  String get visualTypePeriods => 'مراحل زمنية';

  @override
  String get visualTypePlacePanel => 'بطاقة مكان';

  @override
  String get visualNotFound => 'هذا الرسم غير متاح في هذا الإصدار.';

  @override
  String get visualShowChart => 'الرسم';

  @override
  String get visualShowList => 'قائمة';

  @override
  String get visualNotes => 'ملاحظات على الدقة';

  @override
  String get visualSources => 'مصادر الرسم';

  @override
  String get visualOpen => 'عرض كامل';

  @override
  String get mapRouteTitle => 'محطات الطريق';

  @override
  String mapRouteLeg(String from, String to) {
    return 'من $from إلى $to';
  }

  @override
  String visualRelationOf(String relation, String person) {
    return '$relation · $person';
  }

  @override
  String get seerahSectionName => 'السيرة النبوية';

  @override
  String get seerahUnavailable => 'السيرة النبوية غير متاحة في هذا الإصدار.';

  @override
  String get seerahJourneyKicker => 'الرحلة';

  @override
  String get seerahJourneyTitle => 'فصول السيرة بالترتيب';

  @override
  String seerahJourneyNote(String n) {
    return '$n فصلًا من المولد إلى الوفاة، مقسّمة على مراحل الزمن.';
  }

  @override
  String get seerahOpenTimeline => 'السيرة على خط الزمن';

  @override
  String get seerahTopicsKicker => 'موضوعات';

  @override
  String get seerahTopicsTitle => 'من شمائله وهديه ﷺ';

  @override
  String get seerahEventsKicker => 'الأرشيف';

  @override
  String get seerahEventsTitle => 'أحداث فارقة';

  @override
  String get seerahPlacesKicker => 'الأطلس';

  @override
  String get seerahPlacesTitle => 'أماكن السيرة';

  @override
  String get seerahCompanionsKicker => 'الصحبة';

  @override
  String get seerahCompanionsTitle => 'صحابة في هذه السيرة';

  @override
  String get seerahMethodKicker => 'المنهج';

  @override
  String get seerahMethodTitle => 'كيف كُتبت هذه السيرة';

  @override
  String get seerahAllSources => 'كل المصادر';

  @override
  String seerahContinue(String title) {
    return 'تابع: $title';
  }

  @override
  String get seerahStart => 'ابدأ السيرة';

  @override
  String get seerahOpenSection => 'افتح السيرة النبوية';

  @override
  String get seerahScrollHint => 'اثنا عشر فصلًا';

  @override
  String seerahChapterLabel(String number, String date) {
    return 'الفصل $number · $date';
  }

  @override
  String seerahVisualCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n رسمًا',
      few: '$n رسوم',
      two: 'رسمان',
      one: 'رسم توضيحي',
    );
    return '$_temp0';
  }

  @override
  String get coverageSample =>
      'هذا نص تجريبي مختصر، ولم يُكتب بالتفصيل المقصود بعد.';

  @override
  String get coverageSkeleton => 'لم يُكتب هذا النص بعد.';

  @override
  String get coverageSampleShort => 'نص تجريبي';

  @override
  String get seerahFeatureKicker => 'حدث فارق';

  @override
  String get seerahFeatureTitle => 'الهجرة: من مكة إلى المدينة';

  @override
  String get seerahFeatureRead => 'اقرأ فصل الهجرة';

  @override
  String get seerahChapterNotFound => 'هذا الفصل غير موجود.';

  @override
  String get seerahTopicNotFound => 'هذا الموضوع غير موجود.';

  @override
  String seerahChapterOf(String number, String total, String date) {
    return 'الفصل $number من $total · $date';
  }

  @override
  String seerahTopicOf(String number, String total) {
    return 'موضوع $number من $total';
  }

  @override
  String get seerahContents => 'فصول السيرة';

  @override
  String get seerahPreviousChapter => 'الفصل السابق';

  @override
  String get seerahNextChapter => 'الفصل التالي';

  @override
  String get seerahPreviousTopic => 'الموضوع السابق';

  @override
  String get seerahNextTopic => 'الموضوع التالي';

  @override
  String get seerahTimelineTitle => 'السيرة على خط الزمن';

  @override
  String get relatedEvents => 'أحداث في هذا الفصل';

  @override
  String get relatedPlaces => 'أماكن';

  @override
  String get relatedCompanions => 'صحابة ذوو صلة';

  @override
  String get relatedChapters => 'من فصول السيرة';

  @override
  String get eventTypeHijrah => 'هجرة';

  @override
  String get eventTypeBattle => 'غزوة';

  @override
  String get eventTypeTreaty => 'صلح';

  @override
  String get eventTypePledge => 'بيعة';

  @override
  String get eventTypeAppointment => 'ولاية';

  @override
  String get eventTypeDeath => 'وفاة';

  @override
  String get eventTypeRevelation => 'وحي';

  @override
  String get eventTypeMigration => 'هجرة جماعية';

  @override
  String get eventTypeCommunity => 'بناء المجتمع';

  @override
  String get eventTypeOther => 'حدث';

  @override
  String get eventPageTitle => 'حدث من السيرة';

  @override
  String get eventNotFound => 'هذا الحدث غير موجود.';

  @override
  String get eventContext => 'ما قبله';

  @override
  String get eventOutcome => 'ما بعده';

  @override
  String get eventParticipants => 'ممن شهده';

  @override
  String get eventInSeerah => 'في السيرة النبوية';

  @override
  String get placePageTitle => 'مكان من السيرة';

  @override
  String get placeNotFound => 'هذا المكان غير موجود.';

  @override
  String placeToday(String name) {
    return 'اليوم: $name';
  }

  @override
  String get placeOnMap => 'على الخريطة';

  @override
  String get placeEvents => 'أحداث في هذا المكان';

  @override
  String get placeVisuals => 'رسوم تعرض هذا المكان';

  @override
  String get visualPageTitle => 'رسم توضيحي';

  @override
  String get exploreAll => 'الكل';

  @override
  String get exploreEvents => 'الأحداث';

  @override
  String get explorePlaces => 'الأماكن';

  @override
  String get exploreVisuals => 'الرسوم';

  @override
  String get exploreStories => 'القصص';

  @override
  String get exploreIntro =>
      'أرشيف الأحداث، وأماكن السيرة، والرسوم التوضيحية، والقصص: ادخل من أيها شئت.';

  @override
  String get exploreEventsKicker => 'الأرشيف';

  @override
  String get exploreEventsTitle => 'سجل الأحداث';

  @override
  String get exploreEventsNote =>
      'مرتبة بتواريخها كما سجّلتها المصادر، بدقتها.';

  @override
  String get exploreBeforeHijrah => 'قبل الهجرة';

  @override
  String get exploreAfterHijrah => 'بعد الهجرة';

  @override
  String get exploreVisualsKicker => 'رسوم توضيحية';

  @override
  String get exploreVisualsTitle => 'خرائط وخطوط زمنية وصلات';

  @override
  String get explorePlacesKicker => 'الأطلس';

  @override
  String get explorePlacesTitle => 'أماكن السيرة';

  @override
  String get exploreStoriesKicker => 'حكايات';

  @override
  String get exploreStoriesTitle => 'قصص من السيرة';

  @override
  String get savedSeerahChapters => 'من فصول السيرة';

  @override
  String get savedSeerahTopics => 'من موضوعات السيرة';

  @override
  String get homeSeerahKicker => 'السيرة النبوية';

  @override
  String get homeSeerahTitle => 'الفصول القادمة';

  @override
  String get homeAllChapters => 'كل الفصول';

  @override
  String get homeDiscoverTitle => 'تعرّف على صحابي';

  @override
  String get homeAtlasKicker => 'الأطلس';

  @override
  String get homeAtlasTitle => 'أين جرت الأحداث';

  @override
  String get homeArchiveKicker => 'الأرشيف';

  @override
  String get homeArchiveTitle => 'أحداث مختارة';

  @override
  String get homeAllEvents => 'سجل الأحداث كاملًا';

  @override
  String get searchKindSeerahChapters => 'فصول السيرة النبوية';

  @override
  String get searchKindSeerahTopics => 'موضوعات السيرة';

  @override
  String get searchKindEvents => 'أحداث';

  @override
  String get searchKindPlaces => 'أماكن';

  @override
  String get searchScopeSeerah => 'السيرة النبوية';

  @override
  String get searchScopeArchive => 'الأحداث والأماكن';

  @override
  String get profileConnectionsKicker => 'في السيرة';

  @override
  String get profileConnectionsTitle => 'في فصول السيرة وأحداثها';

  @override
  String get profileEvents => 'من الأحداث المشتركة';

  @override
  String get profileVisuals => 'رسوم توضيحية';

  @override
  String get quranTextSource => 'الرسم العثماني من مشروع تنزيل';

  @override
  String get sourcesQuranTextTitle => 'نص القرآن الكريم';

  @override
  String sourcesQuranTextBody(String url) {
    return 'تُعرض الآيات بالرسم العثماني من مشروع تنزيل ($url)، كما هي دون أي تغيير، برخصة المشاع الإبداعي: نسب المصنَّف ٣٫٠. يحفظ التطبيق الآيات المقتبسة فقط، ولا يتصل بالإنترنت.';
  }

  @override
  String get sourcesQuranNotice => 'نص الترخيص';

  @override
  String get relationsTitle => 'الصلات والأنساب';

  @override
  String get relationsIntro =>
      'من يتصل بمن من أهل السيرة: النسب والمصاهرة والصحبة والمؤاخاة، ومع كل صلة مصدرها. تظهر كل صلة عند الطرفين.';

  @override
  String relationsFilteredTitle(String name) {
    return 'صلات $name';
  }

  @override
  String get relationsShowEveryone => 'عرض صلات الجميع';

  @override
  String get relationsIncomplete =>
      'تعذّر تحميل بعض الملفات، فقد تكون هذه القائمة ناقصة.';

  @override
  String get relationsEmpty => 'لا صلات مسجّلة هنا بعد.';

  @override
  String get relationCategoryKinship => 'النسب والقرابة';

  @override
  String get relationCategoryMarriage => 'الزواج';

  @override
  String get relationCategoryCompanionship => 'الصحبة والمؤاخاة';

  @override
  String get relationCategoryLearning => 'العلم والرواية';

  @override
  String relationsOpenProfile(String name) {
    return 'فتح صفحة $name';
  }

  @override
  String get exploreRelationsKicker => 'صلات';

  @override
  String get exploreRelationsTitle => 'الأنساب والمصاهرات والصحبة';

  @override
  String get exploreRelationsBody =>
      'تصفّح صلات أهل السيرة بعضهم ببعض، مجمّعة بحسب نوعها، ومع كل صلة مصدرها.';

  @override
  String get profileAllRelations => 'كل صلاته في مستكشف الصلات';

  @override
  String get citationShareAction => 'مشاركة المقطع مع مصادره';

  @override
  String get shareSourcesHeading => 'المصادر:';

  @override
  String shareReliability(String label) {
    return 'درجة الخبر: $label';
  }

  @override
  String get shareDraftNotice =>
      'تنبيه: نص لم يعتمده مختص بعد، والمصادر ومواضعها مبدئية.';

  @override
  String shareFromApp(String appName) {
    return 'من تطبيق $appName';
  }

  @override
  String get settingsExport => 'تصدير بيانات القراءة';

  @override
  String get settingsExportSubtitle =>
      'ملف بالمحفوظات ومواضع القراءة، تحفظه أو تنقله إلى جهاز آخر.';

  @override
  String get settingsImport => 'استيراد بيانات القراءة';

  @override
  String get settingsImportSubtitle =>
      'يضيف ما في الملف إلى ما على هذا الجهاز، ولا يحذف شيئًا.';

  @override
  String exportSubject(String appName) {
    return 'بيانات القراءة من $appName';
  }

  @override
  String get importConfirmTitle => 'استيراد بيانات القراءة';

  @override
  String importConfirmMessage(String items, String texts) {
    return 'سيُضاف من المحفوظات: $items، ومن مواضع القراءة: $texts. ويبقى ما سواه على هذا الجهاز كما هو، ولا يُحذف شيء.';
  }

  @override
  String get importConfirm => 'استيراد';

  @override
  String get importNothingNew =>
      'لا جديد في هذا الملف؛ كل ما فيه موجود على هذا الجهاز.';

  @override
  String get importDone => 'تم الاستيراد.';

  @override
  String get importFailed =>
      'تعذّر إكمال الاستيراد. ما أُضيف قبل الخطأ باقٍ، ولم يُحذف شيء.';

  @override
  String get exportFailed => 'تعذّر تصدير البيانات.';

  @override
  String get importRefusedTitle => 'تعذّر استيراد الملف';

  @override
  String get importRefusedNotJson =>
      'هذا ليس ملف بيانات صالحًا، أو أنه أكبر مما يُقبل.';

  @override
  String get importRefusedNotAnExport =>
      'هذا الملف ليس تصديرًا لبيانات القراءة من هذا التطبيق.';

  @override
  String get importRefusedNewer =>
      'صُدّر هذا الملف من إصدار أحدث من التطبيق؛ حدّث التطبيق ثم أعد المحاولة.';

  @override
  String importRefusedInvalid(String where) {
    return 'في الملف سجل غير صالح ($where)، فلم يُستورد شيء.';
  }

  @override
  String get dialogOk => 'حسنًا';

  @override
  String get importReadFailed => 'تعذّر فتح الملف، ولم يتغير شيء.';

  @override
  String get themeShortSystem => 'تلقائي';

  @override
  String get themeShortLight => 'فاتح';

  @override
  String get themeShortDark => 'داكن';

  @override
  String get aboutLicensesLink => 'تراخيص البرمجيات المستخدمة';

  @override
  String get draftBadgePreliminary => 'مراجعة أولية — لم يعتمدها مختص';
}
