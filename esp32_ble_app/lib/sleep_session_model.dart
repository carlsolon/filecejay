class SleepSession {
  final String date;
  final String duration;
  final String start;
  final String wake;
  final String temp;
  final String vibration;

  SleepSession({
    required this.date,
    required this.duration,
    required this.start,
    required this.wake,
    required this.temp,
    required this.vibration,
  });

  // Create SleepSession from Firestore map
  factory SleepSession.fromMap(Map<String, dynamic> map) {
    return SleepSession(
      date: map['date'] ?? '',
      duration: map['duration'] ?? '-',
      start: map['start'] ?? '-',
      wake: map['wake'] ?? '-',
      temp: map['temp'] ?? '-',
      vibration: map['vibration'] ?? '-',
    );
  }

  // Convert SleepSession to map (if you want to save to Firestore)
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'duration': duration,
      'start': start,
      'wake': wake,
      'temp': temp,
      'vibration': vibration,
    };
  }
}
