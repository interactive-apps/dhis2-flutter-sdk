import 'package:d2_touch/modules/metadata/program/entities/program_relationship.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class ProgramRelationshipQuery extends BaseQuery<ProgramRelationship> {
  String? toProgram;
  String? fromProgram;

  ProgramRelationshipQuery({Database? database}) : super(database: database);

  ProgramRelationshipQuery byToProgram(String toProgram) {
    this.toProgram = toProgram;
    return this.where(attribute: 'toProgram', value: toProgram);
  }

  ProgramRelationshipQuery byFromProgram(String fromProgram) {
    this.fromProgram = fromProgram;
    return this.where(attribute: 'fromProgram', value: fromProgram);
  }

  @override
  Future<String> dhisUrl() {
    String fields = (this.selected).isNotEmpty
        ? (this.selected).join(',')
        : 'id,name,toConstraint[program[id,code,name]],fromConstraint[program[id,name,code]]';
    if (this.fromProgram != null) {
      return Future.value(
          'relationshipTypes.json?fields=$fields&filter=fromConstraint.program.id:eq:${fromProgram}&paging=false');
    } else {
      return Future.value(
          'relationshipTypes.json?fields=$fields&filter=toConstraint.program.id:eq:${toProgram}&paging=false');
    }
  }
}
