import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class IndependentStepper extends StatelessWidget {
  final List<IndependentStep> steps;
  final int currentStep;

  final bool showCompleteButtons;

  final String confirmLabel;
  final void Function()? onConfirm;

  final String cancelLabel;
  final void Function()? onCancel;

  const IndependentStepper({
    super.key,
    required this.steps,
    required this.currentStep,
    this.showCompleteButtons = false,
    this.onConfirm,
    this.onCancel,
    this.confirmLabel = "Confirm",
    this.cancelLabel = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stepper(
          steps: steps
              .mapIndexed(
                (index, step) => Step(
                  isActive: index == currentStep,
                  title: Text(
                    step.title,
                  ),
                  content: step,
                ),
              )
              .toList(),
          currentStep: currentStep,
          controlsBuilder: (context, details) => const SizedBox.shrink(),
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
}

class IndependentStep extends StatelessWidget {
  final String title;
  final Widget child;

  final String continueLabel;
  final void Function()? onContinue;

  final String cancelLabel;
  final void Function()? onCancel;

  final Alignment alignment;

  const IndependentStep({
    super.key,
    required this.title,
    required this.child,
    this.continueLabel = "Continue",
    required this.onContinue,
    this.cancelLabel = "Cancel",
    required this.onCancel,
    this.alignment = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        Row(
          children: [
            ElevatedButton(
              onPressed: onContinue,
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
              child: Text(
                continueLabel,
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(onPressed: onCancel, child: Text(cancelLabel)),
          ],
        ),
      ],
    );
  }
}
