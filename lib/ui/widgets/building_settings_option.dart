import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/bloc/auth/auth_bloc.dart';
import 'package:recipe_app/ui/screens/auth/login/login_screen.dart';
import 'package:recipe_app/ui/screens/auth/register/begin_register_screen.dart'; // Import qilish

class BuildingSettingsOption extends StatelessWidget {
  final String title;
  final bool isLogout;

  const BuildingSettingsOption({
    super.key,
    required this.title,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () async {
          if (isLogout) {
            // Handle logout
            context.read<AuthBloc>().add(LogoutAuthEvent());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BeginRegisterScreen()), // Redirects to BeginRegisterScreen
            );
          } else {
            // Handle other settings options
          }
        },
      ),
    );
  }
}
