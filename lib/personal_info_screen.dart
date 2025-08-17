// lib/personal_info_screen.dart

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  // Controllers and state variables for the form fields
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  double _age = 25;
  String _country = 'United States';
  final List<String> _countries = ['United States', 'Canada', 'India', 'United Kingdom', 'Australia'];

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load saved data when the screen is initialized
  }

  /// Loads user data from SharedPreferences and updates the UI.
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _usernameController.text = prefs.getString('username') ?? '';
      _age = prefs.getDouble('age') ?? 25;
      _country = prefs.getString('country') ?? 'United States';
    });
  }

  /// Saves the current user data to SharedPreferences.
  Future<void> _saveUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    await prefs.setString('username', _usernameController.text);
    await prefs.setDouble('age', _age);
    await prefs.setString('country', _country);

    // Show a confirmation message
    Fluttertoast.showToast(
      msg: "Profile updated successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Name TextField
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),

          // Username TextField
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Icons.alternate_email),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // Age Slider
          Text('Age: ${_age.round()}', style: Theme.of(context).textTheme.titleMedium),
          Slider(
            value: _age,
            min: 18,
            max: 100,
            divisions: 82,
            label: _age.round().toString(),
            onChanged: (value) => setState(() => _age = value),
          ),
          const SizedBox(height: 16),

          // Country Dropdown
          DropdownButtonFormField<String>(
            value: _country,
            decoration: const InputDecoration(
              labelText: 'Country',
              border: OutlineInputBorder(),
            ),
            items: _countries.map((country) {
              return DropdownMenuItem(value: country, child: Text(country));
            }).toList(),
            onChanged: (newValue) => setState(() => _country = newValue!),
          ),
          const SizedBox(height: 32),

          // Save Button
          ElevatedButton(
            onPressed: _saveUserData,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              textStyle: const TextStyle(fontSize: 16),
            ),
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }
}