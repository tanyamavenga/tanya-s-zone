import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SportsPage extends StatelessWidget {
  const SportsPage({super.key});

  final List<Map<String, String>> events = const [
    {
      'title': 'Interfaculty Soccer Tournament',
      'date': '2025-06-12',
      'location': 'Main Stadium'
    },
    {
      'title': 'Track & Field Trials',
      'date': '2025-06-18',
      'location': 'Athletics Track'
    },
  ];

  final List<Map<String, String>> trainingSchedule = const [
    {
      'sport': 'Soccer',
      'time': 'Mon, Wed, Fri - 4:00 PM',
    },
    {
      'sport': 'Basketball',
      'time': 'Tue, Thu - 3:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sports'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Sports Profile',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoCard('Favorite Sport', 'Soccer'),
            _buildInfoCard('Teams Joined', 'MSU Soccer Club'),
            _buildInfoCard('Position', 'Midfielder'),
            const SizedBox(height: 24),
            Text(
              'Upcoming Events',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...events.map((event) => _buildEventTile(event)),
            const SizedBox(height: 24),
            Text(
              'Training Schedule',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...trainingSchedule.map((train) => _buildTrainingTile(train)),
            const SizedBox(height: 24),
            Text(
              'Quick Actions',
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildActionButton('Register for a Sport', Icons.sports),
            _buildActionButton('View Full Schedule', Icons.calendar_today),
            _buildActionButton('Contact Coach', Icons.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.sports_soccer, color: Colors.orange),
        title: Text(label, style: GoogleFonts.poppins()),
        trailing: Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEventTile(Map<String, String> event) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(event['title']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text('${event['date']} at ${event['location']}'),
        leading: const Icon(Icons.event, color: Colors.green),
      ),
    );
  }

  Widget _buildTrainingTile(Map<String, String> train) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.fitness_center, color: Colors.blueAccent),
        title: Text(train['sport']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text(train['time']!),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 12),
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