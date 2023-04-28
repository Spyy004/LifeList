// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetBucketCollection on Isar {
  IsarCollection<Bucket> get buckets => this.collection();
}

const BucketSchema = CollectionSchema(
  name: r'Bucket',
  id: 2862278782109637644,
  properties: {
    r'bucketCategory': PropertySchema(
      id: 0,
      name: r'bucketCategory',
      type: IsarType.byte,
      enumMap: _BucketbucketCategoryEnumValueMap,
    ),
    r'bucketScope': PropertySchema(
      id: 1,
      name: r'bucketScope',
      type: IsarType.byte,
      enumMap: _BucketbucketScopeEnumValueMap,
    ),
    r'deadline': PropertySchema(
      id: 2,
      name: r'deadline',
      type: IsarType.dateTime,
    ),
    r'description': PropertySchema(
      id: 3,
      name: r'description',
      type: IsarType.string,
    ),
    r'isCompleted': PropertySchema(
      id: 4,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'streak': PropertySchema(
      id: 6,
      name: r'streak',
      type: IsarType.long,
    ),
    r'tasks': PropertySchema(
      id: 7,
      name: r'tasks',
      type: IsarType.longList,
    ),
    r'timeLeft': PropertySchema(
      id: 8,
      name: r'timeLeft',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 9,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _bucketEstimateSize,
  serialize: _bucketSerialize,
  deserialize: _bucketDeserialize,
  deserializeProp: _bucketDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bucketGetId,
  getLinks: _bucketGetLinks,
  attach: _bucketAttach,
  version: '3.0.5',
);

int _bucketEstimateSize(
  Bucket object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.tasks.length * 8;
  bytesCount += 3 + object.timeLeft.length * 3;
  return bytesCount;
}

void _bucketSerialize(
  Bucket object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByte(offsets[0], object.bucketCategory.index);
  writer.writeByte(offsets[1], object.bucketScope.index);
  writer.writeDateTime(offsets[2], object.deadline);
  writer.writeString(offsets[3], object.description);
  writer.writeBool(offsets[4], object.isCompleted);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.streak);
  writer.writeLongList(offsets[7], object.tasks);
  writer.writeString(offsets[8], object.timeLeft);
  writer.writeDateTime(offsets[9], object.updatedAt);
}

Bucket _bucketDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Bucket();
  object.bucketCategory =
      _BucketbucketCategoryValueEnumMap[reader.readByteOrNull(offsets[0])] ??
          BucketCategory.travel;
  object.bucketScope =
      _BucketbucketScopeValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          BucketScope.onetime;
  object.deadline = reader.readDateTime(offsets[2]);
  object.description = reader.readString(offsets[3]);
  object.id = id;
  object.isCompleted = reader.readBool(offsets[4]);
  object.name = reader.readString(offsets[5]);
  object.streak = reader.readLong(offsets[6]);
  object.tasks = reader.readLongList(offsets[7]) ?? [];
  object.timeLeft = reader.readString(offsets[8]);
  object.updatedAt = reader.readDateTime(offsets[9]);
  return object;
}

P _bucketDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (_BucketbucketCategoryValueEnumMap[
              reader.readByteOrNull(offset)] ??
          BucketCategory.travel) as P;
    case 1:
      return (_BucketbucketScopeValueEnumMap[reader.readByteOrNull(offset)] ??
          BucketScope.onetime) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLongList(offset) ?? []) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _BucketbucketCategoryEnumValueMap = {
  'travel': 0,
  'finance': 1,
  'adventure': 2,
  'career': 3,
  'fitness': 4,
  'personalitydevelopment': 5,
  'creativity': 6,
  'relationships': 7,
};
const _BucketbucketCategoryValueEnumMap = {
  0: BucketCategory.travel,
  1: BucketCategory.finance,
  2: BucketCategory.adventure,
  3: BucketCategory.career,
  4: BucketCategory.fitness,
  5: BucketCategory.personalitydevelopment,
  6: BucketCategory.creativity,
  7: BucketCategory.relationships,
};
const _BucketbucketScopeEnumValueMap = {
  'onetime': 0,
  'daily': 1,
  'all': 2,
};
const _BucketbucketScopeValueEnumMap = {
  0: BucketScope.onetime,
  1: BucketScope.daily,
  2: BucketScope.all,
};

