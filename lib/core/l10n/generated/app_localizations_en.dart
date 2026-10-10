// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Siyar al-Sahaba';

  @override
  String get designGalleryTitle => 'Design system gallery';

  @override
  String get themeModeSystem => 'System default';

  @override
  String get themeModeLight => 'Light theme';

  @override
  String get themeModeDark => 'Dark theme';

  @override
  String get changeThemeTooltip => 'Change theme';

  @override
  String get tabHome => 'Home';

  @override
  String get tabCompanions => 'Companions';

  @override
  String get tabSaved => 'Saved';

  @override
  String get tabSettings => 'Settings';

  @override
  String get underConstructionTitle => 'Coming soon';

  @override
  String get underConstructionMessage =>
      'This screen will be added in a later development stage.';

  @override
  String get notFoundTitle => 'Page not found';

  @override
  String get notFoundMessage => 'The link may be outdated or incorrect.';

  @override
  String get goHome => 'Back to home';

  @override
  String get errorTitle => 'This content could not be shown';

  @override
  String get errorMessage =>
      'Something unexpected went wrong. Please try again.';

  @override
  String get retry => 'Try again';

  @override
  String get loading => 'Loading';

  @override
  String get reliabilityEstablished => 'Established';

  @override
  String get reliabilityReported => 'Historical report';

  @override
  String get reliabilityDisputed => 'Disputed';

  @override
  String get reliabilityUnknown => 'Unknown';

  @override
  String reliabilitySemantics(String level) {
    return 'Reliability: $level';
  }

  @override
  String get reliabilityProvisional =>
      'Provisional classification, awaiting review';

  @override
  String dateHijriYear(String year) {
    return '$year AH';
  }

  @override
  String dateBeforeHijraYear(String year) {
    return '$year BH';
  }

  @override
  String dateGregorianYear(String year) {
    return '$year CE';
  }

  @override
  String dateHijriRange(String start, String end) {
    return '$start–$end AH';
  }

  @override
  String dateBeforeHijraRange(String start, String end) {
    return '$start–$end BH';
  }

  @override
  String dateGregorianRange(String start, String end) {
    return '$start–$end CE';
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
    return 'c. $date';
  }

  @override
  String dateWithGregorian(String hijri, String gregorian) {
    return '$hijri / $gregorian';
  }

  @override
  String get dateUnknown => 'Not reliably known';

  @override
  String hijriMonthName(String month) {
    String _temp0 = intl.Intl.selectLogic(month, {
      '1': 'Muharram',
      '2': 'Safar',
      '3': 'Rabi al-Awwal',
      '4': 'Rabi al-Akhir',
      '5': 'Jumada al-Ula',
      '6': 'Jumada al-Akhirah',
      '7': 'Rajab',
      '8': 'Shaban',
      '9': 'Ramadan',
      '10': 'Shawwal',
      '11': 'Dhu al-Qadah',
      '12': 'Dhu al-Hijjah',
      'other': '',
    });
    return '$_temp0';
  }

  @override
  String quranRef(String surah, String ayah) {
    return '$surah $ayah';
  }

  @override
  String quranRefRange(String surah, String from, String to) {
    return '$surah $from–$to';
  }

  @override
  String percent(String value) {
    return '$value%';
  }

  @override
  String get draftBadge => 'Draft — not reviewed';

  @override
  String get draftBannerTitle =>
      'Sample content, not yet academically reviewed';

  @override
  String get draftBannerMessage =>
      'The texts and sources here are for development and review, and should not be relied on until a qualified reviewer has checked them.';

  @override
  String get directoryAll => 'All';

  @override
  String get directoryEmpty => 'No companions in this category yet.';

  @override
  String get companionNotFound => 'This companion could not be found.';

  @override
  String get backToDirectory => 'Back to companions';

  @override
  String get profileAtAGlance => 'At a glance';

  @override
  String get profileBirth => 'Birth';

  @override
  String get profileDeath => 'Death';

  @override
  String get profileDeathPlace => 'Place of death';

  @override
  String get profileSectionsKicker => 'Biography';

  @override
  String get profileSectionsTitle => 'Chapters of the biography';

  @override
  String get profileTimelineKicker => 'Chronology';

  @override
  String get profileTimelineTitle => 'Moments in his life';

  @override
  String get profileTimelineTitleFemale => 'Moments in her life';

  @override
  String get profileStoriesKicker => 'Stories';

  @override
  String get profileStoriesTitle => 'Stories from the biography';

  @override
  String get profileRelatedKicker => 'Connections';

  @override
  String get profileRelatedTitle => 'Related people';

  @override
  String get profileReferencesKicker => 'Sources';

  @override
  String get profileReferencesTitle => 'References for this biography';

  @override
  String get relationFather => 'Father';

  @override
  String get relationMother => 'Mother';

  @override
  String get relationChild => 'Child';

  @override
  String get relationSpouse => 'Spouse';

  @override
  String get relationSibling => 'Sibling';

  @override
  String get relationRelative => 'Relative';

  @override
  String get relationTeacher => 'Teacher';

  @override
  String get relationStudent => 'Student';

  @override
  String get relationBrotherhood => 'Brother in the Mu\'akhat';

  @override
  String get citationsTitle => 'Sources for this information';

  @override
  String citationsButton(String count) {
    return 'Show sources ($count)';
  }

  @override
  String get citationLocatorPending => 'Exact location awaiting verification';

  @override
  String citationVolume(String volume) {
    return 'vol. $volume';
  }

  @override
  String citationPage(String page) {
    return 'p. $page';
  }

  @override
  String citationHadithNumber(String number) {
    return 'no. $number';
  }

  @override
  String citationAuthorDeath(String author, String year) {
    return '$author (d. $year AH)';
  }

  @override
  String citationGrading(String grade, String gradedBy) {
    return '$grade — $gradedBy';
  }

  @override
  String get gradeSahih => 'Sahih';

  @override
  String get gradeHasan => 'Hasan';

  @override
  String get gradeDaif => 'Da\'if';

  @override
  String get citationUnknownSource => 'Unknown source';

  @override
  String get citationDraftNotice =>
      'This content is a draft not yet checked by a qualified reviewer; the classification and locations are provisional.';

  @override
  String get reliabilityExplainEstablished =>
      'From the Qur\'an, a sahih or hasan hadith, or agreed by the historians.';

  @override
  String get reliabilityExplainReported =>
      'Reported in sira and history works; its chain has not been assessed.';

  @override
  String get reliabilityExplainDisputed =>
      'Reports differ or scholars disagree.';

  @override
  String get reliabilityExplainUnknown => 'Not reliably established.';

  @override
  String storyReadingMinutes(int count, String minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$minutes minute read',
      one: '1 minute read',
    );
    return '$_temp0';
  }

  @override
  String get profileAtAGlanceKicker => 'Introduction';

  @override
  String get readerNextSection => 'Next section';

  @override
  String get readerPreviousSection => 'Previous section';

  @override
  String get readerSectionSources => 'Sources of this section';

  @override
  String get readerSettings => 'Reading settings';

  @override
  String readerTextSize(String size) {
    return 'Reading text size: $size';
  }

  @override
  String get readerTextSample => 'This text previews the reading size.';

  @override
  String get readerDigits => 'Digits';

  @override
  String get digitsArabicIndic => 'Arabic (١٢٣)';

  @override
  String get digitsWestern => 'Western (123)';

  @override
  String quranReference(String ref) {
    return 'Allah the Exalted said — $ref';
  }

  @override
  String get quranTextPending =>
      'The verse text could not be shown just now; the reference is above.';

  @override
  String get hadithLabel => 'Hadith';

  @override
  String get reportLabel => 'Report';

  @override
  String get quoteTextPending =>
      'The text is awaiting transcription from the cited edition.';

  @override
  String get disputeLabel => 'A disputed matter';

  @override
  String disputeShowOpinions(String count) {
    return 'Show the opinions ($count)';
  }

  @override
  String disputeOpinion(String n) {
    return 'Opinion $n';
  }

  @override
  String get lessonLabel => 'A lesson';

  @override
  String get sectionNotFound => 'This section could not be found.';

  @override
  String get storyNotFound => 'This story could not be found.';

  @override
  String get profileFullTimeline => 'Full timeline';

  @override
  String get timelineTitle => 'Timeline';

  @override
  String get eraPreIslam => 'Before Islam';

  @override
  String get eraMakkan => 'The Makkan period';

  @override
  String get eraMadinan => 'The Madinan period';

  @override
  String get eraAfterProphet => 'After the Prophet ﷺ';

  @override
  String get eraKicker => 'Period';

  @override
  String get timelineOpenSection => 'Read in the biography';

  @override
  String timelineEvent(String name) {
    return 'Event: $name';
  }

  @override
  String get storyChaptersKicker => 'Chapters';

  @override
  String get storyChaptersTitle => 'The story\'s chapters';

  @override
  String get storyStart => 'Start reading';

  @override
  String storyChapterOf(String n, String total) {
    return 'Chapter $n of $total';
  }

  @override
  String get storyNextChapter => 'Next chapter';

  @override
  String get storyPreviousChapter => 'Previous chapter';

  @override
  String get storyEnd => 'The end of the story';

  @override
  String get storyCompanions => 'Companions in this story';

  @override
  String get bookmarkAdd => 'Save';

  @override
  String get bookmarkRemove => 'Remove from saved';

  @override
  String get bookmarkSaved => 'Saved';

  @override
  String get bookmarkRemoved => 'Removed from saved';

  @override
  String get continueKicker => 'Continue';

  @override
  String get continueTitle => 'Continue reading';

  @override
  String progressRead(String percent) {
    return '$percent read';
  }

  @override
  String get savedKicker => 'Saved';

  @override
  String get savedTitle => 'What you saved';

  @override
  String get savedCompanions => 'Companions';

  @override
  String get savedSections => 'Biography sections';

  @override
  String get savedStories => 'Stories';

  @override
  String get savedChapters => 'Story chapters';

  @override
  String get savedEmptyTitle => 'Nothing saved yet';

  @override
  String get savedEmptyMessage =>
      'Save a companion, a biography section or a story to find it here.';

  @override
  String get searchTooltip => 'Search';

  @override
  String get searchHint => 'Search names, titles or phrases…';

  @override
  String get searchStart =>
      'Search companions\' names, titles and kunyas, and the headings and text of biographies and stories.';

  @override
  String searchNoResults(String query) {
    return 'No results for “$query”';
  }

  @override
  String get searchRecent => 'Recent searches';

  @override
  String get searchClear => 'Clear';

  @override
  String get searchKindCompanions => 'Companions';

  @override
  String get searchKindStories => 'Stories';

  @override
  String get searchKindSections => 'Biography sections';

  @override
  String get searchKindChapters => 'Story chapters';

  @override
  String get homeFeaturedKicker => 'Companion of the day';

  @override
  String get homeReadBiography => 'Read the biography';

  @override
  String get homeCategoriesKicker => 'Categories';

  @override
  String get homeCategoriesTitle => 'Browse the companions';

  @override
  String get homeStoriesKicker => 'Stories';

  @override
  String get homeStoriesTitle => 'Selected stories';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsReading => 'Reading';

  @override
  String get settingsContent => 'Content';

  @override
  String settingsContentVersion(String version) {
    return 'Content version: $version';
  }

  @override
  String get settingsChannelDraft => 'Sample content (draft)';

  @override
  String get settingsChannelPublished => 'Published content';

  @override
  String get settingsAbout => 'About and methodology';

  @override
  String get settingsSources => 'Sources';

  @override
  String get settingsLicenses => 'Licences';

  @override
  String get aboutIntro =>
      'Siyar al-Sahaba is an educational app presenting the lives and stories of the Companions of the Prophet ﷺ, each attributed to its sources.';

  @override
  String get aboutMethodTitle => 'Methodology';

  @override
  String get aboutMethodBody =>
      'The app follows the methodology of Ahl al-Sunnah wal-Jama\'ah in presenting biography and history. Every statement is attributed to its source, and established facts, reports, disputed matters and the unknown are kept distinct. This version focuses on biography, virtues, achievements and key events, and does not cover the details of the fitna.';

  @override
  String get aboutReliabilityTitle => 'Reliability levels';

  @override
  String get aboutReviewTitle => 'Review status';

  @override
  String get aboutReviewDraft =>
      'The content has not been reviewed yet. The current texts are for development and review, and will not be published until a qualified reviewer has checked them.';

  @override
  String get aboutReviewPublished =>
      'The published content was checked by qualified reviewers before publication.';

  @override
  String get aboutImagesTitle => 'Images';

  @override
  String get aboutImagesBody =>
      'The app contains no images or drawings of the Companions or of the Prophet ﷺ; geometric ornament and Arabic calligraphy are used instead. It currently includes no photographs.';

  @override
  String get sourceTypeQuran => 'The Qur\'an';

  @override
  String get sourceTypeHadith => 'Hadith collections';

  @override
  String get sourceTypeBiographical => 'Biographical dictionaries';

  @override
  String get sourceTypeHistory => 'Histories';

  @override
  String get sourceTypeSira => 'Sira works';

  @override
  String get sourceTypeTafsir => 'Tafsir works';

  @override
  String get sourceTypeOther => 'Other sources';

  @override
  String homeCategoryCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n companions',
      one: '1 companion',
    );
    return '$_temp0';
  }

  @override
  String get savedLoadErrorMessage =>
      'Your saved items could not be loaded. Nothing was deleted; try again.';

  @override
  String get savedItemLoading => 'Loading…';

  @override
  String get savedItemLoadError => 'This item could not be loaded';

  @override
  String get savedItemUnavailableTitle => 'This item is no longer available';

  @override
  String get savedItemUnavailableMessage =>
      'It was removed from the content in an update. You can remove it from Saved.';

  @override
  String get bookmarkUpdateFailed =>
      'The change could not be saved. Try again.';

  @override
  String get progressSaveFailed => 'Your reading position could not be saved.';

  @override
  String get readerPassageChanged =>
      'This text changed since you last read it, so it opens at the start.';

  @override
  String get readerRestorePosition => 'My last position';

  @override
  String get errorUnsupportedContent =>
      'This content is in a newer format than this version of the app can read. Update the app to see it.';

  @override
  String get readerMarkComplete => 'I finished reading';

  @override
  String get readerCompleted => 'You have finished this text.';

  @override
  String get readerReadAgain => 'Read it again';

  @override
  String get profileStartReading => 'Start reading';

  @override
  String get profileContinueReading => 'Continue reading';

  @override
  String get profileBiographyFinishedMale =>
      'You have read his whole biography.';

  @override
  String get profileBiographyFinishedFemale =>
      'You have read her whole biography.';

  @override
  String get profileReadFromStart => 'Read it from the start';

  @override
  String get profileBiographyNotWrittenMale =>
      'His full biography has not been written yet; this profile gives a short introduction and its sources.';

  @override
  String get profileBiographyNotWrittenFemale =>
      'Her full biography has not been written yet; this profile gives a short introduction and its sources.';

  @override
  String get passageFinished => 'Finished';

  @override
  String get readerSectionContents => 'Sections';

  @override
  String get readerChapterContents => 'Chapters';

  @override
  String get readerReadingNow => 'Reading now';

  @override
  String profileSectionCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n sections',
      one: '1 section',
    );
    return '$_temp0';
  }

  @override
  String profileResumeDetail(String title, String percent) {
    return '$title · $percent read';
  }

  @override
  String get searchScopeAll => 'All';

  @override
  String get searchScopeCompanions => 'Companions';

  @override
  String get searchScopeBiographies => 'Biographies';

  @override
  String get searchScopeStories => 'Stories';

  @override
  String get searchIncomplete =>
      'Some content could not be loaded, so results may be incomplete.';

  @override
  String get searchFilterLabel => 'Filter results';

  @override
  String searchNoResultsIncomplete(String query) {
    return 'No results for “$query” in the content that could be loaded.';
  }

  @override
  String searchWithin(String name) {
    return 'In: $name';
  }

  @override
  String get undo => 'Undo';

  @override
  String get historyTitle => 'Reading history';

  @override
  String get historyEmpty => 'You have not finished anything yet.';

  @override
  String get historyReset => 'Reset progress';

  @override
  String get continueRemove => 'Remove from Continue reading';

  @override
  String get bookmarkRemovedUndo => 'Removed from Saved.';

  @override
  String get settingsYourData => 'Reading data on this device';

  @override
  String get settingsClearHistory => 'Clear reading history';

  @override
  String get settingsClearSaved => 'Clear saved items';

  @override
  String get settingsNothingToClear => 'Nothing to clear';

  @override
  String get clearHistoryTitle => 'Clear reading history?';

  @override
  String get clearSavedTitle => 'Clear saved items?';

  @override
  String get clearConfirm => 'Clear';

  @override
  String get cancel => 'Cancel';

  @override
  String get historyCleared => 'Reading history cleared.';

  @override
  String get savedCleared => 'Saved items cleared.';

  @override
  String historyResetDone(String title) {
    return 'Progress in “$title” was reset.';
  }

  @override
  String historyFinishedOn(String date) {
    return 'Finished on $date';
  }

  @override
  String countTexts(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n texts',
      one: '1 text',
    );
    return '$_temp0';
  }

  @override
  String countItems(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n items',
      one: '1 item',
    );
    return '$_temp0';
  }

  @override
  String clearHistoryMessage(String what) {
    return 'The reading position and finished mark of $what will be deleted from this device. This cannot be undone. Saved items and settings are not affected.';
  }

  @override
  String clearSavedMessage(String what) {
    return '$what will be deleted from Saved on this device. This cannot be undone. Reading history and settings are not affected.';
  }

  @override
  String get tabSeerah => 'Seerah';

  @override
  String get tabExplore => 'Explore';

  @override
  String get timelineHijrahMark => 'Hijrah';

  @override
  String get timelineUndated => 'No settled date';

  @override
  String mapSemantics(String count) {
    return 'Schematic map of $count places, followed by a list of them';
  }

  @override
  String get mapZoomIn => 'Zoom in';

  @override
  String get mapZoomOut => 'Zoom out';

  @override
  String get mapNorth => 'North';

  @override
  String get mapLegendIdentified => 'Known site';

  @override
  String get mapLegendApproximate => 'Approximate site';

  @override
  String get mapLegendUncertain => 'Disputed site';

  @override
  String get mapApproximatePath => 'Link between stops, not the actual path';

  @override
  String get mapSchematicNote =>
      'A schematic map for orientation, not a survey.';

  @override
  String get relationCompanion => 'Companion of';

  @override
  String sequenceStep(String n) {
    return 'Step $n';
  }

  @override
  String get sequenceOrderUncertain => 'Its place in the order is not settled';

  @override
  String get sceneIllustration => 'Illustration';

  @override
  String get visualTypeTimeline => 'Timeline';

  @override
  String get visualTypeMap => 'Map';

  @override
  String get visualTypeRelationships => 'Relationships';

  @override
  String get visualTypeSequence => 'Sequence';

  @override
  String get visualTypePeriods => 'Periods';

  @override
  String get visualTypePlacePanel => 'Place panel';

  @override
  String get visualNotFound => 'This visual is not in this edition.';

  @override
  String get visualShowChart => 'Chart';

  @override
  String get visualShowList => 'List';

  @override
  String get visualNotes => 'Notes on accuracy';

  @override
  String get visualSources => 'Sources';

  @override
  String get visualOpen => 'Open';

  @override
  String get mapRouteTitle => 'Route';

  @override
  String mapRouteLeg(String from, String to) {
    return 'From $from to $to';
  }

  @override
  String visualRelationOf(String relation, String person) {
    return '$relation · $person';
  }

  @override
  String get seerahSectionName => 'The Prophetic Seerah';

  @override
  String get seerahUnavailable => 'The Seerah is not in this edition.';

  @override
  String get seerahJourneyKicker => 'Journey';

  @override
  String get seerahJourneyTitle => 'The chapters in order';

  @override
  String seerahJourneyNote(String n) {
    return '$n chapters from birth to passing, by period.';
  }

  @override
  String get seerahOpenTimeline => 'The Seerah on a timeline';

  @override
  String get seerahTopicsKicker => 'Themes';

  @override
  String get seerahTopicsTitle => 'His character and guidance ﷺ';

  @override
  String get seerahEventsKicker => 'Archive';

  @override
  String get seerahEventsTitle => 'Turning points';

  @override
  String get seerahPlacesKicker => 'Atlas';

  @override
  String get seerahPlacesTitle => 'Places of the Seerah';

  @override
  String get seerahCompanionsKicker => 'Companionship';

  @override
  String get seerahCompanionsTitle => 'Companions in this story';

  @override
  String get seerahMethodKicker => 'Method';

  @override
  String get seerahMethodTitle => 'How this Seerah is written';

  @override
  String get seerahAllSources => 'All sources';

  @override
  String seerahContinue(String title) {
    return 'Continue: $title';
  }

  @override
  String get seerahStart => 'Begin the Seerah';

  @override
  String get seerahOpenSection => 'Open the Seerah';

  @override
  String get seerahScrollHint => 'Twelve chapters';

  @override
  String seerahChapterLabel(String number, String date) {
    return 'Chapter $number · $date';
  }

  @override
  String seerahVisualCount(int count, String n) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$n visuals',
      one: '1 visual',
    );
    return '$_temp0';
  }

  @override
  String get coverageSample =>
      'This is a short pilot text, not yet written in full.';

  @override
  String get coverageSkeleton => 'This text has not been written yet.';

  @override
  String get coverageSampleShort => 'Pilot text';

  @override
  String get seerahFeatureKicker => 'A turning point';

  @override
  String get seerahFeatureTitle => 'The Hijrah: Makkah to Madinah';

  @override
  String get seerahFeatureRead => 'Read the Hijrah chapter';

  @override
  String get seerahChapterNotFound => 'This chapter does not exist.';

  @override
  String get seerahTopicNotFound => 'This theme does not exist.';

  @override
  String seerahChapterOf(String number, String total, String date) {
    return 'Chapter $number of $total · $date';
  }

  @override
  String seerahTopicOf(String number, String total) {
    return 'Theme $number of $total';
  }

  @override
  String get seerahContents => 'Chapters';

  @override
  String get seerahPreviousChapter => 'Previous chapter';

  @override
  String get seerahNextChapter => 'Next chapter';

  @override
  String get seerahPreviousTopic => 'Previous theme';

  @override
  String get seerahNextTopic => 'Next theme';

  @override
  String get seerahTimelineTitle => 'The Seerah timeline';

  @override
  String get relatedEvents => 'Events in this chapter';

  @override
  String get relatedPlaces => 'Places';

  @override
  String get relatedCompanions => 'Related companions';

  @override
  String get relatedChapters => 'From the chapters';

  @override
  String get eventTypeHijrah => 'Hijrah';

  @override
  String get eventTypeBattle => 'Campaign';

  @override
  String get eventTypeTreaty => 'Treaty';

  @override
  String get eventTypePledge => 'Pledge';

  @override
  String get eventTypeAppointment => 'Appointment';

  @override
  String get eventTypeDeath => 'Death';

  @override
  String get eventTypeRevelation => 'Revelation';

  @override
  String get eventTypeMigration => 'Migration';

  @override
  String get eventTypeCommunity => 'Community';

  @override
  String get eventTypeOther => 'Event';

  @override
  String get eventPageTitle => 'Event';

  @override
  String get eventNotFound => 'This event does not exist.';

  @override
  String get eventContext => 'Context';

  @override
  String get eventOutcome => 'Outcome';

  @override
  String get eventParticipants => 'Who took part';

  @override
  String get eventInSeerah => 'In the Seerah';

  @override
  String get placePageTitle => 'Place';

  @override
  String get placeNotFound => 'This place does not exist.';

  @override
  String placeToday(String name) {
    return 'Today: $name';
  }

  @override
  String get placeOnMap => 'On the map';

  @override
  String get placeEvents => 'Events here';

  @override
  String get placeVisuals => 'Visuals showing this place';

  @override
  String get visualPageTitle => 'Visual';

  @override
  String get exploreAll => 'All';

  @override
  String get exploreEvents => 'Events';

  @override
  String get explorePlaces => 'Places';

  @override
  String get exploreVisuals => 'Visuals';

  @override
  String get exploreStories => 'Stories';

  @override
  String get exploreIntro =>
      'The event archive, the places, the visuals and the stories: start anywhere.';

  @override
  String get exploreEventsKicker => 'Archive';

  @override
  String get exploreEventsTitle => 'Event archive';

  @override
  String get exploreEventsNote =>
      'In date order, as precisely as the sources record them.';

  @override
  String get exploreBeforeHijrah => 'Before the Hijrah';

  @override
  String get exploreAfterHijrah => 'After the Hijrah';

  @override
  String get exploreVisualsKicker => 'Visuals';

  @override
  String get exploreVisualsTitle => 'Maps, timelines and relationships';

  @override
  String get explorePlacesKicker => 'Atlas';

  @override
  String get explorePlacesTitle => 'Places';

  @override
  String get exploreStoriesKicker => 'Stories';

  @override
  String get exploreStoriesTitle => 'Stories';

  @override
  String get savedSeerahChapters => 'Seerah chapters';

  @override
  String get savedSeerahTopics => 'Seerah themes';

  @override
  String get homeSeerahKicker => 'The Seerah';

  @override
  String get homeSeerahTitle => 'Next chapters';

  @override
  String get homeAllChapters => 'All chapters';

  @override
  String get homeDiscoverTitle => 'Meet a companion';

  @override
  String get homeAtlasKicker => 'Atlas';

  @override
  String get homeAtlasTitle => 'Where it happened';

  @override
  String get homeArchiveKicker => 'Archive';

  @override
  String get homeArchiveTitle => 'Selected events';

  @override
  String get homeAllEvents => 'The full archive';

  @override
  String get searchKindSeerahChapters => 'Seerah chapters';

  @override
  String get searchKindSeerahTopics => 'Seerah themes';

  @override
  String get searchKindEvents => 'Events';

  @override
  String get searchKindPlaces => 'Places';

  @override
  String get searchScopeSeerah => 'Seerah';

  @override
  String get searchScopeArchive => 'Events and places';

  @override
  String get profileConnectionsKicker => 'In the Seerah';

  @override
  String get profileConnectionsTitle => 'In the chapters and events';

  @override
  String get profileEvents => 'Shared events';

  @override
  String get profileVisuals => 'Visuals';

  @override
  String get quranTextSource => 'Uthmani text from the Tanzil Project';

  @override
  String get sourcesQuranTextTitle => 'The Qur\'an text';

  @override
  String sourcesQuranTextBody(String url) {
    return 'Verses are shown in the Uthmani script from the Tanzil Project ($url), unchanged, under the Creative Commons Attribution 3.0 licence. The app stores only the quoted verses and does not go online.';
  }

  @override
  String get sourcesQuranNotice => 'Licence notice';

  @override
  String get relationsTitle => 'Relations and lineage';

  @override
  String get relationsIntro =>
      'Who is related to whom in the Seerah: lineage, marriage, companionship and brotherhood, each with its source. Every relation appears under both people.';

  @override
  String relationsFilteredTitle(String name) {
    return 'Relations of $name';
  }

  @override
  String get relationsShowEveryone => 'Show everyone\'s relations';

  @override
  String get relationsIncomplete =>
      'Some files could not be loaded, so this list may be incomplete.';

  @override
  String get relationsEmpty => 'No relations are recorded here yet.';

  @override
  String get relationCategoryKinship => 'Lineage and kin';

  @override
  String get relationCategoryMarriage => 'Marriage';

  @override
  String get relationCategoryCompanionship => 'Companionship and brotherhood';

  @override
  String get relationCategoryLearning => 'Learning and narration';

  @override
  String relationsOpenProfile(String name) {
    return 'Open the page of $name';
  }

  @override
  String get exploreRelationsKicker => 'Relations';

  @override
  String get exploreRelationsTitle => 'Lineage, marriage and companionship';

  @override
  String get exploreRelationsBody =>
      'Browse how the people of the Seerah are related, grouped by kind, each relation with its source.';

  @override
  String get profileAllRelations => 'All relations in the explorer';
}
