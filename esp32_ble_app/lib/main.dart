import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

/// ================= BLE MOCK =================
class BLEManager {
  BLEManager._();
  static final instance = BLEManager._();

  bool connected = false;

  final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  Stream<bool> get connectionStream => _controller.stream;

  Future<void> send(String command) async {
    if (!connected) return;
    debugPrint("BLE SEND ➜ $command");
  }

  Future<void> connect(String device) async {
    connected = true;
    _controller.add(true);
    debugPrint("Connected to $device");
  }

  Future<void> disconnect() async {
    connected = false;
    _controller.add(false);
    debugPrint("Disconnected");
  }
}

/// ================= AUDIO =================
class GlobalAudio {
  GlobalAudio._();
  static final instance = GlobalAudio._();

  final AudioPlayer sharedPlayer = AudioPlayer();
}

/// ================= OTHER SCREENS =================
class SleepSessionScreen extends StatelessWidget {
  const SleepSessionScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Sleep History")),
        body: const Center(child: Text("Sleep records go here")),
      );
}

class SoundScreen extends StatelessWidget {
  const SoundScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text("Select Sound")),
        body: ListView(
          children: [
            _tile(context, "Rain", "rain.mp3"),
            _tile(context, "Ocean", "ocean.mp3"),
            _tile(context, "Forest", "forest.mp3"),
          ],
        ),
      );

  Widget _tile(BuildContext context, String label, String file) {
    return ListTile(
      title: Text(label),
      trailing: const Icon(Icons.music_note),
      onTap: () {
        Navigator.pop(context, {'label': label, 'file': file});
      },
    );
  }
}

/// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComfortNap',
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme()),
      home: const ComfortNapScreen(),
    );
  }
}

/// ================= MAIN SCREEN =================
class ComfortNapScreen extends StatefulWidget {
  const ComfortNapScreen({super.key});

  @override
  State<ComfortNapScreen> createState() => _ComfortNapScreenState();
}

class _ComfortNapScreenState extends State<ComfortNapScreen> {
  double vibrationLevel = 0.6;
  double heatLevel = 21.0;
  double musicVolume = 0.6;
  bool bleConnected = false;

  Timer? _sleepTimer;

  final AudioPlayer _audioPlayer = GlobalAudio.instance.sharedPlayer;
  String? selectedSoundLabel;
  String? selectedSoundFile;

  @override
  void initState() {
    super.initState();
    BLEManager.instance.connectionStream.listen((status) {
      if (mounted) setState(() => bleConnected = status);
    });
  }

  /// ================= FUNCTIONS =================
  Future<void> _playSelectedSound() async {
    if (selectedSoundFile == null) return;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource('sounds/$selectedSoundFile'));
    await _audioPlayer.setVolume(musicVolume);
  }

  void _startSession() {
    BLEManager.instance.send("START");
    BLEManager.instance.send("VIBRATION:$vibrationLevel");
    BLEManager.instance.send("HEAT:$heatLevel");
    _playSelectedSound();
    debugPrint("Session Started");
  }

  void _stopSession() {
    BLEManager.instance.send("STOP");
    _audioPlayer.stop();
    _sleepTimer?.cancel();
    debugPrint("Session Stopped");
  }

  void _setTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = Timer(const Duration(minutes: 30), _stopSession);
    debugPrint("Timer set for 30 minutes");
  }

  Future<void> _selectSound() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SoundScreen()),
    );

    if (result != null) {
      setState(() {
        selectedSoundLabel = result['label'];
        selectedSoundFile = result['file'];
      });
    }
  }

  @override
  void dispose() {
    _sleepTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 24),

              _slider(
                "Vibration Level",
                Icons.vibration,
                Colors.blue,
                vibrationLevel,
                0,
                1,
                "${(vibrationLevel * 100).round()}%",
                (v) {
                  setState(() => vibrationLevel = v);
                  BLEManager.instance.send("VIBRATION:$v");
                },
              ),

              const SizedBox(height: 16),

              _slider(
                "Heat Level",
                Icons.thermostat,
                Colors.orange,
                heatLevel,
                20,
                50,
                "${heatLevel.round()}°C",
                (v) {
                  setState(() => heatLevel = v);
                  BLEManager.instance.send("HEAT:$v");
                },
              ),

              const SizedBox(height: 16),

              _musicCard(),

              const SizedBox(height: 16),

              _row("Set Timer", Icons.hourglass_bottom, Colors.yellow,
                  _setTimer),

              const SizedBox(height: 16),

              _button("Start Session", Colors.blueAccent, _startSession),
              const SizedBox(height: 12),
              _button("Stop Session", Colors.redAccent, _stopSession),

              const SizedBox(height: 16),

              _row("Sleep Sounds", Icons.music_note, Colors.white,
                  _selectSound),

              const Spacer(),

              _button(
                bleConnected ? "Disconnect" : "Connect",
                bleConnected ? Colors.redAccent : Colors.green,
                () async {
                  bleConnected
                      ? await BLEManager.instance.disconnect()
                      : await BLEManager.instance.connect("ESP32");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= WIDGETS =================
  Widget _header() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("ComfortNap",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.history, color: Colors.cyanAccent),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SleepSessionScreen()),
            ),
          )
        ],
      );

  Widget _row(String text, IconData icon, Color color, VoidCallback tap) =>
      InkWell(
        onTap: tap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1B48),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 12),
              Text(text,
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.white),
            ],
          ),
        ),
      );

  Widget _button(String text, Color color, VoidCallback tap) =>
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          onPressed: tap,
          child: Text(text,
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w600)),
        ),
      );

  Widget _slider(
    String title,
    IconData icon,
    Color color,
    double value,
    double min,
    double max,
    String label,
    Function(double) onChanged,
  ) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1B48),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    GoogleFonts.poppins(color: Colors.white, fontSize: 18)),
            Row(
              children: [
                Icon(icon, color: color),
                Expanded(
                  child: Slider(
                    value: value,
                    min: min,
                    max: max,
                    activeColor: color,
                    onChanged: onChanged,
                  ),
                ),
                Text(label,
                    style: GoogleFonts.poppins(color: Colors.white)),
              ],
            ),
          ],
        ),
      );

  Widget _musicCard() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1B48),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Music Sounds",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600)),
            Row(
              children: [
                const Icon(Icons.music_note, color: Colors.purple),
                const SizedBox(width: 12),
                Text(selectedSoundLabel ?? "None",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 16)),
                const Spacer(),
                IconButton(
                    icon: const Icon(Icons.play_arrow, color: Colors.purple),
                    onPressed: _playSelectedSound),
                IconButton(
                    icon: const Icon(Icons.stop, color: Colors.red),
                    onPressed: _stopSession),
              ],
            ),
            Slider(
              value: musicVolume,
              min: 0,
              max: 1,
              activeColor: Colors.purple,
              onChanged: (v) async {
                setState(() => musicVolume = v);
                await _audioPlayer.setVolume(v);
              },
            )
          ],
        ),
      );
}
