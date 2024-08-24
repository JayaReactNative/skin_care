import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skin_care/core/theme/apptheme.dart';
import 'package:skin_care/features/chats/screens/image_history.dart';
import 'package:skin_care/features/setting/screens/change_password.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/features/setting/screens/help_screen.dart';
import 'package:skin_care/features/setting/screens/language.dart';
import 'package:skin_care/main.dart';
import 'package:skin_care/shared/dynamictoast.dart';
import 'package:skin_care/shared/widgets/backbutton_and_heading.dart';

import '../../../dependency_injection.dart';
import '../../auth/screens/login_screen.dart';
import 'policies.dart';
import 'privacy_policy_screen.dart';

class Settings extends StatelessWidget {
  static const id = '/Settings';

  final List<String> icon = [
    'assets/icons/language.png',
    'assets/icons/photos.png',
    'assets/icons/changepassword.png',
    'assets/icons/privacy.png',
    'assets/icons/help.png',
    'assets/icons/policy.png',
  ];

  Settings({super.key});

  // ignore: recursive_getters

  @override
  Widget build(BuildContext context) {
    final List<String> componentname = [
      translate(context).lbl_language,
      translate(context).lbl_my_photos,
      translate(context).lbl_change_password,
      translate(context).lbl_privacy_security,
      translate(context).lbl_help,
      translate(context).lbl_policies,
    ];
    return Scaffold(
      appBar: AppBar(
        // leading:
        title: Text(translate(context).lbl_setting,
            style: AppTheme.headings
                .copyWith(fontSize: 21, fontWeight: FontWeight.w500)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // height: mq.height * 0.41,
              // color: Colors.deepOrangeAccent,
              margin: const EdgeInsets.only(
                  // right: 18,
                  // top: mq.height * 0.38,
                  ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: icon.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(context, Language.id);
                            // Get.toNamed('/PersonalInformation');
                          } else if (index == 1) {
                            Navigator.pushNamed(context, ImageHistory.id);
                            // ImageHistory
                            // locator<PaymentController>()
                            //         .cardlist
                            //         .isEmpty
                            //     ? Get.toNamed('/Payment')
                            //     : Get.toNamed(AppRoutes.cardList);
                          } else if (index == 2) {
                            Navigator.pushNamed(context, ChangePass.id);
                            // DynamicToast.show("Change Password");
                          } else if (index == 3) {
                            // DynamicToast.show("Settings");
                            Navigator.pushNamed(
                                context, PrivacySecurityScreen.id);
                          } else if (index == 4) {
                            // Get.toNamed('/helpScreen');
                            Navigator.pushNamed(context, HelpScreen.id);
                          } else if (index == 5) {
                            // Get.toNamed('/helpScreen');
                            Navigator.pushNamed(
                                context, CompanyPoliciesScreen.id);
                          } else {}
                          // CompanyPoliciesScreen
                        },
                        dense: true,
                        leading: Image.asset(icon[index]),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  componentname[index],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 18,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 17,
                        endIndent: 25,
                        color: Color.fromARGB(255, 195, 195, 195),
                        height: 1,
                      ),
                    ],
                  );
                },
              )),
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: TextButton(
          //     onPressed: () {
          //       showDialog(
          //         context: context,
          //         builder: (BuildContext context) => CupertinoAlertDialog(
          //           title: const Text("Sign Out"),
          //           content: const Text("Are you sure you want to sign out?"),
          //           actions: <Widget>[
          //             CupertinoDialogAction(
          //               isDefaultAction: true,
          //               child: const Text("Cancel"),
          //               onPressed: () {
          //                 Navigator.pop(context);
          //               },
          //             ),
          //             CupertinoDialogAction(
          //               isDestructiveAction: true,
          //               child: const Text("Sign Out"),
          //               onPressed: () {
          //                 // Dispatch delete chat event
          //                 // context
          //                 //     .read<ChatBloc>()
          //                 //     .add(ChatClearEvent());
          //                 storage.erase();

          //                 Navigator.pop(context);
          //                 Navigator.pushNamedAndRemoveUntil(
          //                   context,
          //                   LoginScreen.id,
          //                   (route) => false,
          //                 );
          //               },
          //             ),
          //           ],
          //         ),
          //       );
          //     },
          //     // child: const Text(
          //     //   "Sign Out",
          //     //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          //     // ),
          //   ),
          // )
        ],
      ),
    );
  }
}
