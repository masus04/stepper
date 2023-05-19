import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class IndependentStepper extends HookWidget {
  final List<IndependentStepData> steps;

  final bool showCompleteButtons;

  final String confirmLabel;
  final void Function()? onConfirm;

  final String cancelLabel;
  final void Function()? onCancel;

  final int? Function(IndependentStepData step, int nextStep) onStepTapped;

  const IndependentStepper({
    super.key,
    required this.steps,
    this.showCompleteButtons = false,
    this.onConfirm,
    this.onCancel,
    this.confirmLabel = "Confirm",
    this.cancelLabel = "Cancel",
    this.onStepTapped = IndependentStepper.defaultOnStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    final currentStep = useState(0);

    return Column(
      children: [
        Stepper(
          steps: steps
              .mapIndexed(
                (index, step) => Step(
                  isActive: index == currentStep.value,
                  title: Text(
                    step.title,
                  ),
                  content: IndependentStep(
                    stepData: step,
                    stepIndex: index,
                    currentStep: currentStep,
                  ),
                ),
              )
              .toList(),
          currentStep: currentStep.value,
          controlsBuilder: (context, details) => const SizedBox.shrink(),
          onStepTapped: (index) {
            final nextStep = onStepTapped(steps[currentStep.value], index);
            if (nextStep != null) {
              currentStep.value;
            }
          },
        ),
        if (showCompleteButtons)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 4),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                  child: Text(
                    confirmLabel,
                    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
                TextButton(
                  onPressed: onCancel,
                  child: Text(cancelLabel),
                )
              ],
            ),
          )
      ],
    );
  }

  static int? defaultOnStepTapped(IndependentStepData step, int nextStep) {
    /// Returns the index of the next step if it should be changed or null otherwise.
    if (step.validate() == null) {
      return nextStep;
    } else {
      return null;
    }
  }
}

class IndependentStepData {
  final String title;
  final Widget child;

  final String continueLabel;
  final int? Function(int currentStep) onContinue;

  final String cancelLabel;
  final int? Function(int currentStep) onCancel;

  final String? Function() validate;

  final Alignment alignment;

  IndependentStepData({
    required this.title,
    required this.child,
    this.continueLabel = "Continue",
    required this.onContinue,
    this.cancelLabel = "Cancel",
    required this.onCancel,
    this.validate = IndependentStep.defaultValidate,
    this.alignment = Alignment.centerLeft,
  });
}

class IndependentStep extends StatelessWidget {
  final IndependentStepData stepData;
  final int stepIndex;
  final ValueNotifier<int> currentStep;

  const IndependentStep({super.key, required this.stepData, required this.stepIndex, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        stepData.child,
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                final nextStep = stepData.onContinue(stepIndex);
                if (nextStep != null) {
                  currentStep.value = nextStep;
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
              child: Text(
                stepData.continueLabel,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                final nextStep = stepData.onCancel(stepIndex);
                if (nextStep != null) {
                  currentStep.value = nextStep;
                }
              },
              child: Text(stepData.cancelLabel),
            ),
          ],
        ),
      ],
    );
  }

  static String? defaultValidate() {
    return null;
  }
}
