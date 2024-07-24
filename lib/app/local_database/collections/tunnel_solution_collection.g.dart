// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tunnel_solution_collection.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTunnelSolutionCollectionCollection on Isar {
  IsarCollection<TunnelSolutionCollection> get tunnelSolutionCollections =>
      this.collection();
}

const TunnelSolutionCollectionSchema = CollectionSchema(
  name: r'TunnelSolutionCollection',
  id: -6241848136364050731,
  properties: {
    r'positionLatitude': PropertySchema(
      id: 0,
      name: r'positionLatitude',
      type: IsarType.double,
    ),
    r'positionLongitude': PropertySchema(
      id: 1,
      name: r'positionLongitude',
      type: IsarType.double,
    ),
    r'timeStamp': PropertySchema(
      id: 2,
      name: r'timeStamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _tunnelSolutionCollectionEstimateSize,
  serialize: _tunnelSolutionCollectionSerialize,
  deserialize: _tunnelSolutionCollectionDeserialize,
  deserializeProp: _tunnelSolutionCollectionDeserializeProp,
  idName: r'tSolutionId',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tunnelSolutionCollectionGetId,
  getLinks: _tunnelSolutionCollectionGetLinks,
  attach: _tunnelSolutionCollectionAttach,
  version: '3.1.0+1',
);

int _tunnelSolutionCollectionEstimateSize(
  TunnelSolutionCollection object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _tunnelSolutionCollectionSerialize(
  TunnelSolutionCollection object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.positionLatitude);
  writer.writeDouble(offsets[1], object.positionLongitude);
  writer.writeDateTime(offsets[2], object.timeStamp);
}

TunnelSolutionCollection _tunnelSolutionCollectionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TunnelSolutionCollection(
    positionLatitude: reader.readDouble(offsets[0]),
    positionLongitude: reader.readDouble(offsets[1]),
    timeStamp: reader.readDateTime(offsets[2]),
  );
  return object;
}

P _tunnelSolutionCollectionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tunnelSolutionCollectionGetId(TunnelSolutionCollection object) {
  return object.tSolutionId;
}

List<IsarLinkBase<dynamic>> _tunnelSolutionCollectionGetLinks(
    TunnelSolutionCollection object) {
  return [];
}

void _tunnelSolutionCollectionAttach(
    IsarCollection<dynamic> col, Id id, TunnelSolutionCollection object) {}

extension TunnelSolutionCollectionQueryWhereSort on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QWhere> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterWhere>
      anyTSolutionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TunnelSolutionCollectionQueryWhere on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QWhereClause> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterWhereClause> tSolutionIdEqualTo(Id tSolutionId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: tSolutionId,
        upper: tSolutionId,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterWhereClause> tSolutionIdNotEqualTo(Id tSolutionId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: tSolutionId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: tSolutionId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(
                  lower: tSolutionId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: tSolutionId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
          QAfterWhereClause>
      tSolutionIdGreaterThan(Id tSolutionId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: tSolutionId, includeLower: include),
      );
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
          QAfterWhereClause>
      tSolutionIdLessThan(Id tSolutionId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: tSolutionId, includeUpper: include),
      );
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterWhereClause> tSolutionIdBetween(
    Id lowerTSolutionId,
    Id upperTSolutionId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerTSolutionId,
        includeLower: includeLower,
        upper: upperTSolutionId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TunnelSolutionCollectionQueryFilter on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QFilterCondition> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLatitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLatitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLatitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionLatitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLatitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionLatitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLongitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'positionLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLongitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'positionLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLongitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'positionLongitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> positionLongitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'positionLongitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> tSolutionIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tSolutionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> tSolutionIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tSolutionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> tSolutionIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tSolutionId',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> tSolutionIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tSolutionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> timeStampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> timeStampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> timeStampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeStamp',
        value: value,
      ));
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection,
      QAfterFilterCondition> timeStampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeStamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TunnelSolutionCollectionQueryObject on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QFilterCondition> {}

extension TunnelSolutionCollectionQueryLinks on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QFilterCondition> {}

extension TunnelSolutionCollectionQuerySortBy on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QSortBy> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByPositionLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLatitude', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByPositionLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLatitude', Sort.desc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByPositionLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLongitude', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByPositionLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLongitude', Sort.desc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      sortByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }
}

extension TunnelSolutionCollectionQuerySortThenBy on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QSortThenBy> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByPositionLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLatitude', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByPositionLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLatitude', Sort.desc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByPositionLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLongitude', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByPositionLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'positionLongitude', Sort.desc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByTSolutionId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tSolutionId', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByTSolutionIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tSolutionId', Sort.desc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.asc);
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QAfterSortBy>
      thenByTimeStampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeStamp', Sort.desc);
    });
  }
}

extension TunnelSolutionCollectionQueryWhereDistinct on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QDistinct> {
  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QDistinct>
      distinctByPositionLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionLatitude');
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QDistinct>
      distinctByPositionLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'positionLongitude');
    });
  }

  QueryBuilder<TunnelSolutionCollection, TunnelSolutionCollection, QDistinct>
      distinctByTimeStamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeStamp');
    });
  }
}

extension TunnelSolutionCollectionQueryProperty on QueryBuilder<
    TunnelSolutionCollection, TunnelSolutionCollection, QQueryProperty> {
  QueryBuilder<TunnelSolutionCollection, int, QQueryOperations>
      tSolutionIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tSolutionId');
    });
  }

  QueryBuilder<TunnelSolutionCollection, double, QQueryOperations>
      positionLatitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionLatitude');
    });
  }

  QueryBuilder<TunnelSolutionCollection, double, QQueryOperations>
      positionLongitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'positionLongitude');
    });
  }

  QueryBuilder<TunnelSolutionCollection, DateTime, QQueryOperations>
      timeStampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeStamp');
    });
  }
}
