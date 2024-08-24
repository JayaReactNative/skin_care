import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:skin_care/features/Profile/widget/custom_dropdown.dart';
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

class SignupScreen extends StatefulWidget {
  static const id = '/SignupScreen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscurepassword = true;
  bool _obscureconfirmpassword = true;

  // Check if there is data in the storage
  @override
  Widget build(BuildContext context) {
    final signupcotroller = BlocProvider.of<AuthBloc>(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.success) {
          Navigator.pushNamed(context, LoginScreen.id);
          signupcotroller.add(ResponseStatusAuth());
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Stack(
          children: [
            Form(
              key: _formKey,
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: SingleChildScrollView(
                  child: Container(
                    // color: AppTheme.grey,
                    padding: const EdgeInsets.all(25),
                    child: //wrap here
                        AnimationLimiter(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:
                                    AnimationConfiguration.toStaggeredList(
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
                                      height: height * 0.06,
                                    ),
                                    Container(
                                      width: mq.width * 0.6,
                                      child: Text(
                                          translate(context).lbl_hello_register,
                                          // textAlign: TextAlign.justify,
                                          style: AppTheme.headings
                                              .copyWith(fontSize: 24)),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ReusableTextFormField(
                                              hinttext: translate(context)
                                                  .lbl_first_name,
                                              validater: (value) {
                                                if (value.isEmpty) {
                                                  return translate(context)
                                                      .lbl_enter_first_name;
                                                }

                                                return null; // Return null if the input is valid
                                              },
                                              ispasswordtype: false,
                                              controller:
                                                  signupcotroller.firstName),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: ReusableTextFormField(
                                              hinttext: translate(context)
                                                  .lbl_last_name,
                                              validater: (value) {
                                                if (value.isEmpty) {
                                                  return translate(context)
                                                      .lbl_enter_last_name;
                                                }

                                                return null; // Return null if the input is valid
                                              },
                                              ispasswordtype: false,
                                              controller:
                                                  signupcotroller.lastName),
                                        ),
                                      ],
                                    ),
                                    ReusableTextFormField(
                                        hinttext:
                                            translate(context).lbl_phone_no,
                                        validater: (value) {
                                          if (value.isEmpty) {
                                            return translate(context)
                                                .lbl_enter_contact_no;
                                          }
                                          if (value.length != 10) {
                                            return translate(context)
                                                .lbl_valid_contact_no;
                                          }

                                          return null; // Return null if the input is valid
                                        },
                                        ispasswordtype: false,
                                        controller:
                                            signupcotroller.phoneNumber),

                                    ReusableTextFormField(
                                        hinttext: translate(context).lbl_email,
                                        validater: (value) {
                                          if (value.isEmpty) {
                                            return translate(context)
                                                .lbl_enter_email;
                                          }
                                          if (!RegExp(
                                                  r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                              .hasMatch(value)) {
                                            return translate(context)
                                                .lbl_valid_email;
                                          }
                                          return null; // Return null if the input is valid
                                        },
                                        ispasswordtype: false,
                                        controller:
                                            signupcotroller.emailcontroller),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    CustomDropdown(
                                      paddinghorizontal: 0,
                                      labelText: translate(context).lbl_gender,
                                      // initialValue: ,
                                      // Provide initial value here
                                      items: [
                                        translate(context).lbl_male,
                                        translate(context).lbl_female,
                                        translate(context).lbl_other
                                      ], // List of gender options
                                      onChanged: (value) {
                                        // Handle dropdown value change here
                                        print(value ?? "");
                                        // setState(() {
                                        signupcotroller.gender = value ??
                                            translate(context).lbl_male;
                                        // });
                                      },
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                " ")
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
                                          controller: signupcotroller
                                              .passwordcontroller,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 15),
                                          cursorHeight: 25,
                                          obscureText: _obscurepassword,
                                          enableSuggestions: false,
                                          onTap: () {},
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                translate(context).lbl_password,
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                " ")
                                          ],
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return translate(context)
                                                  .lbl_enter_password;
                                            }
                                            // if (value.length < 5) {
                                            //   return translate(context)
                                            //       .lbl_password_length;
                                            // }
                                            if (signupcotroller
                                                    .passwordcontroller.text !=
                                                signupcotroller
                                                    .confirmpassword.text) {
                                              // return 'Password is not matching';
                                              return translate(context)
                                                  .lbl_password_not_matching;
                                            }

                                            return null;
                                          },
                                          controller:
                                              signupcotroller.confirmpassword,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(fontSize: 15),
                                          cursorHeight: 25,
                                          obscureText: _obscureconfirmpassword,
                                          enableSuggestions: false,
                                          onTap: () {},
                                          autocorrect: false,
                                          decoration: InputDecoration(
                                            hintText: translate(context)
                                                .lbl_confirm_password,
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _obscureconfirmpassword =
                                                        !_obscureconfirmpassword;
                                                  });
                                                },
                                                icon: Icon(
                                                    _obscureconfirmpassword
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
                                      height: height * 0.02,
                                    ),
                                    CustomButtom(
                                        button_name:
                                            translate(context).lbl_signup,
                                        buttonaction: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            signupcotroller.add(SignupAuth());
                                          }
                                        },
                                        filledcolor: true),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(right: 6),
                                            width: double.infinity,
                                            height: 2,
                                            color: Color.fromARGB(
                                                255, 211, 211, 211),
                                          ),
                                        ),
                                        Text(
                                          translate(context)
                                              .lbl_or_register_with,
                                          textAlign: TextAlign.center,
                                          style: AppTheme.descriptive.copyWith(
                                              fontSize: 15,
                                              color:
                                                  Color.fromARGB(201, 0, 0, 0)),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            width: double.infinity,
                                            height: 2,
                                            color: Color.fromARGB(
                                                255, 211, 211, 211),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            DynamicToast.show(
                                                "Open authentication by facebook");
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 211, 211, 211),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Image.asset(
                                              'assets/icons/facebook_icon.png',
                                              height: 30,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 18,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              DynamicToast.show(
                                                  "Open authentication by google");
                                            },
                                            child: Container(
                                              height: 50,
                                              width: 90,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 211, 211, 211),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Image.asset(
                                                'assets/icons/google_icon.png',
                                                height: 30,
                                              ),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mq.height * 0.02,
                                    ),

                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.center,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.end,
                                    //   children: [
                                    //     Text(
                                    //       translate(context)
                                    //           .lbl_already_have_account,
                                    //       style: TextStyle(
                                    //           color: Color.fromARGB(
                                    //               255, 79, 77, 77)),
                                    //     ),
                                    //     InkWell(
                                    //       onTap: () {
                                    //         signupcotroller
                                    //             .disposecontrollers();
                                    //         Navigator.pushReplacementNamed(
                                    //             context, LoginScreen.id);
                                    //       },
                                    //       child: Flexible(
                                    //         child: Text(
                                    //           translate(context)
                                    //               .lbl_already_login,
                                    //           style: TextStyle(
                                    //             fontWeight: FontWeight.w500,
                                    //             color: Color.fromARGB(
                                    //                 255, 200, 6, 35),
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // const Spacer(),

                                    Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: translate(context)
                                                  .lbl_already_have_account,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 79, 77, 77)),
                                            ),
                                            TextSpan(
                                                text: translate(context)
                                                    .lbl_already_login,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 200, 6, 35),
                                                ),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {
                                                        print('on Click');
                                                        //viewModel.clearFields();
                                                        // Navigator.of(context)
                                                        //     .pushReplacementNamed('/login');
                                                        signupcotroller
                                                            .disposecontrollers();
                                                        Navigator
                                                            .pushReplacementNamed(
                                                                context,
                                                                LoginScreen.id);
                                                      }),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ))),
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
