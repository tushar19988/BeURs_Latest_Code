import 'package:flutter/material.dart';

class NotificationPermissionDialog extends StatelessWidget {
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const NotificationPermissionDialog(
      {super.key, required this.onAccept, required this.onDecline});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enable Notifications"),
      content: const Text(
          "Would you like to enable notifications for updates and alerts?"),
      actions: [
        TextButton(
          onPressed: onDecline,
          child: const Text("No, Thanks"),
        ),
        ElevatedButton(
          onPressed: onAccept,
          child: const Text("Enable"),
        ),
      ],
    );
  }
}
