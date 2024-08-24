import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CustomButtom extends StatelessWidget {
  String button_name;
  Function() buttonaction;

  CustomButtom(
      {super.key,
      required this.button_name,
      required this.buttonaction,
      this.buttoncolor,
      this.buttonheight,
      this.buttonwidth,
      this.bordercolor,
      this.buttontextcolor,
      required this.filledcolor,
      this.radius});

  Color? buttoncolor;
  double? buttonheight;
  double? buttonwidth;
  Color? buttontextcolor;
  Color? bordercolor;
  bool filledcolor = false;
  double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buttonaction();
      },
      child: Container(
        height: MediaQuery.sizeOf(context).height * (buttonheight ?? 0.06),
        width: MediaQuery.sizeOf(context).width * (buttonwidth ?? 1),
        decoration: BoxDecoration(
          gradient: filledcolor
              ? LinearGradient(colors: [
                  const Color.fromARGB(255, 200, 6, 35),
                  const Color.fromARGB(255, 251, 101, 129)
                ])
              : LinearGradient(colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 255, 255, 255)
                ]),
          border: Border.all(
              color: bordercolor ?? Color.fromARGB(0, 255, 255, 255)),
          // color: buttoncolor ?? Color.fromARGB(255, 72, 163, 198),
          borderRadius: BorderRadius.circular(radius ?? 12),
        ),
        child:
            // Material(
            //   color: Colors.transparent,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       buttonaction();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       alignment: Alignment.center,
            //       backgroundColor: Colors.transparent,
            //       // elevation: 12,
            //       elevation: 0.0,
            //       // padding: EdgeInsets.symmetric(horizontal: 10.0),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            Center(
          child: Text(
            button_name,
            style: TextStyle(
                color: buttontextcolor ?? Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
