import 'package:audioplayers/audioplayers.dart' show AudioPlayer, DeviceFileSource;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart' show AudioRecorder, RecordConfig;

class AudioService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  String? _recordingPath;

  bool get hasRecording => _recordingPath != null;

  Stream<void> get onPlaybackCompleted => _player.onPlayerComplete;

  Future<bool> startRecording() async {
    if (!await _recorder.hasPermission()) return false;

    final directory = await getTemporaryDirectory();
    final fileName = 'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: '${directory.path}/$fileName');
    return true;
  }

  Future<void> stopRecording() async {
    final path = await _recorder.stop();
    if (path != null) _recordingPath = path;
  }

  Future<void> playRecording() async {
    final path = _recordingPath;
    if (path == null) throw StateError('There is no recording to play.');

    await _player.play(DeviceFileSource(path));
  }

  Future<void> stopPlayback() => _player.stop();

  Future<void> dispose() async {
    await _recorder.dispose();
    await _player.dispose();
  }
}
