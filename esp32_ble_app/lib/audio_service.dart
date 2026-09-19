// audio_service.dart
import 'package:audioplayers/audioplayers.dart';

class GlobalAudio {
  static final GlobalAudio instance = GlobalAudio._internal();
  final AudioPlayer sharedPlayer = AudioPlayer();

  String? currentlyPlayingFile;  // store current file name
  String? currentlyPlayingLabel; // store current label

  GlobalAudio._internal();
}
