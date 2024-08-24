import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showCustomDialog(BuildContext context,
    {required String title, required String desc}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(desc),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
            },
            child: Text('Log out'),
          ),
          SizedBox(
            width: 100,
          ),
          TextButton(
            onPressed: () {},
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
