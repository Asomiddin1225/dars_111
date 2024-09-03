import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NotificationsActiveScreen extends StatefulWidget {
  const NotificationsActiveScreen({super.key});

  @override
  State<NotificationsActiveScreen> createState() =>
      _NotificationsActiveScreenState();
}

class _NotificationsActiveScreenState extends State<NotificationsActiveScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("Notification Screen"),
      ),
    );
  }
}
