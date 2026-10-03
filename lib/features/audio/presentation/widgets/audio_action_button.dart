import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/widgets/app_button.dart';

class AudioActionButton extends StatelessWidget {
  const AudioActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isStopAction = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isStopAction;

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: label,
      icon: icon,
      onPressed: onPressed,
      isDestructive: isStopAction,
    );
  }
}
