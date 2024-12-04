import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/aggregate/entities/data_value_set.entity.dart';
import 'package:d2_touch/modules/engine/validation_rule/models/validation_rule_result.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/data_sets.sample.dart';
import '../sample/data_value_set.sample.dart';
import '../sample/data_value_set_import_summary.sample.dart';
import '../sample/data_value_set_upload.sample.dart';
import '../sample/validation_rule.sample.dart';
import 'aggregate_module_test.reflectable.dart';
import '../sample/database_sample.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: randomStrings(),
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataValueSets.json?dataSet=BfMAe6Itzgt&period=202201&orgUnit=bG0PlyD0iP3',
    (server) => server.reply(200, sampleDataValueSet),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  await d2.aggregateModule.dataValueSet
      .byDataSet('BfMAe6Itzgt')
      .byOrgUnit('bG0PlyD0iP3')
      .byPeriod("202201")
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataValueSet> dataValueSets =
      await d2.aggregateModule.dataValueSet.withDataValues().get();

  test('should store all incoming data value sets', () {
    expect(dataValueSets.length, 1);
    expect(dataValueSets[0].dataValues?.length, 31);
  });

  await d2.aggregateModule.dataValueSet
      .setData(DataValueSet(
          period: '202201',
          orgUnit: 'bG0PlyD0iP3',
          synced: false,
          dataSet: 'BfMAe6Itzgt',
          dirty: true))
      .save();

  DataValueSet updatedDataValueSet = await d2.aggregateModule.dataValueSet
      .withDataValues()
      .byId('BfMAe6Itzgt_bG0PlyD0iP3_202201')
      .getOne();

  test('should not replace existing local data', () {
    expect(updatedDataValueSet.completeDate, '2010-03-06T00:00:00.000+0000');
  });

  final DataValueSet dataValueSet = DataValueSet.fromJson(
      {...sampleDataValueSetUpload, 'dirty': true, "synced": false});

  await d2.aggregateModule.dataValueSet.setData(dataValueSet).save();

  dioAdapter.onPost('https://play.dhis2.org/2.35.11/api/dataValueSets',
      (server) => server.reply(409, sampleDataValueSetImportSummary),
      data: sampleDataValueSetUpload);

  List<DataValueSet>? dataValueSetUpload =
      await d2.aggregateModule.dataValueSet.upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfull import', () {
    final successImports = (dataValueSetUpload ?? [])
        .where((event) => event.synced == true)
        .toList();
    expect(successImports.length, 1);
  });

  final DataValueSet generatedDataValueSet = await d2
      .aggregateModule.dataValueSet
      .byDataSet('IpHINAT79UW')
      .byOrgUnit('fnei293faf')
      .byPeriod('201201')
      .create();

  final DataValueSet createdInstance = await d2.aggregateModule.dataValueSet
      .byId(generatedDataValueSet.id as String)
      .getOne();

  test('should return created data value set', () {
    expect(createdInstance.id, generatedDataValueSet.id);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataSets.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired,dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]&paging=false',
    (server) => server.reply(200, {
      "dataSets": [chunkedSampleDataSets['dataSets'][0]]
    }),
  );

  await d2.dataSetModule.dataSet.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/validationRules?dataSet=BfMAe6Itzgt&fields=id,name,displayName,created,lastUpdated,description,operator,instruction,displayInstruction,displayFormName,periodOffset,periodType,leftSide,rightSide',
    (server) => server.reply(200, sampleValidationRule),
  );

  await d2.dataSetModule.validationRule.download(
      (progress, complete) => {print(progress.message)},
      dioTestClient: dio);

  final DataValueSet dataValueSetForValidation = await d2
      .aggregateModule.dataValueSet
      .byDataSet('BfMAe6Itzgt')
      .byOrgUnit('orgunitid')
      .byPeriod('202001')
      .create();

  await d2.aggregateModule.dataValue
      .setData(DataValue(
          dataElement: 'YtbsuPPo010',
          attributeOptionCombo: '',
          categoryOptionCombo: 'Prlt0C1RF0s',
          dataValueSet: dataValueSetForValidation.id,
          value: '2',
          synced: false,
          dirty: true))
      .save();

  await d2.aggregateModule.dataValue
      .setData(DataValue(
          dataElement: 'GCGfEY82Wz6',
          attributeOptionCombo: '',
          categoryOptionCombo: 'Prlt0C1RF0s',
          dataValueSet: dataValueSetForValidation.id,
          value: '3',
          synced: false,
          dirty: true))
      .save();

  ValidationRuleResult validationRuleResult =
      await d2.engine.validation.execute(
    dataValueSet: dataValueSetForValidation,
    dataSet: 'BfMAe6Itzgt',
  );

  test('should return validation rule actions', () {
    expect(validationRuleResult.validationRuleActions.length, 1);
  });

  await d2.dispose();
}
