// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCurrencyProfileCollection on Isar {
  IsarCollection<CurrencyProfile> get currencyProfiles => this.collection();
}

const CurrencyProfileSchema = CollectionSchema(
  name: r'CurrencyProfile',
  id: 3350983064427081100,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'shortForm': PropertySchema(
      id: 1,
      name: r'shortForm',
      type: IsarType.string,
    ),
    r'symbol': PropertySchema(
      id: 2,
      name: r'symbol',
      type: IsarType.string,
    )
  },
  estimateSize: _currencyProfileEstimateSize,
  serialize: _currencyProfileSerialize,
  deserialize: _currencyProfileDeserialize,
  deserializeProp: _currencyProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'shortForm': IndexSchema(
      id: 8413192256733782512,
      name: r'shortForm',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'shortForm',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _currencyProfileGetId,
  getLinks: _currencyProfileGetLinks,
  attach: _currencyProfileAttach,
  version: '3.1.0+1',
);

int _currencyProfileEstimateSize(
  CurrencyProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.shortForm.length * 3;
  bytesCount += 3 + object.symbol.length * 3;
  return bytesCount;
}

void _currencyProfileSerialize(
  CurrencyProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeString(offsets[1], object.shortForm);
  writer.writeString(offsets[2], object.symbol);
}

CurrencyProfile _currencyProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CurrencyProfile();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.shortForm = reader.readString(offsets[1]);
  object.symbol = reader.readString(offsets[2]);
  return object;
}

P _currencyProfileDeserializeProp<P>(
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _currencyProfileGetId(CurrencyProfile object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _currencyProfileGetLinks(CurrencyProfile object) {
  return [];
}

void _currencyProfileAttach(
    IsarCollection<dynamic> col, Id id, CurrencyProfile object) {
  object.id = id;
}

extension CurrencyProfileByIndex on IsarCollection<CurrencyProfile> {
  Future<CurrencyProfile?> getByShortForm(String shortForm) {
    return getByIndex(r'shortForm', [shortForm]);
  }

  CurrencyProfile? getByShortFormSync(String shortForm) {
    return getByIndexSync(r'shortForm', [shortForm]);
  }

  Future<bool> deleteByShortForm(String shortForm) {
    return deleteByIndex(r'shortForm', [shortForm]);
  }

  bool deleteByShortFormSync(String shortForm) {
    return deleteByIndexSync(r'shortForm', [shortForm]);
  }

  Future<List<CurrencyProfile?>> getAllByShortForm(
      List<String> shortFormValues) {
    final values = shortFormValues.map((e) => [e]).toList();
    return getAllByIndex(r'shortForm', values);
  }

  List<CurrencyProfile?> getAllByShortFormSync(List<String> shortFormValues) {
    final values = shortFormValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'shortForm', values);
  }

  Future<int> deleteAllByShortForm(List<String> shortFormValues) {
    final values = shortFormValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'shortForm', values);
  }

  int deleteAllByShortFormSync(List<String> shortFormValues) {
    final values = shortFormValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'shortForm', values);
  }

  Future<Id> putByShortForm(CurrencyProfile object) {
    return putByIndex(r'shortForm', object);
  }

  Id putByShortFormSync(CurrencyProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'shortForm', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByShortForm(List<CurrencyProfile> objects) {
    return putAllByIndex(r'shortForm', objects);
  }

  List<Id> putAllByShortFormSync(List<CurrencyProfile> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'shortForm', objects, saveLinks: saveLinks);
  }
}

extension CurrencyProfileQueryWhereSort
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QWhere> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CurrencyProfileQueryWhere
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QWhereClause> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause> idBetween(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause>
      shortFormEqualTo(String shortForm) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'shortForm',
        value: [shortForm],
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterWhereClause>
      shortFormNotEqualTo(String shortForm) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortForm',
              lower: [],
              upper: [shortForm],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortForm',
              lower: [shortForm],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortForm',
              lower: [shortForm],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'shortForm',
              lower: [],
              upper: [shortForm],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CurrencyProfileQueryFilter
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QFilterCondition> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameEqualTo(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameBetween(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortForm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortForm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortForm',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortForm',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      shortFormIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortForm',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolEqualTo(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolLessThan(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolBetween(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolEndsWith(
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

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'symbol',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'symbol',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'symbol',
        value: '',
      ));
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterFilterCondition>
      symbolIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'symbol',
        value: '',
      ));
    });
  }
}

extension CurrencyProfileQueryObject
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QFilterCondition> {}

extension CurrencyProfileQueryLinks
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QFilterCondition> {}

extension CurrencyProfileQuerySortBy
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QSortBy> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      sortByShortForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortForm', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      sortByShortFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortForm', Sort.desc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> sortBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      sortBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }
}

extension CurrencyProfileQuerySortThenBy
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QSortThenBy> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      thenByShortForm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortForm', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      thenByShortFormDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortForm', Sort.desc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy> thenBySymbol() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.asc);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QAfterSortBy>
      thenBySymbolDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'symbol', Sort.desc);
    });
  }
}

extension CurrencyProfileQueryWhereDistinct
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QDistinct> {
  QueryBuilder<CurrencyProfile, CurrencyProfile, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QDistinct> distinctByShortForm(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortForm', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CurrencyProfile, CurrencyProfile, QDistinct> distinctBySymbol(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'symbol', caseSensitive: caseSensitive);
    });
  }
}

extension CurrencyProfileQueryProperty
    on QueryBuilder<CurrencyProfile, CurrencyProfile, QQueryProperty> {
  QueryBuilder<CurrencyProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CurrencyProfile, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CurrencyProfile, String, QQueryOperations> shortFormProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortForm');
    });
  }

  QueryBuilder<CurrencyProfile, String, QQueryOperations> symbolProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'symbol');
    });
  }
}
