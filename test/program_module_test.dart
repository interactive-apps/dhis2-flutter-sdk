import 'package:d2_touch/d2_touch.dart';
import 'package:d2_touch/modules/auth/entities/user.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/attribute_reserved_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked-entity.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';
import 'package:d2_touch/modules/engine/program_rule/models/tracker_rule_result.model.dart';
import 'package:d2_touch/modules/metadata/program/entities/program.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_action.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_rule_variable.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_section_attribute.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_data_element_option.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_stage_section.entity.dart';
import 'package:d2_touch/modules/metadata/program/entities/program_tracked_entity_attribute.entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../sample/current_user.sample.dart';
import '../sample/program.sample.dart';
import '../sample/program_rule.sample.dart';
import '../sample/program_stage.sample.dart';
import '../sample/reserved_values.sample.dart';
import '../sample/program_relationship_sample.dart';
import 'program_module_test.reflectable.dart';
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

  final program = Program(
    id: 'test1',
    name: "Test 1",
    shortName: 'Test 1',
    dirty: false,
    captureCoordinates: true,
    completeEventsExpiryDays: 15,
    displayIncidentDate: false,
    enrollmentDateLabel: '',
    featureType: '',
    ignoreOverdueEvents: true,
    incidentDateLabel: '',
    onlyEnrollOnce: false,
    organisationUnits: '',
    programRuleVariables: [],
    programType: 'EVENT',
    selectEnrollmentDatesInFuture: true,
    selectIncidentDatesInFuture: false,
    trackedEntity: '',
    trackedEntityType: '',
    useFirstStageDuringRegistration: true,
    withoutRegistration: true,
  );

  var insertResult = await d2.programModule.program.setData(program).save();

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await d2.programModule.program.byId('test1').getOne();

  test('should return saved details', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.programType, 'EVENT');
    expect(result.captureCoordinates, true);
  });

  final programStage = ProgramStage(
      id: 'programstage1',
      name: 'Program Stage 1',
      shortName: 'Program Stage 1',
      featureType: '',
      captureCoordinates: false,
      sortOrder: 1,
      allowGenerateNextVisit: true,
      autoGenerateEvent: true,
      blockEntryForm: true,
      dueDateLabel: 'Due Date',
      executionDateLabel: 'Execution Date',
      formType: 'DEFAULT',
      generatedByEnrollmentDate: false,
      hideDueDate: false,
      minDaysFromStart: 3,
      program: {"id": "test1"},
      programStageDataElements: [],
      programStageSections: [],
      repeatable: false,
      dirty: false);

  var insertProgramStageResult =
      await d2.programModule.programStage.setData(programStage).save();

  test('should return success if program stage is inserted into the database',
      () {
    expect(insertProgramStageResult, 1);
  });

  var programStageResult = await d2.programModule.programStage
      .byIds(['programstage1'])
      .withProgram()
      .getOne();

  test('should return saved program stage details', () {
    expect(programStageResult.id, 'programstage1');
    expect(programStageResult.name, 'Program Stage 1');
    expect(programStageResult.shortName, 'Program Stage 1');
  });

  // var programWithStages =
  //     await programQuery.byId('test1').withProgramStages().getOne();

  test('should return program with stage information', () {
    expect(result.id, 'test1');
    expect(result.name, 'Test 1');
    expect(result.shortName, 'Test 1');
    expect(result.programType, 'EVENT');
    expect(result.captureCoordinates, true);
  });

  final dio = Dio(BaseOptions());
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programs.json?fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariables[id,name,displayName,created,lastUpdated,programRuleVariableSourceType,useCodeForOptionSet,program,dataElement,trackedEntityAttribute,progamStage],programTrackedEntityAttributes[id,displayInList,name,displayName,attributeValues,mandatory,renderOptionsAsRadio,sortOrder,valueType,trackedEntityAttribute[id,code,name,displayName,formName,shortName,aggregationType,unique,generated,optionSetValue,optionSet[id,name,options[code,name,id]]]],programSections[id,name,created,lastUpdated,displayName,renderType,displayFormName,sortOrder,trackedEntityAttributes[id~rename(attribute)]],programStages[id,name,code,created,lastUpdated,formType,generatedByEnrollmentDate,displayFormName,sortOrder,hideDueDate,enableUserAssignment,minDaysFromStart,executionDateLabel,preGenerateUID,displayName,description,displayExecutionDateLabel,openAfterEnrollment,repeatable,featureType,remindCompleted,displayGenerateEventBox,validationStrategy,autoGenerateEvent,blockEntryForm,programStageSections[id,name,displayName,displayFormName,created,lastUpdated,renderType,sortOrder,dataElements[id~rename(dataElement)]],programStageDataElements[id,created,lastUpdated,displayInReports,skipSynchronization,renderOptionsAsRadio,allowFutureDate,compulsory,allowProvidedElseWhere,sortOrder,dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]]&paging=false',
    (server) => server.reply(200, samplePrograms),
  );

  userData['password'] = 'district';
  userData['isLoggedIn'] = true;
  userData['username'] = 'admin';
  userData['baseUrl'] = 'https://play.dhis2.org/2.35.11';
  final user = User.fromApi(userData);
  await d2.userModule.user.setData(user).save();

  await d2.programModule.program.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<Program> programs = await d2.programModule.program.get();

  List<ProgramTrackedEntityAttribute> programTrackedEntityAttributes =
      await d2.programModule.programTrackedEntityAttribute.withOptions().get();

  test('should store all incoming program metadata', () {
    expect(programs.length, 15);
    expect(programTrackedEntityAttributes.length, 4);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programs.json?filter=id:in:[IpHINAT79UX]&fields=id,name,displayName,shortName,lastUpdated,created,code,dirty,programType,displayIncidentDate,description,withoutRegistration,ignoreOverdueEvents,captureCoordinates,featureType,enrollmentDateLabel,onlyEnrollOnce,selectIncidentDatesInFuture,selectEnrollmentDatesInFuture,useFirstStageDuringRegistration,incidentDateLabel,completeEventsExpiryDays,displayFrontPageList,trackedEntity,trackedEntityType,organisationUnits,programRuleVariables[id,name,displayName,created,lastUpdated,programRuleVariableSourceType,useCodeForOptionSet,program,dataElement,trackedEntityAttribute,progamStage],programTrackedEntityAttributes[id,displayInList,name,displayName,attributeValues,mandatory,renderOptionsAsRadio,sortOrder,valueType,trackedEntityAttribute[id,code,name,displayName,formName,shortName,aggregationType,unique,generated,optionSetValue,optionSet[id,name,options[code,name,id]]]],programSections[id,name,created,lastUpdated,displayName,renderType,displayFormName,sortOrder,trackedEntityAttributes[id~rename(attribute)]],programStages[id,name,code,created,lastUpdated,formType,generatedByEnrollmentDate,displayFormName,sortOrder,hideDueDate,enableUserAssignment,minDaysFromStart,executionDateLabel,preGenerateUID,displayName,description,displayExecutionDateLabel,openAfterEnrollment,repeatable,featureType,remindCompleted,displayGenerateEventBox,validationStrategy,autoGenerateEvent,blockEntryForm,programStageSections[id,name,displayName,displayFormName,created,lastUpdated,renderType,sortOrder,dataElements[id~rename(dataElement)]],programStageDataElements[id,created,lastUpdated,displayInReports,skipSynchronization,renderOptionsAsRadio,allowFutureDate,compulsory,allowProvidedElseWhere,sortOrder,dataElement[id,code,name,shortName,aggregationType,domainType,displayName,description,displayShortName,periodOffset,valueType,formName,displayDescription,displayFormName,zeroIsSignificant,optionSetValue,optionSet[id,name,displayName,valueType,options[id,name,displayName,code,sortOrder,displayFormName]]]]]&paging=false',
    (server) => server.reply(200, sampleFilteredPrograms),
  );

  await d2.programModule.program.byIds(['IpHINAT79UX']).download(
      (progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  Program? filteredProgram =
      await d2.programModule.program.byId('IpHINAT79UX').getOne();

  test('should store all incoming filtered program metadata', () {
    expect(filteredProgram?.id, 'IpHINAT79UX');
  });

  List<ProgramStage> programStages =
      await d2.programModule.programStage.withDataElements().get();

  List<ProgramStageDataElement> programStageElements =
      await d2.programModule.programStageDataElement.get();

  List<ProgramStageDataElementOption> programStageElementOptions =
      await d2.programModule.programStageDataElementOption.get();

  List<ProgramRuleVariable> programRuleVariables =
      await d2.programModule.programRuleVariable.get();

  List<ProgramSection> programSections =
      await d2.programModule.programSection.withAttributes().get();

  List<ProgramSectionAttribute> programSectionAttributes =
      await d2.programModule.programSectionAttribute.get();

  List<ProgramStageSection> programStageSections =
      await d2.programModule.programStageSection.withDataElements().get();

  test(
      'should store all program stages, their elements and options per selected program',
      () {
    expect(programStages.length, 2);
    expect(programStageElements.length, 22);
    expect(programStageElementOptions.length, 48);
    expect(programRuleVariables.length, 4);
    expect(programSections.length, 1);
    expect(programSectionAttributes.length, 3);
    expect(programStageSections.length, 1);
    expect(programStageSections[0].dataElements?.length, 1);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programStages.json?fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,sortOrder,executionDateLabel,description,formType,blockEntryForm,hideDueDate,repeatable,allowGenerateNextVisit,minDaysFromStart,generatedByEnrollmentDate,autoGenerateEvent,captureCoordinates,featureType,dueDateLabel,programStageSections[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,formName,description,sortOrder,renderType,dataElements[id,dirty,lastUpdated,created,dataElement,programStageSection],programStage],program,programStageDataElements[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,formName,valueType,dataElementId,aggregationType,domainType,description,displayDescription,displayFormName,displayInReports,renderOptionsAsRadio,compulsory,sortOrder,skipSynchronization,allowFutureDate,zeroIsSignificant,periodOffset,programStage,optionSetValue,optionSetName,options[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,programStageDataElement]]&paging=false',
    (server) => server.reply(200, sampleProgramStages),
  );

  await d2.programModule.programStage.download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<ProgramStage> updatedProgramStages =
      await d2.programModule.programStage.get();

  test('should download and store all incoming program stage metadata', () {
    expect(updatedProgramStages.length, 3);
  });

  dioAdapter.onGet(
    'https://play.dhis2.org/2.35.11/api/programRules.json?filter=program.id:in:[IpHINAT79UW]&fields=id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,condition,description,program,programRuleActions[id,dirty,lastUpdated,created,name,displayName,shortName,code,translations,content,data,displayContent,programRuleActionType,evaluationTime,description,dataElement,trackedEntityAttribute,programRule]&paging=false',
    (server) => server.reply(200, sampleProgramRules),
  );

  await d2.programModule.programRule
      .whereIn(attribute: 'program', values: ['IpHINAT79UW'], merge: false)
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  List<ProgramRule> programRules =
      await d2.programModule.programRule.withActions().get();

  List<ProgramRuleAction> programRuleActions =
      await d2.programModule.programRuleAction.get();

  test('should download and store all incoming program rule metadata', () {
    expect(programRules.length, 4);
    expect(programRuleActions.length, 4);
  });

  List<AttributeReservedValue> attributeResrvedValues = [];
  sampleReservedValues.forEach((reservedValue) {
    attributeResrvedValues.add(
        AttributeReservedValue.fromJson({...reservedValue, 'dirty': false}));
  });

  await d2.trackerModule.attributeReservedValue
      .setData(attributeResrvedValues)
      .save();

  final TrackedEntityInstance trackedEntityInstance = await d2
      .trackerModule.trackedEntityInstance
      .byProgram('IpHINAT79UW')
      .byOrgUnit('fnei293faf')
      .create();

  final trackedEntityAttributeValues = [
    TrackedEntityAttributeValue(
        dirty: true,
        attribute: 'w75KJ2mc4zz',
        trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
        value: 'First name'),
    TrackedEntityAttributeValue(
        dirty: true,
        attribute: 'cejWyOfXge6',
        trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
        value: 'Female')
  ];

  await d2.trackerModule.trackedEntityAttributeValue
      .setData(trackedEntityAttributeValues)
      .save();

  final TrackedEntityInstance createdInstance = await d2
      .trackerModule.trackedEntityInstance
      .byId(trackedEntityInstance.id as String)
      .withEnrollments()
      .withAttributes()
      .getOne();

  final executedProgramRuleActions = (await d2.engine.tracker.execute(
          program: 'IpHINAT79UW', trackedEntityInstance: createdInstance))
      .programRuleActions;

  final lastNameRuleAction = executedProgramRuleActions
      .lastWhere((element) => element.trackedEntityAttribute == 'zDhUuAYrxNC');

  test('should return action with signal to assign last name', () {
    expect(lastNameRuleAction.programRuleActionType, 'ASSIGN');
    expect(lastNameRuleAction.data, 'Last Name');
  });

  final secondTrackedEntityAttributeValue = TrackedEntityAttributeValue(
      dirty: true,
      attribute: 'cejWyOfXge6',
      trackedEntityInstance: trackedEntityInstance.trackedEntityInstance,
      value: 'Male');

  await d2.trackerModule.trackedEntityAttributeValue
      .setData(secondTrackedEntityAttributeValue)
      .save();

  final TrackedEntityInstance updatedInstance = await d2
      .trackerModule.trackedEntityInstance
      .byId(trackedEntityInstance.id as String)
      .withEnrollments()
      .withAttributes()
      .getOne();

  final secondProgramRuleActions = (await d2.engine.tracker.execute(
    trackedEntityInstance: createdInstance,
    program: 'IpHINAT79UW',
  ))
      .programRuleActions;

  final secondLastNameRuleAction = secondProgramRuleActions
      .lastWhere((element) => element.trackedEntityAttribute == 'zDhUuAYrxNC');

  test('should return action with signal not to assign last name', () {
    expect(secondLastNameRuleAction.programRuleActionType, '');
  });

  await d2.trackerModule.trackedEntityAttributeValue
      .setData(TrackedEntityAttributeValue(
          dirty: true,
          attribute: 'cejWyOfXge6',
          trackedEntityInstance: updatedInstance.trackedEntityInstance,
          value: 'Female'))
      .save();

  TrackerRuleResult trackerRuleResult = await d2.engine.tracker.execute(
    trackedEntityInstance: createdInstance,
    program: 'IpHINAT79UW',
  );

  final lastNameAttributeValue = trackerRuleResult
      .trackedEntityInstance.attributes
      ?.lastWhere((attribute) => attribute.attribute == 'zDhUuAYrxNC');

  test('should assign last name', () {
    expect(lastNameAttributeValue?.value, 'Last Name');
  });

  dioAdapter.onGet(
      'https://play.dhis2.org/2.35.11/api/relationshipTypes.json?fields=id,name,toConstraint[program[id,code,name]],fromConstraint[program[id,name,code]]&filter=fromConstraint.program.id:eq:qDkgAbB5Jlk&paging=false',
      (server) => server.reply(200, sampleProgramRelationship));

  await d2.programModule.programRelationship
      .byFromProgram('qDkgAbB5Jlk')
      .download((progress, complete) {
    print(progress.message);
  }, dioTestClient: dio);

  final relationships = await d2.programModule.programRelationship.get();

  test('should return relationships', () {
    expect(relationships?.length, 3);
  });

  await d2.dispose();
}
