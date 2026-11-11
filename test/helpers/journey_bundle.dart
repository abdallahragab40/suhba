import 'content_bundle.dart';

MemoryAssetBundle journeyBundle() {
  final bundle = MemoryAssetBundle.builtContent();
  bundle.editJson('assets/content/journeys/meet-the-companions.json', (j) {
    j['steps'] = <Object>[
      {
        'id': 'meet-the-companions.first',
        'title': {'ar': 'في الغار'},
        'readings': [
          for (var i = 1; i <= 3; i++)
            {
              'type': 'storyChapter',
              'parentId': 'the-cave',
              'targetId': 'the-cave.$i',
            },
        ],
        'reflection': {'ar': 'ماذا تعلمت؟'},
      },
      {
        'id': 'meet-the-companions.second',
        'title': {'ar': 'قراءة تالية'},
        'readings': [
          {
            'type': 'companionSection',
            'parentId': 'abu-bakr',
            'targetId': 'abu-bakr.early-life',
          },
        ],
      },
    ];
  });
  return bundle;
}
