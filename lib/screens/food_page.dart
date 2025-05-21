import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  final List<Map<String, String>> menu = const [
    {'day': 'Monday', 'meal': 'Rice, Chicken, Salad'},
    {'day': 'Tuesday', 'meal': 'Sadza, Beef Stew, Vegetables'},
    {'day': 'Wednesday', 'meal': 'Spaghetti, Mince, Beans'},
  ];

  final List<Map<String, String>> cafeterias = const [
    {'name': 'Main Cafeteria', 'hours': '8:00 AM - 6:00 PM'},
    {'name': 'North Campus Café', 'hours': '9:00 AM - 5:00 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Meal Account',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 16),
            _buildBalanceCard('\$120.00'),
            const SizedBox(height: 24),
            Text(
              'Weekly Menu',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...menu.map((item) => _buildMenuTile(item)),
            const SizedBox(height: 24),
            Text(
              'Cafeteria Info',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...cafeterias.map((cafe) => _buildCafeTile(cafe)),
            const SizedBox(height: 24),
            _buildActionButton('Load Meals', Icons.fastfood),
            _buildActionButton('Meal Purchase History', Icons.history),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(String balance) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet, color: Colors.green),
        title: Text('Meal Balance', style: GoogleFonts.poppins(fontSize: 16)),
        trailing: Text(
          balance,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile(Map<String, String> item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.restaurant_menu, color: Colors.orange),
        title: Text(item['day']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text(item['meal']!, style: GoogleFonts.poppins(fontSize: 14)),
      ),
    );
  }

  Widget _buildCafeTile(Map<String, String> cafe) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.location_on, color: Colors.red),
        title: Text(cafe['name']!, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        subtitle: Text('Open: ${cafe['hours']}'),
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