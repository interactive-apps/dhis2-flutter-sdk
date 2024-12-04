import 'package:d2_touch/core/annotations/column.annotation.dart';
import 'package:d2_touch/core/annotations/entity.annotation.dart';
import 'package:d2_touch/core/annotations/reflectable.annotation.dart';
import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:reflectable/reflectable.dart';
import 'package:sqflite/sqflite.dart';

class DataSetQuery extends BaseQuery<DataSet> {
  DataSetQuery({Database? database}) : super(database: database);

  DataSetQuery withSections() {
    final dataSetSection =
        Repository<DataSetSection>(database: database as Database);

    final Column? relationColumn = dataSetSection.columns.firstWhere((column) =>
        column.relation?.referencedEntity?.tableName == this.tableName);

    if (relationColumn != null) {
      ColumnRelation relation = ColumnRelation(
          referencedColumn: relationColumn.relation?.attributeName,
          attributeName: 'sections',
          primaryKey: this.primaryKey?.name,
          relationType: RelationType.OneToMany,
          referencedEntity: Entity.getEntityDefinition(
              AnnotationReflectable.reflectType(DataSetSection) as ClassMirror),
          referencedEntityColumns: Entity.getEntityColumns(
              AnnotationReflectable.reflectType(DataSetSection) as ClassMirror,
              false));

      this.relations.add(relation);
    }

    return this;
  }

  @override
  Future<String> dhisUrl({List<String>? fields}) {
    final apiFilter =
        QueryFilter.getApiFilters(this.repository.columns, this.query.filters);
    if ((fields ?? []).isNotEmpty) {
      return Future.value(
          'dataSets.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=${fields?.join(',')}&paging=false');
    }
    return Future.value(
        'dataSets.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired,dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,categoryCombo[id,name,displayName,categoryOptionCombos[id,code,name,displayName,displayFormName,ignoreApproval,created,lastUpdated]],optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]],sections[id,name,displayName,sortOrder,showRowTotals,greyedFields,created,lastUpdated,dataElements[id~rename(dataElement)]]&paging=false');
  }
}
