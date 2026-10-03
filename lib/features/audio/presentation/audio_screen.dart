import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_device_features/core/constants/app_spacing.dart';
import 'package:flutter_device_features/core/widgets/app_snack_bar.dart';
import 'package:flutter_device_features/features/audio/data/audio_service.dart';
import 'package:flutter_device_features/features/audio/presentation/audio_status.dart';
import 'package:flutter_device_features/features/audio/presentation/widgets/audio_action_button.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioService _audioService = AudioService();
  late final StreamSubscription<void> _playbackCompletedSubscription;
  AudioStatus _status = AudioStatus.idle;

  @override
  void initState() {
    super.initState();
    _playbackCompletedSubscription = _audioService.onPlaybackCompleted.listen((
      _,
    ) {
      if (mounted) setState(() => _status = AudioStatus.recorded);
    });
  }

  @override
  void dispose() {
    _playbackCompletedSubscription.cancel();
    _audioService.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      final didStart = await _audioService.startRecording();
      if (!mounted) return;

      if (didStart) {
        setState(() => _status = AudioStatus.recording);
      } else {
        showAppSnackBar(
          context,
          'Microphone permission is required to record audio.',
        );
      }
    } on Exception {
      if (!mounted) return;
      showAppSnackBar(context, 'Could not start recording.');
    }
  }

  Future<void> _stopRecording() async {
    try {
      await _audioService.stopRecording();
    } on Exception {
      if (!mounted) return;
      showAppSnackBar(context, 'Could not save the recording.');
    }
    if (!mounted) return;

    setState(() {
      _status = _audioService.hasRecording
          ? AudioStatus.recorded
          : AudioStatus.idle;
    });
  }

  Future<void> _playRecording() async {
    try {
      await _audioService.playRecording();
      if (!mounted) return;
      setState(() => _status = AudioStatus.playing);
    } on Exception {
      if (!mounted) return;
      showAppSnackBar(context, 'Could not play the recording.');
    }
  }

  Future<void> _stopPlayback() async {
    await _audioService.stopPlayback();
    if (!mounted) return;
    setState(() => _status = AudioStatus.recorded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isRecording = _status == AudioStatus.recording;
    final isPlaying = _status == AudioStatus.playing;
    final canPlay = _status == AudioStatus.recorded || isPlaying;

    return Scaffold(
      appBar: AppBar(title: const Text('Audio Recorder')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.large),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _status.icon,
                  size: 72,
                  color: isRecording
                      ? theme.colorScheme.error
                      : theme.colorScheme.primary,
                ),
                const SizedBox(height: AppSpacing.medium),
                Text(_status.label, style: theme.textTheme.titleMedium),
                const SizedBox(height: AppSpacing.large),
                AudioActionButton(
                  label: isRecording ? 'Stop Recording' : 'Record Audio',
                  icon: isRecording ? Icons.stop : Icons.mic,
                  isStopAction: isRecording,
                  onPressed: isPlaying
                      ? null
                      : (isRecording ? _stopRecording : _startRecording),
                ),
                if (canPlay) ...[
                  const SizedBox(height: AppSpacing.medium),
                  AudioActionButton(
                    label: isPlaying ? 'Stop Audio' : 'Play Audio',
                    icon: isPlaying ? Icons.stop : Icons.play_arrow,
                    isStopAction: isPlaying,
                    onPressed: isPlaying ? _stopPlayback : _playRecording,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
