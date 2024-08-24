import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:skin_care/features/auth/screens/login_screen.dart';
import 'package:skin_care/features/auth/screens/signup_screen.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';

import '../../../shared/widgets/custom_button.dart';

class LoginSignUp extends StatelessWidget {
  static const id = '/LoginSignUp';
  const LoginSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: mq.height,
              width: mq.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/login_signup.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: mq.height * 0.4,
              width: mq.width,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: mq.height * 0.08,
                  ),
                  CustomButtom(
                    filledcolor: true,
                    button_name: translate(context).lbl_login,
                    buttonaction: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    buttoncolor: Color.fromARGB(255, 255, 43, 11),
                    buttonwidth: 0.9,
                    buttonheight: 0.06,
                  ),
                  SizedBox(
                    height: mq.height * 0.03,
                  ),
                  CustomButtom(
                    buttontextcolor: Color.fromARGB(255, 200, 6, 35),
                    filledcolor: false,
                    bordercolor: Color.fromARGB(255, 200, 6, 35),
                    button_name: translate(context).lbl_signup,
                    buttonaction: () {
                      Navigator.pushNamed(context, SignupScreen.id);
                    },
                    buttoncolor: Color.fromARGB(255, 255, 255, 255),
                    buttonwidth: 0.9,
                    buttonheight: 0.06,
                  ),
                  Spacer(),
                  // Text(
                  //   "Continue as a Guest",
                  //   style: TextStyle(fontSize: 20),
                  // ),
                  SizedBox(
                    height: mq.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
