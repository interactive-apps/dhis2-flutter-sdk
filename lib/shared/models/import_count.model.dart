// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

class ImportCount {
  int imported;
  int updated;
  int ignored;
  int deleted;

  ImportCount(
      {required this.imported,
      required this.updated,
      required this.ignored,
      required this.deleted});

  factory ImportCount.fromJson(Map<String, dynamic> jsonData) {
    return ImportCount(
      imported: jsonData['imported'],
      updated: jsonData['updated'],
      ignored: jsonData['ignored'],
      deleted: jsonData['deleted'],
    );
  }
}
