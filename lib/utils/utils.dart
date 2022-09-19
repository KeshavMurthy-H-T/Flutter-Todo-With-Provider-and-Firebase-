import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Utils {
  static DateTime? toDateTime(Timestamp value) {
    if (value == null) return null;

    return value.toDate();
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;

    return date.toUtc();
  }

  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final object = snaps.map((json) => fromJson(json)).toList();

              sink.add(object);
            },
          );


  static showAlertDialog(BuildContext context,String title,String message,Function onTapCancel,Function onTapOk) {

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
   title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: (() => onTapCancel), child: const Text("Cancel")),
          TextButton(onPressed: (() => onTapOk), child: const Text("Yes")),
        ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

 
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Widget buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
              color: Colors.cyan,
              backgroundColor: Colors.red,
            ),
    );
  }