import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/shared/dynamictoast.dart';

import '../../../dependency_injection.dart';
import '../../../shared/widgets/custom_button.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_events.dart';
import '../controller/auth_state.dart';
import 'change_password.dart';

class OtpScreen extends StatelessWidget {
  static const id = '/OtpScreen';
  OtpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final verifyotpcontroller = BlocProvider.of<AuthBloc>(context);

    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.success) {
          Navigator.pushNamed(context, ChangePassword.id);
          verifyotpcontroller.add(ResponseStatusAuth());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Text(
                        translate(context).lbl_enter_otp,
                        //'Enter Otp',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      OTPTextField(
                          controller: verifyotpcontroller.otpController,
                          length: 4,
                          width: MediaQuery.of(context).size.width,
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldWidth: 45,
                          fieldStyle: FieldStyle.box,
                          outlineBorderRadius: 15,
                          style: TextStyle(fontSize: 17),
                          onChanged: (pin) {
                            // print("Changed: " + pin);
                          },
                          onCompleted: (pin) {
                            verifyotpcontroller.otp = pin;
                          }),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      CustomButtom(
                          button_name: translate(context).lbl_verify_otp,
                          //button_name: 'Verfiy otp',
                          buttonaction: () {
                            if (verifyotpcontroller.otp!.length != 4) {
                              DynamicToast.show("Enter correct otp");
                            } else {
                              verifyotpcontroller.add(EnterOtpAuth());
                            }
                            // if (_formKey.currentState?.validate() ??
                            //     false) {

                            // }
                          },
                          filledcolor: true),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state.status == IsLoading.loading,
              child: Container(
                height: height * 1,
                width: width * 1,
                decoration: const BoxDecoration(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                  child: Container(
                    color: Colors.black
                        .withOpacity(0.5), // Adjust the opacity as needed
                  ),
                ),
              ),
            ),
            Visibility(
              visible: state.status == IsLoading.loading,
              child: Center(
                  child: CupertinoActivityIndicator(
                radius: 15,
              )
                  // CircularProgressIndicator(
                  //   strokeWidth: 5,
                  //   color: Colors.blue,
                  // ),
                  ),
            ),
          ],
        );
      },
    );
  }
}
