import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ble_man.dart'; // Import imong BLEManager file

class SetTimerScreen extends StatelessWidget {
  const SetTimerScreen({super.key});

  // Helper function to send timer value to ESP32 via BLE
  void sendTimerCommand(BuildContext context, int seconds) {
    String command = "TIMER:$seconds";

    // ✅ Send command via BLEManager
    BLEManager.instance.send(command);

    print("Sending $command to ESP32");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Timer set to $seconds seconds"),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0731), // dark navy background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              "Set Timer",
              style: GoogleFonts.poppins(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 50),
            _buildTimerButton(context, "10 seconds", seconds: 10),
            const SizedBox(height: 18),
            _buildTimerButton(context, "20 seconds", seconds: 20),
            const SizedBox(height: 18),
            _buildTimerButton(context, "30 seconds", seconds: 30),
            const SizedBox(height: 18),
            _buildTimerButton(context, "1 minute", seconds: 60),
            const SizedBox(height: 18),
            _buildTimerButton(context, "Custom", isCustom: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTimerButton(
    BuildContext context,
    String text, {
    bool isCustom = false,
    int? seconds,
  }) {
    return SizedBox(
      width: double.infinity,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isCustom ? Colors.white : const Color(0xFF1B154B),
            foregroundColor: isCustom ? Colors.black : Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
          ),
          onPressed: () {
            if (isCustom) {
              showDialog(
                context: context,
                builder: (context) {
                  final controller = TextEditingController();
                  return AlertDialog(
                    backgroundColor: const Color(0xFF1B154B),
                    title: const Text("Enter seconds",
                        style: TextStyle(color: Colors.white)),
                    content: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: "e.g. 45",
                        hintStyle: TextStyle(color: Colors.white54),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          final secs = int.tryParse(controller.text) ?? 0;
                          if (secs > 0) {
                            sendTimerCommand(context, secs);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Set"),
                      ),
                    ],
                  );
                },
              );
            } else if (seconds != null) {
              sendTimerCommand(context, seconds);
            }
          },
          child: Text(
            text,
            style: GoogleFonts.robotoMono(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
