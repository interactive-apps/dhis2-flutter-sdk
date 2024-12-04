import 'package:d2_touch/modules/data/aggregate/entities/data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/event_data_value.entity.dart';
import 'package:d2_touch/modules/data/tracker/entities/tracked_entity_attribute_value.entity.dart';

class DataValueObject {
  String id;
  String value;
  DataValueObject({required this.id, required this.value});
}

class DataValueEntities {
  static fromAttributeValues(List<TrackedEntityAttributeValue> attributeValues,
      {Map<String, DataValueObject>? initialEntities = null}) {
    Map<String, DataValueObject> entities = initialEntities ?? {};

    attributeValues.forEach((attributeValue) {
      entities[attributeValue.attribute] = DataValueObject(
          id: attributeValue.attribute, value: attributeValue.value);
    });

    return entities;
  }

  static fromEventDataValues(List<EventDataValue> eventDataValues,
      {Map<String, DataValueObject>? initialEntities = null}) {
    Map<String, DataValueObject> entities = initialEntities ?? {};

    eventDataValues.forEach((eventDataValue) {
      entities[eventDataValue.dataElement] = DataValueObject(
          id: eventDataValue.dataElement, value: eventDataValue.value);
    });

    return entities;
  }

  static fromAggregateDataValues(List<DataValue> aggregateDataValues) {
    Map<String, DataValueObject> entities = {};

    aggregateDataValues.forEach((aggregateDataValue) {
      final id =
          '${aggregateDataValue.dataElement}.${aggregateDataValue.categoryOptionCombo}';
      entities[id] = DataValueObject(id: id, value: aggregateDataValue.value);
    });
    return entities;
  }
}
