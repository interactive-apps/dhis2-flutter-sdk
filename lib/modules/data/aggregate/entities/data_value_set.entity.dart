import 'dart:convert';

import 'package:d2_touch/core/annotations/index.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/aggregate/models/data_value_set_import_summary.dart';
import 'package:d2_touch/shared/entities/identifiable.entity.dart';
import 'package:d2_touch/shared/utilities/object.util.dart';

@AnnotationReflectable
@Entity(tableName: 'datavalueset', apiResourceName: 'dataValueSets')
class DataValueSet extends IdentifiableEntity {
  @Column(type: ColumnType.TEXT)
  String period;

  @Column(type: ColumnType.TEXT)
  String orgUnit;

  @Column(nullable: true)
  String? completeDate;

  @Column(type: ColumnType.BOOLEAN, nullable: true)
  bool? synced;

  @Column(nullable: true)
  bool? syncFailed;

  @Column(nullable: true, type: ColumnType.TEXT)
  DataValueSetImportSummary? lastSyncSummary;

  @Column(nullable: true)
  String? lastSyncDate;

  @Column(type: ColumnType.TEXT)
  String dataSet;

  @Column(type: ColumnType.TEXT, nullable: true)
  String? attributeOptionCombo;

  @OneToMany(table: DataValue)
  List<DataValue>? dataValues;

  DataValueSet(
      {String? id,
      String? created,
      String? lastUpdated,
      String? name,
      required this.period,
      required this.orgUnit,
      required this.synced,
      this.syncFailed,
      this.lastSyncSummary,
      this.lastSyncDate,
      this.dataValues,
      this.completeDate,
      required this.dataSet,
      required dirty})
      : super(
            id: id,
            name: name,
            created: created,
            lastUpdated: lastUpdated,
            dirty: dirty) {
    this.id = '${this.dataSet}_${this.orgUnit}_${this.period}';
    this.name = this.name ?? this.id;
  }

  factory DataValueSet.fromJson(Map<String, dynamic> json) {
    final id =
        json['id'] ?? '${json['dataSet']}_${json['orgUnit']}_${json['period']}';

    final DataValueSetImportSummary? lastSyncSummary =
        DataValueSet.getDataValueSetImportSummary(json['lastSyncSummary']);

    final dataValues = json['dataValues'];

    return DataValueSet(
        id: id,
        name: json['name'] ?? id,
        created: json['created'],
        completeDate: json['completeDate'],
        lastUpdated: json['lastUpdated'],
        dirty: json['dirty'],
        synced: json['synced'],
        syncFailed: json['syncFailed'],
        lastSyncSummary: lastSyncSummary,
        lastSyncDate: json['lastSyncDate'],
        period: json['period'],
        orgUnit: json['orgUnit'],
        dataSet: json['dataSet'],
        dataValues: dataValues is List<DataValue>
            ? dataValues
            : List<dynamic>.from(dataValues ?? [])
                .map((dataValue) => DataValue.fromJson(
                    {...dataValue, 'dirty': json['dirty'], 'dataValueSet': id}))
                .toList());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdated'] = this.lastUpdated;
    data['id'] = this.id;
    data['created'] = this.created;
    data['completeDate'] = this.completeDate;
    data['name'] = this.name;
    data['dirty'] = this.dirty;
    data['synced'] = this.synced;
    data['syncFailed'] = this.syncFailed;
    data['lastSyncSummary'] = this.lastSyncSummary != null
        ? jsonEncode(
            (this.lastSyncSummary as DataValueSetImportSummary).responseSummary)
        : null;
    data['lastSyncDate'] = this.lastSyncDate;
    data['period'] = this.period;
    data['orgUnit'] = this.orgUnit;
    data['dataSet'] = this.dataSet;
    data['dataValues'] = this.dataValues;

    return data;
  }

  static DataValueSetImportSummary? getDataValueSetImportSummary(
      String? lastSyncSummary) {
    if (lastSyncSummary == null) {
      return null;
    }

    DataValueSetImportSummary? importSummary = null;
    try {
      importSummary =
          DataValueSetImportSummary.fromJson(jsonDecode(lastSyncSummary));
    } catch (e) {}

    return importSummary;
  }

  static toUpload(DataValueSet dataValueSet) {
    return ObjectUtil.removeNull({
      "dataSet": dataValueSet.dataSet,
      "completeDate": dataValueSet.completeDate,
      "period": dataValueSet.period,
      "orgUnit": dataValueSet.orgUnit,
      "attributeOptionCombo": dataValueSet.attributeOptionCombo,
      "dataValues": (dataValueSet.dataValues ?? [])
          .map((dataValue) => DataValue.toUpload(dataValue))
          .toList()
    });
  }
}
