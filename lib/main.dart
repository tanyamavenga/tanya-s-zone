import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Authentication & Onboarding
import 'screens/login_page.dart';
import 'screens/verify_email_page.dart';
import 'screens/home_page.dart';
import 'screens/register_page.dart';
import 'screens/reset_password_page.dart';
import 'screens/two_factor_page.dart';
import 'screens/phone_auth_page.dart';

// Student Feature Pages
import 'screens/academia_page.dart';
import 'screens/finance_page.dart';
import 'screens/health_page.dart';
import 'screens/food_page.dart';
import 'screens/sports_page.dart';
import 'screens/library_page.dart';
import 'screens/settings_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MSU eLearning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const AuthGate(),

      // Routes for navigation
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/reset-password': (context) => const ResetPasswordPage(),
        '/verify-email': (context) => const VerifyEmailPage(),
        '/2fa': (context) => const TwoFactorPage(phoneNumber: ''),
        '/phone-auth': (context) => const PhoneAuthPage(),
        '/home': (context) => const HomePage(),
        '/academia': (context) => const AcademiaPage(),
        '/finance': (context) => const FinancePage(),
        '/health': (context) => const HealthPage(),
        '/food': (context) => const FoodPage(),
        '/sports': (context) => const SportsPage(),
        '/library': (context) => const LibraryPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          if (!user.emailVerified && user.email != null) {
            return const VerifyEmailPage();
          }
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}