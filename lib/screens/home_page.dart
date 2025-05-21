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
      backgroundColor:  Colors.white,
      appBar: AppBar(

        backgroundColor:  Colors.white,
      ),
        drawer: Drawer(
          backgroundColor: const Color(0xFFE0E5EC),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E5EC),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(-6.0, -6.0),
                      blurRadius: 16.0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(6.0, 6.0),
                      blurRadius: 16.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFE0E5EC),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.8),
                            offset: const Offset(-4.0, -4.0),
                            blurRadius: 8.0,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(4.0, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '$firstName $surname',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${user?.email}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.blue.shade900.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildNeumorphicItem(context, 'Academia', Icons.school, '/academia'),
              _buildNeumorphicItem(context, 'Food', Icons.fastfood, '/food'),
              _buildNeumorphicItem(context, 'Library', Icons.library_books, '/library'),
              _buildNeumorphicItem(context, 'Finance', Icons.account_balance_wallet, '/finance'),
              _buildNeumorphicItem(context, 'Health', Icons.health_and_safety, '/health'),
              _buildNeumorphicItem(context, 'Sports', Icons.sports_soccer, '/sports'),
              _buildNeumorphicItem(context, 'Timetable', Icons.book, '/timetable'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(color: Colors.blue.shade900.withOpacity(0.2)),
              ),
              _buildNeumorphicItem(context, 'Settings', Icons.settings, '/settings'),
              _buildNeumorphicItem(context, 'About Us', Icons.info, '/about'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Divider(color: Colors.blue.shade900.withOpacity(0.2)),
              ),
              _buildNeumorphicItem(
                context,
                'Logout',
                Icons.logout,
                '/login',
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),


      body: isLoading
          ? const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3A7FD5)),
          )
      )
              : Column(
          children: [

          _buildHeader(context),


      _buildWelcomeSection(),


      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.1,
            physics: const BouncingScrollPhysics(),
            children: [
              _dashboardTile(context, 'Academia', Icons.school_outlined, '/academia', const Color(0xFF6F8DF7)),
              _dashboardTile(context, 'Food', Icons.restaurant_outlined, '/food', const Color(0xFFF77F6F)),
              _dashboardTile(context, 'Library', Icons.library_books_outlined, '/library', const Color(0xFF6FD8F7)),
              _dashboardTile(context, 'Finance', Icons.account_balance_wallet_outlined, '/finance', const Color(0xFFF7B46F)),
              _dashboardTile(context, 'Health', Icons.health_and_safety_outlined, '/health', const Color(0xFF8F6FF7)),
              _dashboardTile(context, 'Sports', Icons.sports_soccer_outlined, '/sports', const Color(0xFF6FF78F)),
            ],
          ),
        ),
      ),


      Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          '© MSU ${DateFormat('y').format(DateTime.now())}',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black54,
            letterSpacing: 0.5,
          ),
        ),
      ),
      ],
    ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        // Profile avatar
        Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(Icons.person_outline, color: Color(0xFF3A7FD5)),
      ),


      Image.asset(
        'assets/msu_logo.png',
        height: 50,
        fit: BoxFit.contain,
      ),


      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),

        child: Stack(
            children: [
        const Center(
        child: Icon(Icons.notifications_outlined, color: Color(0xFF3A7FD5)),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
          ),
        ),
        ],
      ),
    ),
    ],
    ),
    );
  }

  Widget _buildWelcomeSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome back,',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            firstName,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A3E72),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF3A7FD5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dashboardTile(BuildContext context, String label, IconData icon, String route, Color color) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    color.withOpacity(0.2),
                    color.withOpacity(0.1),
                  ],
                ),
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A3E72),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeumorphicItem(
      BuildContext context,
      String title,
      IconData icon,
      String route,
      {VoidCallback? onTap}
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E5EC),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: const Offset(-4.0, -4.0),
              blurRadius: 8.0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(4.0, 4.0),
              blurRadius: 8.0,
            ),
          ],
        ),
        child: ListTile(
          onTap: onTap ?? () => Navigator.pushNamed(context, route),
          leading: Icon(
            icon,
            color: Colors.blue.shade800,
          ),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.blue.shade900,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.blue.shade800,
          ),
        ),
      ),
    );
  }
}