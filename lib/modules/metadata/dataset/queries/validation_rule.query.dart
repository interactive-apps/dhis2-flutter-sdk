import 'package:d2_touch/modules/metadata/dataset/entities/data_set.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/entities/validation_rule.entity.dart';
import 'package:d2_touch/modules/metadata/dataset/queries/data_set.query.dart';
import 'package:d2_touch/shared/models/request_progress.model.dart';
import 'package:d2_touch/shared/queries/base.query.dart';
import 'package:d2_touch/shared/utilities/http_client.util.dart';
import 'package:dio/dio.dart';
import 'package:queue/queue.dart';
import 'package:sqflite/sqflite.dart';

class ValidationRuleQuery extends BaseQuery<ValidationRule> {
  ValidationRuleQuery({Database? database}) : super(database: database);

  @override
  Future<List<ValidationRule>?> download(
      Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    List<DataSet> dataSets = await DataSetQuery(database: database).get();

    final queue = Queue(parallel: 50);
    num availableItemCount = 0;

    dataSets.forEach((dataSet) {
      availableItemCount++;
      queue.add(() =>
          this.downloadOne(dataSet, availableItemCount, (progress, complete) {
            callback(progress, complete);
          }, dioTestClient: dioTestClient));
    });

    if (availableItemCount == 0) {
      queue.cancel();
    } else {
      await queue.onComplete;
    }

    return this.get();
  }

  Future<List<ValidationRule>?> downloadOne(
      DataSet dataSet, num index, Function(RequestProgress, bool) callback,
      {Dio? dioTestClient}) async {
    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Downloading ${this.apiResourceName?.toLowerCase()} for ${dataSet.name} from the server....',
            status: '',
            percentage: 0),
        false);

    final response = await HttpClient.get(
        'validationRules?dataSet=${dataSet.id}&fields=id,name,displayName,created,lastUpdated,description,operator,instruction,displayInstruction,displayFormName,periodOffset,periodType,leftSide,rightSide',
        database: this.database,
        dioTestClient: dioTestClient);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${this.apiResourceName?.toLowerCase()} for ${dataSet.name} downloaded successfully',
            status: '',
            percentage: 50),
        false);

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                'Saving ${this.apiResourceName?.toLowerCase()} for ${dataSet.name} into phone database...',
            status: '',
            percentage: 51),
        false);

    List? data =
        response.body != null && response.body[this.apiResourceName] != null
            ? response.body[this.apiResourceName]?.toList()
            : [];

    this.data = (data ?? []).map((dataItem) {
      dataItem['dirty'] = false;
      dataItem['dataSet'] = dataSet.id;
      return ValidationRule.fromJson(dataItem);
    }).toList();
    await this.save();

    callback(
        RequestProgress(
            resourceName: this.apiResourceName as String,
            message:
                '${this.apiResourceName?.toLowerCase()} for ${dataSet.name} successfully saved into the database',
            status: '',
            percentage: 100),
        true);

    return this.data;
  }
}
