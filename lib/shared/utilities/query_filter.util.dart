import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/shared/utilities/query_filter_condition.util.dart';

class QueryFilter {
  String attribute;
  QueryCondition condition;
  dynamic value;
  String? filterCondition;
  String? key;
  String? keyValue;
  QueryFilter(
      {required this.attribute,
      required this.condition,
      required this.value,
      this.filterCondition,
      this.key,
      this.keyValue});

  static String? getWhereParameters(
      List<Column> columns, List<QueryFilter>? filters) {
    if (filters == null) {
      return null;
    }

    final whereParams = filters.map((filter) {
      final Column attributeColumn = columns
          .lastWhere((column) => column.attributeName == filter.attribute);

      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return '${filter.attribute} IN (${values.map((value) => '${QueryFilter.getTypedValue(attributeColumn, value)}').join(',')})';

        case QueryCondition.Equal:
          return '${filter.attribute} = ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.Like:
          return '${filter.attribute} LIKE ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.Ilike:
          return '${filter.attribute} LIKE ${QueryFilter.getTypedValue(attributeColumn, filter.value, isLikeFilter: true, filterCondition: filter.filterCondition, key: filter.key, keyValue: filter.keyValue)}';

        case QueryCondition.LessThan:
          return '${filter.attribute} < ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.LessThanOrEqualTo:
          return '${filter.attribute} <= ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';
        case QueryCondition.GreaterThan:
          return '${filter.attribute} > ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';

        case QueryCondition.GreaterThanOrEqualTo:
          return '${filter.attribute} >= ${QueryFilter.getTypedValue(attributeColumn, filter.value)}';
        default:
          return null;
      }
    }).where((filter) => filter != null);

    return whereParams.length > 0 ? whereParams.join(' AND ') : null;
  }

  static String? getApiFilters(
      List<Column> columns, List<QueryFilter>? filters) {
    if (filters == null) {
      return null;
    }

    final whereParams = filters.map((filter) {
      final Column attributeColumn = columns
          .lastWhere((column) => column.attributeName == filter.attribute);

      switch (filter.condition) {
        case QueryCondition.In:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          return 'filter=${filter.attribute}${attributeColumn.relation?.referencedColumn != null ? '.${attributeColumn.relation?.referencedColumn}' : ''}:in:[${values.join(',')}]';

        case QueryCondition.Equal:
          return 'filter=${filter.attribute}:eq:${filter.value}';

        case QueryCondition.Like:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          final ilikeFilters = values
              .map((valueItem) => 'filter=${filter.attribute}:like:$valueItem')
              .toList();
          return ilikeFilters.join('&');

        case QueryCondition.Ilike:
          final List<String> values =
              filter.value is List ? filter.value : [filter.value];
          final ilikeFilters = values
              .map((valueItem) => 'filter=${filter.attribute}:ilike:$valueItem')
              .toList();
          return ilikeFilters.join('&');

        case QueryCondition.LessThan:
          return 'filter=${filter.attribute}:lt:${filter.value}';

        case QueryCondition.LessThanOrEqualTo:
          return 'filter=${filter.attribute}:lte:${filter.value}';
        case QueryCondition.GreaterThan:
          return 'filter=${filter.attribute}:gt:${filter.value}';

        case QueryCondition.GreaterThanOrEqualTo:
          return 'filter=${filter.attribute}:gte:${filter.value}';
        default:
          return null;
      }
    }).where((filter) => filter != null);

    return whereParams.length > 0 ? whereParams.join(' AND ') : null;
  }

  static getTypedValue(Column attributeColumn, dynamic value,
      {bool? isLikeFilter,
      String? filterCondition,
      String? key,
      String? keyValue}) {
    switch (attributeColumn.columnType) {
      case 'TEXT':
        return getTextFiler(value,
            isLikeFilter: isLikeFilter,
            filterCondition: filterCondition,
            key: key,
            keyValue: keyValue);
      case 'BOOLEAN':
        return value == true ? 1 : 0;
      default:
        return value;
    }
  }

  static getTextFiler(dynamic value,
      {bool? isLikeFilter,
      String? filterCondition,
      String? key,
      String? keyValue}) {
    if (isLikeFilter == false || isLikeFilter == null) {
      return '"$value"';
    }
    if (key != null && keyValue != null) {
      return filterWithAdditionalAttributes(value,
          key: key, keyValue: keyValue);
    } else {
      switch (filterCondition) {
        case 'startsWith':
          return '"$value%"';
        case 'endsWith':
          return '"%$value"';
        case 'includes':
          return '"%$value%"';
        default:
          return '"%$value%"';
      }
    }
  }
}

filterWithAdditionalAttributes(dynamic value,
    {String? filterCondition, String? key, String? keyValue}) {
  switch (filterCondition) {
    case 'startsWith':
      return '"$value%" AND $key = "$keyValue"';
    case 'endsWith':
      return '"%$value" AND "$key" = "$keyValue"';
    case 'includes':
      return '"%$value%" AND $key = "$keyValue"';
    default:
      return '"%$value%" AND $key = "$keyValue"';
  }
}
