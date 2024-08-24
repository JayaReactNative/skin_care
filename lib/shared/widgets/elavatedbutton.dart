import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Elavatedbutton extends StatelessWidget {
  String button_name;
  Function() buttonaction;

  Elavatedbutton({
    super.key,
    required this.button_name,
    required this.buttonaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 255, 0, 0),
            Color.fromARGB(255, 208, 13, 13),
            Color.fromARGB(255, 161, 49, 49),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {
            buttonaction();
          },
          style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            backgroundColor: Colors.transparent,
            // elevation: 12,
            elevation: 0.0,
            // padding: EdgeInsets.symmetric(horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: Center(
              child: Text(
                button_name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
