import 'package:flutter/material.dart';

enum AudioStatus {
  idle('Ready to record', Icons.mic_none),
  recording('Recording...', Icons.mic),
  recorded('Recording saved', Icons.check_circle_outline),
  playing('Playing...', Icons.volume_up);

  const AudioStatus(this.label, this.icon);

  final String label;
  final IconData icon;
}
