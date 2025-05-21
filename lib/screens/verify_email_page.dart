import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool _emailVerified = false;
  bool _isSending = false;
  bool _isReloading = false;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _checkEmailVerified();
  }

  Future<void> _checkEmailVerified() async {
    await _auth.currentUser?.reload();
    setState(() {
      _emailVerified = _auth.currentUser?.emailVerified ?? false;
    });

    if (_emailVerified) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  Future<void> _sendVerificationEmail() async {
    setState(() => _isSending = true);

    try {
      await _auth.currentUser?.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email sent')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Could not send email')),
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.mark_email_read, size: 100, color: Colors.blueAccent),
                const SizedBox(height: 20),
                Text(
                  'Verify Your Email',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'A verification link has been sent to your email. Please check your inbox and click the link.',
                  style: GoogleFonts.poppins(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _isSending
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _sendVerificationEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          'Resend Email',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                const SizedBox(height: 20),
                _isReloading
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () async {
                          setState(() => _isReloading = true);
                          await _checkEmailVerified();
                          setState(() => _isReloading = false);
                        },
                        child: const Text('I have verified my email'),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}