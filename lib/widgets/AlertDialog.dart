import 'package:flutter/material.dart';

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog(
      {Key? key,
      required this.title,
      required this.message,
      this.onTapCancel,
      this.onTapOk})
      : super(key: key);
  final String title;
  final String message;
  final GestureTapCallback? onTapCancel;
  final GestureTapCallback? onTapOk;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: (() => onTapCancel), child: const Text("Cancel")),
          TextButton(onPressed: (() => onTapOk), child: const Text("Yes")),
        ],
      ),
    );
  }
}
