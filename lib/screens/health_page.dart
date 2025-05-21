import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  final List<Map<String, String>> appointments = const [
    {
      'date': '2025-06-10',
      'time': '10:30 AM',
      'clinic': 'Campus Medical Centre'
    },
    {
      'date': '2025-06-15',
      'time': '2:00 PM',
      'clinic': 'Mental Wellness Unit'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Health Summary',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            _buildHealthInfoTile('Blood Type', 'O+'),
            _buildHealthInfoTile('Allergies', 'Penicillin, Pollen'),
            _buildHealthInfoTile('Chronic Conditions', 'None'),
            const SizedBox(height: 24),
            Text(
              'Upcoming Appointments',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...appointments.map((appt) => _buildAppointmentTile(appt)),
            const SizedBox(height: 24),
            Text(
              'Quick Access',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildActionButton('Book Appointment', Icons.calendar_today),
            _buildActionButton('View Health Records', Icons.folder_shared),
            _buildActionButton('Mental Health Support', Icons.support),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthInfoTile(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.health_and_safety, color: Colors.blueAccent),
        title: Text(label, style: GoogleFonts.poppins()),
        trailing: Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildAppointmentTile(Map<String, String> appt) {
    return Card(
      child: ListTile(
        title: Text(
          '${appt['clinic']}',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${appt['date']} at ${appt['time']}',
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        leading: const Icon(Icons.local_hospital, color: Colors.green),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(label, style: GoogleFonts.poppins(fontSize: 16)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}