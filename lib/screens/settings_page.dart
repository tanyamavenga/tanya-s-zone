import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'About Us',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Midlands State University (MSU) is committed to academic excellence and innovation. '
            'This app is developed for MSU students to simplify learning and campus life.',
            style: GoogleFonts.poppins(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Text(
            'App Information',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.blueAccent),
            title: Text('Version', style: GoogleFonts.poppins()),
            subtitle: Text('1.0.0', style: GoogleFonts.poppins(fontSize: 14)),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blueAccent),
            title: Text('Developer', style: GoogleFonts.poppins()),
            subtitle: Text('MSU Dev Team', style: GoogleFonts.poppins(fontSize: 14)),
          ),
          ListTile(
            leading: const Icon(Icons.email, color: Colors.blueAccent),
            title: Text('Contact', style: GoogleFonts.poppins()),
            subtitle: Text('support@msu.ac.zw', style: GoogleFonts.poppins(fontSize: 14)),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              '© MSU ${DateTime.now().year} — All Rights Reserved',
              style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
            ),
          )
        ],
      ),
    );
  }
}