import 'import_action.model.dart';
import 'import_conflict.model.dart';
import 'import_status.model.dart';

class ImportSummary {
  ImportStatus status;
  String? reference;
  ImportAction importAction;
  List<ImportConflict>? conflicts;
  Map<String, dynamic> responseSummary;
  ImportSummary(
      {required this.status,
      this.reference,
      required this.importAction,
      required this.responseSummary,
      this.conflicts});
}
