import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_care/features/Profile/widget/customtextfield.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/shared/dynamictoast.dart';

import '../../../core/theme/apptheme.dart';
import '../../../dependency_injection.dart';
import '../../../shared/widgets/backbutton_and_heading.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_dialog.dart';
import '../../auth/screens/login_screen.dart';
import '../controller/profile_bloc.dart';
import '../controller/profile_event.dart';
import '../controller/profile_state.dart';
import '../model/user_profile_model.dart';
import '../widget/custom_dropdown.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthDetails? authDetails;

  List<Item> userdata = [];
  String profileImage = "";
  String backupImage = "";
  String gender = "";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void disposecontroller() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
  }

  bool showbutton = false;

  @override
  Widget build(BuildContext context) {
    final profilecontroller = BlocProvider.of<ProfileBloc>(context);

    // profilecontroller.add(GetUserDetail());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(translate(context).lbl_appbar_profile,
            style: AppTheme.headings
                .copyWith(fontSize: 21, fontWeight: FontWeight.w500)),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: Text(translate(context).lbl_sign_out),
                    content: Text(translate(context).lbl_set_dialogue_content),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        child: Text(
                            translate(context).lbl_set_dialogue_action_cancel),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        child: Text(translate(context).lbl_sign_out),
                        onPressed: () {
                          storage.remove('userid');
                          storage.remove('token');
                          storage.write('islogin', false);
                          // storage.remove('onborded');
                          // Dispatch delete chat event
                          // context
                          //     .read<ChatBloc>()
                          //     .add(ChatClearEvent());

                          Navigator.pop(context);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.id,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfilLoadedState) {
            log("New Updated Detail: ${state.authDetails}");
            // authDetails = state.authDetails;
            // userdata = state.userdata;
            // nameController.text =
            //     "${userdata[0].firstName} ${userdata[0].lastName}";
            // emailController.text = authDetails!.email;
            // phoneController.text = userdata[0].mobileNumber.toString();
            // addressController.text = userdata[0].address.toString();
            // gender = userdata[0].gender.toString();
            // profileImage = userdata[0].userProfileImage.toString();
            // print(authDetails?.toJson());
            // print(userdata[0].toJson());
          }
        },
        builder: (context, state) {
          if (state is ProfilLoadedState) {
            log("New Updated Detail: ${state.authDetails}");
            authDetails = state.authDetails;
            userdata = state.userdata;
            nameController.text =
                "${userdata[0].firstName} ${userdata[0].lastName}";
            emailController.text = authDetails!.email;
            phoneController.text = userdata[0].mobileNumber.toString();
            addressController.text = userdata[0].address.toString();
            gender = userdata[0].gender.toString();
            profileImage = userdata[0].userProfileImage.toString();
            // print(authDetails?.toJson());
            // print(userdata[0].toJson());
          }
          if (state is ProfileUpdatedState) {
            HapticFeedback.mediumImpact();

            print("Profile Updated");
            print(
                "${state.authDetail!.items.firstName} ${state.authDetail!.items.lastName}");
            nameController.text =
                "${state.authDetail!.items.firstName} ${state.authDetail!.items.lastName}";
            emailController.text = authDetails!.email;
            phoneController.text =
                state.authDetail!.items.mobileNumber.toString();
            addressController.text = state.authDetail!.items.address.toString();
            gender = state.authDetail!.items.gender.toString();
            profileImage = state.authDetail!.items.userProfileImage.toString();
          }
          return profilecontroller.userdata.isEmpty || authDetails == null
              ? const SizedBox()
              : Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            backupImage != ""
                                ? Container(
                                    height: mq.height * 0.15,
                                    width: mq.height * 0.15,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        backupImage,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : profileImage == ""
                                    ? Container(
                                        height: mq.height * 0.15,
                                        width: mq.height * 0.15,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Icon(Icons.person)
                                            // Image.asset(
                                            //   "assets/images/profile_girl.png",
                                            //   fit: BoxFit.cover,
                                            // ),
                                            ),
                                      )
                                    : Container(
                                        height: mq.height * 0.15,
                                        width: mq.height * 0.15,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.network(
                                            profileImage,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                            Positioned(
                              bottom: mq.height * 0.0,
                              right: mq.width * 0.01,
                              child: Container(
                                // padding: EdgeInsets.all(2),
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 251, 101, 129),
                                    borderRadius: BorderRadius.circular(100)),
                                child: FittedBox(
                                  child: IconButton(
                                    onPressed: () {
                                      _addImage();
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomTextfield(
                        controller: nameController,

                        // initialValue:
                        //     "${userdata[0].firstName}  ${userdata[0].lastName}",
                        labletext: translate(context).lbl_full_name,
                        validater: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name ';
                          }

                          return null;
                        },
                      ),
                      CustomTextfield(
                        readOnly: true,
                        controller: emailController,
                        // initialValue: authDetails!.email,
                        labletext: translate(context).lbl_profile_email,
                        validater: (value) {
                          if (value.isEmpty) {
                            return 'Please enter an email address';
                          }
                          if (!RegExp(
                                  r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                              .hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      if (userdata.isNotEmpty)
                        const SizedBox(
                          height: 20,
                        ),
                      if (userdata.isNotEmpty)
                        CustomDropdown(
                          paddinghorizontal: 20,
                          labelText: translate(context).lbl_gender,
                          initialValue: translate(context).lbl_male,
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
                            gender = value ?? translate(context).lbl_male;
                            // });
                          },
                        ),

                      if (userdata.isNotEmpty)
                        const SizedBox(
                          height: 5,
                        ),
                      // CustomTextfield(
                      //   initialValue: "12345678",
                      //   labletext: "Password",
                      //   validater: (value) {},
                      // ),
                      CustomTextfield(
                        controller: phoneController,
                        // initialValue: userdata[0].mobileNumber.toString(),
                        labletext: translate(context).lbl_phone_no,
                        validater: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your contact no';
                          }
                          if (value.length != 10) {
                            return 'enter a valid contact no';
                          }

                          return null;
                        },
                      ),
                      CustomTextfield(
                        controller: addressController,
                        // initialValue: userdata[0].mobileNumber.toString(),
                        labletext: translate(context).lbl_address,
                        validater: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your address';
                          }

                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 40),
                        child: CustomButtom(
                          button_name: translate(context).lbl_update,
                          buttonaction: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              ////
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CupertinoAlertDialog(
                                  content: Text(
                                      translate(context).lbl_update_profile),
                                  title:
                                      Text(translate(context).lbl_are_you_sure),
                                  // content: Text(translate(context).lbl_set_dialogue_content),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      isDefaultAction: true,
                                      child: Text(translate(context)
                                          .lbl_set_dialogue_action_cancel),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      isDestructiveAction: true,
                                      child:
                                          Text(translate(context).lbl_update),
                                      onPressed: () {
                                        String fullName = nameController.text;
                                        String lastName;
                                        String firstName;

                                        if (fullName.contains(' ')) {
                                          int lastSpaceIndex =
                                              fullName.lastIndexOf(' ');
                                          firstName = fullName.substring(
                                              0, lastSpaceIndex);
                                          lastName = fullName
                                              .substring(lastSpaceIndex + 1);
                                        } else {
                                          firstName = fullName;
                                          lastName = '';
                                        }

                                        // String firstName =
                                        //     nameParts.first; // Extract the first name
                                        // String lastName =
                                        //     nameParts.last; // Extract the last name
                                        String image = "";
                                        if (backupImage == "") {
                                          image = profileImage;
                                        } else {
                                          image = backupImage;
                                        }
                                        var body = {
                                          'userId': storage.read('userid'),
                                          'userProfileImage': image,
                                          'gender': gender,
                                          "firstName": firstName,
                                          "lastName": lastName,
                                          "mobileNumber":
                                              phoneController.text.trim(),
                                          "address":
                                              addressController.text.trim(),
                                          // "email": emailController.text.trim(),
                                        };
                                        print(body);
                                        setState(() {
                                          backupImage = "";
                                        });
                                        profilecontroller.add(UpdateUserDetail(
                                          userDetail: body,
                                        ));

                                        Navigator.pop(context);

                                        FocusManager.instance.primaryFocus!
                                            .unfocus();
                                      },
                                    ),
                                  ],
                                ),
                              );
////
                            }
                            // String fname =
                            //     nameController.text.trim().split(" ")[0];
                            // String lname =
                            //     nameController.text.trim().split(' ').removeAt(0);
                          },
                          filledcolor: true,
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }

  _addImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File file = File(image.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await FirebaseStorage.instance.ref('images/$fileName').putFile(file);

        String downloadURL = await FirebaseStorage.instance
            .ref('images/$fileName')
            .getDownloadURL();
        print(downloadURL);
        setState(() {
          profileImage = downloadURL;
          backupImage = downloadURL;
        });
        DynamicToast.show("Click on Update button to save updates");

        // Handle the uploaded image URL as needed
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }
}
