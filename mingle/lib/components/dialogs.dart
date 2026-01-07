import 'package:flutter/material.dart';

void showErrorAlertDialog(BuildContext context, String resMessage) {
  String message =  resMessage;//json.decode(resMessage)['detail'];
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
  );
}