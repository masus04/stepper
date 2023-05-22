import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stepper/stepper.dart';

void main() {
  group("Steper Tests", () {
    testWidgets("Test Create Widget", (widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: IndependentStepper(steps: [
              IndependentStepData(
                id: "test-id",
                title: 'Test Title',
                child: const Text("Placeholder Text"),
                onContinue: (int currentStep, stepData) {
                  return currentStep;
                },
                onCancel: (int currentStep, stepData) {
                  return currentStep;
                },
              ),
            ]),
          ),
        ),
      );
    });
  });
}
