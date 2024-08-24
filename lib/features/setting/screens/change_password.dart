import 'package:flutter/material.dart';
import 'package:skin_care/shared/dynamictoast.dart';
import 'package:skin_care/shared/widgets/CustomTextFormField.dart';
import 'package:skin_care/shared/widgets/custom_button2.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});
  static const id = '/ChangePass';

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController newpassController = TextEditingController();
  TextEditingController newconfmPassController = TextEditingController();
  bool isPassVisible = false;

  var resetPassformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Change Password'),
        flexibleSpace: Container(
          color: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: resetPassformKey,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: height * 0.1, bottom: 5, left: 20),
                child: Text(
                  'Password',
                  style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: CustomTextFormField(
                    controller: newpassController,
                    readOnly: false,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your old password',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter password';
                      } else if (value.length < 6) {
                        return 'Password length should be grater than 6';
                      } else {
                        return null;
                      }
                    },
                    autoValidate: true,
                    onTap: () {}),
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 10, bottom: 5, left: 20),
                child: Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontFamily: 'Poppins SemiBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                child: CustomTextFormField(
                    obscureText: isPassVisible,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPassVisible = !isPassVisible;
                        });
                      },
                      icon: Icon(isPassVisible
                          ? Icons.visibility_off
                          : Icons.visibility),
                    ),
                    controller: newconfmPassController,
                    readOnly: false,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your password again',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter password again';
                      } else if (newconfmPassController.text !=
                          newpassController.text) {
                        return "Password doesn't match ";
                      } else {
                        return null;
                      }
                    },
                    autoValidate: true,
                    onTap: () {}),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: RoundButton(
                    title: 'Change Password',
                    onTap: () {
                      if (resetPassformKey.currentState!.validate()) {
                        changepassauth(context, newpassController.text,
                            newconfmPassController.text);
                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> changepassauth(
      BuildContext context, String pass, String pass2) async {
    try {
      // isloading = true;
      //update();
      await Future.delayed(Duration(seconds: 0));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => HoomePage()));
      // context.pushReplacementNamed(MyAppRouteConstants.loginPage);
      DynamicToast.show("Password Changed succesfully");
    } catch (e) {
      print(e.toString());
    } finally {
      // isloading = false;
      // update();
    }
  }
}
