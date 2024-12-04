import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/enrollment.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/file_resource/entities/file_resource.entity.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/shared/utilities/orgunit_mode.util.dart';
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
import '../sample/reserved_values.sample.dart';
import '../sample/tracked_entity_import_summary.sample.dart';
import '../sample/tracked_entity_instance_upload.sample.dart';
import '../sample/tracked_entity_instances.sample.dart';
import 'tracked_entity_instance_module_test.reflectable.dart';
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
    'https://play.dhis2.org/2.35.11/api/trackedEntityInstances.json?ou=DiszpKrYNg8&ouMode=SELECTED&program=IpHINAT79UW&programStatus=ACTIVE&pageSize=50&order=created:desc&fields=*',
    (server) => server.reply(200, sampleTrackedEntityInstances),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
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

  await d2.trackerModule.trackedEntityInstance
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<TrackedEntityInstance> trackedEntityInstances =
      await d2.trackerModule.trackedEntityInstance.get();

  test('should store all incoming tracked entity instances', () {
    expect(trackedEntityInstances.length, 32);
  });

  List<Enrollment> enrollments = await d2.trackerModule.enrollment.get();
  test('should store all incoming enrollments', () {
    expect(enrollments.length, 34);
  });

  List<TrackedEntityAttributeValue> attributes =
      await d2.trackerModule.trackedEntityAttributeValue.get();

  test('should store all incoming attributes', () {
    expect(attributes.length, 98);
  });

  List<Event> events = await d2.trackerModule.event.get();

  test('should store all incoming events', () {
    expect(events.length, 67);
  });

  List<EventDataValue> eventDataValues =
      await d2.trackerModule.eventDataValue.get();

  test('should store all incoming event data values', () {
    expect(eventDataValues.length, 442);
  });

  await d2.trackerModule.trackedEntityInstance
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<TrackedEntityInstance> secondTrackedEntityInstances =
      await d2.trackerModule.trackedEntityInstance.get();
  test('should updated all incoming tracked entity instances', () {
    expect(secondTrackedEntityInstances.length, 32);
  });

  List<Enrollment> secondEnrollments = await d2.trackerModule.enrollment.get();
  test('should store all incoming enrollments', () {
    expect(secondEnrollments.length, 34);
  });

  List<TrackedEntityAttributeValue> secondAttributes =
      await d2.trackerModule.trackedEntityAttributeValue.get();

  test('should store all incoming attributes', () {
    expect(secondAttributes.length, 98);
  });

  List<Event> secondEvents = await d2.trackerModule.event.get();

  test('should store all incoming events', () {
    expect(secondEvents.length, 67);
  });

  List<EventDataValue> secondEventDataValues =
      await d2.trackerModule.eventDataValue.get();

  test('should store all incoming event data values', () {
    expect(secondEventDataValues.length, 442);
  });

  List<TrackedEntityInstance> trackedEntityInstancesByProgram = await d2
      .trackerModule.trackedEntityInstance
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .get();

  test(
      'should updated all tracked entity instances for selected program and orgunit',
      () {
    expect(trackedEntityInstancesByProgram.length, 32);
  });

  await d2.trackerModule.trackedEntityAttributeValue
      .setData(TrackedEntityAttributeValue.fromJson({
        ...secondAttributes[0].toJson(),
        "value": 'New Female',
        "dirty": true
      }))
      .save();

  final ulteredAttributeValue = await d2
      .trackerModule.trackedEntityAttributeValue
      .byId(secondAttributes[0].id as String)
      .getOne();

  await d2.trackerModule.trackedEntityInstance
      .byOrgUnit('DiszpKrYNg8')
      .byProgram('IpHINAT79UW')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final finalAttributeValue = await d2.trackerModule.trackedEntityAttributeValue
      .byId(secondAttributes[0].id as String)
      .getOne();

  test('should not change local latest local attribute value', () {
    expect(ulteredAttributeValue.value, finalAttributeValue.value);
  });

  await d2.trackerModule.trackedEntityAttributeValue
      .setData(TrackedEntityAttributeValue.fromJson(
          {...secondAttributes[0].toJson(), "value": 'Female', "dirty": true}))
      .save();

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/trackedEntityInstances.json?ou=ImspTQPwCqd&ouMode=SELECTED&program=IpHINAT79UW&programStatus=ACTIVE&pageSize=50&order=created:desc&fields=*',
    (server) => server.reply(200, sampleTrackedEntityInstances),
  );

  List<TrackedEntityInstance>? listByOrgUnits = await d2
      .trackerModule.trackedEntityInstance
      .byUserOrgUnit()
      .byProgram('IpHINAT79UW')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test(
      'should updated all incoming tracked entity instances given user organisation unit',
      () {
    expect(listByOrgUnits?.length, 32);
  });

  final enrollmentToUpdate = await d2.trackerModule.enrollment.getOne();

  enrollmentToUpdate?.status = 'COMPLETED';
  enrollmentToUpdate?.dirty = true;

  await d2.trackerModule.enrollment.setData(enrollmentToUpdate).save();

  test('should update enrollment details for selected tracked entity instance',
      () {
    expect(listByOrgUnits?.length, 32);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/trackedEntityInstances.json?ou=ImspTQPwCqd&ouMode=DESCENDANTS&program=IpHINAT79UW&programStatus=ACTIVE&pageSize=50&order=created:desc&fields=*',
    (server) => server.reply(200, sampleTrackedEntityInstances),
  );

  await d2.trackerModule.trackedEntityInstance
      .byUserOrgUnit()
      .byProgram('IpHINAT79UW')
      .withOuMode(OrgUnitMode.DESCENDANTS)
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test(
      'should updated all incoming tracked entity instances given user organisation unit',
      () {
    expect(listByOrgUnits?.length, 32);
  });

  final List<FileResource> fileResources = sampleFileResources
      .map((fileResource) => FileResource.fromJson(fileResource))
      .toList();

  await d2.fileResourceModule.fileResource.setData(fileResources).save();

  final TrackedEntityInstance trackedEntityInstance =
      TrackedEntityInstance.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][0],
    'dirty': true
  });

  await d2.trackerModule.trackedEntityInstance
      .setData(trackedEntityInstance)
      .save();

  final TrackedEntityInstance secondTrackedEntityInstance =
      TrackedEntityInstance.fromJson({
    ...sampleTrackedEntityInstances['trackedEntityInstances'][1],
    'dirty': true
  });

  await d2.trackerModule.trackedEntityInstance
      .setData(secondTrackedEntityInstance)
      .save();

  dioAdapter.onPost('https://play.dhis2.org/2.35.11/api/trackedEntityInstances',
      (server) => server.reply(409, sampleTrackedEntityInstanceImportSummary),
      data: sampleTrackedEntityInstanceUpload);

  List<TrackedEntityInstance>? trackedEntityInstanceUpload =
      await d2.trackerModule.trackedEntityInstance.upload((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  test('should correctly set sync status to true for successfull import', () {
    final successImports = (trackedEntityInstanceUpload ?? [])
        .where((trackedEntityInstance) => trackedEntityInstance.synced == true)
        .toList();
    expect(successImports.length, 1);
  });

  test(
      'should not set sync status to true for unsuccessfull import and save import summary',
      () {
    final unSuccessfulImports = (trackedEntityInstanceUpload ?? [])
        .where((trackedEntityInstance) =>
            trackedEntityInstance.syncFailed == false)
        .toList();

    expect(unSuccessfulImports.length, 1);
    expect(unSuccessfulImports[0].lastSyncSummary != null, true);
  });

  List<AttributeReservedValue> attributeReservedValues = [];
  sampleReservedValues.forEach((reservedValue) {
    attributeReservedValues.add(
        AttributeReservedValue.fromJson({...reservedValue, 'dirty': false}));
  });

  await d2.trackerModule.attributeReservedValue
      .setData(attributeReservedValues)
      .save();

  final TrackedEntityInstance trackedEntityInstanceWithReservedValue = await d2
      .trackerModule.trackedEntityInstance
      .byProgram('IpHINAT79UW')
      .byOrgUnit('fnei293faf')
      .create();

  final TrackedEntityInstance createdInstance = await d2
      .trackerModule.trackedEntityInstance
      .byId(trackedEntityInstanceWithReservedValue.id as String)
      .withEnrollments()
      .withAttributes()
      .getOne();

  test('should return created tracked entity instance with generated values',
      () {
    expect(createdInstance.id, trackedEntityInstanceWithReservedValue.id);
    expect(createdInstance.orgUnit, 'fnei293faf');
    expect(
        (trackedEntityInstanceWithReservedValue.attributes ?? [])
            .lastWhere((attribute) => attribute.attribute == 'lZGmxYbs97q')
            .attribute,
        'lZGmxYbs97q');
    expect(createdInstance.enrollments?.length, 1);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/trackedEntityAttributes/lZGmxYbs97q/generateAndReserve?numberToReserve=1',
    (server) => server.reply(200, sampleReservedValues),
  );

  await d2.trackerModule.attributeReservedValue.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<AttributeReservedValue> downloadedAttributeReservedValues =
      await d2.trackerModule.attributeReservedValue.get();

  test('should store all incoming data value sets', () {
    expect(downloadedAttributeReservedValues.length, 100);
  });

  await d2.dispose();
}
