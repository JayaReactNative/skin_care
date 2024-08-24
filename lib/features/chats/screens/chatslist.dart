// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// // import 'package:go_router/go_router.dart';

// import '../../../core/theme/apptheme.dart';
// import '../../../dependency_injection.dart';
// // import '../../../routing/route_constants.dart';
// import '../controller/chatcontroller.dart';

// class Chat extends StatelessWidget {
//   const Chat({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var mq = MediaQuery.sizeOf(context);
//     var _chatController = locator<ChatController>();
//     return Scaffold(
//         appBar: AppBar(
//           // elevation: 8,
//           backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//           shadowColor: const Color.fromARGB(158, 0, 0, 0),
//           elevation: 10.0,
//           leading: const Icon(
//             Icons.chat_outlined,
//             color: AppTheme.primaryColor,
//             size: 30,
//           ),
//           titleSpacing: 5,
//           title: Text(
//             "Conversations",
//             style: AppTheme.headline3,
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   "...",
//                   style: AppTheme.headline2,
//                 ))
//           ],
//         ),
//         body: ListView(
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           primary: false,
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 22),
//               decoration: BoxDecoration(
//                   color: Colors.white, borderRadius: BorderRadius.circular(12)),
//               child: TextField(
//                 decoration: InputDecoration(
//                   isDense: true,
//                   contentPadding: const EdgeInsets.all(5),
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       borderSide: const BorderSide(
//                           color: Color.fromARGB(107, 99, 99, 99))),
//                   hintText: 'Search',

//                   hintStyle: AppTheme.headline4,
//                   prefixIcon: Image.asset(
//                     'asset/logo/search.png',
//                   ),
//                   suffixIconConstraints: const BoxConstraints(
//                     minWidth: 35, // Adjust the minimum width
//                     minHeight: 30,
//                   ),
//                   // filled: true,
//                   // fillColor: Colors.white,
//                 ),
//               ),
//             ),
//             Container(
//               height: mq.height * 0.73,
//               child: ListView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 primary: true,
//                 itemCount: _chatController.contactChats.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       // Get.pushNamed(
//                       //     // '/${MyAppRouteConstants.initial}/${MyAppRouteConstants.chatscreen}',
//                       //     MyAppRouteConstants.chatscreen,
//                       //     extra: _chatController.contactChats[index]);
//                     },
//                     child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 5),
//                         padding: const EdgeInsets.all(8),
//                         child: Row(
//                           children: [
//                             Container(
//                               padding: const EdgeInsets.all(2.5),
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(100),
//                                   border: Border.all(
//                                       color: AppTheme.primaryColor,
//                                       width: 2.3)),
//                               child: CircleAvatar(
//                                 radius: 28,
//                                 backgroundImage: AssetImage(_chatController
//                                     .contactChats[index].profilepic),
//                               ),
//                             ),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 12.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     _chatController.contactChats[index].name,
//                                     style: AppTheme.headline4,
//                                   ),
//                                   Text(
//                                     _chatController
//                                         .contactChats[index].lastMessage,
//                                     style: AppTheme.bodyText2,
//                                   )
//                                 ],
//                               ),
//                             ),
//                             const Spacer(),
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8.0),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "${_chatController.contactChats[index].time} min",
//                                     style: AppTheme.captionText,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.all(2),
//                                     height: 20,
//                                     // width: 20,
//                                     decoration: BoxDecoration(
//                                         color: const Color.fromARGB(
//                                             255, 250, 150, 0),
//                                         borderRadius:
//                                             BorderRadius.circular(100)),
//                                     child: ConstrainedBox(
//                                       constraints:
//                                           const BoxConstraints(minWidth: 16),
//                                       child: const FittedBox(
//                                         child: Center(
//                                             child: Text(
//                                           "1",
//                                           style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w500),
//                                         )),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             )
//                           ],
//                         )),
//                   );
//                 },
//               ),
//             )
//           ],
//         ));
//   }
// }
