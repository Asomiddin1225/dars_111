import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/bloc/auth/auth_bloc.dart';
import 'package:recipe_app/data/models/user/user.dart';
import 'package:recipe_app/ui/screens/edit_profile_screen.dart';
import 'package:recipe_app/ui/widgets/building_settings_option.dart';

class SettingsScreen extends StatefulWidget {
  final User user;

  const SettingsScreen({super.key, required this.user});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late User _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user; // Initialize with the user from widget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  ClipOval(
                    child: FutureBuilder<bool>(
                      future: _currentUser.photo != null
                          ? File(_currentUser.photo!).exists()
                          : Future.value(false),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError || !snapshot.data!) {
                          return const Icon(Icons.person, size: 60);
                        } else {
                          return Image.file(
                            File(_currentUser.photo!),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _currentUser.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _currentUser.email,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(user: _currentUser),
                        ),
                      ).then((updatedUser) {
                        if (updatedUser != null) {
                          setState(() {
                            _currentUser = updatedUser;
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Settings Options
            Expanded(
              child: ListView(
                children: const [
                  BuildingSettingsOption(
                    title: 'Information',
                  ),
                  BuildingSettingsOption(
                    title: 'Notification',
                  ),
                  BuildingSettingsOption(
                    title: 'Privacy',
                  ),
                  BuildingSettingsOption(
                    title: 'Support',
                  ),
                  BuildingSettingsOption(
                    isLogout: true,
                    title: 'Logout',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
