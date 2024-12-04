// Copyright 2023 UDSM DHIS2 Lab. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:d2_touch/modules/metadata/dataset/entities/data_element_category_option_combo.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:sqflite/sqflite.dart';

class DataElementCategoryOptionComboQuery
    extends BaseQuery<DataElementCategoryOptionCombo> {
  DataElementCategoryOptionComboQuery({Database? database})
      : super(database: database);
}
