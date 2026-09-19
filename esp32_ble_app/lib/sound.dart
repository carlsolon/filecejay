// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class SoundScreen extends StatefulWidget {
//   const SoundScreen({super.key});

//   @override
//   State<SoundScreen> createState() => _SoundScreenState();
// }

// class _SoundScreenState extends State<SoundScreen> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isDisposed = false; // Track if widget is disposed
//   String? currentlyPlaying;

//   final List<Map<String, dynamic>> sounds = [
//     {"icon": Icons.cloud, "label": "Rain", "file": "calming-rain-257596.mp3"},
//     {
//       "icon": Icons.ac_unit,
//       "label": "Snow",
//       "file": "sledding-on-snow-sliding-on-snow-snow-and-sledding-16590.mp3"
//     },
//     {"icon": Icons.nightlight_round, "label": "Owl", "file": "scops-owl-57475.mp3"},
//     {"icon": Icons.filter_vintage, "label": "Bird", "file": "bird-chipping-426107.mp3"},
//     {"icon": Icons.local_fire_department, "label": "Fire", "file": "crackle-fireplace-campfire-402289.mp3"},
//     {"icon": Icons.bedtime, "label": "Night", "file": "night-ambience-17064.mp3"},
//     {"icon": Icons.waves, "label": "Ocean", "file": "ocean-waves-crashing-the-shoreline-423649.mp3"},
//     {"icon": Icons.air, "label": "Wind", "file": "wind-blowing-sfx-01-423673.mp3"},
//     {"icon": Icons.chair, "label": "Swing", "file": "swing-squeak-73201.mp3"},
//   ];

//   Future<void> playSound(String fileName) async {
//     try {
//       // Stop previous sound
//       await _audioPlayer.stop();

//       if (_isDisposed) return;

//       // Set looping
//       await _audioPlayer.setReleaseMode(ReleaseMode.loop);

//       // Play new sound
//       await _audioPlayer.play(AssetSource('sounds/$fileName'));

//       setState(() {
//         currentlyPlaying = fileName;
//       });
//     } catch (e) {
//       print("⚠️ Error playing sound: $e");
//     }
//   }

//   Future<void> stopSound() async {
//     try {
//       await _audioPlayer.stop();
//       setState(() {
//         currentlyPlaying = null;
//       });
//     } catch (e) {
//       print("⚠️ Error stopping sound: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _isDisposed = true;
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0B0530),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1E1B48),
//         elevation: 0,
//         title: const Text(
//           "Sleep Sounds",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: GridView.builder(
//                   itemCount: sounds.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 15,
//                     mainAxisSpacing: 15,
//                   ),
//                   itemBuilder: (context, index) {
//                     final sound = sounds[index];
//                     bool isPlaying = currentlyPlaying == sound['file'];

//                     return GestureDetector(
//                       onTap: () async {
//                         await playSound(sound['file']);

//                         // Optional: show snackbar
//                         if (mounted) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text(
//                                 "${sound['label']} is now playing (looping)",
//                               ),
//                               duration: const Duration(seconds: 1),
//                             ),
//                           );
//                         }
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: isPlaying ? Colors.purple : Colors.indigo.shade800,
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(sound["icon"], color: Colors.white, size: 40),
//                             const SizedBox(height: 10),
//                             Text(
//                               sound["label"],
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 15),
//               ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.redAccent,
//                   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                 ),
//                 icon: const Icon(Icons.stop, color: Colors.white),
//                 label: const Text("Stop Sound", style: TextStyle(color: Colors.white)),
//                 onPressed: stopSound,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// sound.dart
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'audio_service.dart'; // Import global player
import 'package:google_fonts/google_fonts.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({super.key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  final AudioPlayer _audioPlayer = GlobalAudio.instance.sharedPlayer;

  // Local UI tracking
  String? currentlyPlaying;

  final List<Map<String, dynamic>> sounds = [
    {"icon": Icons.cloud, "label": "Rain", "file": "calming-rain-257596.mp3"},
    {"icon": Icons.ac_unit, "label": "Snow", "file": "sledding-on-snow-sliding-on-snow-snow-and-sledding-16590.mp3"},
    {"icon": Icons.nightlight_round, "label": "Owl", "file": "scops-owl-57475.mp3"},
    {"icon": Icons.filter_vintage, "label": "Bird", "file": "bird-chipping-426107.mp3"},
    {"icon": Icons.local_fire_department, "label": "Fire", "file": "crackle-fireplace-campfire-402289.mp3"},
    {"icon": Icons.bedtime, "label": "Night", "file": "night-ambience-17064.mp3"},
    {"icon": Icons.waves, "label": "Ocean", "file": "ocean-waves-crashing-the-shoreline-423649.mp3"},
    {"icon": Icons.air, "label": "Wind", "file": "wind-blowing-sfx-01-423673.mp3"},
    {"icon": Icons.chair, "label": "Swing", "file": "swing-squeak-73201.mp3"},
  ];

@override
void initState() {
  super.initState();

  // This will trigger rebuild every time player state changes
  _audioPlayer.onPlayerStateChanged.listen((state) {
    if (!mounted) return;
    setState(() {}); // rebuild HomeScreen UI automatically
  });
}

 Future<void> playSound(String fileName, String label) async {
  try {
    await _audioPlayer.stop();
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('sounds/$fileName'));

    // Update global info
    GlobalAudio.instance.currentlyPlayingFile = fileName;
    GlobalAudio.instance.currentlyPlayingLabel = label;

    if (!mounted) return;
    setState(() {}); // rebuild the UI
  } catch (e) {
    print("⚠️ Error playing sound: $e");
  }
}

Future<void> stopSound() async {
  try {
    await _audioPlayer.stop();

    // Reset global info
    GlobalAudio.instance.currentlyPlayingFile = null;
    GlobalAudio.instance.currentlyPlayingLabel = null;

    if (!mounted) return;
    setState(() {});
  } catch (e) {
    print("⚠️ Error stopping sound: $e");
  }
}


  @override
  void dispose() {
    // Do NOT dispose the global player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentlyPlayingFile = GlobalAudio.instance.currentlyPlayingFile;
    final currentlyPlayingLabel = GlobalAudio.instance.currentlyPlayingLabel;

    return Scaffold(
      backgroundColor: const Color(0xFF0B0530),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1B48),
        elevation: 0,
        title: const Text(
          "Sleep Sounds",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Display currently playing label
              if (currentlyPlayingLabel != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Now Playing: $currentlyPlayingLabel",
                    style: GoogleFonts.poppins(
                        color: Colors.cyanAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              Expanded(
                child: GridView.builder(
                  itemCount: sounds.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    final sound = sounds[index];
                    bool isPlaying = currentlyPlayingFile == sound['file'];

                    return GestureDetector(
                      onTap: () async {
                        await playSound(sound['file'], sound['label']);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isPlaying ? Colors.purple : Colors.indigo.shade800,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(sound["icon"], color: Colors.white, size: 40),
                            const SizedBox(height: 10),
                            Text(
                              sound["label"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.stop, color: Colors.white),
                label: const Text("Stop Sound", style: TextStyle(color: Colors.white)),
                onPressed: stopSound,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

