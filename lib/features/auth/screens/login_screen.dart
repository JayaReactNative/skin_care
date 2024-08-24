import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:skin_care/features/Profile/controller/profile_bloc.dart';
import 'package:skin_care/features/Profile/controller/profile_event.dart';
import 'package:skin_care/features/auth/controller/auth_bloc.dart';
import 'package:skin_care/features/auth/controller/auth_state.dart';
import 'package:skin_care/features/auth/screens/forget_password.dart';
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

class LoginScreen extends StatefulWidget {
  static const id = '/LoginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextEditingController emailidcontroller = TextEditingController();

  // TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  // Check if there is data in the storage
  @override
  Widget build(BuildContext context) {
    final logincontroller = BlocProvider.of<AuthBloc>(context);

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.success) {
          context.read<ProfileBloc>().add(GetUserDetail());

          Navigator.pushNamedAndRemoveUntil(
              context, BottomNavBar.id, (route) => false);
          logincontroller.add(ResponseStatusAuth());
        }
      },
      builder: (context, state) {
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
                              child: Text(translate(context).lbl_login_heading,
                                  // textAlign: TextAlign.justify,
                                  style:
                                      AppTheme.headings.copyWith(fontSize: 24)),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            ReusableTextFormField(
                                hinttext: translate(context).lbl_email,
                                validater: (value) {
                                  if (value.isEmpty) {
                                    return translate(context).lbl_enter_email;
                                  }
                                  if (!RegExp(
                                          r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                                      .hasMatch(value)) {
                                    return translate(context).lbl_valid_email;
                                  }
                                  return null; // Return null if the input is valid
                                },
                                ispasswordtype: false,
                                controller: logincontroller.emailcontroller),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
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
                                  controller:
                                      logincontroller.passwordcontroller,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(fontSize: 15),
                                  cursorHeight: 25,
                                  obscureText: _obscureText,
                                  enableSuggestions: false,
                                  onTap: () {},
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    hintText: translate(context).lbl_password,
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText = !_obscureText;
                                          });
                                        },
                                        icon: Icon(_obscureText
                                            ? Icons.visibility_off
                                            : Icons.visibility)),
                                    isDense: true, // Added this
                                    contentPadding: const EdgeInsets.all(10),
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
                                        color:
                                            Color.fromARGB(210, 196, 195, 195)),
                                    border: OutlineInputBorder(
                                      gapPadding: Checkbox.width * 0.1,
                                      borderRadius: BorderRadius.circular(15),
                                      // borderSide: BorderSide(
                                      //   color: const Color.fromARGB(255, 222, 222, 222),
                                      // ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword),
                            ),

                            Row(
                              children: [
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ForgetPassword.id);
                                  },
                                  child: Text(
                                    translate(context).lbl_forgot_password,
                                    style: AppTheme.descriptive.copyWith(
                                        fontSize: 16,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.037,
                            ),
                            CustomButtom(
                                button_name: translate(context).lbl_login,
                                buttonaction: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    logincontroller.add(LoginAuth());
                                  }
                                },
                                filledcolor: true),
                            SizedBox(
                              height: height * 0.037,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 6),
                                    width: double.infinity,
                                    height: 2,
                                    color: Color.fromARGB(255, 211, 211, 211),
                                  ),
                                ),
                                Text(
                                  translate(context).lbl_login_with,
                                  textAlign: TextAlign.center,
                                  style: AppTheme.descriptive.copyWith(
                                      fontSize: 15,
                                      color: Color.fromARGB(201, 0, 0, 0)),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    width: double.infinity,
                                    height: 2,
                                    color: Color.fromARGB(255, 211, 211, 211),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                              BorderRadius.circular(12)),
                                      child: Image.asset(
                                        'assets/icons/google_icon.png',
                                        height: 30,
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    translate(context).lbl_dont_have_account,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 79, 77, 77),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        4), // Adding some space between the text widgets
                                InkWell(
                                  onTap: () {
                                    logincontroller.disposecontrollers();
                                    Navigator.pushReplacementNamed(
                                        context, SignupScreen.id);
                                  },
                                  child: Text(
                                    translate(context).lbl_register_now,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromARGB(255, 200, 6, 35),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            // const Spacer(),
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
