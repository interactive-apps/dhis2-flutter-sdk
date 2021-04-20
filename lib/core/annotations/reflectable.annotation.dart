import 'package:reflectable/reflectable.dart';

class AnnotationReflection extends Reflectable {
  const AnnotationReflection()
      : super(
            invokingCapability,
            declarationsCapability,
            reflectedTypeCapability,
            newInstanceCapability,
            metadataCapability,
            typeRelationsCapability,
            typeCapability);
}

const AnnotationReflectable = AnnotationReflection();
