import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        // height: 42,
        // width: 359,
        margin: EdgeInsets.only(right: 13, left: 13),
        padding: EdgeInsets.only(top: 2),
        width: MediaQuery.of(context).size.width,
        height: 42,
        decoration: ShapeDecoration(
            color: Color.fromARGB(255, 179, 48, 135),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        child: Center(
            child: loading
                ? CircularProgressIndicator(strokeWidth: 3, color: Colors.white)
                : Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  )),
      ),
    );
  }
}
