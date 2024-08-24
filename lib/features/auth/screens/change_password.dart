import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:skin_care/features/auth/controller/auth_events.dart';
import 'package:skin_care/features/auth/screens/login_screen.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/shared/widgets/custom_button.dart';

import '../../../core/theme/apptheme.dart';
import '../../../shared/dynamictoast.dart';
import '../../../shared/widgets/elavatedbutton.dart';
import '../../../shared/widgets/textfield.dart';
import '../../bottom_nav_bar/Screens/bottom_bar.dart';
import '../controller/auth_bloc.dart';
import '../controller/auth_state.dart';

class ChangePassword extends StatefulWidget {
  static const id = '/ChangePassword';

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurepassword = true;
  bool _obscureconfirmpassword = true;

  // Check if there is data in the storage
  @override
  Widget build(BuildContext context) {
    final changepasswordcotroller = BlocProvider.of<AuthBloc>(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.id, (route) => false);
          changepasswordcotroller.add(ResponseStatusAuth());
        }

        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: Container(
                  height: mq.height * 1,
                  width: mq.width * 1,
                  // color: AppTheme.grey,
                  padding: const EdgeInsets.all(25),
                  child: //wrap here
                      AnimationLimiter(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: AnimationConfiguration.toStaggeredList(
                                duration: const Duration(milliseconds: 300),
                                childAnimationBuilder: (widget) =>
                                    SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: widget,
                                  ),
                                ),
                                children: <Widget>[
                                  SizedBox(
                                    height: mq.height * 0.1,
                                  ),
                                  Container(
                                    width: mq.width * 0.9,
                                    child: Text(
                                        translate(context)
                                            .lbl_please_enter_new_password,
                                        // textAlign: TextAlign.justify,
                                        style: AppTheme.headings
                                            .copyWith(fontSize: 24)),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.02,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(" ")
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translate(context)
                                                .lbl_enter_password;
                                          }
                                          if (value.length < 5) {
                                            return translate(context)
                                                .lbl_password_length;
                                          }

                                          return null;
                                        },
                                        controller: changepasswordcotroller
                                            .passwordcontroller,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 15),
                                        cursorHeight: 25,
                                        obscureText: _obscurepassword,
                                        enableSuggestions: false,
                                        onTap: () {},
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: translate(context)
                                              .lbl_new_password,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _obscurepassword =
                                                      !_obscurepassword;
                                                });
                                              },
                                              icon: Icon(_obscurepassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                          isDense: true, // Added this
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 222, 222, 222),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  210, 196, 195, 195)),
                                          border: OutlineInputBorder(
                                            gapPadding: Checkbox.width * 0.1,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // borderSide: BorderSide(
                                            //   color: const Color.fromARGB(255, 222, 222, 222),
                                            // ),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: TextFormField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(" ")
                                        ],
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return translate(context)
                                                .lbl_enter_password;
                                          }
                                          if (value.length < 5) {
                                            return translate(context)
                                                .lbl_password_length;
                                          }

                                          return null;
                                        },
                                        controller: changepasswordcotroller
                                            .confirmpassword,
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(fontSize: 15),
                                        cursorHeight: 25,
                                        obscureText: _obscureconfirmpassword,
                                        enableSuggestions: false,
                                        onTap: () {},
                                        autocorrect: false,
                                        decoration: InputDecoration(
                                          hintText: translate(context)
                                              .lbl_confirm_new_password,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _obscureconfirmpassword =
                                                      !_obscureconfirmpassword;
                                                });
                                              },
                                              icon: Icon(_obscureconfirmpassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility)),
                                          isDense: true, // Added this
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          filled: true,
                                          fillColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color.fromARGB(
                                                    255, 222, 222, 222),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          hintStyle: const TextStyle(
                                              color: Color.fromARGB(
                                                  210, 196, 195, 195)),
                                          border: OutlineInputBorder(
                                            gapPadding: Checkbox.width * 0.1,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            // borderSide: BorderSide(
                                            //   color: const Color.fromARGB(255, 222, 222, 222),
                                            // ),
                                          ),
                                        ),
                                        keyboardType:
                                            TextInputType.visiblePassword),
                                  ),

                                  // Row(
                                  //   children: [
                                  //     Spacer(),
                                  //     InkWell(
                                  //       onTap: () {},
                                  //       child: Text(
                                  //         "Forgot Password?",
                                  //         style: AppTheme.descriptive.copyWith(
                                  //             fontSize: 16,
                                  //             decoration: TextDecoration.underline),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  SizedBox(
                                    height: mq.height * 0.02,
                                  ),
                                  CustomButtom(
                                      button_name: translate(context)
                                          .lbl_change_password,
                                      buttonaction: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          changepasswordcotroller
                                              .add(ChangePasswordAuth());
                                        }
                                      },
                                      filledcolor: true),
                                  SizedBox(
                                    height: mq.height * 0.037,
                                  ),

                                  // const Spacer(),
                                ],
                              ))),
                ),
              ),
            ),
            Visibility(
              visible: state.status == IsLoading.loading,
              child: Container(
                height: mq.height * 1,
                width: mq.width * 1,
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
              )),
            ),
          ],
        );
      },
    );
  }
}
