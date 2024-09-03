import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:recipe_app/data/models/user/user.dart';
import 'package:recipe_app/data/services.dart/user_service.dart';
import 'package:recipe_app/ui/screens/edit_profile_screen.dart';
import 'package:recipe_app/ui/screens/setting_screen.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  const ProfileScreen({super.key, required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserService _userService;
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _userService = UserService();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await _userService.getUser();
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load user data")),
      );
    }
  }

  void _updateUser(User updatedUser) {
    setState(() {
      _user = updatedUser; // Update user with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_user == null) {
      return const Center(child: Text("User not found"));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/image/profile_bacground.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      (_user!.photo != null && _user!.photo!.isNotEmpty)
                          ? (Uri.tryParse(_user!.photo!)?.isAbsolute == true
                              ? NetworkImage(_user!.photo!)
                              : (File(_user!.photo!).existsSync()
                                  ? FileImage(File(_user!.photo!))
                                  : null))
                          : null,
                  child: (_user!.photo == null || _user!.photo!.isEmpty)
                      ? const Icon(Icons.camera_alt)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  _user!.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  _user!.email,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                // Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () async {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(user: _user!),
                          ),
                        );
                        if (updatedUser != null) {
                          _updateUser(updatedUser);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () async {
                        final updatedUser = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SettingsScreen(user: _user!),
                          ),
                        );
                        if (updatedUser != null) {
                          _updateUser(updatedUser);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
