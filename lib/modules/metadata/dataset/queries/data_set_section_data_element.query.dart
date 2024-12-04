// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/modules/metadata/dataset/entities/data_set_section_data_element.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataSetSectionDataElementQuery
    extends BaseQuery<DataSetSectionDataElement> {
  DataSetSectionDataElementQuery({Database? database})
      : super(database: database);
}
