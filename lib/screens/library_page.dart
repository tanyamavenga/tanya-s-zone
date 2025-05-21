import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  // Mock PDF download URLs
  final String doc1Url = 'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf';
  final String doc2Url = 'https://www.orimi.com/pdf-test.pdf';

  Future<void> _openDocument(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: const Color(0xFFE3F2FD),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'E-Library Resources',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 20),
            _buildDocumentTile(
              context,
              title: 'MSU Research Handbook',
              description: 'PDF guide for undergraduate/postgrad research',
              url: doc1Url,
            ),
            const SizedBox(height: 16),
            _buildDocumentTile(
              context,
              title: 'Student Guide 2025',
              description: 'Campus rules, academic policies, and student services',
              url: doc2Url,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context,
      {required String title, required String description, required String url}) {
    return InkWell(
      onTap: () => _openDocument(url),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf, color: Colors.red, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(description,
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700])),
                ],
              ),
            ),
            const Icon(Icons.download_rounded, color: Colors.blueAccent),
          ],
        ),
      ),
    );
  }
}