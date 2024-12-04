import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/file_resource/entities/file_resource.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/file_resource.sample.dart';
import '../sample/org_unit.sample.dart';
import '../sample/program.sample.dart';
import '../sample/program_stage.sample.dart';
import '../sample/tracked_entity_instances.sample.dart';
import 'file_resource_test.reflectable.dart';
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

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.14';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  List<Program> programs = List.from((samplePrograms['programs'] ?? []))
      .map<Program>((program) => Program.fromJson(program))
      .toList();

  await d2.programModule.program.setData(programs).save();

  List<ProgramStage> programStages = List.from(
          (sampleProgramStages['programStages'] ?? []))
      .map<ProgramStage>((programStage) => ProgramStage.fromJson(programStage))
      .toList();

  await d2.programModule.programStage.setData(programStages).save();

  List<OrganisationUnit> organisationUnits = List.from(
          sampleOrganisationUnits['organisationUnits'] ?? [])
      .map<OrganisationUnit>((orgUnit) => OrganisationUnit.fromJson(orgUnit))
      .toList();

  await d2.organisationUnitModule.organisationUnit
      .setData(organisationUnits)
      .save();

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.14/api/trackedEntityInstances.json?ou=DiszpKrYNg8&ouMode=SELECTED&program=IpHINAT79UW&programStatus=ACTIVE&pageSize=50&order=created:desc&fields=*',
    (server) => server.reply(200, sampleTrackedEntityInstances),
  );

  await d2.trackerModule.trackedEntityInstance
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final List<FileResource> fileResources = sampleFileResources
      .map((fileResource) => FileResource.fromJson(fileResource))
      .toList();

  await d2.fileResourceModule.fileResource.setData(fileResources).save();

  final List<FileResource> savedFileResources =
      await d2.fileResourceModule.fileResource.get();

  test(
      'should save provided file resources information into the phone database',
      () {
    expect(savedFileResources.length, 1);
  });

  var formData = FormData.fromMap({
    'file': await MultipartFile.fromFile(savedFileResources[0].localFilePath)
  });

  dioAdapter.onPost('https://play.dhis2.org/2.35.14/api/fileResources',
      (server) => server.reply(202, fileResourceUploadResponse),
      data: formData);

  List<FileResource>? fileResourceUpload =
      await d2.fileResourceModule.fileResource.upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfuly import', () {
    final successImports = (fileResourceUpload ?? [])
        .where((event) => event.synced == true)
        .toList();
    expect(successImports.length, 1);
  });

  final attribute = fileResourceUpload?[0].elementId;
  final resourceId = fileResourceUpload?[0].resourceId;

  TrackedEntityAttributeValue attributeDataValue = await d2
      .trackerModule.trackedEntityAttributeValue
      .where(attribute: 'attribute', value: attribute)
      .getOne();

  test('should update tracked entity attribute value based on file resource',
      () {
    expect(attributeDataValue.value, resourceId);
  });

  await d2.dispose();
}
