import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinancePage extends StatelessWidget {
  const FinancePage({super.key});

  final List<Map<String, String>> transactions = const [
    {
      'date': '2025-05-01',
      'description': 'Tuition Payment',
      'amount': '- \$1,200'
    },
    {
      'date': '2025-04-15',
      'description': 'Library Fine Payment',
      'amount': '- \$20'
    },
    {
      'date': '2025-04-05',
      'description': 'Meal Top-Up',
      'amount': '- \$100'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Financial Summary',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              _buildBalanceTile('Tuition Balance', '\$800.00'),
              _buildBalanceTile('Meals Balance', '\$75.00'),
              _buildBalanceTile('Library Fines', '\$0.00'),
              const SizedBox(height: 24),
              Text(
                'Recent Transactions',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ...transactions.map((tx) => _buildTransactionTile(tx)),
              const SizedBox(height: 24),
              Text(
                'Payment Options',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _buildPaymentButton('Pay Tuition'),
              _buildPaymentButton('Top-up Meals'),
              _buildPaymentButton('Clear Fines'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceTile(String title, String amount) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(Icons.account_balance_wallet, color: Colors.blueAccent),
        title: Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        trailing: Text(
          amount,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.green[700],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionTile(Map<String, String> tx) {
    return Card(
      child: ListTile(
        title: Text(tx['description']!, style: GoogleFonts.poppins()),
        subtitle: Text(tx['date']!, style: GoogleFonts.poppins(fontSize: 13)),
        trailing: Text(
          tx['amount']!,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.red[600],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(String label) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.payment),
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