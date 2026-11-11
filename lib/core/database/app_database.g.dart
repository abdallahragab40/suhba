// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BookmarksTable extends Bookmarks
    with TableInfo<$BookmarksTable, BookmarkRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BookmarksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetTypeMeta = const VerificationMeta(
    'targetType',
  );
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
    'target_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetType,
    targetId,
    parentId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bookmarks';
  @override
  VerificationContext validateIntegrity(
    Insertable<BookmarkRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_type')) {
      context.handle(
        _targetTypeMeta,
        targetType.isAcceptableOrUnknown(data['target_type']!, _targetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {targetType, targetId},
  ];
  @override
  BookmarkRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BookmarkRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_type'],
      )!,
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BookmarksTable createAlias(String alias) {
    return $BookmarksTable(attachedDatabase, alias);
  }
}

class BookmarkRow extends DataClass implements Insertable<BookmarkRow> {
  final int id;

  /// companion | section | story | chapter
  final String targetType;
  final String targetId;

  /// The companion of a section, or the story of a chapter.
  final String? parentId;
  final DateTime createdAt;
  const BookmarkRow({
    required this.id,
    required this.targetType,
    required this.targetId,
    this.parentId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_type'] = Variable<String>(targetType);
    map['target_id'] = Variable<String>(targetId);
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BookmarksCompanion toCompanion(bool nullToAbsent) {
    return BookmarksCompanion(
      id: Value(id),
      targetType: Value(targetType),
      targetId: Value(targetId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      createdAt: Value(createdAt),
    );
  }

  factory BookmarkRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BookmarkRow(
      id: serializer.fromJson<int>(json['id']),
      targetType: serializer.fromJson<String>(json['targetType']),
      targetId: serializer.fromJson<String>(json['targetId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetType': serializer.toJson<String>(targetType),
      'targetId': serializer.toJson<String>(targetId),
      'parentId': serializer.toJson<String?>(parentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BookmarkRow copyWith({
    int? id,
    String? targetType,
    String? targetId,
    Value<String?> parentId = const Value.absent(),
    DateTime? createdAt,
  }) => BookmarkRow(
    id: id ?? this.id,
    targetType: targetType ?? this.targetType,
    targetId: targetId ?? this.targetId,
    parentId: parentId.present ? parentId.value : this.parentId,
    createdAt: createdAt ?? this.createdAt,
  );
  BookmarkRow copyWithCompanion(BookmarksCompanion data) {
    return BookmarkRow(
      id: data.id.present ? data.id.value : this.id,
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BookmarkRow(')
          ..write('id: $id, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('parentId: $parentId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, targetType, targetId, parentId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BookmarkRow &&
          other.id == this.id &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.parentId == this.parentId &&
          other.createdAt == this.createdAt);
}

class BookmarksCompanion extends UpdateCompanion<BookmarkRow> {
  final Value<int> id;
  final Value<String> targetType;
  final Value<String> targetId;
  final Value<String?> parentId;
  final Value<DateTime> createdAt;
  const BookmarksCompanion({
    this.id = const Value.absent(),
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BookmarksCompanion.insert({
    this.id = const Value.absent(),
    required String targetType,
    required String targetId,
    this.parentId = const Value.absent(),
    required DateTime createdAt,
  }) : targetType = Value(targetType),
       targetId = Value(targetId),
       createdAt = Value(createdAt);
  static Insertable<BookmarkRow> custom({
    Expression<int>? id,
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<String>? parentId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (parentId != null) 'parent_id': parentId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BookmarksCompanion copyWith({
    Value<int>? id,
    Value<String>? targetType,
    Value<String>? targetId,
    Value<String?>? parentId,
    Value<DateTime>? createdAt,
  }) {
    return BookmarksCompanion(
      id: id ?? this.id,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BookmarksCompanion(')
          ..write('id: $id, ')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('parentId: $parentId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReadingProgressEntriesTable extends ReadingProgressEntries
    with TableInfo<$ReadingProgressEntriesTable, ProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _targetTypeMeta = const VerificationMeta(
    'targetType',
  );
  @override
  late final GeneratedColumn<String> targetType = GeneratedColumn<String>(
    'target_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetIdMeta = const VerificationMeta(
    'targetId',
  );
  @override
  late final GeneratedColumn<String> targetId = GeneratedColumn<String>(
    'target_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentIdMeta = const VerificationMeta(
    'parentId',
  );
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
    'parent_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fractionMeta = const VerificationMeta(
    'fraction',
  );
  @override
  late final GeneratedColumn<double> fraction = GeneratedColumn<double>(
    'fraction',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<String> contentVersion = GeneratedColumn<String>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetRevisionMeta = const VerificationMeta(
    'targetRevision',
  );
  @override
  late final GeneratedColumn<String> targetRevision = GeneratedColumn<String>(
    'target_revision',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockIndexMeta = const VerificationMeta(
    'blockIndex',
  );
  @override
  late final GeneratedColumn<int> blockIndex = GeneratedColumn<int>(
    'block_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _blockOffsetMeta = const VerificationMeta(
    'blockOffset',
  );
  @override
  late final GeneratedColumn<double> blockOffset = GeneratedColumn<double>(
    'block_offset',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    targetType,
    targetId,
    parentId,
    fraction,
    completed,
    contentVersion,
    updatedAt,
    targetRevision,
    blockIndex,
    blockOffset,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reading_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('target_type')) {
      context.handle(
        _targetTypeMeta,
        targetType.isAcceptableOrUnknown(data['target_type']!, _targetTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_targetTypeMeta);
    }
    if (data.containsKey('target_id')) {
      context.handle(
        _targetIdMeta,
        targetId.isAcceptableOrUnknown(data['target_id']!, _targetIdMeta),
      );
    } else if (isInserting) {
      context.missing(_targetIdMeta);
    }
    if (data.containsKey('parent_id')) {
      context.handle(
        _parentIdMeta,
        parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_parentIdMeta);
    }
    if (data.containsKey('fraction')) {
      context.handle(
        _fractionMeta,
        fraction.isAcceptableOrUnknown(data['fraction']!, _fractionMeta),
      );
    } else if (isInserting) {
      context.missing(_fractionMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentVersionMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('target_revision')) {
      context.handle(
        _targetRevisionMeta,
        targetRevision.isAcceptableOrUnknown(
          data['target_revision']!,
          _targetRevisionMeta,
        ),
      );
    }
    if (data.containsKey('block_index')) {
      context.handle(
        _blockIndexMeta,
        blockIndex.isAcceptableOrUnknown(data['block_index']!, _blockIndexMeta),
      );
    }
    if (data.containsKey('block_offset')) {
      context.handle(
        _blockOffsetMeta,
        blockOffset.isAcceptableOrUnknown(
          data['block_offset']!,
          _blockOffsetMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {targetType, targetId};
  @override
  ProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressRow(
      targetType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_type'],
      )!,
      targetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_id'],
      )!,
      parentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_id'],
      )!,
      fraction: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fraction'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_version'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      targetRevision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_revision'],
      ),
      blockIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}block_index'],
      ),
      blockOffset: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}block_offset'],
      ),
    );
  }

  @override
  $ReadingProgressEntriesTable createAlias(String alias) {
    return $ReadingProgressEntriesTable(attachedDatabase, alias);
  }
}

class ProgressRow extends DataClass implements Insertable<ProgressRow> {
  /// section | chapter
  final String targetType;
  final String targetId;
  final String parentId;

  /// 0–1, the share of the text scrolled through.
  final double fraction;
  final bool completed;

  /// The content build the position was recorded against.
  final String contentVersion;
  final DateTime updatedAt;

  /// The passage's content revision when the position was recorded; null
  /// for positions saved before schema 2.
  final String? targetRevision;

  /// The block at the top of the screen and how far into it (0–1); null
  /// for positions saved before schema 3, which fall back to [fraction].
  final int? blockIndex;
  final double? blockOffset;
  const ProgressRow({
    required this.targetType,
    required this.targetId,
    required this.parentId,
    required this.fraction,
    required this.completed,
    required this.contentVersion,
    required this.updatedAt,
    this.targetRevision,
    this.blockIndex,
    this.blockOffset,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['target_type'] = Variable<String>(targetType);
    map['target_id'] = Variable<String>(targetId);
    map['parent_id'] = Variable<String>(parentId);
    map['fraction'] = Variable<double>(fraction);
    map['completed'] = Variable<bool>(completed);
    map['content_version'] = Variable<String>(contentVersion);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || targetRevision != null) {
      map['target_revision'] = Variable<String>(targetRevision);
    }
    if (!nullToAbsent || blockIndex != null) {
      map['block_index'] = Variable<int>(blockIndex);
    }
    if (!nullToAbsent || blockOffset != null) {
      map['block_offset'] = Variable<double>(blockOffset);
    }
    return map;
  }

  ReadingProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return ReadingProgressEntriesCompanion(
      targetType: Value(targetType),
      targetId: Value(targetId),
      parentId: Value(parentId),
      fraction: Value(fraction),
      completed: Value(completed),
      contentVersion: Value(contentVersion),
      updatedAt: Value(updatedAt),
      targetRevision: targetRevision == null && nullToAbsent
          ? const Value.absent()
          : Value(targetRevision),
      blockIndex: blockIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(blockIndex),
      blockOffset: blockOffset == null && nullToAbsent
          ? const Value.absent()
          : Value(blockOffset),
    );
  }

  factory ProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressRow(
      targetType: serializer.fromJson<String>(json['targetType']),
      targetId: serializer.fromJson<String>(json['targetId']),
      parentId: serializer.fromJson<String>(json['parentId']),
      fraction: serializer.fromJson<double>(json['fraction']),
      completed: serializer.fromJson<bool>(json['completed']),
      contentVersion: serializer.fromJson<String>(json['contentVersion']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      targetRevision: serializer.fromJson<String?>(json['targetRevision']),
      blockIndex: serializer.fromJson<int?>(json['blockIndex']),
      blockOffset: serializer.fromJson<double?>(json['blockOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'targetType': serializer.toJson<String>(targetType),
      'targetId': serializer.toJson<String>(targetId),
      'parentId': serializer.toJson<String>(parentId),
      'fraction': serializer.toJson<double>(fraction),
      'completed': serializer.toJson<bool>(completed),
      'contentVersion': serializer.toJson<String>(contentVersion),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'targetRevision': serializer.toJson<String?>(targetRevision),
      'blockIndex': serializer.toJson<int?>(blockIndex),
      'blockOffset': serializer.toJson<double?>(blockOffset),
    };
  }

  ProgressRow copyWith({
    String? targetType,
    String? targetId,
    String? parentId,
    double? fraction,
    bool? completed,
    String? contentVersion,
    DateTime? updatedAt,
    Value<String?> targetRevision = const Value.absent(),
    Value<int?> blockIndex = const Value.absent(),
    Value<double?> blockOffset = const Value.absent(),
  }) => ProgressRow(
    targetType: targetType ?? this.targetType,
    targetId: targetId ?? this.targetId,
    parentId: parentId ?? this.parentId,
    fraction: fraction ?? this.fraction,
    completed: completed ?? this.completed,
    contentVersion: contentVersion ?? this.contentVersion,
    updatedAt: updatedAt ?? this.updatedAt,
    targetRevision: targetRevision.present
        ? targetRevision.value
        : this.targetRevision,
    blockIndex: blockIndex.present ? blockIndex.value : this.blockIndex,
    blockOffset: blockOffset.present ? blockOffset.value : this.blockOffset,
  );
  ProgressRow copyWithCompanion(ReadingProgressEntriesCompanion data) {
    return ProgressRow(
      targetType: data.targetType.present
          ? data.targetType.value
          : this.targetType,
      targetId: data.targetId.present ? data.targetId.value : this.targetId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      fraction: data.fraction.present ? data.fraction.value : this.fraction,
      completed: data.completed.present ? data.completed.value : this.completed,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      targetRevision: data.targetRevision.present
          ? data.targetRevision.value
          : this.targetRevision,
      blockIndex: data.blockIndex.present
          ? data.blockIndex.value
          : this.blockIndex,
      blockOffset: data.blockOffset.present
          ? data.blockOffset.value
          : this.blockOffset,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressRow(')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('parentId: $parentId, ')
          ..write('fraction: $fraction, ')
          ..write('completed: $completed, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('targetRevision: $targetRevision, ')
          ..write('blockIndex: $blockIndex, ')
          ..write('blockOffset: $blockOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    targetType,
    targetId,
    parentId,
    fraction,
    completed,
    contentVersion,
    updatedAt,
    targetRevision,
    blockIndex,
    blockOffset,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressRow &&
          other.targetType == this.targetType &&
          other.targetId == this.targetId &&
          other.parentId == this.parentId &&
          other.fraction == this.fraction &&
          other.completed == this.completed &&
          other.contentVersion == this.contentVersion &&
          other.updatedAt == this.updatedAt &&
          other.targetRevision == this.targetRevision &&
          other.blockIndex == this.blockIndex &&
          other.blockOffset == this.blockOffset);
}

class ReadingProgressEntriesCompanion extends UpdateCompanion<ProgressRow> {
  final Value<String> targetType;
  final Value<String> targetId;
  final Value<String> parentId;
  final Value<double> fraction;
  final Value<bool> completed;
  final Value<String> contentVersion;
  final Value<DateTime> updatedAt;
  final Value<String?> targetRevision;
  final Value<int?> blockIndex;
  final Value<double?> blockOffset;
  final Value<int> rowid;
  const ReadingProgressEntriesCompanion({
    this.targetType = const Value.absent(),
    this.targetId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.fraction = const Value.absent(),
    this.completed = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.targetRevision = const Value.absent(),
    this.blockIndex = const Value.absent(),
    this.blockOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReadingProgressEntriesCompanion.insert({
    required String targetType,
    required String targetId,
    required String parentId,
    required double fraction,
    this.completed = const Value.absent(),
    required String contentVersion,
    required DateTime updatedAt,
    this.targetRevision = const Value.absent(),
    this.blockIndex = const Value.absent(),
    this.blockOffset = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : targetType = Value(targetType),
       targetId = Value(targetId),
       parentId = Value(parentId),
       fraction = Value(fraction),
       contentVersion = Value(contentVersion),
       updatedAt = Value(updatedAt);
  static Insertable<ProgressRow> custom({
    Expression<String>? targetType,
    Expression<String>? targetId,
    Expression<String>? parentId,
    Expression<double>? fraction,
    Expression<bool>? completed,
    Expression<String>? contentVersion,
    Expression<DateTime>? updatedAt,
    Expression<String>? targetRevision,
    Expression<int>? blockIndex,
    Expression<double>? blockOffset,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (targetType != null) 'target_type': targetType,
      if (targetId != null) 'target_id': targetId,
      if (parentId != null) 'parent_id': parentId,
      if (fraction != null) 'fraction': fraction,
      if (completed != null) 'completed': completed,
      if (contentVersion != null) 'content_version': contentVersion,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (targetRevision != null) 'target_revision': targetRevision,
      if (blockIndex != null) 'block_index': blockIndex,
      if (blockOffset != null) 'block_offset': blockOffset,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReadingProgressEntriesCompanion copyWith({
    Value<String>? targetType,
    Value<String>? targetId,
    Value<String>? parentId,
    Value<double>? fraction,
    Value<bool>? completed,
    Value<String>? contentVersion,
    Value<DateTime>? updatedAt,
    Value<String?>? targetRevision,
    Value<int?>? blockIndex,
    Value<double?>? blockOffset,
    Value<int>? rowid,
  }) {
    return ReadingProgressEntriesCompanion(
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      parentId: parentId ?? this.parentId,
      fraction: fraction ?? this.fraction,
      completed: completed ?? this.completed,
      contentVersion: contentVersion ?? this.contentVersion,
      updatedAt: updatedAt ?? this.updatedAt,
      targetRevision: targetRevision ?? this.targetRevision,
      blockIndex: blockIndex ?? this.blockIndex,
      blockOffset: blockOffset ?? this.blockOffset,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (targetType.present) {
      map['target_type'] = Variable<String>(targetType.value);
    }
    if (targetId.present) {
      map['target_id'] = Variable<String>(targetId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (fraction.present) {
      map['fraction'] = Variable<double>(fraction.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<String>(contentVersion.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (targetRevision.present) {
      map['target_revision'] = Variable<String>(targetRevision.value);
    }
    if (blockIndex.present) {
      map['block_index'] = Variable<int>(blockIndex.value);
    }
    if (blockOffset.present) {
      map['block_offset'] = Variable<double>(blockOffset.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingProgressEntriesCompanion(')
          ..write('targetType: $targetType, ')
          ..write('targetId: $targetId, ')
          ..write('parentId: $parentId, ')
          ..write('fraction: $fraction, ')
          ..write('completed: $completed, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('targetRevision: $targetRevision, ')
          ..write('blockIndex: $blockIndex, ')
          ..write('blockOffset: $blockOffset, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReviewItemsTable extends ReviewItems
    with TableInfo<$ReviewItemsTable, ReviewItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReviewItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _questionKeyMeta = const VerificationMeta(
    'questionKey',
  );
  @override
  late final GeneratedColumn<String> questionKey = GeneratedColumn<String>(
    'question_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _boxMeta = const VerificationMeta('box');
  @override
  late final GeneratedColumn<int> box = GeneratedColumn<int>(
    'box',
    aliasedName,
    false,
    check: () => ComparableExpr(box).isBetweenValues(1, 5),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueOnMeta = const VerificationMeta('dueOn');
  @override
  late final GeneratedColumn<DateTime> dueOn = GeneratedColumn<DateTime>(
    'due_on',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastAnsweredAtMeta = const VerificationMeta(
    'lastAnsweredAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAnsweredAt =
      GeneratedColumn<DateTime>(
        'last_answered_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _timesRightMeta = const VerificationMeta(
    'timesRight',
  );
  @override
  late final GeneratedColumn<int> timesRight = GeneratedColumn<int>(
    'times_right',
    aliasedName,
    false,
    check: () => ComparableExpr(timesRight).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timesWrongMeta = const VerificationMeta(
    'timesWrong',
  );
  @override
  late final GeneratedColumn<int> timesWrong = GeneratedColumn<int>(
    'times_wrong',
    aliasedName,
    false,
    check: () => ComparableExpr(timesWrong).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    questionKey,
    box,
    dueOn,
    lastAnsweredAt,
    timesRight,
    timesWrong,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'review_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReviewItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('question_key')) {
      context.handle(
        _questionKeyMeta,
        questionKey.isAcceptableOrUnknown(
          data['question_key']!,
          _questionKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_questionKeyMeta);
    }
    if (data.containsKey('box')) {
      context.handle(
        _boxMeta,
        box.isAcceptableOrUnknown(data['box']!, _boxMeta),
      );
    } else if (isInserting) {
      context.missing(_boxMeta);
    }
    if (data.containsKey('due_on')) {
      context.handle(
        _dueOnMeta,
        dueOn.isAcceptableOrUnknown(data['due_on']!, _dueOnMeta),
      );
    } else if (isInserting) {
      context.missing(_dueOnMeta);
    }
    if (data.containsKey('last_answered_at')) {
      context.handle(
        _lastAnsweredAtMeta,
        lastAnsweredAt.isAcceptableOrUnknown(
          data['last_answered_at']!,
          _lastAnsweredAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastAnsweredAtMeta);
    }
    if (data.containsKey('times_right')) {
      context.handle(
        _timesRightMeta,
        timesRight.isAcceptableOrUnknown(data['times_right']!, _timesRightMeta),
      );
    } else if (isInserting) {
      context.missing(_timesRightMeta);
    }
    if (data.containsKey('times_wrong')) {
      context.handle(
        _timesWrongMeta,
        timesWrong.isAcceptableOrUnknown(data['times_wrong']!, _timesWrongMeta),
      );
    } else if (isInserting) {
      context.missing(_timesWrongMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {questionKey};
  @override
  ReviewItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReviewItemRow(
      questionKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_key'],
      )!,
      box: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}box'],
      )!,
      dueOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_on'],
      )!,
      lastAnsweredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_answered_at'],
      )!,
      timesRight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_right'],
      )!,
      timesWrong: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}times_wrong'],
      )!,
    );
  }

  @override
  $ReviewItemsTable createAlias(String alias) {
    return $ReviewItemsTable(attachedDatabase, alias);
  }
}

class ReviewItemRow extends DataClass implements Insertable<ReviewItemRow> {
  final String questionKey;
  final int box;

  /// UTC midnight encoding a local calendar date, rather than an instant.
  final DateTime dueOn;
  final DateTime lastAnsweredAt;
  final int timesRight;
  final int timesWrong;
  const ReviewItemRow({
    required this.questionKey,
    required this.box,
    required this.dueOn,
    required this.lastAnsweredAt,
    required this.timesRight,
    required this.timesWrong,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['question_key'] = Variable<String>(questionKey);
    map['box'] = Variable<int>(box);
    map['due_on'] = Variable<DateTime>(dueOn);
    map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt);
    map['times_right'] = Variable<int>(timesRight);
    map['times_wrong'] = Variable<int>(timesWrong);
    return map;
  }

  ReviewItemsCompanion toCompanion(bool nullToAbsent) {
    return ReviewItemsCompanion(
      questionKey: Value(questionKey),
      box: Value(box),
      dueOn: Value(dueOn),
      lastAnsweredAt: Value(lastAnsweredAt),
      timesRight: Value(timesRight),
      timesWrong: Value(timesWrong),
    );
  }

  factory ReviewItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReviewItemRow(
      questionKey: serializer.fromJson<String>(json['questionKey']),
      box: serializer.fromJson<int>(json['box']),
      dueOn: serializer.fromJson<DateTime>(json['dueOn']),
      lastAnsweredAt: serializer.fromJson<DateTime>(json['lastAnsweredAt']),
      timesRight: serializer.fromJson<int>(json['timesRight']),
      timesWrong: serializer.fromJson<int>(json['timesWrong']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'questionKey': serializer.toJson<String>(questionKey),
      'box': serializer.toJson<int>(box),
      'dueOn': serializer.toJson<DateTime>(dueOn),
      'lastAnsweredAt': serializer.toJson<DateTime>(lastAnsweredAt),
      'timesRight': serializer.toJson<int>(timesRight),
      'timesWrong': serializer.toJson<int>(timesWrong),
    };
  }

  ReviewItemRow copyWith({
    String? questionKey,
    int? box,
    DateTime? dueOn,
    DateTime? lastAnsweredAt,
    int? timesRight,
    int? timesWrong,
  }) => ReviewItemRow(
    questionKey: questionKey ?? this.questionKey,
    box: box ?? this.box,
    dueOn: dueOn ?? this.dueOn,
    lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
    timesRight: timesRight ?? this.timesRight,
    timesWrong: timesWrong ?? this.timesWrong,
  );
  ReviewItemRow copyWithCompanion(ReviewItemsCompanion data) {
    return ReviewItemRow(
      questionKey: data.questionKey.present
          ? data.questionKey.value
          : this.questionKey,
      box: data.box.present ? data.box.value : this.box,
      dueOn: data.dueOn.present ? data.dueOn.value : this.dueOn,
      lastAnsweredAt: data.lastAnsweredAt.present
          ? data.lastAnsweredAt.value
          : this.lastAnsweredAt,
      timesRight: data.timesRight.present
          ? data.timesRight.value
          : this.timesRight,
      timesWrong: data.timesWrong.present
          ? data.timesWrong.value
          : this.timesWrong,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItemRow(')
          ..write('questionKey: $questionKey, ')
          ..write('box: $box, ')
          ..write('dueOn: $dueOn, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('timesRight: $timesRight, ')
          ..write('timesWrong: $timesWrong')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    questionKey,
    box,
    dueOn,
    lastAnsweredAt,
    timesRight,
    timesWrong,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReviewItemRow &&
          other.questionKey == this.questionKey &&
          other.box == this.box &&
          other.dueOn == this.dueOn &&
          other.lastAnsweredAt == this.lastAnsweredAt &&
          other.timesRight == this.timesRight &&
          other.timesWrong == this.timesWrong);
}

class ReviewItemsCompanion extends UpdateCompanion<ReviewItemRow> {
  final Value<String> questionKey;
  final Value<int> box;
  final Value<DateTime> dueOn;
  final Value<DateTime> lastAnsweredAt;
  final Value<int> timesRight;
  final Value<int> timesWrong;
  final Value<int> rowid;
  const ReviewItemsCompanion({
    this.questionKey = const Value.absent(),
    this.box = const Value.absent(),
    this.dueOn = const Value.absent(),
    this.lastAnsweredAt = const Value.absent(),
    this.timesRight = const Value.absent(),
    this.timesWrong = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReviewItemsCompanion.insert({
    required String questionKey,
    required int box,
    required DateTime dueOn,
    required DateTime lastAnsweredAt,
    required int timesRight,
    required int timesWrong,
    this.rowid = const Value.absent(),
  }) : questionKey = Value(questionKey),
       box = Value(box),
       dueOn = Value(dueOn),
       lastAnsweredAt = Value(lastAnsweredAt),
       timesRight = Value(timesRight),
       timesWrong = Value(timesWrong);
  static Insertable<ReviewItemRow> custom({
    Expression<String>? questionKey,
    Expression<int>? box,
    Expression<DateTime>? dueOn,
    Expression<DateTime>? lastAnsweredAt,
    Expression<int>? timesRight,
    Expression<int>? timesWrong,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (questionKey != null) 'question_key': questionKey,
      if (box != null) 'box': box,
      if (dueOn != null) 'due_on': dueOn,
      if (lastAnsweredAt != null) 'last_answered_at': lastAnsweredAt,
      if (timesRight != null) 'times_right': timesRight,
      if (timesWrong != null) 'times_wrong': timesWrong,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReviewItemsCompanion copyWith({
    Value<String>? questionKey,
    Value<int>? box,
    Value<DateTime>? dueOn,
    Value<DateTime>? lastAnsweredAt,
    Value<int>? timesRight,
    Value<int>? timesWrong,
    Value<int>? rowid,
  }) {
    return ReviewItemsCompanion(
      questionKey: questionKey ?? this.questionKey,
      box: box ?? this.box,
      dueOn: dueOn ?? this.dueOn,
      lastAnsweredAt: lastAnsweredAt ?? this.lastAnsweredAt,
      timesRight: timesRight ?? this.timesRight,
      timesWrong: timesWrong ?? this.timesWrong,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (questionKey.present) {
      map['question_key'] = Variable<String>(questionKey.value);
    }
    if (box.present) {
      map['box'] = Variable<int>(box.value);
    }
    if (dueOn.present) {
      map['due_on'] = Variable<DateTime>(dueOn.value);
    }
    if (lastAnsweredAt.present) {
      map['last_answered_at'] = Variable<DateTime>(lastAnsweredAt.value);
    }
    if (timesRight.present) {
      map['times_right'] = Variable<int>(timesRight.value);
    }
    if (timesWrong.present) {
      map['times_wrong'] = Variable<int>(timesWrong.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReviewItemsCompanion(')
          ..write('questionKey: $questionKey, ')
          ..write('box: $box, ')
          ..write('dueOn: $dueOn, ')
          ..write('lastAnsweredAt: $lastAnsweredAt, ')
          ..write('timesRight: $timesRight, ')
          ..write('timesWrong: $timesWrong, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JourneyEnrollmentsTable extends JourneyEnrollments
    with TableInfo<$JourneyEnrollmentsTable, JourneyEnrollmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneyEnrollmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _journeyIdMeta = const VerificationMeta(
    'journeyId',
  );
  @override
  late final GeneratedColumn<String> journeyId = GeneratedColumn<String>(
    'journey_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pausedMeta = const VerificationMeta('paused');
  @override
  late final GeneratedColumn<bool> paused = GeneratedColumn<bool>(
    'paused',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("paused" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    journeyId,
    startedAt,
    updatedAt,
    paused,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journey_enrollments';
  @override
  VerificationContext validateIntegrity(
    Insertable<JourneyEnrollmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('journey_id')) {
      context.handle(
        _journeyIdMeta,
        journeyId.isAcceptableOrUnknown(data['journey_id']!, _journeyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_journeyIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('paused')) {
      context.handle(
        _pausedMeta,
        paused.isAcceptableOrUnknown(data['paused']!, _pausedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {journeyId};
  @override
  JourneyEnrollmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JourneyEnrollmentRow(
      journeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}journey_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      paused: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}paused'],
      )!,
    );
  }

  @override
  $JourneyEnrollmentsTable createAlias(String alias) {
    return $JourneyEnrollmentsTable(attachedDatabase, alias);
  }
}

class JourneyEnrollmentRow extends DataClass
    implements Insertable<JourneyEnrollmentRow> {
  final String journeyId;
  final DateTime startedAt;
  final DateTime updatedAt;
  final bool paused;
  const JourneyEnrollmentRow({
    required this.journeyId,
    required this.startedAt,
    required this.updatedAt,
    required this.paused,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['journey_id'] = Variable<String>(journeyId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['paused'] = Variable<bool>(paused);
    return map;
  }

  JourneyEnrollmentsCompanion toCompanion(bool nullToAbsent) {
    return JourneyEnrollmentsCompanion(
      journeyId: Value(journeyId),
      startedAt: Value(startedAt),
      updatedAt: Value(updatedAt),
      paused: Value(paused),
    );
  }

  factory JourneyEnrollmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JourneyEnrollmentRow(
      journeyId: serializer.fromJson<String>(json['journeyId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      paused: serializer.fromJson<bool>(json['paused']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'journeyId': serializer.toJson<String>(journeyId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'paused': serializer.toJson<bool>(paused),
    };
  }

  JourneyEnrollmentRow copyWith({
    String? journeyId,
    DateTime? startedAt,
    DateTime? updatedAt,
    bool? paused,
  }) => JourneyEnrollmentRow(
    journeyId: journeyId ?? this.journeyId,
    startedAt: startedAt ?? this.startedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    paused: paused ?? this.paused,
  );
  JourneyEnrollmentRow copyWithCompanion(JourneyEnrollmentsCompanion data) {
    return JourneyEnrollmentRow(
      journeyId: data.journeyId.present ? data.journeyId.value : this.journeyId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      paused: data.paused.present ? data.paused.value : this.paused,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JourneyEnrollmentRow(')
          ..write('journeyId: $journeyId, ')
          ..write('startedAt: $startedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('paused: $paused')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(journeyId, startedAt, updatedAt, paused);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JourneyEnrollmentRow &&
          other.journeyId == this.journeyId &&
          other.startedAt == this.startedAt &&
          other.updatedAt == this.updatedAt &&
          other.paused == this.paused);
}

class JourneyEnrollmentsCompanion
    extends UpdateCompanion<JourneyEnrollmentRow> {
  final Value<String> journeyId;
  final Value<DateTime> startedAt;
  final Value<DateTime> updatedAt;
  final Value<bool> paused;
  final Value<int> rowid;
  const JourneyEnrollmentsCompanion({
    this.journeyId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.paused = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JourneyEnrollmentsCompanion.insert({
    required String journeyId,
    required DateTime startedAt,
    required DateTime updatedAt,
    this.paused = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : journeyId = Value(journeyId),
       startedAt = Value(startedAt),
       updatedAt = Value(updatedAt);
  static Insertable<JourneyEnrollmentRow> custom({
    Expression<String>? journeyId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? paused,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (journeyId != null) 'journey_id': journeyId,
      if (startedAt != null) 'started_at': startedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (paused != null) 'paused': paused,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JourneyEnrollmentsCompanion copyWith({
    Value<String>? journeyId,
    Value<DateTime>? startedAt,
    Value<DateTime>? updatedAt,
    Value<bool>? paused,
    Value<int>? rowid,
  }) {
    return JourneyEnrollmentsCompanion(
      journeyId: journeyId ?? this.journeyId,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      paused: paused ?? this.paused,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (journeyId.present) {
      map['journey_id'] = Variable<String>(journeyId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (paused.present) {
      map['paused'] = Variable<bool>(paused.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneyEnrollmentsCompanion(')
          ..write('journeyId: $journeyId, ')
          ..write('startedAt: $startedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('paused: $paused, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JourneyProgressEntriesTable extends JourneyProgressEntries
    with TableInfo<$JourneyProgressEntriesTable, JourneyStepProgressRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneyProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _journeyIdMeta = const VerificationMeta(
    'journeyId',
  );
  @override
  late final GeneratedColumn<String> journeyId = GeneratedColumn<String>(
    'journey_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepIdMeta = const VerificationMeta('stepId');
  @override
  late final GeneratedColumn<String> stepId = GeneratedColumn<String>(
    'step_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _skippedMeta = const VerificationMeta(
    'skipped',
  );
  @override
  late final GeneratedColumn<bool> skipped = GeneratedColumn<bool>(
    'skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _answeredKeysMeta = const VerificationMeta(
    'answeredKeys',
  );
  @override
  late final GeneratedColumn<String> answeredKeys = GeneratedColumn<String>(
    'answered_keys',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    journeyId,
    stepId,
    startedAt,
    updatedAt,
    completedAt,
    skipped,
    answeredKeys,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journey_progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JourneyStepProgressRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('journey_id')) {
      context.handle(
        _journeyIdMeta,
        journeyId.isAcceptableOrUnknown(data['journey_id']!, _journeyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_journeyIdMeta);
    }
    if (data.containsKey('step_id')) {
      context.handle(
        _stepIdMeta,
        stepId.isAcceptableOrUnknown(data['step_id']!, _stepIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('skipped')) {
      context.handle(
        _skippedMeta,
        skipped.isAcceptableOrUnknown(data['skipped']!, _skippedMeta),
      );
    }
    if (data.containsKey('answered_keys')) {
      context.handle(
        _answeredKeysMeta,
        answeredKeys.isAcceptableOrUnknown(
          data['answered_keys']!,
          _answeredKeysMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {journeyId, stepId};
  @override
  JourneyStepProgressRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JourneyStepProgressRow(
      journeyId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}journey_id'],
      )!,
      stepId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}step_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      skipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}skipped'],
      )!,
      answeredKeys: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answered_keys'],
      )!,
    );
  }

  @override
  $JourneyProgressEntriesTable createAlias(String alias) {
    return $JourneyProgressEntriesTable(attachedDatabase, alias);
  }
}

class JourneyStepProgressRow extends DataClass
    implements Insertable<JourneyStepProgressRow> {
  final String journeyId;
  final String stepId;
  final DateTime startedAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final bool skipped;
  final String answeredKeys;
  const JourneyStepProgressRow({
    required this.journeyId,
    required this.stepId,
    required this.startedAt,
    required this.updatedAt,
    this.completedAt,
    required this.skipped,
    required this.answeredKeys,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['journey_id'] = Variable<String>(journeyId);
    map['step_id'] = Variable<String>(stepId);
    map['started_at'] = Variable<DateTime>(startedAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['skipped'] = Variable<bool>(skipped);
    map['answered_keys'] = Variable<String>(answeredKeys);
    return map;
  }

  JourneyProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return JourneyProgressEntriesCompanion(
      journeyId: Value(journeyId),
      stepId: Value(stepId),
      startedAt: Value(startedAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      skipped: Value(skipped),
      answeredKeys: Value(answeredKeys),
    );
  }

  factory JourneyStepProgressRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JourneyStepProgressRow(
      journeyId: serializer.fromJson<String>(json['journeyId']),
      stepId: serializer.fromJson<String>(json['stepId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      skipped: serializer.fromJson<bool>(json['skipped']),
      answeredKeys: serializer.fromJson<String>(json['answeredKeys']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'journeyId': serializer.toJson<String>(journeyId),
      'stepId': serializer.toJson<String>(stepId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'skipped': serializer.toJson<bool>(skipped),
      'answeredKeys': serializer.toJson<String>(answeredKeys),
    };
  }

  JourneyStepProgressRow copyWith({
    String? journeyId,
    String? stepId,
    DateTime? startedAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    bool? skipped,
    String? answeredKeys,
  }) => JourneyStepProgressRow(
    journeyId: journeyId ?? this.journeyId,
    stepId: stepId ?? this.stepId,
    startedAt: startedAt ?? this.startedAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    skipped: skipped ?? this.skipped,
    answeredKeys: answeredKeys ?? this.answeredKeys,
  );
  JourneyStepProgressRow copyWithCompanion(
    JourneyProgressEntriesCompanion data,
  ) {
    return JourneyStepProgressRow(
      journeyId: data.journeyId.present ? data.journeyId.value : this.journeyId,
      stepId: data.stepId.present ? data.stepId.value : this.stepId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      skipped: data.skipped.present ? data.skipped.value : this.skipped,
      answeredKeys: data.answeredKeys.present
          ? data.answeredKeys.value
          : this.answeredKeys,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JourneyStepProgressRow(')
          ..write('journeyId: $journeyId, ')
          ..write('stepId: $stepId, ')
          ..write('startedAt: $startedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('skipped: $skipped, ')
          ..write('answeredKeys: $answeredKeys')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    journeyId,
    stepId,
    startedAt,
    updatedAt,
    completedAt,
    skipped,
    answeredKeys,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JourneyStepProgressRow &&
          other.journeyId == this.journeyId &&
          other.stepId == this.stepId &&
          other.startedAt == this.startedAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt &&
          other.skipped == this.skipped &&
          other.answeredKeys == this.answeredKeys);
}

class JourneyProgressEntriesCompanion
    extends UpdateCompanion<JourneyStepProgressRow> {
  final Value<String> journeyId;
  final Value<String> stepId;
  final Value<DateTime> startedAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<bool> skipped;
  final Value<String> answeredKeys;
  final Value<int> rowid;
  const JourneyProgressEntriesCompanion({
    this.journeyId = const Value.absent(),
    this.stepId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.skipped = const Value.absent(),
    this.answeredKeys = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JourneyProgressEntriesCompanion.insert({
    required String journeyId,
    required String stepId,
    required DateTime startedAt,
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.skipped = const Value.absent(),
    this.answeredKeys = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : journeyId = Value(journeyId),
       stepId = Value(stepId),
       startedAt = Value(startedAt),
       updatedAt = Value(updatedAt);
  static Insertable<JourneyStepProgressRow> custom({
    Expression<String>? journeyId,
    Expression<String>? stepId,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<bool>? skipped,
    Expression<String>? answeredKeys,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (journeyId != null) 'journey_id': journeyId,
      if (stepId != null) 'step_id': stepId,
      if (startedAt != null) 'started_at': startedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (skipped != null) 'skipped': skipped,
      if (answeredKeys != null) 'answered_keys': answeredKeys,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JourneyProgressEntriesCompanion copyWith({
    Value<String>? journeyId,
    Value<String>? stepId,
    Value<DateTime>? startedAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<bool>? skipped,
    Value<String>? answeredKeys,
    Value<int>? rowid,
  }) {
    return JourneyProgressEntriesCompanion(
      journeyId: journeyId ?? this.journeyId,
      stepId: stepId ?? this.stepId,
      startedAt: startedAt ?? this.startedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      skipped: skipped ?? this.skipped,
      answeredKeys: answeredKeys ?? this.answeredKeys,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (journeyId.present) {
      map['journey_id'] = Variable<String>(journeyId.value);
    }
    if (stepId.present) {
      map['step_id'] = Variable<String>(stepId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (skipped.present) {
      map['skipped'] = Variable<bool>(skipped.value);
    }
    if (answeredKeys.present) {
      map['answered_keys'] = Variable<String>(answeredKeys.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneyProgressEntriesCompanion(')
          ..write('journeyId: $journeyId, ')
          ..write('stepId: $stepId, ')
          ..write('startedAt: $startedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('skipped: $skipped, ')
          ..write('answeredKeys: $answeredKeys, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BookmarksTable bookmarks = $BookmarksTable(this);
  late final $ReadingProgressEntriesTable readingProgressEntries =
      $ReadingProgressEntriesTable(this);
  late final $ReviewItemsTable reviewItems = $ReviewItemsTable(this);
  late final $JourneyEnrollmentsTable journeyEnrollments =
      $JourneyEnrollmentsTable(this);
  late final $JourneyProgressEntriesTable journeyProgressEntries =
      $JourneyProgressEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    bookmarks,
    readingProgressEntries,
    reviewItems,
    journeyEnrollments,
    journeyProgressEntries,
  ];
}

typedef $$BookmarksTableCreateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      required String targetType,
      required String targetId,
      Value<String?> parentId,
      required DateTime createdAt,
    });
typedef $$BookmarksTableUpdateCompanionBuilder =
    BookmarksCompanion Function({
      Value<int> id,
      Value<String> targetType,
      Value<String> targetId,
      Value<String?> parentId,
      Value<DateTime> createdAt,
    });

class $$BookmarksTableFilterComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BookmarksTableOrderingComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BookmarksTableAnnotationComposer
    extends Composer<_$AppDatabase, $BookmarksTable> {
  $$BookmarksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$BookmarksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BookmarksTable,
          BookmarkRow,
          $$BookmarksTableFilterComposer,
          $$BookmarksTableOrderingComposer,
          $$BookmarksTableAnnotationComposer,
          $$BookmarksTableCreateCompanionBuilder,
          $$BookmarksTableUpdateCompanionBuilder,
          (
            BookmarkRow,
            BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkRow>,
          ),
          BookmarkRow,
          PrefetchHooks Function()
        > {
  $$BookmarksTableTableManager(_$AppDatabase db, $BookmarksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BookmarksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BookmarksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BookmarksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> targetType = const Value.absent(),
                Value<String> targetId = const Value.absent(),
                Value<String?> parentId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BookmarksCompanion(
                id: id,
                targetType: targetType,
                targetId: targetId,
                parentId: parentId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String targetType,
                required String targetId,
                Value<String?> parentId = const Value.absent(),
                required DateTime createdAt,
              }) => BookmarksCompanion.insert(
                id: id,
                targetType: targetType,
                targetId: targetId,
                parentId: parentId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BookmarksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BookmarksTable,
      BookmarkRow,
      $$BookmarksTableFilterComposer,
      $$BookmarksTableOrderingComposer,
      $$BookmarksTableAnnotationComposer,
      $$BookmarksTableCreateCompanionBuilder,
      $$BookmarksTableUpdateCompanionBuilder,
      (
        BookmarkRow,
        BaseReferences<_$AppDatabase, $BookmarksTable, BookmarkRow>,
      ),
      BookmarkRow,
      PrefetchHooks Function()
    >;
typedef $$ReadingProgressEntriesTableCreateCompanionBuilder =
    ReadingProgressEntriesCompanion Function({
      required String targetType,
      required String targetId,
      required String parentId,
      required double fraction,
      Value<bool> completed,
      required String contentVersion,
      required DateTime updatedAt,
      Value<String?> targetRevision,
      Value<int?> blockIndex,
      Value<double?> blockOffset,
      Value<int> rowid,
    });
typedef $$ReadingProgressEntriesTableUpdateCompanionBuilder =
    ReadingProgressEntriesCompanion Function({
      Value<String> targetType,
      Value<String> targetId,
      Value<String> parentId,
      Value<double> fraction,
      Value<bool> completed,
      Value<String> contentVersion,
      Value<DateTime> updatedAt,
      Value<String?> targetRevision,
      Value<int?> blockIndex,
      Value<double?> blockOffset,
      Value<int> rowid,
    });

class $$ReadingProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingProgressEntriesTable> {
  $$ReadingProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fraction => $composableBuilder(
    column: $table.fraction,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetRevision => $composableBuilder(
    column: $table.targetRevision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get blockIndex => $composableBuilder(
    column: $table.blockIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get blockOffset => $composableBuilder(
    column: $table.blockOffset,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReadingProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingProgressEntriesTable> {
  $$ReadingProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetId => $composableBuilder(
    column: $table.targetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentId => $composableBuilder(
    column: $table.parentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fraction => $composableBuilder(
    column: $table.fraction,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetRevision => $composableBuilder(
    column: $table.targetRevision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get blockIndex => $composableBuilder(
    column: $table.blockIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get blockOffset => $composableBuilder(
    column: $table.blockOffset,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReadingProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingProgressEntriesTable> {
  $$ReadingProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get targetType => $composableBuilder(
    column: $table.targetType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetId =>
      $composableBuilder(column: $table.targetId, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<double> get fraction =>
      $composableBuilder(column: $table.fraction, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get targetRevision => $composableBuilder(
    column: $table.targetRevision,
    builder: (column) => column,
  );

  GeneratedColumn<int> get blockIndex => $composableBuilder(
    column: $table.blockIndex,
    builder: (column) => column,
  );

  GeneratedColumn<double> get blockOffset => $composableBuilder(
    column: $table.blockOffset,
    builder: (column) => column,
  );
}

class $$ReadingProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingProgressEntriesTable,
          ProgressRow,
          $$ReadingProgressEntriesTableFilterComposer,
          $$ReadingProgressEntriesTableOrderingComposer,
          $$ReadingProgressEntriesTableAnnotationComposer,
          $$ReadingProgressEntriesTableCreateCompanionBuilder,
          $$ReadingProgressEntriesTableUpdateCompanionBuilder,
          (
            ProgressRow,
            BaseReferences<
              _$AppDatabase,
              $ReadingProgressEntriesTable,
              ProgressRow
            >,
          ),
          ProgressRow,
          PrefetchHooks Function()
        > {
  $$ReadingProgressEntriesTableTableManager(
    _$AppDatabase db,
    $ReadingProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingProgressEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ReadingProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ReadingProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> targetType = const Value.absent(),
                Value<String> targetId = const Value.absent(),
                Value<String> parentId = const Value.absent(),
                Value<double> fraction = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String> contentVersion = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String?> targetRevision = const Value.absent(),
                Value<int?> blockIndex = const Value.absent(),
                Value<double?> blockOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressEntriesCompanion(
                targetType: targetType,
                targetId: targetId,
                parentId: parentId,
                fraction: fraction,
                completed: completed,
                contentVersion: contentVersion,
                updatedAt: updatedAt,
                targetRevision: targetRevision,
                blockIndex: blockIndex,
                blockOffset: blockOffset,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String targetType,
                required String targetId,
                required String parentId,
                required double fraction,
                Value<bool> completed = const Value.absent(),
                required String contentVersion,
                required DateTime updatedAt,
                Value<String?> targetRevision = const Value.absent(),
                Value<int?> blockIndex = const Value.absent(),
                Value<double?> blockOffset = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReadingProgressEntriesCompanion.insert(
                targetType: targetType,
                targetId: targetId,
                parentId: parentId,
                fraction: fraction,
                completed: completed,
                contentVersion: contentVersion,
                updatedAt: updatedAt,
                targetRevision: targetRevision,
                blockIndex: blockIndex,
                blockOffset: blockOffset,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReadingProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingProgressEntriesTable,
      ProgressRow,
      $$ReadingProgressEntriesTableFilterComposer,
      $$ReadingProgressEntriesTableOrderingComposer,
      $$ReadingProgressEntriesTableAnnotationComposer,
      $$ReadingProgressEntriesTableCreateCompanionBuilder,
      $$ReadingProgressEntriesTableUpdateCompanionBuilder,
      (
        ProgressRow,
        BaseReferences<
          _$AppDatabase,
          $ReadingProgressEntriesTable,
          ProgressRow
        >,
      ),
      ProgressRow,
      PrefetchHooks Function()
    >;
typedef $$ReviewItemsTableCreateCompanionBuilder =
    ReviewItemsCompanion Function({
      required String questionKey,
      required int box,
      required DateTime dueOn,
      required DateTime lastAnsweredAt,
      required int timesRight,
      required int timesWrong,
      Value<int> rowid,
    });
typedef $$ReviewItemsTableUpdateCompanionBuilder =
    ReviewItemsCompanion Function({
      Value<String> questionKey,
      Value<int> box,
      Value<DateTime> dueOn,
      Value<DateTime> lastAnsweredAt,
      Value<int> timesRight,
      Value<int> timesWrong,
      Value<int> rowid,
    });

class $$ReviewItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get box => $composableBuilder(
    column: $table.box,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesRight => $composableBuilder(
    column: $table.timesRight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timesWrong => $composableBuilder(
    column: $table.timesWrong,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReviewItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get box => $composableBuilder(
    column: $table.box,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueOn => $composableBuilder(
    column: $table.dueOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesRight => $composableBuilder(
    column: $table.timesRight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timesWrong => $composableBuilder(
    column: $table.timesWrong,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReviewItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReviewItemsTable> {
  $$ReviewItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get questionKey => $composableBuilder(
    column: $table.questionKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get box =>
      $composableBuilder(column: $table.box, builder: (column) => column);

  GeneratedColumn<DateTime> get dueOn =>
      $composableBuilder(column: $table.dueOn, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAnsweredAt => $composableBuilder(
    column: $table.lastAnsweredAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesRight => $composableBuilder(
    column: $table.timesRight,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timesWrong => $composableBuilder(
    column: $table.timesWrong,
    builder: (column) => column,
  );
}

class $$ReviewItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReviewItemsTable,
          ReviewItemRow,
          $$ReviewItemsTableFilterComposer,
          $$ReviewItemsTableOrderingComposer,
          $$ReviewItemsTableAnnotationComposer,
          $$ReviewItemsTableCreateCompanionBuilder,
          $$ReviewItemsTableUpdateCompanionBuilder,
          (
            ReviewItemRow,
            BaseReferences<_$AppDatabase, $ReviewItemsTable, ReviewItemRow>,
          ),
          ReviewItemRow,
          PrefetchHooks Function()
        > {
  $$ReviewItemsTableTableManager(_$AppDatabase db, $ReviewItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReviewItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReviewItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReviewItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> questionKey = const Value.absent(),
                Value<int> box = const Value.absent(),
                Value<DateTime> dueOn = const Value.absent(),
                Value<DateTime> lastAnsweredAt = const Value.absent(),
                Value<int> timesRight = const Value.absent(),
                Value<int> timesWrong = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion(
                questionKey: questionKey,
                box: box,
                dueOn: dueOn,
                lastAnsweredAt: lastAnsweredAt,
                timesRight: timesRight,
                timesWrong: timesWrong,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String questionKey,
                required int box,
                required DateTime dueOn,
                required DateTime lastAnsweredAt,
                required int timesRight,
                required int timesWrong,
                Value<int> rowid = const Value.absent(),
              }) => ReviewItemsCompanion.insert(
                questionKey: questionKey,
                box: box,
                dueOn: dueOn,
                lastAnsweredAt: lastAnsweredAt,
                timesRight: timesRight,
                timesWrong: timesWrong,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReviewItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReviewItemsTable,
      ReviewItemRow,
      $$ReviewItemsTableFilterComposer,
      $$ReviewItemsTableOrderingComposer,
      $$ReviewItemsTableAnnotationComposer,
      $$ReviewItemsTableCreateCompanionBuilder,
      $$ReviewItemsTableUpdateCompanionBuilder,
      (
        ReviewItemRow,
        BaseReferences<_$AppDatabase, $ReviewItemsTable, ReviewItemRow>,
      ),
      ReviewItemRow,
      PrefetchHooks Function()
    >;
typedef $$JourneyEnrollmentsTableCreateCompanionBuilder =
    JourneyEnrollmentsCompanion Function({
      required String journeyId,
      required DateTime startedAt,
      required DateTime updatedAt,
      Value<bool> paused,
      Value<int> rowid,
    });
typedef $$JourneyEnrollmentsTableUpdateCompanionBuilder =
    JourneyEnrollmentsCompanion Function({
      Value<String> journeyId,
      Value<DateTime> startedAt,
      Value<DateTime> updatedAt,
      Value<bool> paused,
      Value<int> rowid,
    });

class $$JourneyEnrollmentsTableFilterComposer
    extends Composer<_$AppDatabase, $JourneyEnrollmentsTable> {
  $$JourneyEnrollmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get journeyId => $composableBuilder(
    column: $table.journeyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get paused => $composableBuilder(
    column: $table.paused,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JourneyEnrollmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $JourneyEnrollmentsTable> {
  $$JourneyEnrollmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get journeyId => $composableBuilder(
    column: $table.journeyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get paused => $composableBuilder(
    column: $table.paused,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JourneyEnrollmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JourneyEnrollmentsTable> {
  $$JourneyEnrollmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get journeyId =>
      $composableBuilder(column: $table.journeyId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get paused =>
      $composableBuilder(column: $table.paused, builder: (column) => column);
}

class $$JourneyEnrollmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JourneyEnrollmentsTable,
          JourneyEnrollmentRow,
          $$JourneyEnrollmentsTableFilterComposer,
          $$JourneyEnrollmentsTableOrderingComposer,
          $$JourneyEnrollmentsTableAnnotationComposer,
          $$JourneyEnrollmentsTableCreateCompanionBuilder,
          $$JourneyEnrollmentsTableUpdateCompanionBuilder,
          (
            JourneyEnrollmentRow,
            BaseReferences<
              _$AppDatabase,
              $JourneyEnrollmentsTable,
              JourneyEnrollmentRow
            >,
          ),
          JourneyEnrollmentRow,
          PrefetchHooks Function()
        > {
  $$JourneyEnrollmentsTableTableManager(
    _$AppDatabase db,
    $JourneyEnrollmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneyEnrollmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JourneyEnrollmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JourneyEnrollmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> journeyId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> paused = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JourneyEnrollmentsCompanion(
                journeyId: journeyId,
                startedAt: startedAt,
                updatedAt: updatedAt,
                paused: paused,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String journeyId,
                required DateTime startedAt,
                required DateTime updatedAt,
                Value<bool> paused = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JourneyEnrollmentsCompanion.insert(
                journeyId: journeyId,
                startedAt: startedAt,
                updatedAt: updatedAt,
                paused: paused,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JourneyEnrollmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JourneyEnrollmentsTable,
      JourneyEnrollmentRow,
      $$JourneyEnrollmentsTableFilterComposer,
      $$JourneyEnrollmentsTableOrderingComposer,
      $$JourneyEnrollmentsTableAnnotationComposer,
      $$JourneyEnrollmentsTableCreateCompanionBuilder,
      $$JourneyEnrollmentsTableUpdateCompanionBuilder,
      (
        JourneyEnrollmentRow,
        BaseReferences<
          _$AppDatabase,
          $JourneyEnrollmentsTable,
          JourneyEnrollmentRow
        >,
      ),
      JourneyEnrollmentRow,
      PrefetchHooks Function()
    >;
typedef $$JourneyProgressEntriesTableCreateCompanionBuilder =
    JourneyProgressEntriesCompanion Function({
      required String journeyId,
      required String stepId,
      required DateTime startedAt,
      required DateTime updatedAt,
      Value<DateTime?> completedAt,
      Value<bool> skipped,
      Value<String> answeredKeys,
      Value<int> rowid,
    });
typedef $$JourneyProgressEntriesTableUpdateCompanionBuilder =
    JourneyProgressEntriesCompanion Function({
      Value<String> journeyId,
      Value<String> stepId,
      Value<DateTime> startedAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
      Value<bool> skipped,
      Value<String> answeredKeys,
      Value<int> rowid,
    });

class $$JourneyProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JourneyProgressEntriesTable> {
  $$JourneyProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get journeyId => $composableBuilder(
    column: $table.journeyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stepId => $composableBuilder(
    column: $table.stepId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answeredKeys => $composableBuilder(
    column: $table.answeredKeys,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JourneyProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JourneyProgressEntriesTable> {
  $$JourneyProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get journeyId => $composableBuilder(
    column: $table.journeyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stepId => $composableBuilder(
    column: $table.stepId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answeredKeys => $composableBuilder(
    column: $table.answeredKeys,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JourneyProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JourneyProgressEntriesTable> {
  $$JourneyProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get journeyId =>
      $composableBuilder(column: $table.journeyId, builder: (column) => column);

  GeneratedColumn<String> get stepId =>
      $composableBuilder(column: $table.stepId, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get skipped =>
      $composableBuilder(column: $table.skipped, builder: (column) => column);

  GeneratedColumn<String> get answeredKeys => $composableBuilder(
    column: $table.answeredKeys,
    builder: (column) => column,
  );
}

class $$JourneyProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JourneyProgressEntriesTable,
          JourneyStepProgressRow,
          $$JourneyProgressEntriesTableFilterComposer,
          $$JourneyProgressEntriesTableOrderingComposer,
          $$JourneyProgressEntriesTableAnnotationComposer,
          $$JourneyProgressEntriesTableCreateCompanionBuilder,
          $$JourneyProgressEntriesTableUpdateCompanionBuilder,
          (
            JourneyStepProgressRow,
            BaseReferences<
              _$AppDatabase,
              $JourneyProgressEntriesTable,
              JourneyStepProgressRow
            >,
          ),
          JourneyStepProgressRow,
          PrefetchHooks Function()
        > {
  $$JourneyProgressEntriesTableTableManager(
    _$AppDatabase db,
    $JourneyProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneyProgressEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$JourneyProgressEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$JourneyProgressEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> journeyId = const Value.absent(),
                Value<String> stepId = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<String> answeredKeys = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JourneyProgressEntriesCompanion(
                journeyId: journeyId,
                stepId: stepId,
                startedAt: startedAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                skipped: skipped,
                answeredKeys: answeredKeys,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String journeyId,
                required String stepId,
                required DateTime startedAt,
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<String> answeredKeys = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JourneyProgressEntriesCompanion.insert(
                journeyId: journeyId,
                stepId: stepId,
                startedAt: startedAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                skipped: skipped,
                answeredKeys: answeredKeys,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JourneyProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JourneyProgressEntriesTable,
      JourneyStepProgressRow,
      $$JourneyProgressEntriesTableFilterComposer,
      $$JourneyProgressEntriesTableOrderingComposer,
      $$JourneyProgressEntriesTableAnnotationComposer,
      $$JourneyProgressEntriesTableCreateCompanionBuilder,
      $$JourneyProgressEntriesTableUpdateCompanionBuilder,
      (
        JourneyStepProgressRow,
        BaseReferences<
          _$AppDatabase,
          $JourneyProgressEntriesTable,
          JourneyStepProgressRow
        >,
      ),
      JourneyStepProgressRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BookmarksTableTableManager get bookmarks =>
      $$BookmarksTableTableManager(_db, _db.bookmarks);
  $$ReadingProgressEntriesTableTableManager get readingProgressEntries =>
      $$ReadingProgressEntriesTableTableManager(
        _db,
        _db.readingProgressEntries,
      );
  $$ReviewItemsTableTableManager get reviewItems =>
      $$ReviewItemsTableTableManager(_db, _db.reviewItems);
  $$JourneyEnrollmentsTableTableManager get journeyEnrollments =>
      $$JourneyEnrollmentsTableTableManager(_db, _db.journeyEnrollments);
  $$JourneyProgressEntriesTableTableManager get journeyProgressEntries =>
      $$JourneyProgressEntriesTableTableManager(
        _db,
        _db.journeyProgressEntries,
      );
}
