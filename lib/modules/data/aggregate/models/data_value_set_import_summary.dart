// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/shared/models/import_action.model.dart';
import 'package:d2_touch/shared/models/import_count.model.dart';
import 'package:d2_touch/shared/models/import_status.model.dart';
import 'package:d2_touch/shared/models/import_summary.model.dart';

import '../../../../shared/models/import_conflict.model.dart';

class DataValueSetImportSummary extends ImportSummary {
  ImportCount importCount;
  DataValueSetImportSummary({
    required ImportStatus status,
    required ImportAction importAction,
    required this.importCount,
    List<ImportConflict>? conflicts,
    required Map<String, dynamic> responseSummary,
  }) : super(
            status: status,
            importAction: importAction,
            conflicts: conflicts,
            responseSummary: responseSummary);

  factory DataValueSetImportSummary.fromJson(Map<String, dynamic> jsonData) {
    return DataValueSetImportSummary(
        status: ImportStatusUtil.getStatus(jsonData['status']),
        importAction: ImportActionUtil.getAction(jsonData['importCount']),
        importCount: ImportCount.fromJson(jsonData['importCount']),
        responseSummary: jsonData,
        conflicts: List<dynamic>.from(jsonData['conflicts'] ?? [])
            .map((conflict) => ImportConflict(
                object: conflict['object'], value: conflict['value']))
            .toList());
  }
}
