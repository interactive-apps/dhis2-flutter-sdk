import 'package:d2_touch/modules/engine/program_rule/event_rule_engine.dart';
import 'package:d2_touch/modules/engine/program_rule/tracker_rule_engine.dart';
import 'package:d2_touch/modules/engine/shared/utilities/raw.query.dart';
import 'package:d2_touch/modules/engine/validation_rule/validation_rule_engine.dart';
import 'package:sqflite/sqflite.dart';

class EngineModule {
  Database database;
  EngineModule({required this.database});

  TrackerRuleEngine get tracker => TrackerRuleEngine(database: database);
  EventRuleEngine get event => EventRuleEngine(database: database);
  ValidationRuleEngine get validation =>
      ValidationRuleEngine(database: database);

  RawQueryModule get query => RawQueryModule(database: database);
}
