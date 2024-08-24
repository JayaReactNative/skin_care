import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/apptheme.dart';

class BackButtonAndHeading extends StatelessWidget {
  BackButtonAndHeading({super.key, required this.heading});
  String heading;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 23,
              width: 23,
              child: Image.asset(
                'assets/icons/arrowback.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Text(heading,
              textAlign: TextAlign.center,
              style: AppTheme.headings
                  .copyWith(fontSize: 21, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
