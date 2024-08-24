import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:skin_care/features/auth/controller/auth_bloc.dart';
import 'package:skin_care/features/auth/controller/auth_state.dart';
import 'package:skin_care/features/auth/screens/signup_screen.dart';
import 'package:skin_care/features/bottom_nav_bar/Screens/bottom_bar.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/shared/widgets/custom_button.dart';

import '../../../core/theme/apptheme.dart';
import '../../../shared/dynamictoast.dart';
import '../../../shared/widgets/elavatedbutton.dart';
import '../../../shared/widgets/textfield.dart';
import '../controller/auth_events.dart';
import 'enter_otp_scree.dart';

class ForgetPassword extends StatelessWidget {
  static const id = '/ForgetPassword';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Check if there is data in the storage
  @override
  Widget build(BuildContext context) {
    final forgetpassword = BlocProvider.of<AuthBloc>(context);

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.success) {
          Navigator.pushReplacementNamed(context, OtpScreen.id);
          forgetpassword.add(ResponseStatusAuth());
        }
        // TODO: implement listener
      },
      builder: (_, state) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  height: height * 1,
                  width: width * 1,
                  // color: AppTheme.grey,
                  padding: const EdgeInsets.all(25),
                  child: //wrap here
                      AnimationLimiter(
                          child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 300),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.1,
                            ),
                            Container(
                              width: mq.width * 0.6,
                              child: Text(
                                  translate(context).lbl_title_forgot_password,
                                  // textAlign: TextAlign.justify,
                                  style:
                                      AppTheme.headings.copyWith(fontSize: 24)),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                              width: mq.width * 0.9,
                              child: Text(
                                  translate(context)
                                      .lbl_text, // textAlign: TextAlign.justify,
                                  style: AppTheme.descriptive.copyWith(
                                      fontSize: 14,
                                      color: Colors.grey.shade600)),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            ReusableTextFormField(
                                hinttext: translate(context).lbl_email_example,
                                validater: (value) {
                                  if (value.isEmpty) {
                                    return translate(context)
                                        .lbl_error_text_invalid_email;
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                      .hasMatch(value)) {
                                    return translate(context).lbl_valid_email;
                                  }
                                  return null; // Return null if the input is valid
                                },
                                ispasswordtype: false,
                                controller: forgetpassword.emailcontroller),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: TextFormField(
                            //       autovalidateMode:
                            //           AutovalidateMode.onUserInteraction,
                            //       inputFormatters: [
                            //         FilteringTextInputFormatter.deny(" ")
                            //       ],
                            //       validator: (value) {
                            //         if (value!.isEmpty) {
                            //           return 'Please enter a password';
                            //         }
                            //         if (value.length < 6) {
                            //           return 'Password length should be grater than 6';
                            //         }

                            //         return null;
                            //       },
                            //       controller:
                            //           logincontroller.passwordcontroller,
                            //       textAlign: TextAlign.start,
                            //       style: const TextStyle(fontSize: 15),
                            //       cursorHeight: 25,
                            //       obscureText: _obscureText,
                            //       enableSuggestions: false,
                            //       onTap: () {},
                            //       autocorrect: false,
                            //       decoration: InputDecoration(
                            //         hintText: "Password",
                            //         suffixIcon: IconButton(
                            //             onPressed: () {
                            //               setState(() {
                            //                 _obscureText = !_obscureText;
                            //               });
                            //             },
                            //             icon: Icon(_obscureText
                            //                 ? Icons.visibility_off
                            //                 : Icons.visibility)),
                            //         isDense: true, // Added this
                            //         contentPadding: const EdgeInsets.all(10),
                            //         filled: true,
                            //         fillColor: Colors.white,
                            //         enabledBorder: OutlineInputBorder(
                            //             borderSide: const BorderSide(
                            //               color: Color.fromARGB(
                            //                   255, 222, 222, 222),
                            //             ),
                            //             borderRadius:
                            //                 BorderRadius.circular(12)),
                            //         hintStyle: const TextStyle(
                            //             color:
                            //                 Color.fromARGB(210, 196, 195, 195)),
                            //         border: OutlineInputBorder(
                            //           gapPadding: Checkbox.width * 0.1,
                            //           borderRadius: BorderRadius.circular(15),
                            //           // borderSide: BorderSide(
                            //           //   color: const Color.fromARGB(255, 222, 222, 222),
                            //           // ),
                            //         ),
                            //       ),
                            //       keyboardType: TextInputType.visiblePassword),
                            // ),

                            CustomButtom(
                                button_name: translate(context)
                                    .lbl_button_forgot_password,
                                buttonaction: () async {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    forgetpassword.add(ForgetPasswordAuth());
                                    // log(state.authStatus.toString());
                                  }
                                },
                                filledcolor: true),
                          ],
                        )),
                  )),
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
