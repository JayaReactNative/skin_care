import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_care/features/chats/model.dart/image_history.dart';
import 'package:skin_care/features/chats/model.dart/new_message_model.dart';
// import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:skin_care/main.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/apptheme.dart';
// import '../../../shared/widgets/dynamic_toast.dart';
import '../../../dependency_injection.dart';
import '../../../shared/dynamictoast.dart';
import '../../../shared/widgets/custom_button.dart';
import '../controller/chat_bloc/chat_bloc.dart';
import '../controller/chatcontroller.dart';
import '../model.dart/chat_details_model.dart';
import '../model.dart/chat_details_model.dart' as chat;
import 'package:cached_network_image/cached_network_image.dart';

class ImageHistory extends StatelessWidget {
  const ImageHistory({super.key});
  static String id = '/ImageHistoryScreen';

  // late ScrollController scrollController;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the ScrollController
  //   scrollController = ScrollController();
  // }

  @override
  Widget build(BuildContext context) {
    const adminIcon = Icon(Icons.support_agent);
    const userIcon = Icon(Icons.face_6);
    //  ImageHistory({super.key});
    final ChatController chatController = Get.put(ChatController());
    List<ImagesDetails> imagehistory = [];
    // final ContactChat contactChat;

    // ChatModel chatMessages = ChatModel(
    //     status: true,
    //     subCode: 1,
    //     message: "message",
    //     error: "error",
    //     items: Items(symptomHistory: [], chatDetail: []));

    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    TextEditingController messagecontroller = TextEditingController();
    final homeBloc = BlocProvider.of<ChatBloc>(context);
    // homeBloc.add(ChatLoadEvent());
    homeBloc.add(FetchImageHistoryEvent());
    final userId = storage.read('userid') ?? "";
    // final scrollController = ScrollController();

    return GestureDetector(
      onTap: () {
        if (chatController.iswriting == true) {
          FocusManager.instance.primaryFocus!.unfocus();
          chatController.settextfieldicon();
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ImageHistoryState) {
            // print("New chat loaded...");
            // if ((chatMessages.items.chatDetail.length !=
            //         state.chatMessages.items.chatDetail.length) ||
            //     chatMessages.items.symptomHistory.length !=
            //         state.chatMessages.items.symptomHistory.length) {

            imagehistory = state.chatimage;
            log(state.chatimage.toString());
            // Future(
            //   () => scrollController.animateTo(
            //     scrollController.position.maxScrollExtent,
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.easeOut,
            //   ),
            // );

            // HapticFeedback.mediumImpact();
            // log("===>>> Latest history: ${state.chatMessages.toJson()}");
            // }
            // log("===>>> Chat List Length: ${state.chatMessages.items.chatDetail.length}");

            // scrollController.animateTo(
            //   scrollController.position.maxScrollExtent,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.easeOut,
            // );
          }
          if (state.status == ChatStatus.loading) {
            // Future(
            //   () => scrollController.animateTo(
            //     scrollController.position.maxScrollExtent,
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.easeOut,
            //   ),
            // );
          }
          return LayoutBuilder(builder: (context, constraints) {
            if (mediaQuery.viewInsets.bottom > 0) {
              // Keyboard is visible
              chatController.isKeyboardVisible.value = true;
            } else {
              // Keyboard is not visible
              chatController.isKeyboardVisible.value = false;
            }
            // Group images by date
            Map<String, List<String>> dateGroupedImages = {};
            for (ImagesDetails message in imagehistory) {
              DateTime messageDateTime = DateTime.parse(message.createAt);
              String messageDate =
                  DateFormat('d MMMM y').format(messageDateTime);

              // dateGroupedImages.putIfAbsent(messageDate, () => []);
              // dateGroupedImages[messageDate]!.addAll(message.userImage);
              // Check if userImage is not empty
              if (message.userImage.isNotEmpty) {
                dateGroupedImages.putIfAbsent(messageDate, () => []);
                dateGroupedImages[messageDate]!.addAll(message.userImage);
              }
            }

// Create a list of widgets for each date
            List<Widget> dateWidgets = [];
            dateGroupedImages.forEach((formattedDate, images) {
              List<Widget> imageWidgets = images
                  .map((imageUrl) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: imageUrl,
                          width: mq.width * 0.29, // Adjust as needed
                          height: mq.width * 0.29, // Adjust as needed
                        ),
                      ))
                  .toList();

              dateWidgets.add(
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: imageWidgets.reversed.map((e) => e).toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            });
            return Stack(
              children: [
                Scaffold(
                  appBar: AppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: MaterialButton(
                          color: const Color.fromARGB(255, 200, 6, 35),
                          onPressed: () {
                            homeBloc.add(ImageAddHistoryEvent());
                          },
                          // icon: const Icon(Icons.file_upload_outlined),
                          child: Text(
                            translate(context).lbl_upload_image,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // CustomButtom(
                      //   buttonwidth: mq.width * 0.3,
                      //   button_name: "Upload Image",
                      //   buttonaction: () {
                      //     // homeBloc.add(ImageAddHistoryEvent());
                      //     homeBloc.add(ImageAddHistoryEvent());
                      //   },
                      //   filledcolor: true,
                      // )
                    ],
                    // leading: IconButton(
                    //     onPressed: () {
                    //       Get.back();
                    //     },
                    //     icon: Icon(Icons.navigate_before)),
                    backgroundColor: Colors.white,
                    // automaticallyImplyLeading: false,

                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translate(context).lbl_image_history,
                                style: AppTheme.mediumText,
                              ),
                              // Text(
                              //   "Chat image history",
                              //   style: AppTheme.bodyText2,
                              // )
                            ],
                          ),
                        ),
                        // Spacer(),
                        // Padding(
                        //   padding:
                        //       const EdgeInsets.symmetric(horizontal: 8.0),
                        //   child: Text(
                        //     "${_chatController.contactChats[index].time} min",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         color: Color.fromARGB(128, 99, 99, 99)),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                  body:
                      // ListView.builder(
                      //   primary: false,
                      //   shrinkWrap: true,
                      //   reverse: true,
                      //   itemCount: imagehistory.length,
                      //   itemBuilder: (context, index) {
                      //     ImagesDetails message = imagehistory[index];

                      //     final parsedDateTime = DateTime.parse(message.createAt);
                      //     final dateFormat = DateFormat('d MMMM y');
                      //     final formattedDate = dateFormat.format(parsedDateTime);

                      //     final timeFormat = DateFormat('HH:mm');
                      //     final formattedTime = timeFormat.format(parsedDateTime);
                      //     return message.userImage != null &&
                      //             message.userImage.isNotEmpty
                      //         ? Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 margin: const EdgeInsets.all(5.0),
                      //                 width: mq.width * 0.95,
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.white,
                      //                   borderRadius: BorderRadius.circular(10),
                      //                   boxShadow: [
                      //                     BoxShadow(
                      //                       color: Colors.grey.withOpacity(0.5),
                      //                       spreadRadius: 3,
                      //                       blurRadius: 4,
                      //                       offset: const Offset(0, 3),
                      //                     ),
                      //                   ],
                      //                 ),
                      //                 padding: const EdgeInsets.only(
                      //                     top: 10.0, bottom: 8.0),
                      //                 child: message.userImage.isNotEmpty
                      //                     ? Column(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.center,
                      //                         children: [
                      //                           Padding(
                      //                             padding:
                      //                                 const EdgeInsets.symmetric(
                      //                                     horizontal: 18.0),
                      //                             child: Row(
                      //                               mainAxisAlignment:
                      //                                   MainAxisAlignment
                      //                                       .spaceBetween,
                      //                               children: [
                      //                                 Text(
                      //                                   // 2024-04-29T12:35:26.737Z
                      //                                   formattedDate,
                      //                                   style: const TextStyle(
                      //                                       fontSize: 20,
                      //                                       fontWeight:
                      //                                           FontWeight.bold),
                      //                                 ),
                      //                                 Text(
                      //                                   // 2024-04-29T12:35:26.737Z
                      //                                   formattedTime,
                      //                                   style: const TextStyle(
                      //                                       fontSize: 18,
                      //                                       fontWeight:
                      //                                           FontWeight.w400),
                      //                                   // ${message.createAt.toString().split('T').last.split('.').first}"
                      //                                 ),
                      //                               ],
                      //                             ),
                      //                           ),
                      //                           Wrap(
                      //                             children: message
                      //                                 .userImage.reversed
                      //                                 .map((e) => Padding(
                      //                                       padding:
                      //                                           const EdgeInsets
                      //                                               .all(8.0),
                      //                                       child: ClipRRect(
                      //                                         borderRadius:
                      //                                             const BorderRadius
                      //                                                 .all(Radius
                      //                                                     .circular(
                      //                                                         10)),
                      //                                         child:
                      //                                             CachedNetworkImage(
                      //                                           fit: BoxFit.cover,
                      //                                           imageUrl: e,
                      //                                           // height:
                      //                                           //     width * 0.42,
                      //                                           width: width * 0.42,
                      //                                         ),
                      //                                       ),
                      //                                     ))
                      //                                 .toList(),
                      //                           ),
                      //                         ],
                      //                       )

                      //                     // ? Text(e.images.length.toString())
                      //                     : const SizedBox(),
                      //               ),
                      //             ],
                      //           )
                      //         : const SizedBox();
                      //   },
                      // ),
                      // --------
                      //     ListView.builder(
                      //   primary: false,
                      //   shrinkWrap: true,
                      //   reverse: true,
                      //   itemCount: imagehistory.length,
                      //   itemBuilder: (context, index) {
                      //     ImagesDetails message = imagehistory[index];

                      //     final parsedDateTime = DateTime.parse(message.createAt);
                      //     final dateFormat = DateFormat('d MMMM y');
                      //     final formattedDate = dateFormat.format(parsedDateTime);

                      //     final timeFormat = DateFormat('HH:mm');
                      //     final formattedTime = timeFormat.format(parsedDateTime);

                      //     // Group images by date
                      //     Map<String, List<String>> dateGroupedImages = {};
                      //     for (ImagesDetails message in imagehistory) {
                      //       DateTime messageDateTime =
                      //           DateTime.parse(message.createAt);
                      //       String messageDate = dateFormat.format(messageDateTime);
                      //       dateGroupedImages.putIfAbsent(messageDate, () => []);
                      //       dateGroupedImages[messageDate]!
                      //           .addAll(message.userImage);
                      //     }

                      //     return Container(
                      //       margin: const EdgeInsets.symmetric(vertical: 5),
                      //       padding: const EdgeInsets.all(8),
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(10),
                      //         boxShadow: [
                      //           BoxShadow(
                      //             color: Colors.grey.withOpacity(0.5),
                      //             spreadRadius: 3,
                      //             blurRadius: 4,
                      //             offset: const Offset(0, 3),
                      //           ),
                      //         ],
                      //       ),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             formattedDate,
                      //             style: const TextStyle(
                      //               fontSize: 20,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 5),
                      //           Text(
                      //             formattedTime,
                      //             style: const TextStyle(
                      //               fontSize: 18,
                      //               fontWeight: FontWeight.w400,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 10),
                      //           Wrap(
                      //             spacing: 8,
                      //             runSpacing: 8,
                      //             children: dateGroupedImages[formattedDate]
                      //                     ?.map((e) => ClipRRect(
                      //                           borderRadius:
                      //                               BorderRadius.circular(10),
                      //                           child: CachedNetworkImage(
                      //                             fit: BoxFit.cover,
                      //                             imageUrl: e,
                      //                             width: 100, // Adjust as needed
                      //                             height: 100, // Adjust as needed
                      //                           ),
                      //                         ))
                      //                     ?.toList() ??
                      //                 [],
                      //           ),
                      //         ],
                      //       ),
                      //     );
                      //   },
                      // ),
                      ListView(
                    primary: false,
                    shrinkWrap: true,
                    reverse: true,
                    children: dateWidgets,
                  ),
                ),

                // Positioned(
                //     bottom: 20,
                //     right: 5,
                //     left: 5,
                //     child: CustomButtom(
                //       button_name: "Upload Image",
                //       buttonaction: () {
                //         // homeBloc.add(ImageAddHistoryEvent());
                //         homeBloc.add(FetchImageHistoryEvent());
                //       },
                //       filledcolor: true,
                //     ))
              ],
            );
          });
        },
      ),
    );
  }

  // Future<void> uploadImages(context) async {
  //   final homeBloc = BlocProvider.of<ChatBloc>(context);

  //   final userId = storage.read('userid') ?? "";
  //   final ImagePicker _picker = ImagePicker();
  //   List<String> uploadedImageUrls = [];
  //   final List<XFile> images = await _picker.pickMultiImage();

  //   if (images != null) {
  //     for (var image in images) {
  //       File file = File(image.path);
  //       String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  //       try {
  //         await FirebaseStorage.instance.ref('images/$fileName').putFile(file);

  //         String downloadURL = await FirebaseStorage.instance
  //             .ref('images/$fileName')
  //             .getDownloadURL();

  //         // setState(() {
  //         uploadedImageUrls.add(downloadURL);
  //       } catch (e) {
  //         print('Error uploading image: $e');
  //       }
  //     }
  //     NewMessageModel newNessage = NewMessageModel(
  //       userId: userId,
  //       symptomId: null,
  //       answer: "",
  //       userQuestion: "",
  //       userImage: uploadedImageUrls,
  //     );
  //     homeBloc.add(ChatAddMessageEvent(message: newNessage));
  //   }
  // }
}
