// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMeasurementCollection on Isar {
  IsarCollection<Measurement> get measurements => this.collection();
}

const MeasurementSchema = CollectionSchema(
  name: r'Measurement',
  id: -8666549389298478361,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'symbol': PropertySchema(
      id: 1,
      name: r'symbol',
      type: IsarType.string,
    ),
    r'system': PropertySchema(
      id: 2,
      name: r'system',
      type: IsarType.string,
    ),
    r'unitOf': PropertySchema(
      id: 3,
      name: r'unitOf',
      type: IsarType.string,
    )
  },
  estimateSize: _measurementEstimateSize,
  serialize: _measurementSerialize,
  deserialize: _measurementDeserialize,
  deserializeProp: _measurementDeserializeProp,
  idName: r'id',
  indexes: {
    r'symbol': IndexSchema(
      id: -7050953154795990356,
      name: r'symbol',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'symbol',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _measurementGetId,
  getLinks: _measurementGetLinks,
  attach: _measurementAttach,
  version: '3.1.0+1',
);

int _measurementEstimateSize(
  Measurement object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.symbol.length * 3;
  bytesCount += 3 + object.system.length * 3;
  bytesCount += 3 + object.unitOf.length * 3;
  return bytesCount;
}

void _measurementSerialize(
  Measurement object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.symbol);
  writer.writeString(offsets[2], object.system);
  writer.writeString(offsets[3], object.unitOf);
}

Measurement _measurementDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Measurement();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.symbol = reader.readString(offsets[1]);
  object.system = reader.readString(offsets[2]);
  object.unitOf = reader.readString(offsets[3]);
  return object;
}

P _measurementDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _measurementGetId(Measurement object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _measurementGetLinks(Measurement object) {
  return [];
}

void _measurementAttach(
    IsarCollection<dynamic> col, Id id, Measurement object) {
  object.id = id;
}

extension MeasurementQueryWhereSort
    on QueryBuilder<Measurement, Measurement, QWhere> {
  QueryBuilder<Measurement, Measurement, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MeasurementQueryWhere
    on QueryBuilder<Measurement, Measurement, QWhereClause> {
  QueryBuilder<Measurement, Measurement, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> idBetween(
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

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> symbolEqualTo(
      String symbol) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'symbol',
        value: [symbol],
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterWhereClause> symbolNotEqualTo(
      String symbol) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [],
              upper: [symbol],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [symbol],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [symbol],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'symbol',
              lower: [],
              upper: [symbol],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MeasurementQueryFilter
    on QueryBuilder<Measurement, Measurement, QFilterCondition> {
  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      symbolGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'symbol',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      symbolStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> symbolMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symbol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      systemGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'system',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      systemStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'system',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> systemMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'system',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      systemIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'system',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      systemIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'system',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      unitOfGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitOf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      unitOfStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unitOf',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition> unitOfMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unitOf',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      unitOfIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitOf',
        value: '',
      ));
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterFilterCondition>
      unitOfIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unitOf',
        value: '',
      ));
    });
  }
}

extension MeasurementQueryObject
    on QueryBuilder<Measurement, Measurement, QFilterCondition> {}

extension MeasurementQueryLinks
    on QueryBuilder<Measurement, Measurement, QFilterCondition> {}

extension MeasurementQuerySortBy
    on QueryBuilder<Measurement, Measurement, QSortBy> {
  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortBySystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'system', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortBySystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'system', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortByUnitOf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitOf', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> sortByUnitOfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitOf', Sort.desc);
    });
  }
}

extension MeasurementQuerySortThenBy
    on QueryBuilder<Measurement, Measurement, QSortThenBy> {
  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenBySystem() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'system', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenBySystemDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'system', Sort.desc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenByUnitOf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitOf', Sort.asc);
    });
  }

  QueryBuilder<Measurement, Measurement, QAfterSortBy> thenByUnitOfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unitOf', Sort.desc);
    });
  }
}

extension MeasurementQueryWhereDistinct
    on QueryBuilder<Measurement, Measurement, QDistinct> {
  QueryBuilder<Measurement, Measurement, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Measurement, Measurement, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Measurement, Measurement, QDistinct> distinctBySystem(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'system', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Measurement, Measurement, QDistinct> distinctByUnitOf(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unitOf', caseSensitive: caseSensitive);
    });
  }
}

extension MeasurementQueryProperty
    on QueryBuilder<Measurement, Measurement, QQueryProperty> {
  QueryBuilder<Measurement, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Measurement, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Measurement, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }

  QueryBuilder<Measurement, String, QQueryOperations> systemProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'system');
    });
  }

  QueryBuilder<Measurement, String, QQueryOperations> unitOfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unitOf');
    });
  }
}
