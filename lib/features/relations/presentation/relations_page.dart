import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:siyar_sahaba/app/router/routes.dart';
import 'package:siyar_sahaba/core/design_system/tokens/sahaba_colors.dart';
import 'package:siyar_sahaba/core/design_system/tokens/spacing.dart';
import 'package:siyar_sahaba/core/design_system/widgets/citation_marker.dart';
import 'package:siyar_sahaba/core/design_system/widgets/draft_banner.dart';
import 'package:siyar_sahaba/core/design_system/widgets/empty_state.dart';
import 'package:siyar_sahaba/core/design_system/widgets/error_view.dart';
import 'package:siyar_sahaba/core/design_system/widgets/loading_skeleton.dart';
import 'package:siyar_sahaba/core/design_system/widgets/reliability_badge.dart';
import 'package:siyar_sahaba/core/domain/reliability.dart';
import 'package:siyar_sahaba/core/l10n/generated/app_localizations.dart';
import 'package:siyar_sahaba/features/relations/domain/relationship_index.dart';
import 'package:siyar_sahaba/features/relations/presentation/relationship_providers.dart';
import 'package:siyar_sahaba/features/sources/presentation/citation_sheet.dart';
import 'package:siyar_sahaba/shared/content/domain/catalog.dart';
import 'package:siyar_sahaba/shared/content/domain/companion.dart';
import 'package:siyar_sahaba/shared/content/presentation/content_text.dart';
import 'package:siyar_sahaba/shared/content/providers.dart';

/// The label for what [other] is to the subject (e.g. "من الأبناء").
String relationLabel(AppLocalizations l10n, RelationType t) => switch (t) {
  RelationType.father => l10n.relationFather,
  RelationType.mother => l10n.relationMother,
  RelationType.child => l10n.relationChild,
  RelationType.spouse => l10n.relationSpouse,
  RelationType.sibling => l10n.relationSibling,
  RelationType.relative => l10n.relationRelative,
  RelationType.teacher => l10n.relationTeacher,
  RelationType.student => l10n.relationStudent,
  RelationType.brotherhood => l10n.relationBrotherhood,
  RelationType.companion => l10n.relationCompanion,
};

String relationCategoryLabel(AppLocalizations l10n, RelationCategory c) =>
    switch (c) {
      RelationCategory.kinship => l10n.relationCategoryKinship,
      RelationCategory.marriage => l10n.relationCategoryMarriage,
      RelationCategory.companionship => l10n.relationCategoryCompanionship,
      RelationCategory.learning => l10n.relationCategoryLearning,
    };

/// The relationship explorer (F18): every sourced relation, listed under
/// each of the two people, filterable by kind. A companion's or person's
/// relations alone when [companionId] or [personId] is given. Each row
/// shows its sources; a draft notice covers unreviewed relations, and
/// companions open their profile.
class RelationsPage extends ConsumerWidget {
  const RelationsPage({this.companionId, this.personId, super.key});

  final String? companionId;
  final String? personId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final index = ref.watch(relationshipIndexProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.relationsTitle)),
      body: switch (index) {
        AsyncData(:final value) => _Relations(
          index: value,
          subjectKey: switch ((companionId, personId)) {
            (final c?, _) => 'c:$c',
            (_, final p?) => 'p:$p',
            _ => null,
          },
          onRetry: () => ref.invalidate(relationshipIndexProvider),
        ),
        AsyncError(:final error) => ErrorView(
          error: error,
          onRetry: () => ref.invalidate(relationshipIndexProvider),
        ),
        _ => const Padding(
          padding: EdgeInsets.all(AppSpacing.gutter),
          child: LoadingSkeleton(lines: 8),
        ),
      },
    );
  }
}

class _Relations extends ConsumerStatefulWidget {
  const _Relations({
    required this.index,
    required this.subjectKey,
    required this.onRetry,
  });

  final RelationshipIndex index;
  final String? subjectKey;
  final VoidCallback onRetry;

  @override
  ConsumerState<_Relations> createState() => _RelationsState();
}

class _RelationsState extends ConsumerState<_Relations> {
  RelationCategory? _category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final names = _Names(
      ref.watch(companionIndexProvider).value ?? const [],
      ref.watch(peopleProvider).value ?? const {},
    );
    final subjectKey = widget.subjectKey;
    final scoped = widget.index.bySubject(subjectKey: subjectKey);
    final present = {
      for (final (_, entries) in scoped)
        for (final e in entries) e.category,
    };
    final groups = widget.index.bySubject(
      category: present.contains(_category) ? _category : null,
      subjectKey: subjectKey,
    );

