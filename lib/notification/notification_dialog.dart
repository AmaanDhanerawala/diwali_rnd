//push notification dialog for foreground
import 'package:flutter/material.dart';

class NotificationDialog extends StatefulWidget {
  final String title;
  final Map<String, dynamic> body;

  const NotificationDialog({super.key, required this.body, required this.title});

  @override
  NotificationDialogState createState() => NotificationDialogState();
}

class NotificationDialogState extends State<NotificationDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      actions: <Widget>[
        OutlinedButton.icon(
            label: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close))
      ],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            widget.body['image'],
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 20),
          Text(
            widget.body['message'],
          ),
        ],
      ),
    );
  }
}
