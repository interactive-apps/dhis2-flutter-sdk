import 'package:d2_touch/modules/metadata/dataset/queries/data_element_category_option_combo.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_element_option.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_section.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_section_data_element.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set_section_greyed_field.query.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/validation_rule.query.dart';
import 'package:sqflite/sqflite.dart';

class DataSetModule {
  Database? database;
  DataSetModule({this.database, String? locale});
  static createTables({required Database database}) async {
    await DataSetQuery(database: database).createTable();
    await DataSetElementQuery(database: database).createTable();
    await DataSetElementOptionQuery(database: database).createTable();
    await DataSetSectionQuery(database: database).createTable();
    await DataSetSectionDataElementQuery(database: database).createTable();
    await DataSetSectionGreyedFieldQuery(database: database).createTable();
    await ValidationRuleQuery(database: database).createTable();
    await DataElementCategoryOptionComboQuery(database: database).createTable();
  }

  DataSetQuery get dataSet => DataSetQuery(database: database);

  DataSetElementQuery get dataSetElement =>
      DataSetElementQuery(database: database);

  DataSetElementOptionQuery get dataSetElementOption =>
      DataSetElementOptionQuery(database: database);

  DataSetSectionQuery get dataSetSection =>
      DataSetSectionQuery(database: database);

  DataSetSectionDataElementQuery get dataSetSectionDataElement =>
      DataSetSectionDataElementQuery(database: database);

  DataSetSectionGreyedFieldQuery get dataSetSectionGreyedField =>
      DataSetSectionGreyedFieldQuery(database: database);

  ValidationRuleQuery get validationRule =>
      ValidationRuleQuery(database: database);

  DataElementCategoryOptionComboQuery get categoryOptionCombo =>
      DataElementCategoryOptionComboQuery(database: database);
}