    return ListView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.xxl,
      ),
      children: [
        if (subjectKey != null && scoped.isNotEmpty) ...[
          Text(
            l10n.relationsFilteredTitle(names.of(context, scoped.first.$1)),
            style: textTheme.titleLarge,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              icon: const Icon(Icons.people_outline),
              label: Text(l10n.relationsShowEveryone),
              onPressed: () => context.replace(AppRoutes.relations()),
            ),
          ),
        ] else
          Text(l10n.relationsIntro, style: textTheme.bodyLarge),
        // One notice for the page rather than a badge on every row; the
        // citation sheet still marks each draft source.
        if (widget.index.entries.any((e) => !e.review.isApproved)) ...[
          const SizedBox(height: AppSpacing.sm),
          const DraftBanner(),
        ],
        if (!widget.index.isComplete)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: colors.onSurfaceDim),
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: Text(l10n.relationsIncomplete)),
                TextButton(onPressed: widget.onRetry, child: Text(l10n.retry)),
              ],
            ),
          ),
        if (present.length > 1) ...[
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              ChoiceChip(
                label: Text(l10n.exploreAll),
                selected: _category == null,
                onSelected: (_) => setState(() => _category = null),
              ),
              for (final c in RelationCategory.values)
                if (present.contains(c))
                  ChoiceChip(
                    label: Text(relationCategoryLabel(l10n, c)),
                    selected: _category == c,
                    onSelected: (_) => setState(() => _category = c),
                  ),
            ],
          ),
        ],
        if (groups.isEmpty)
          EmptyState(icon: Icons.people_outline, title: l10n.relationsEmpty),
        for (final (subject, entries) in groups) ...[
          _SubjectHeader(subject: subject, names: names),
          for (final e in entries) _RelationRow(entry: e, names: names),
        ],
      ],
    );
  }
}

/// Display names with honorifics, from the catalog and the people records,
/// falling back to the name as written in the relation.
class _Names {
  _Names(List<CompanionSummary> companions, this._people)
    : _companions = {for (final c in companions) c.id: c};

  final Map<String, CompanionSummary> _companions;
  final Map<String, Person> _people;

  CompanionSummary? companion(PersonRef p) => _companions[p.companionId];

  String of(BuildContext context, PersonRef p) {
    if (companion(p) case final c?) {
      return '${c.name.of(context)} ${companionHonorific(c.gender)}';
    }
    if (_people[p.personId] case final person?) {
      return [person.name.of(context), ?personHonorific(person)].join(' ');
    }
    return p.displayName.of(context);
  }
}

class _SubjectHeader extends StatelessWidget {
  const _SubjectHeader({required this.subject, required this.names});

  final PersonRef subject;
  final _Names names;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final name = names.of(context, subject);
    final companion = names.companion(subject);
    final title = Text(
      name,
      style: textTheme.titleMedium?.copyWith(color: colors.accentText),
    );
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: AppSpacing.lg),
      child: Semantics(
        header: true,
        child: companion == null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
                child: title,
              )
            : InkWell(
                onTap: () => context.push(AppRoutes.companion(companion.id)),
                child: Semantics(
                  hint: l10n.relationsOpenProfile(name),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 48),
                    alignment: AlignmentDirectional.centerStart,
                    child: Row(
                      children: [
                        Expanded(child: title),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

class _RelationRow extends StatelessWidget {
  const _RelationRow({required this.entry, required this.names});

  final RelationEntry entry;
  final _Names names;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = SahabaColors.of(context);
    final e = entry;
    final provisional = !e.review.isApproved;
    final companion = names.companion(e.other);
    final textTheme = Theme.of(context).textTheme;
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(names.of(context, e.other), style: textTheme.bodyLarge),
        Text(
          relationLabel(l10n, e.type),
          style: textTheme.bodyMedium?.copyWith(color: colors.onSurfaceDim),
        ),
        if (e.note case final note?)
          Text(
            note.of(context),
            style: textTheme.bodySmall?.copyWith(color: colors.onSurfaceDim),
          ),
        if (e.reliability != Reliability.established)
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxs),
            child: ReliabilityBadge(e.reliability, provisional: provisional),
          ),
      ],
    );
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(bottom: BorderSide(color: colors.line)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: companion == null
                  ? null
                  : () => context.push(AppRoutes.companion(companion.id)),
              child: Container(
                constraints: const BoxConstraints(minHeight: 48),
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Expanded(child: details),
                    if (companion != null) const Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ),
          ),
          if (e.citations.isNotEmpty)
            CitationMarker(
              count: e.citations.length,
              onPressed: () => showCitationSheet(
                context,
                citations: e.citations,
                reliability: e.reliability,
                provisional: provisional,
              ),
            ),
        ],
      ),
    );
  }
}
