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
        body: IndependentStepper(
          showCompleteButtons: true,
          onConfirm: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Confirmed!"))),
          steps: [
            IndependentStepData(
              id: "first-step",
              title: "First Step",
              onContinue: (currentStep, stepData) => currentStep + 1,
              onCancel: (currentStep, stepData) {
                debugPrint("${stepData.id} canceled");
                return currentStep;
              },
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.emoji_emotions_outlined),
              ),
            ),
            IndependentStepData(
              id: "second-step",
              title: "Second Step",
              onContinue: (currentStep, stepData) {
                debugPrint("${stepData.title} continued");
                return currentStep;
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
