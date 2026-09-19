import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class SleepSessionScreen extends StatefulWidget {
  const SleepSessionScreen({super.key});

  @override
  State<SleepSessionScreen> createState() => _SleepSessionScreenState();
}

class _SleepSessionScreenState extends State<SleepSessionScreen> {
  DateTime selectedDate = DateTime.now();

  final Map<String, Map<String, String>> sleepData = {
    "Sun": {"Duration": "7h 10m", "Start": "9:15 PM", "Wake": "6:25 AM", "Temp": "36°C", "Vibration": "55%"},
    "Mon": {"Duration": "6h 45m", "Start": "8:00 PM", "Wake": "6:00 AM", "Temp": "38°C", "Vibration": "60%"},
    "Tue": {"Duration": "7h 30m", "Start": "9:00 PM", "Wake": "6:30 AM", "Temp": "37°C", "Vibration": "50%"},
    "Wed": {"Duration": "5h 55m", "Start": "11:15 PM", "Wake": "5:10 AM", "Temp": "39°C", "Vibration": "40%"},
    "Thu": {"Duration": "8h 05m", "Start": "9:00 PM", "Wake": "5:05 AM", "Temp": "37°C", "Vibration": "70%"},
    "Fri": {"Duration": "6h 20m", "Start": "10:00 PM", "Wake": "6:20 AM", "Temp": "38°C", "Vibration": "65%"},
    "Sat": {"Duration": "9h 00m", "Start": "8:30 PM", "Wake": "5:30 AM", "Temp": "37°C", "Vibration": "50%"},
  };

  List<DateTime> getCurrentWeek() {
    final now = DateTime.now();
    int weekday = now.weekday % 7;
    DateTime sunday = now.subtract(Duration(days: weekday));
    return List.generate(7, (i) => sunday.add(Duration(days: i)));
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.indigoAccent,
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1A163F),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    final String fullDay = DateFormat('EEEE').format(selectedDate);
    final String shortDay = DateFormat('E').format(selectedDate).substring(0, 3);
    final String dateText = DateFormat('MMMM d, yyyy').format(selectedDate);
    final data = sleepData[shortDay] ?? {};

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A0734), Color(0xFF1B1464), Color(0xFF000021)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with back and calendar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const Icon(Icons.calendar_month, color: Colors.white, size: 28),
                        onPressed: _pickDate,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Text(fullDay,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
                  Text(dateText,
                      style: const TextStyle(color: Colors.grey, fontSize: 16)),
                  const SizedBox(height: 20),

                  // Week buttons
                  SizedBox(
                    height: 60,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: getCurrentWeek().map((date) {
                        String label = DateFormat('E').format(date).substring(0, 3);
                        bool isSelected = DateFormat('yyyy-MM-dd').format(date) ==
                            DateFormat('yyyy-MM-dd').format(selectedDate);
                        return GestureDetector(
                          onTap: () => setState(() => selectedDate = date),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: isSelected
                                  ? const LinearGradient(colors: [Colors.indigoAccent, Colors.cyanAccent])
                                  : const LinearGradient(colors: [Colors.transparent, Colors.transparent]),
                              border: Border.all(color: Colors.white.withOpacity(0.5)),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: Colors.cyanAccent.withOpacity(0.6),
                                        blurRadius: 12,
                                        offset: const Offset(0, 4),
                                      )
                                    ]
                                  : [],
                            ),
                            child: Center(
                              child: Text(
                                label,
                                style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Glass panel
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: Colors.white.withOpacity(0.15)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Sleep Session Summary",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              const SizedBox(height: 25),
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 160,
                                      width: 160,
                                      child: CircularProgressIndicator(
                                        value: 0.8,
                                        strokeWidth: 10,
                                        backgroundColor: Colors.white24,
                                        color: Colors.cyanAccent,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          data["Duration"] ?? "-",
                                          style: const TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        const Text("Slept",
                                            style: TextStyle(color: Colors.white70)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30),
                              Expanded(
                                child: ListView(
                                  children: [
                                    SleepDetailTile(
                                        icon: Icons.nightlight_round,
                                        label: "Start",
                                        value: data["Start"]),
                                    SleepDetailTile(
                                        icon: Icons.wb_sunny,
                                        label: "Wake",
                                        value: data["Wake"]),
                                    SleepDetailTile(
                                        icon: Icons.thermostat,
                                        label: "Temperature",
                                        value: data["Temp"]),
                                    SleepDetailTile(
                                        icon: Icons.vibration,
                                        label: "Vibration",
                                        value: data["Vibration"]),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SleepDetailTile extends StatelessWidget {
  final IconData icon;
  final String? label;
  final String? value;
  const SleepDetailTile({super.key, required this.icon, this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.cyanAccent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(label ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.white70)),
          ),
          Text(value ?? "-",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