Id _bucketGetId(Bucket object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _bucketGetLinks(Bucket object) {
  return [];
}

void _bucketAttach(IsarCollection<dynamic> col, Id id, Bucket object) {
  object.id = id;
}

extension BucketQueryWhereSort on QueryBuilder<Bucket, Bucket, QWhere> {
  QueryBuilder<Bucket, Bucket, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BucketQueryWhere on QueryBuilder<Bucket, Bucket, QWhereClause> {
  QueryBuilder<Bucket, Bucket, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BucketQueryFilter on QueryBuilder<Bucket, Bucket, QFilterCondition> {
  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketCategoryEqualTo(
      BucketCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bucketCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketCategoryGreaterThan(
    BucketCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bucketCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketCategoryLessThan(
    BucketCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bucketCategory',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketCategoryBetween(
    BucketCategory lower,
    BucketCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bucketCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketScopeEqualTo(
      BucketScope value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bucketScope',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketScopeGreaterThan(
    BucketScope value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bucketScope',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketScopeLessThan(
    BucketScope value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bucketScope',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> bucketScopeBetween(
    BucketScope lower,
    BucketScope upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bucketScope',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> deadlineEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> deadlineGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> deadlineLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deadline',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> deadlineBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> isCompletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> streakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> streakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> streakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'streak',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> streakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'streak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tasks',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tasks',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tasks',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tasks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> tasksLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tasks',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeLeft',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'timeLeft',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'timeLeft',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeLeft',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> timeLeftIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'timeLeft',
        value: '',
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BucketQueryObject on QueryBuilder<Bucket, Bucket, QFilterCondition> {}

extension BucketQueryLinks on QueryBuilder<Bucket, Bucket, QFilterCondition> {}

extension BucketQuerySortBy on QueryBuilder<Bucket, Bucket, QSortBy> {
  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByBucketCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketCategory', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByBucketCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketCategory', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByBucketScope() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketScope', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByBucketScopeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketScope', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByTimeLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLeft', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByTimeLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLeft', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BucketQuerySortThenBy on QueryBuilder<Bucket, Bucket, QSortThenBy> {
  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByBucketCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketCategory', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByBucketCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketCategory', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByBucketScope() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketScope', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByBucketScopeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bucketScope', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deadline', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByStreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'streak', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByTimeLeft() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLeft', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByTimeLeftDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLeft', Sort.desc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Bucket, Bucket, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension BucketQueryWhereDistinct on QueryBuilder<Bucket, Bucket, QDistinct> {
  QueryBuilder<Bucket, Bucket, QDistinct> distinctByBucketCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bucketCategory');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByBucketScope() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bucketScope');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deadline');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByStreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'streak');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByTasks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tasks');
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByTimeLeft(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeLeft', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Bucket, Bucket, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension BucketQueryProperty on QueryBuilder<Bucket, Bucket, QQueryProperty> {
  QueryBuilder<Bucket, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Bucket, BucketCategory, QQueryOperations>
      bucketCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bucketCategory');
    });
  }

  QueryBuilder<Bucket, BucketScope, QQueryOperations> bucketScopeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bucketScope');
    });
  }

  QueryBuilder<Bucket, DateTime, QQueryOperations> deadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deadline');
    });
  }

  QueryBuilder<Bucket, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<Bucket, bool, QQueryOperations> isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<Bucket, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Bucket, int, QQueryOperations> streakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'streak');
    });
  }

  QueryBuilder<Bucket, List<int>, QQueryOperations> tasksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tasks');
    });
  }

  QueryBuilder<Bucket, String, QQueryOperations> timeLeftProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeLeft');
    });
  }

  QueryBuilder<Bucket, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
