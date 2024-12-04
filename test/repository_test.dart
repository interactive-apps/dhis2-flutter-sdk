import 'package:d2_touch/core/utilities/repository.dart';
import 'package:d2_touch/modules/metadata/organisation_unit/entities/organisation_unit.entity.dart';
import 'package:d2_touch/shared/utilities/merge_mode.util.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:d2_touch/shared/utilities/query_filter_condition.util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'repository_test.reflectable.dart';

void main() async {
  initializeReflectable();
  sqfliteFfiInit();

  var databaseFactory = databaseFactoryFfi;
  var db = await databaseFactory.openDatabase(inMemoryDatabasePath);

  final repository = Repository<OrganisationUnit>(database: db);

  final columns =
      repository.columns.map((column) => column.columnQueryExpresion);

  test('should return columns based on entity definition', () {
    expect(columns, [
      'id TEXT PRIMARY KEY NOT NULL',
      'dirty BOOLEAN NOT NULL',
      'lastUpdated TEXT',
      'created TEXT',
      'name TEXT NOT NULL',
      'displayName TEXT',
      'shortName TEXT',
      'code TEXT',
      'translations TEXT',
      'level INTEGER NOT NULL',
      'path TEXT NOT NULL',
      'externalAccess BOOLEAN',
      'openingDate TEXT NOT NULL',
      'geometry TEXT',
      'parent TEXT'
    ]);
  });

  test(
      'should return table name based on what has been passed on entity definition',
      () {
    expect(repository.entity.tableName, 'organisationunit');
  });

  test('should return create query expression', () {
    expect(repository.createQuery,
        'CREATE TABLE IF NOT EXISTS organisationunit (id TEXT PRIMARY KEY NOT NULL, dirty BOOLEAN NOT NULL, lastUpdated TEXT, created TEXT, name TEXT NOT NULL, displayName TEXT, shortName TEXT, code TEXT, translations TEXT, level INTEGER NOT NULL, path TEXT NOT NULL, externalAccess BOOLEAN, openingDate TEXT NOT NULL, geometry TEXT, parent TEXT)');
  });

  await repository.create(database: db);

  final organisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1",
      level: 1,
      path: 'test1',
      shortName: 'Test 1',
      openingDate: '20-01-2020',
      dirty: false);

  var insertResult =
      await repository.insertOne(entity: organisationUnit, database: db);

  test('should return success if data is inserted into the database', () {
    expect(insertResult, 1);
  });

  var result = await repository.findById(id: 'test1', database: db);

  test('should return saved details', () {
    expect(result!.id, 'test1');
    expect(result.name, 'Test 1');
  });

  final updatedOrganisationUnit = OrganisationUnit(
      id: 'test1',
      name: "Test 1 (updated)",
      level: 1,
      path: 'test1',
      shortName: 'Test 1 (updated)',
      openingDate: '20-01-2020',
      dirty: false);

  var updateResult =
      await repository.updateOne(entity: updatedOrganisationUnit, database: db);

  test('should return success if data is updated into the database', () {
    expect(updateResult, 1);
  });

  var updatedResult = await repository.findById(id: 'test1', database: db);

  test('should return updated details', () {
    expect(updatedResult!.id, 'test1');
    expect(updatedResult.name, 'Test 1 (updated)');
  });

  var deleteResult = await repository.deleteById(id: 'test1', database: db);

  test('should return delete success', () {
    expect(deleteResult, 1);
  });

  var deletedResult = await repository.findById(id: 'test1', database: db);
  test('should return null for deleted item', () {
    expect(deletedResult, null);
  });

  var savedResponse = await repository.saveOne(
      entity: organisationUnit, database: db, mergeMode: MergeMode.Replace);

  test('should return save success', () {
    expect(savedResponse, 1);
  });

  var savedResult = await repository.findById(id: 'test1', database: db);

  test('should return saved result', () {
    expect(savedResult!.id, 'test1');
    expect(savedResult.name, 'Test 1');
  });

  final organisationUnitList = [
    OrganisationUnit(
        id: 'test2',
        name: "Test 2",
        level: 1,
        path: 'test2',
        shortName: 'Test 2',
        openingDate: '20-01-2020',
        dirty: false),
    OrganisationUnit(
        id: 'test3',
        name: "Test 3",
        level: 1,
        path: 'test3',
        shortName: 'Test 3',
        openingDate: '20-01-2020',
        dirty: false)
  ];

  var saveManyResponse = await repository.saveMany(
      entities: organisationUnitList,
      database: db,
      mergeMode: MergeMode.Replace);

  test('should return save success for saved list', () {
    expect(saveManyResponse, 1);
  });

  var savedManyResult1 = await repository.findById(id: 'test2', database: db);
  var savedManyResult2 = await repository.findById(id: 'test3', database: db);

  test('should return saved result', () {
    expect(savedManyResult1!.id, 'test2');
    expect(savedManyResult2!.id, 'test3');
    expect(savedManyResult1.name, 'Test 2');
    expect(savedManyResult2.name, 'Test 3');
  });

  var resultByIds = await repository.find(database: db, filters: [
    QueryFilter(
        attribute: 'id',
        condition: QueryCondition.In,
        value: ['test2', 'test3'])
  ]);

  test("should return saved results", () {
    expect(resultByIds.length, 2);
  });

  await db.close();
}
