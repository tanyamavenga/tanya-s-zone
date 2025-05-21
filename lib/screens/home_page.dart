import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = '';
  String surname = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final data = doc.data();
      if (data != null) {
        setState(() {
          firstName = data['firstName'] ?? '';
          surname = data['surname'] ?? '';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4FF),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("MSU eLearning Home"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$firstName $surname',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${user?.email}',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            _drawerItem(context, 'Academia', Icons.school, '/academia'),
            _drawerItem(context, 'Food', Icons.fastfood, '/food'),
            _drawerItem(context, 'Library', Icons.library_books, '/library'),
            _drawerItem(context, 'Finance', Icons.account_balance_wallet, '/finance'),
            _drawerItem(context, 'Health', Icons.health_and_safety, '/health'),
            _drawerItem(context, 'Sports', Icons.sports_soccer, '/sports'),
            const Divider(),
            _drawerItem(context, 'Settings', Icons.settings, '/settings'),
            _drawerItem(context, 'About Us', Icons.info, '/about'),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/msu_logo.png',
                  height: 80,
                ),
                const SizedBox(height: 10),
                Text(
                  'Welcome, $firstName!',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(16),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      _dashboardTile(context, 'Academia', Icons.school, '/academia'),
                      _dashboardTile(context, 'Food', Icons.fastfood, '/food'),
                      _dashboardTile(context, 'Library', Icons.library_books, '/library'),
                      _dashboardTile(context, 'Finance', Icons.account_balance_wallet, '/finance'),
                      _dashboardTile(context, 'Health', Icons.health_and_safety, '/health'),
                      _dashboardTile(context, 'Sports', Icons.sports_soccer, '/sports'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    '© MSU ${DateFormat('y').format(DateTime.now())}. All rights reserved.',
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.black54),
                  ),
                )
              ],
            ),
    );
  }

  Widget _dashboardTile(BuildContext context, String label, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blueAccent),
            const SizedBox(height: 10),
            Text(label, style: GoogleFonts.poppins(fontSize: 16))
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String label, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}