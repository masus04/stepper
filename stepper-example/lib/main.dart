import 'package:flutter/material.dart';
import 'package:stepper/stepper.dart';

void main() {
  runApp(const StepperExample());
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  State<StepperExample> createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int step = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: IndependentStepper<ExampleStepData>(
          showCompleteButtons: true,
          onConfirm: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Confirmed!"))),
          steps: [
            ExampleStepData(
              id: "first-step",
              title: "First Step",
              onContinue: (currentStep, stepData) => currentStep + 1,
              onCancel: (currentStep, stepData) {
                debugPrint("${stepData.id} canceled");
                return null;
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.emoji_emotions_outlined),
              ),
            ),
            ExampleStepData(
              id: "second-step",
              title: "Second Step",
              onContinue: (currentStep, stepData) {
                debugPrint("${stepData.title} continued");
                return null;
              },
              onCancel: (currentStep, stepData) => currentStep - 1,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.emoji_emotions),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleStepData extends IndependentStepData<ExampleStepData> {
  final String id;

  ExampleStepData({
    required this.id,
    required super.title,
    required super.child,
    required super.onContinue,
    required super.onCancel,
  });
}
