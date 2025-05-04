import 'package:flutter/material.dart';
import 'screens/registration_screen.dart';
import 'screens/main_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  runApp(const AutismBuddyApp());
}

class AutismBuddyApp extends StatefulWidget {
  const AutismBuddyApp({super.key});

  @override
  State<AutismBuddyApp> createState() => _AutismBuddyAppState();
}

class _AutismBuddyAppState extends State<AutismBuddyApp> {
  bool _isRegistered = false;
  bool _showSettings = false;

  void _onGetStarted() {
    setState(() {
      _isRegistered = true;
    });
  }

  void _openSettings() {
    setState(() {
      _showSettings = true;
    });
  }

  void _closeSettings() {
    setState(() {
      _showSettings = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isRegistered) {
      return MaterialApp(
        title: 'Autism Buddy',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: RegistrationScreen(onGetStarted: _onGetStarted),
      );
    }

    if (_showSettings) {
      return MaterialApp(
        title: 'Settings',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: SettingsScreen(onBack: _closeSettings),
      );
    }

    return MaterialApp(
      title: 'Autism Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(onSettingsPressed: _openSettings),
    );
  }
}
