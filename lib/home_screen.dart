// lib/home_screen.dart

import 'package:flutter/material.dart';
import 'storage_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _storageService = StorageService();
  String _username = 'User'; // Default value

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final username = await _storageService.getUsername();
    if (username != null) {
      setState(() {
        _username = username;
      });
    }
  }

  void _logout() async {
    await _storageService.clearUserData(); // [cite: 34]
    // Navigate to login screen and clear the entire navigation stack
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      // The Drawer widget implements the settings menu [cite: 16]
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              // Personalized greeting using user-specific data 
              child: Text(
                'Hello, $_username!',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle), // [cite: 18, 32]
              title: const Text('Account Settings'), // [cite: 25]
              onTap: () {
                // Placeholder for navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications), // [cite: 18, 32]
              title: const Text('Notifications'), // [cite: 25]
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info), // [cite: 18, 32]
              title: const Text('About'), // [cite: 25]
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout), // [cite: 18, 32]
              title: const Text('Logout'), // [cite: 26]
              onTap: _logout, // [cite: 34]
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text('Welcome! Open the drawer to see the settings menu.'),
      ),
    );
  }
}