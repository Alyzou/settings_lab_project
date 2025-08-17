// lib/home_screen.dart

import 'package:flutter/material.dart';
import 'storage_service.dart';
import 'personal_info_screen.dart'; // Import the new screen

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
    await _storageService.clearUserData();
    // Navigate to login screen and clear the entire navigation stack
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      // The Drawer widget implements the settings menu
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
              // Personalized greeting using user-specific data
              child: Text(
                'Hello, $_username!',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // This is the new ListTile to connect to the settings screen
            ListTile(
              leading: const Icon(Icons.person), // [cite: 309]
              title: const Text('Personal Info'), // [cite: 310]
              onTap: () { // [cite: 311]
                Navigator.pop(context); // Close the drawer first
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PersonalInfoScreen())); // 
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account Settings'),
              onTap: () {
                // Placeholder for navigation
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
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