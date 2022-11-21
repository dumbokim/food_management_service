// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adoption.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetAdoptionCollection on Isar {
  IsarCollection<Adoption> get adoptions => this.collection();
}

const AdoptionSchema = CollectionSchema(
  name: r'Adoption',
  id: -4942730727844328074,
  properties: {
    r'adoptedDate': PropertySchema(
      id: 0,
      name: r'adoptedDate',
      type: IsarType.long,
    ),
    r'restaurant': PropertySchema(
      id: 1,
      name: r'restaurant',
      type: IsarType.string,
    ),
    r'restaurantId': PropertySchema(
      id: 2,
      name: r'restaurantId',
      type: IsarType.long,
    )
  },
  estimateSize: _adoptionEstimateSize,
  serialize: _adoptionSerialize,
  deserialize: _adoptionDeserialize,
  deserializeProp: _adoptionDeserializeProp,
  idName: r'id',
  indexes: {
    r'restaurantId': IndexSchema(
      id: -5575443496065107470,
      name: r'restaurantId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'restaurantId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'adoptedDate': IndexSchema(
      id: 2772238706446557116,
      name: r'adoptedDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'adoptedDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _adoptionGetId,
  getLinks: _adoptionGetLinks,
  attach: _adoptionAttach,
  version: '3.0.5',
);

int _adoptionEstimateSize(
  Adoption object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.restaurant;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _adoptionSerialize(
  Adoption object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.adoptedDate);
  writer.writeString(offsets[1], object.restaurant);
  writer.writeLong(offsets[2], object.restaurantId);
}

Adoption _adoptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Adoption();
  object.adoptedDate = reader.readLongOrNull(offsets[0]);
  object.id = id;
  object.restaurant = reader.readStringOrNull(offsets[1]);
  object.restaurantId = reader.readLongOrNull(offsets[2]);
  return object;
}

P _adoptionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _adoptionGetId(Adoption object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _adoptionGetLinks(Adoption object) {
  return [];
}

void _adoptionAttach(IsarCollection<dynamic> col, Id id, Adoption object) {
  object.id = id;
}

extension AdoptionQueryWhereSort on QueryBuilder<Adoption, Adoption, QWhere> {
  QueryBuilder<Adoption, Adoption, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhere> anyRestaurantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'restaurantId'),
      );
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhere> anyAdoptedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'adoptedDate'),
      );
    });
  }
}

extension AdoptionQueryWhere on QueryBuilder<Adoption, Adoption, QWhereClause> {
  QueryBuilder<Adoption, Adoption, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> idBetween(
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

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'restaurantId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'restaurantId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdEqualTo(
      int? restaurantId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'restaurantId',
        value: [restaurantId],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdNotEqualTo(
      int? restaurantId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'restaurantId',
              lower: [],
              upper: [restaurantId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'restaurantId',
              lower: [restaurantId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'restaurantId',
              lower: [restaurantId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'restaurantId',
              lower: [],
              upper: [restaurantId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdGreaterThan(
    int? restaurantId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'restaurantId',
        lower: [restaurantId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdLessThan(
    int? restaurantId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'restaurantId',
        lower: [],
        upper: [restaurantId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> restaurantIdBetween(
    int? lowerRestaurantId,
    int? upperRestaurantId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'restaurantId',
        lower: [lowerRestaurantId],
        includeLower: includeLower,
        upper: [upperRestaurantId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'adoptedDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'adoptedDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateEqualTo(
      int? adoptedDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'adoptedDate',
        value: [adoptedDate],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateNotEqualTo(
      int? adoptedDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'adoptedDate',
              lower: [],
              upper: [adoptedDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'adoptedDate',
              lower: [adoptedDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'adoptedDate',
              lower: [adoptedDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'adoptedDate',
              lower: [],
              upper: [adoptedDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateGreaterThan(
    int? adoptedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'adoptedDate',
        lower: [adoptedDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateLessThan(
    int? adoptedDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'adoptedDate',
        lower: [],
        upper: [adoptedDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterWhereClause> adoptedDateBetween(
    int? lowerAdoptedDate,
    int? upperAdoptedDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'adoptedDate',
        lower: [lowerAdoptedDate],
        includeLower: includeLower,
        upper: [upperAdoptedDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AdoptionQueryFilter
    on QueryBuilder<Adoption, Adoption, QFilterCondition> {
  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> adoptedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'adoptedDate',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      adoptedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'adoptedDate',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> adoptedDateEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adoptedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      adoptedDateGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adoptedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> adoptedDateLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adoptedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> adoptedDateBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adoptedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> idGreaterThan(
    Id value, {
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

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> idLessThan(
    Id value, {
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

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
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

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'restaurant',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      restaurantIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'restaurant',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restaurant',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'restaurant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'restaurant',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restaurant',
        value: '',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      restaurantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'restaurant',
        value: '',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'restaurantId',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      restaurantIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'restaurantId',
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restaurantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition>
      restaurantIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restaurantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restaurantId',
        value: value,
      ));
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterFilterCondition> restaurantIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restaurantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AdoptionQueryObject
    on QueryBuilder<Adoption, Adoption, QFilterCondition> {}

extension AdoptionQueryLinks
    on QueryBuilder<Adoption, Adoption, QFilterCondition> {}

extension AdoptionQuerySortBy on QueryBuilder<Adoption, Adoption, QSortBy> {
  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByAdoptedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adoptedDate', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByAdoptedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adoptedDate', Sort.desc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByRestaurant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurant', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByRestaurantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurant', Sort.desc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByRestaurantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantId', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> sortByRestaurantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantId', Sort.desc);
    });
  }
}

extension AdoptionQuerySortThenBy
    on QueryBuilder<Adoption, Adoption, QSortThenBy> {
  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByAdoptedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adoptedDate', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByAdoptedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adoptedDate', Sort.desc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByRestaurant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurant', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByRestaurantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurant', Sort.desc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByRestaurantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantId', Sort.asc);
    });
  }

  QueryBuilder<Adoption, Adoption, QAfterSortBy> thenByRestaurantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restaurantId', Sort.desc);
    });
  }
}

extension AdoptionQueryWhereDistinct
    on QueryBuilder<Adoption, Adoption, QDistinct> {
  QueryBuilder<Adoption, Adoption, QDistinct> distinctByAdoptedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adoptedDate');
    });
  }

  QueryBuilder<Adoption, Adoption, QDistinct> distinctByRestaurant(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restaurant', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Adoption, Adoption, QDistinct> distinctByRestaurantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restaurantId');
    });
  }
}

extension AdoptionQueryProperty
    on QueryBuilder<Adoption, Adoption, QQueryProperty> {
  QueryBuilder<Adoption, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Adoption, int?, QQueryOperations> adoptedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adoptedDate');
    });
  }

  QueryBuilder<Adoption, String?, QQueryOperations> restaurantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restaurant');
    });
  }

  QueryBuilder<Adoption, int?, QQueryOperations> restaurantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restaurantId');
    });
  }
}
