// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

class Stepper<T extends StepData> {
  final List<T> steps;

  Stepper({required this.steps});
}

class StepData<T> {
  final int? Function(T stepData) stepFunc;

  StepData({required this.stepFunc});
}

class ConcreteStepData extends StepData<ConcreteStepData> {
  final int id;

  ConcreteStepData({
    required this.id,
    required super.stepFunc,
  });
}

void main() {
  test("Test generic Inheritance", () {
    final step = ConcreteStepData(
      id: 32,
      stepFunc: (stepData) => stepData.id,
    );

    final stepper = Stepper(steps: [step]);

    stepper.steps[0].stepFunc(step);
  });
}
