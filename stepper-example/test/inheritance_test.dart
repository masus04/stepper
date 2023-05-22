// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter/foundation.dart';

class StepData<T extends StepData<T>> {
  final int? Function(T stepData) stepFunc;

  StepData(this.stepFunc);
}

class ConcreteStepData extends StepData<ConcreteStepData> {
  final String id;

  ConcreteStepData(
    this.id,
    super.stepFunc,
  );
}

void main() {
  test("Test generic Inheritance", () {
    final data = ConcreteStepData("some-id", (stepData) {
      debugPrint(stepData.id);
      return null;
    });

    data.stepFunc(data);
  });
}
