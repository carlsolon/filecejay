import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:two/SetTimerScreen.dart';
import 'set_timer_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ComfortNap',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: const ComfortNapScreen(),
    );
  }
}

class ComfortNapScreen extends StatefulWidget {
  const ComfortNapScreen({super.key});

  @override
  State<ComfortNapScreen> createState() => _ComfortNapScreenState();
}

class _ComfortNapScreenState extends State<ComfortNapScreen> {
  double vibrationLevel = 0.6;
  double heatLevel = 38.0;
  double musicVolume = 0.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0B2E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                "ComfortNap",
                style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),

              // Vibration Level
              _buildSliderTile(
                title: "Vibration Level",
                icon: Icons.vibration,
                color: Colors.blue,
                value: vibrationLevel,
                min: 0,
                max: 1,
                label: "${(vibrationLevel * 100).round()}%",
                onChanged: (val) {
                  setState(() => vibrationLevel = val);
                },
              ),
              const SizedBox(height: 16),

              // Heat Level
              _buildSliderTile(
                title: "Heat Level",
                icon: Icons.thermostat,
                color: Colors.orange,
                value: heatLevel,
                min: 20,
                max: 50,
                label: "${heatLevel.round()}°C",
                onChanged: (val) {
                  setState(() => heatLevel = val);
                },
              ),
              const SizedBox(height: 16),

              // Music Sounds
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1B48),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Music Sounds",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.play_arrow, color: Colors.white),
                        const SizedBox(width: 6),
                        Text(
                          "Rain",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: musicVolume,
                      min: 0,
                      max: 1,
                      activeColor: Colors.purple,
                      inactiveColor: Colors.purple.withOpacity(0.4),
                      onChanged: (val) {
                        setState(() => musicVolume = val);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Timer (Clickable)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SetTimerScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1B48),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.hourglass_bottom, color: Colors.yellow),
                      const SizedBox(width: 8),
                      Text(
                        "Set Timer",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, color: Colors.yellow),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Start Session Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Start Session",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Sleep Sounds
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1B48),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      "Sleep Sounds",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ],
                ),
              ),

              const Spacer(),

              // Connected Button with Bluetooth logo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.green.shade600,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.bluetooth, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      "Connected",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSliderTile({
    required String title,
    required IconData icon,
    required Color color,
    required double value,
    required double min,
    required double max,
    required String label,
    required Function(double) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B48),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, color: color),
              Expanded(
                child: Slider(
                  value: value,
                  min: min,
                  max: max,
                  activeColor: color,
                  inactiveColor: color.withOpacity(0.4),
                  onChanged: onChanged,
                ),
              ),
              Text(label, style: GoogleFonts.poppins(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
