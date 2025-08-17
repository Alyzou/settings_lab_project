// lib/main.dart

import 'package:flutter/material.dart';
import 'storage_service.dart';
import 'login_screen.dart';
import 'home_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized before calling async code
  WidgetsFlutterBinding.ensureInitialized();

  final storageService = StorageService();
  // Check if a username is already saved
  final String? loggedInUser = await storageService.getUsername();

  runApp(MyApp(isLoggedIn: loggedInUser != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings Menu Lab',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      // Show HomeScreen if logged in, otherwise show LoginScreen
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}