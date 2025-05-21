import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AcademiaPage extends StatefulWidget {
  const AcademiaPage({super.key});

  @override
  State<AcademiaPage> createState() => _AcademiaPageState();
}

class _AcademiaPageState extends State<AcademiaPage> {
  String firstName = '';
  String surname = '';
  String program = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          firstName = data['firstName'] ?? '';
          surname = data['surname'] ?? '';
          program = data['program'] ?? '';
          isLoading = false;
        });
      }
    }
  }

  Stream<QuerySnapshot> getCourses() {
    return FirebaseFirestore.instance
        .collection('courses')
        .where('program', isEqualTo: program)
        .snapshots();
  }

  Stream<QuerySnapshot> getAnnouncements() {
    return FirebaseFirestore.instance.collection('announcements').snapshots();
  }

  Stream<QuerySnapshot> getTimetable() {
    return FirebaseFirestore.instance
        .collection('timetable')
        .where('program', isEqualTo: program)
        .snapshots();
  }

  Stream<QuerySnapshot> getLecturers() {
    return FirebaseFirestore.instance.collection('lecturers').snapshots();
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Text(title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Academia"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          sectionTitle('Student Profile'),
          ListTile(
            title: Text('$firstName $surname', style: GoogleFonts.poppins()),
            subtitle: Text('Program: $program', style: GoogleFonts.poppins()),
            trailing: Chip(label: Text("Registered")),
          ),

          sectionTitle('Your Modules'),
          StreamBuilder<QuerySnapshot>(
            stream: getCourses(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      title: Text(data['title'], style: GoogleFonts.poppins()),
                      subtitle: Text(data['description'] ?? ''),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          sectionTitle('Timetable'),
          StreamBuilder<QuerySnapshot>(
            stream: getTimetable(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['title'], style: GoogleFonts.poppins()),
                    subtitle: Text('${data['day']} at ${data['time']}'),
                    leading: const Icon(Icons.schedule),
                  );
                }).toList(),
              );
            },
          ),

          sectionTitle('Announcements'),
          StreamBuilder<QuerySnapshot>(
            stream: getAnnouncements(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['title'], style: GoogleFonts.poppins()),
                    subtitle: Text(data['body']),
                    leading: const Icon(Icons.campaign),
                  );
                }).toList(),
              );
            },
          ),

          sectionTitle('Smart AI Assistant'),
          ListTile(
            title: Text('Suggested: Take additional courses in Data Science or AI.',
                style: GoogleFonts.poppins()),
            subtitle: Text('More AI features coming soon...'),
            leading: const Icon(Icons.smart_toy),
          ),

          sectionTitle('Career Guidance'),
          ListTile(
            title: Text('VacancyMail: Software Developer Intern – Harare',
                style: GoogleFonts.poppins()),
            subtitle: Text('Visit VacancyMail.co.zw for more.'),
            leading: const Icon(Icons.work_outline),
          ),

          sectionTitle('Lecturer Connect'),
          StreamBuilder<QuerySnapshot>(
            stream: getLecturers(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const CircularProgressIndicator();
              return Column(
                children: snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['name'], style: GoogleFonts.poppins()),
                    subtitle: Text('${data['email']} | ${data['phone']}'),
                    leading: const Icon(Icons.person),
                  );
                }).toList(),
              );
            },
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}