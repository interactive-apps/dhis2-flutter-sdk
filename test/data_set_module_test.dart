import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_element_option.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/data_element_category_option_combo.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/data_sets.sample.dart';
import 'data_set_module_test.reflectable.dart';
import '../sample/database_sample.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});
  initializeReflectable();
  sqfliteFfiInit();

  var sharedPreferenceInstance = await SharedPreferences.getInstance();

  final d2 = await D2Touch.init(
    databaseFactory: databaseFactoryFfi,
    databaseName: randomStrings(),
    sharedPreferenceInstance: sharedPreferenceInstance,
  );

  final dataSet = DataSet(
      id: 'test1',
      name: "Test 1",
      shortName: 'Test 1',
      timelyDays: 15,
      dirty: false,
      expiryDays: 15,
      formType: 'CUSTOM',
      openFuturePeriods: 2,
      periodType: 'MONTHLY');

  var insertResult = await d2.dataSetModule.dataSet.setData(dataSet).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  DataSet? result = await d2.dataSetModule.dataSet.byId('test1').getOne();

  test('should return saved details', () {
    expect(result!.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.timelyDays, 15);
    expect(result.expiryDays, 15);
    expect(result.formType, 'CUSTOM');
    expect(result.openFuturePeriods, 2);
  });

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataSets.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired,dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,categoryCombo[id,name,displayName,categoryOptionCombos[id,code,name,displayName,displayFormName,ignoreApproval,created,lastUpdated]],optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]],sections[id,name,displayName,sortOrder,showRowTotals,greyedFields,created,lastUpdated,dataElements[id~rename(dataElement)]]&paging=false',
    (server) => server.reply(200, sampleDataSets),
  );

  await d2.dataSetModule.dataSet.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataSet> dataSets = await d2.dataSetModule.dataSet.get();

  test('should store all incoming data set metadata', () {
    expect(dataSets.length, 25);
  });

  List<DataSetElement> dataSetElements =
      await d2.dataSetModule.dataSetElement.get();

  test('should store all incoming data set data elements', () {
    expect(dataSetElements.length, 123);
  });

  List<DataSetElementOption> dataSetElementOptions =
      await d2.dataSetModule.dataSetElementOption.get();

  test('should store all incoming data set data element options', () {
    expect(dataSetElementOptions.length, 4);
  });

  List<DataSetSection> dataSetSections =
      await d2.dataSetModule.dataSetSection.get();

  test('should store all incoming data set sections', () {
    expect(dataSetSections.length, 2);
  });

  List<DataSetSectionDataElement> dataSetSectionDataElements =
      await d2.dataSetModule.dataSetSectionDataElement.get();

  test('should store all incoming data set section elements', () {
    expect(dataSetSectionDataElements.length, 2);
  });

  DataSet? dataSetWithSections = await d2.dataSetModule.dataSet
      .withSections()
      .byId('lyLU2wR22tC')
      .getOne();

  test('should return data set sections for selected dataset', () {
    expect(dataSetWithSections?.sections?.length, 2);
  });

  DataSetSection? dataSetSectionWithElements =
      await d2.dataSetModule.dataSetSection.withDataElements().getOne();

  test('should return data set section data elements for selected section', () {
    expect(dataSetSectionWithElements?.dataElements?.length, 1);
  });

  List<DataElementCategoryOptionCombo>? categoryOptionCombos =
      await d2.dataSetModule.categoryOptionCombo.get();

  test('should return category options combos available for the dataelements',
      () {
    expect(categoryOptionCombos?.length, 8);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/dataSets.json?filter=id:in:[BfMAe6Itzgt,VTdjfLXXmoi]&fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,timelyDays,formType,description,periodType,openFuturePeriods,expiryDays,renderHorizontally,renderAsTabs,fieldCombinationRequired,dataSetElements[dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,categoryCombo[id,name,displayName,categoryOptionCombos[id,code,name,displayName,displayFormName,ignoreApproval,created,lastUpdated]],optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]],sections[id,name,displayName,sortOrder,showRowTotals,greyedFields,created,lastUpdated,dataElements[id~rename(dataElement)]]&paging=false',
    (server) => server.reply(200, chunkedSampleDataSets),
  );

  await d2.dataSetModule.dataSet.byIds(['BfMAe6Itzgt', 'VTdjfLXXmoi']).download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<DataSet> newDataSets = await d2.dataSetModule.dataSet
      .byIds(['BfMAe6Itzgt', 'VTdjfLXXmoi']).get();

  test('should store dataset given the ids', () {
    expect(newDataSets.length, 2);
  });

  await d2.dispose();
}
