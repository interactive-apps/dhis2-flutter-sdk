import 'package:d2_touch/modules/metadata/option_group/entities/option_group.entity.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/query_filter.util.dart';
import 'package:sqflite/sqflite.dart';

class OptionGroupQuery extends BaseQuery<OptionGroup> {
  OptionGroupQuery({Database? database}) : super(database: database);

  @override
  Future<String> dhisUrl() {
    final apiFilter =
        QueryFilter.getApiFilters(this.repository.columns, this.filters);

    if ((this.selected).isNotEmpty) {
      return Future.value(
          'optionGroups.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=${this.selected.join(',')}&paging=false');
    }

    return Future.value(
        'optionGroups.json${apiFilter != null ? '?$apiFilter&' : '?'}fields=id,name,shortName,options[code,name]&paging=false');
  }
}
