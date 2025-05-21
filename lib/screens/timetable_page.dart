import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimetablePage extends StatelessWidget {
  const TimetablePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Map<String, String>>> timetable = {
      'Monday': [
        {'time': '08:00 - 09:30', 'module': 'CSC101 - Intro to Programming'},
        {'time': '10:00 - 11:30', 'module': 'MAT201 - Calculus II'},
      ],
      'Tuesday': [
        {'time': '09:00 - 10:30', 'module': 'PHY150 - Modern Physics'},
        {'time': '13:00 - 14:30', 'module': 'MAT201 - Calculus II'},
      ],
      'Wednesday': [
        {'time': '08:00 - 09:30', 'module': 'CSC101 - Intro to Programming'},
        {'time': '11:00 - 12:30', 'module': 'PHY150 - Modern Physics'},
      ],
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Timetable'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Class Schedule',
                style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...timetable.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent)),
                  const SizedBox(height: 8),
                  ...entry.value.map((session) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.schedule, color: Colors.blueAccent),
                        title: Text(session['module']!,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                        subtitle: Text(session['time']!,
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                ],
              );
            }),
            Center(
              child: Text('© MSU ${DateTime.now().year} — All Rights Reserved',
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}