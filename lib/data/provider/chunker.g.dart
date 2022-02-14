// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chunker.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Subject extends DataClass implements Insertable<Subject> {
  final int id;
  final DateTime createdAt;
  final String name;
  Subject({required this.id, required this.createdAt, required this.name});
  factory Subject.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Subject(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['name'] = Variable<String>(name);
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      name: Value(name),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'name': serializer.toJson<String>(name),
    };
  }

  Subject copyWith({int? id, DateTime? createdAt, String? name}) => Subject(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.name == this.name);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<String> name;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  SubjectsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Subject> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (name != null) 'name': name,
    });
  }

  SubjectsCompanion copyWith(
      {Value<int>? id, Value<DateTime>? createdAt, Value<String>? name}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name =
      GeneratedColumn<String?>('name', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, name];
  @override
  String get aliasedName => _alias ?? 'subjects';
  @override
  String get actualTableName => 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Subject.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Chunk extends DataClass implements Insertable<Chunk> {
  final int id;
  final double effectiveLevel;
  final DateTime createdAt;
  final String? content;
  final String reference;
  final Uint8List? image;
  final bool isMarked;
  final int subject;
  Chunk(
      {required this.id,
      required this.effectiveLevel,
      required this.createdAt,
      this.content,
      required this.reference,
      this.image,
      required this.isMarked,
      required this.subject});
  factory Chunk.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Chunk(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      effectiveLevel: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}effective_level'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      reference: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}reference'])!,
      image: const BlobType()
          .mapFromDatabaseResponse(data['${effectivePrefix}image']),
      isMarked: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_marked'])!,
      subject: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}subject'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['effective_level'] = Variable<double>(effectiveLevel);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    map['reference'] = Variable<String>(reference);
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<Uint8List?>(image);
    }
    map['is_marked'] = Variable<bool>(isMarked);
    map['subject'] = Variable<int>(subject);
    return map;
  }

  ChunksCompanion toCompanion(bool nullToAbsent) {
    return ChunksCompanion(
      id: Value(id),
      effectiveLevel: Value(effectiveLevel),
      createdAt: Value(createdAt),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      reference: Value(reference),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      isMarked: Value(isMarked),
      subject: Value(subject),
    );
  }

  factory Chunk.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Chunk(
      id: serializer.fromJson<int>(json['id']),
      effectiveLevel: serializer.fromJson<double>(json['effectiveLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      content: serializer.fromJson<String?>(json['content']),
      reference: serializer.fromJson<String>(json['reference']),
      image: serializer.fromJson<Uint8List?>(json['image']),
      isMarked: serializer.fromJson<bool>(json['isMarked']),
      subject: serializer.fromJson<int>(json['subject']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'effectiveLevel': serializer.toJson<double>(effectiveLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'content': serializer.toJson<String?>(content),
      'reference': serializer.toJson<String>(reference),
      'image': serializer.toJson<Uint8List?>(image),
      'isMarked': serializer.toJson<bool>(isMarked),
      'subject': serializer.toJson<int>(subject),
    };
  }

  Chunk copyWith(
          {int? id,
          double? effectiveLevel,
          DateTime? createdAt,
          String? content,
          String? reference,
          Uint8List? image,
          bool? isMarked,
          int? subject}) =>
      Chunk(
        id: id ?? this.id,
        effectiveLevel: effectiveLevel ?? this.effectiveLevel,
        createdAt: createdAt ?? this.createdAt,
        content: content ?? this.content,
        reference: reference ?? this.reference,
        image: image ?? this.image,
        isMarked: isMarked ?? this.isMarked,
        subject: subject ?? this.subject,
      );
  @override
  String toString() {
    return (StringBuffer('Chunk(')
          ..write('id: $id, ')
          ..write('effectiveLevel: $effectiveLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('content: $content, ')
          ..write('reference: $reference, ')
          ..write('image: $image, ')
          ..write('isMarked: $isMarked, ')
          ..write('subject: $subject')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, effectiveLevel, createdAt, content,
      reference, image, isMarked, subject);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Chunk &&
          other.id == this.id &&
          other.effectiveLevel == this.effectiveLevel &&
          other.createdAt == this.createdAt &&
          other.content == this.content &&
          other.reference == this.reference &&
          other.image == this.image &&
          other.isMarked == this.isMarked &&
          other.subject == this.subject);
}

class ChunksCompanion extends UpdateCompanion<Chunk> {
  final Value<int> id;
  final Value<double> effectiveLevel;
  final Value<DateTime> createdAt;
  final Value<String?> content;
  final Value<String> reference;
  final Value<Uint8List?> image;
  final Value<bool> isMarked;
  final Value<int> subject;
  const ChunksCompanion({
    this.id = const Value.absent(),
    this.effectiveLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.content = const Value.absent(),
    this.reference = const Value.absent(),
    this.image = const Value.absent(),
    this.isMarked = const Value.absent(),
    this.subject = const Value.absent(),
  });
  ChunksCompanion.insert({
    this.id = const Value.absent(),
    this.effectiveLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.content = const Value.absent(),
    required String reference,
    this.image = const Value.absent(),
    this.isMarked = const Value.absent(),
    required int subject,
  })  : reference = Value(reference),
        subject = Value(subject);
  static Insertable<Chunk> custom({
    Expression<int>? id,
    Expression<double>? effectiveLevel,
    Expression<DateTime>? createdAt,
    Expression<String?>? content,
    Expression<String>? reference,
    Expression<Uint8List?>? image,
    Expression<bool>? isMarked,
    Expression<int>? subject,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (effectiveLevel != null) 'effective_level': effectiveLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (content != null) 'content': content,
      if (reference != null) 'reference': reference,
      if (image != null) 'image': image,
      if (isMarked != null) 'is_marked': isMarked,
      if (subject != null) 'subject': subject,
    });
  }

  ChunksCompanion copyWith(
      {Value<int>? id,
      Value<double>? effectiveLevel,
      Value<DateTime>? createdAt,
      Value<String?>? content,
      Value<String>? reference,
      Value<Uint8List?>? image,
      Value<bool>? isMarked,
      Value<int>? subject}) {
    return ChunksCompanion(
      id: id ?? this.id,
      effectiveLevel: effectiveLevel ?? this.effectiveLevel,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      reference: reference ?? this.reference,
      image: image ?? this.image,
      isMarked: isMarked ?? this.isMarked,
      subject: subject ?? this.subject,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (effectiveLevel.present) {
      map['effective_level'] = Variable<double>(effectiveLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (image.present) {
      map['image'] = Variable<Uint8List?>(image.value);
    }
    if (isMarked.present) {
      map['is_marked'] = Variable<bool>(isMarked.value);
    }
    if (subject.present) {
      map['subject'] = Variable<int>(subject.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChunksCompanion(')
          ..write('id: $id, ')
          ..write('effectiveLevel: $effectiveLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('content: $content, ')
          ..write('reference: $reference, ')
          ..write('image: $image, ')
          ..write('isMarked: $isMarked, ')
          ..write('subject: $subject')
          ..write(')'))
        .toString();
  }
}

class $ChunksTable extends Chunks with TableInfo<$ChunksTable, Chunk> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChunksTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _effectiveLevelMeta =
      const VerificationMeta('effectiveLevel');
  @override
  late final GeneratedColumn<double?> effectiveLevel = GeneratedColumn<double?>(
      'effective_level', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0.5));
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _referenceMeta = const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String?> reference =
      GeneratedColumn<String?>('reference', aliasedName, false,
          additionalChecks: GeneratedColumn.checkTextLength(
            minTextLength: 1,
          ),
          type: const StringType(),
          requiredDuringInsert: true);
  final VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<Uint8List?> image = GeneratedColumn<Uint8List?>(
      'image', aliasedName, true,
      type: const BlobType(), requiredDuringInsert: false);
  final VerificationMeta _isMarkedMeta = const VerificationMeta('isMarked');
  @override
  late final GeneratedColumn<bool?> isMarked = GeneratedColumn<bool?>(
      'is_marked', aliasedName, false,
      type: const BoolType(),
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_marked IN (0, 1))',
      defaultValue: const Constant(false));
  final VerificationMeta _subjectMeta = const VerificationMeta('subject');
  @override
  late final GeneratedColumn<int?> subject = GeneratedColumn<int?>(
      'subject', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      defaultConstraints: 'REFERENCES subjects (id) ON DELETE CASCADE');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        effectiveLevel,
        createdAt,
        content,
        reference,
        image,
        isMarked,
        subject
      ];
  @override
  String get aliasedName => _alias ?? 'chunks';
  @override
  String get actualTableName => 'chunks';
  @override
  VerificationContext validateIntegrity(Insertable<Chunk> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('effective_level')) {
      context.handle(
          _effectiveLevelMeta,
          effectiveLevel.isAcceptableOrUnknown(
              data['effective_level']!, _effectiveLevelMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    } else if (isInserting) {
      context.missing(_referenceMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image']!, _imageMeta));
    }
    if (data.containsKey('is_marked')) {
      context.handle(_isMarkedMeta,
          isMarked.isAcceptableOrUnknown(data['is_marked']!, _isMarkedMeta));
    }
    if (data.containsKey('subject')) {
      context.handle(_subjectMeta,
          subject.isAcceptableOrUnknown(data['subject']!, _subjectMeta));
    } else if (isInserting) {
      context.missing(_subjectMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Chunk map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Chunk.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ChunksTable createAlias(String alias) {
    return $ChunksTable(attachedDatabase, alias);
  }
}

abstract class _$ChunkerDatabase extends GeneratedDatabase {
  _$ChunkerDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $ChunksTable chunks = $ChunksTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [subjects, chunks];
}
