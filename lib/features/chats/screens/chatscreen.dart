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
import 'package:shimmer/shimmer.dart';
import 'package:skin_care/features/chats/model.dart/new_message_model.dart';
// import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:skin_care/features/setting/model/language_model.dart';
import 'package:readmore/readmore.dart';

import '../../../core/theme/apptheme.dart';
// import '../../../shared/widgets/dynamic_toast.dart';
import '../../../dependency_injection.dart';
import '../../../shared/dynamictoast.dart';
import '../controller/chat_bloc/chat_bloc.dart';
import '../controller/chatcontroller.dart';
import '../model.dart/chat_details_model.dart';
import '../model.dart/chat_details_model.dart' as chat;
import 'package:cached_network_image/cached_network_image.dart';

import 'image_history.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = '/ChatScreen';

  // late ScrollController scrollController;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the ScrollController
  //   scrollController = ScrollController();
  // }
  int length = 0;

  @override
  Widget build(BuildContext context) {
    const adminIcon = Icon(Icons.support_agent);
    const userIcon = Icon(Icons.face_6);
    //  ChatScreen({super.key});
    final ChatController chatController = Get.put(ChatController());
    // final RegExp _validationRegex = RegExp(r'^(?=.*\S).*$');
    final RegExp _validationRegex = RegExp(r'^\S.*$');

    // final ContactChat contactChat;
    ChatModel chatMessages = ChatModel(
      status: true,
      subCode: 1,
      message: "message",
      error: "error",
      items: Items(
        symptomHistory: [],
        chatDetail: [],
      ),
    );
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    TextEditingController messagecontroller = TextEditingController();
    final homeBloc = BlocProvider.of<ChatBloc>(context);

    final userId = storage.read('userid') ?? "";
    final ScrollController chatscrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   scrollController.animateTo(
    //     scrollController.position.maxScrollExtent,
    //     duration: Duration(milliseconds: 300),
    //     curve: Curves.easeOut,
    //   );
    // });

    return GestureDetector(
      onTap: () {
        if (chatController.iswriting == true) {
          FocusManager.instance.primaryFocus!.unfocus();
          chatController.settextfieldicon();
        }
      },
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoadedState) {
            // print("New chat loaded...");
            // if ((chatMessages.items.chatDetail.length !=
            //         state.chatMessages.items.chatDetail.length) ||
            //     chatMessages.items.symptomHistory.length !=
            //         state.chatMessages.items.symptomHistory.length) {

            chatMessages = state.chatMessages;
            // Future(
            //   () => scrollController.animateTo(
            //     scrollController.position.maxScrollExtent,
            //     duration: const Duration(milliseconds: 300),
            //     curve: Curves.easeOut,
            //   ),
            // );
            // chatMessages.items.chatDetail.length

            // chatscrollController.animateTo(
            //   chatscrollController.position.maxScrollExtent,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.easeOut,
            // );
            if (length != chatMessages.items.chatDetail.length) {
              // print("2 " + length.toString());
              // print("3 " + chatMessages.items.chatDetail.length.toString());
              if (chatMessages.message != state.chatMessages)
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (chatscrollController.hasClients)
                    chatscrollController.animateTo(
                      chatscrollController.position.maxScrollExtent,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.easeOut,
                    );
                });
              length = chatMessages.items.chatDetail.length;
              // print("4 " + length.toString());
              // print("5 " + chatMessages.items.chatDetail.length.toString());
            }

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
            return WillPopScope(
              onWillPop: () async {
                print("will pop scope");
                homeBloc.add(StopCalling());
                return true;
              },
              child: Scaffold(
                drawerEnableOpenDragGesture: true,
                appBar: AppBar(
                  // leading: IconButton(
                  //     onPressed: () {
                  //       Get.back();
                  //     },
                  //     icon: Icon(Icons.navigate_before)),
                  backgroundColor: Colors.white,
                  // automaticallyImplyLeading: false,
                  actions: [
                    Container(
                      height: width * 0.09,
                      width: width * 0.09,
                      margin: EdgeInsets.only(right: width * 0.04),
                      // padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      child: IconButton(
                        onPressed: () {
                          context.read<ChatBloc>().add(ChatLoadEvent());
                        },
                        icon: Icon(
                          CupertinoIcons.refresh,
                          size: width * 0.05,
                        ),
                        // size: height * 0.03,
                      ),
                    ),
                    Container(
                      height: width * 0.09,
                      width: width * 0.09,
                      margin: EdgeInsets.only(right: width * 0.04),
                      // padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12)),
                      child: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title:
                                  Text(translate(context).lbl_dialogue_title),
                              content:
                                  Text(translate(context).lbl_dialogue_content),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  child: Text(translate(context)
                                      .lbl_dialogue_action_cancel),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                CupertinoDialogAction(
                                  isDestructiveAction: true,
                                  child: Text(translate(context)
                                      .lbl_dialogue_action_delete),
                                  onPressed: () {
                                    // Dispatch delete chat event
                                    context
                                        .read<ChatBloc>()
                                        .add(ChatClearEvent());
                                    Navigator.pop(context);
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                          size: width * 0.05,
                        ),

                        // size: height * 0.03,
                      ),
                    ),
                    // Container(
                    //   height: width * 0.09,
                    //   width: width * 0.09,
                    //   margin: EdgeInsets.only(right: width * 0.04),
                    //   // padding: const EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       border: Border.all(color: Colors.black12)),
                    //   child: IconButton(
                    //     onPressed: () {
                    //         Navigator.pushNamed(
                    //                       context, ImageHistory.id);
                    //     },
                    //     icon: Icon(
                    //       CupertinoIcons.photo,
                    //       size: width * 0.05,
                    //     ),

                    //     // size: height * 0.03,
                    //   ),
                    // ),
                  ],
                  title: Row(
                    children: [
                      Container(
                        // padding: EdgeInsets.all(2.5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppTheme.primaryColor, width: 2.3)),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage("assets/images/product1.png"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              translate(context).lbl_chat_bot,
                              style: AppTheme.mediumText,
                            ),
                            Text(
                              translate(context).lbl_chat_with_us,
                              style: AppTheme.bodyText2,
                            )
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
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Container(
                            // padding: EdgeInsets.only(bottom: height * 0.03),
                            // margin: EdgeInsets.only(
                            //   bottom: height * 0.09,
                            //   left: width * 0.01,
                            //   right: width * 0.01,
                            // ),
                            child: ListView(
                              controller: chatscrollController,
                              children: [
                                /*
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        primary: false,
                                        shrinkWrap: true,
                                        controller: scrollController,
                                        itemCount:
                                            chatMessages!.items.symptomHistory.length,
                                        itemBuilder: (context, index) {
                                          final message =
                                              chatMessages!.items.symptomHistory;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 9.0,
                                              vertical: 2.0,
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        maxWidth: width * 0.65,
                                                      ),
                                                      child: Wrap(
                                                        spacing: 9,
                                                        children:  chatMessages!.items.symptomHistory
                                                            .map((item) => Column(
                                                                  children: [
                                                                    Chip(
                                                                      backgroundColor:
                                                                          Colors.blue,
                                                                      label: Text(
                                                                        item
                                                                            .symptomData[
                                                                                0]
                                                                            .symptomName,
                                                                        style: AppTheme
                                                                            .bodyText1
                                                                            .copyWith(
                                                                          color: Color
                                                                              .fromARGB(
                                                                                  255,
                                                                                  255,
                                                                                  255,
                                                                                  255),
                                                                        ),
                                                                      ),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius
                                                                                .circular(
                                                                                    12),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ))
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                      */
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8.0,
                                    bottom: 6.0,
                                    top: 8.0,
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.0, right: 4.0),
                                          child: adminIcon,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: width * 0.6,
                                          ),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            decoration: const BoxDecoration(
                                                color: Color.fromARGB(
                                                    255, 255, 206, 215),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    topLeft:
                                                        Radius.circular(12),
                                                    bottomLeft: Radius.zero,
                                                    bottomRight:
                                                        Radius.circular(12))),
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                                translate(context)
                                                    .lbl_chatbotmessage,
                                                style: AppTheme.bodyText1
                                                    .copyWith(
                                                        color: Colors.black)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (state.status == ChatStatus.success)
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            maxWidth: width * 0.65,
                                          ),
                                          child: Wrap(
                                            spacing: 9,
                                            children: chatMessages
                                                .items.symptomHistory
                                                .map((item) => Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            NewMessageModel
                                                                message =
                                                                NewMessageModel(
                                                              userId: userId,
                                                              symptomId: item
                                                                  .symptomData[
                                                                      0]
                                                                  .id,
                                                              answer: "",
                                                              userQuestion: "",
                                                            );
                                                            homeBloc.add(
                                                                ChatAddMessageEvent(
                                                                    message:
                                                                        message));
                                                          },
                                                          child: Chip(
                                                            backgroundColor:
                                                                Colors.blue,
                                                            label: Text(
                                                              item
                                                                  .symptomData[
                                                                      0]
                                                                  .symptomName,
                                                              style: AppTheme
                                                                  .bodyText1
                                                                  .copyWith(
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                              ),
                                                            ),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  primary: false,
                                  shrinkWrap: true,

                                  // reverse: true,
                                  // controller: enableScroll,
                                  itemCount:
                                      chatMessages.items.chatDetail.length,
                                  itemBuilder: (context, index) {
                                    // chatscrollController.animateTo(
                                    //   chatscrollController.position.maxScrollExtent,
                                    //   duration: const Duration(milliseconds: 300),
                                    //   curve: Curves.easeOut,
                                    // );
                                    // int reverseIndex =
                                    //     chatMessages.items.chatDetail.length -
                                    //         1 -
                                    //         index;
                                    chat.ChatDetail message =
                                        chatMessages.items.chatDetail[index];
                                    return message.userImage != null &&
                                            message.userImage.isNotEmpty
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    !(message.userId == userId)
                                                        ? MainAxisAlignment
                                                            .start
                                                        : MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      maxWidth: width *
                                                          0.65, // Adjust the maximum width as needed
                                                    ),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          // color: message.userId == userId
                                                          //     ? const Color.fromARGB(
                                                          //         255, 226, 57, 83)
                                                          //     : const Color.fromARGB(
                                                          //         255, 255, 206, 215),
                                                          borderRadius: BorderRadius.only(
                                                              topRight: const Radius
                                                                  .circular(12),
                                                              topLeft: const Radius
                                                                  .circular(12),
                                                              bottomLeft: !(message
                                                                          .userId ==
                                                                      userId)
                                                                  ? Radius.zero
                                                                  : const Radius
                                                                      .circular(
                                                                      12),
                                                              bottomRight: (message
                                                                          .userId ==
                                                                      userId)
                                                                  ? Radius.zero
                                                                  : const Radius
                                                                      .circular(
                                                                      12))),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: message.userImage
                                                              .isNotEmpty
                                                          ?
                                                          // Wrap(
                                                          //     children:
                                                          //         message.userImage
                                                          //             .map((e) =>
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20)),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Text(
                                                                          "Image not found"),
                                                                  imageUrl: message
                                                                      .userImage,
                                                                  height:
                                                                      width *
                                                                          0.5,
                                                                  width: width *
                                                                      0.5,
                                                                ),
                                                              ),
                                                            )
                                                          //           .toList(),
                                                          // )

                                                          // ? Text(e.images.length.toString())
                                                          : const SizedBox(),
                                                    ),
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0, left: 6.0),
                                                    child: userIcon,
                                                  ),
                                                ],
                                              ),

                                              ///??????
                                              Row(
                                                  mainAxisAlignment: (message
                                                              .userId ==
                                                          userId)
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, right: 4.0),
                                                      child: adminIcon,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: width *
                                                            0.65, // Adjust the maximum width as needed
                                                      ),
                                                      child: message.replyOnMessage !=
                                                                  null &&
                                                              message
                                                                  .replyOnMessage!
                                                                  .isNotEmpty
                                                          ?
                                                          // Text(message.replyOnMessage
                                                          //     .toString())

                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: !(message.userId ==
                                                                          userId)
                                                                      ? const Color.fromARGB(
                                                                          255,
                                                                          226,
                                                                          57,
                                                                          83)
                                                                      : const Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          206,
                                                                          215),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          const Radius.circular(
                                                                              12),
                                                                      topLeft: const Radius.circular(
                                                                          12),
                                                                      bottomLeft: (message.userId == userId)
                                                                          ? Radius.zero
                                                                          : const Radius.circular(12),
                                                                      bottomRight: !(message.userId == userId) ? Radius.zero : const Radius.circular(12))),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      10.0),
                                                              margin:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                vertical: 4.0,
                                                              ),
                                                              child:
                                                                  ReadMoreText(
                                                                message.answerDetail
                                                                            .length !=
                                                                        0
                                                                    ? message
                                                                        .answerDetail[
                                                                            0]
                                                                        .answer
                                                                        .toString()
                                                                    : message
                                                                        .replyOnMessage
                                                                        .toString(),
                                                                trimLines: 5,
                                                                // colorClickableText: Colors.blue,
                                                                trimMode:
                                                                    TrimMode
                                                                        .Line,
                                                                trimCollapsedText:
                                                                    'Read more',
                                                                style: AppTheme
                                                                    .bodyText1
                                                                    .copyWith(
                                                                  color: !(message
                                                                              .userId ==
                                                                          userId)
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                      : Colors
                                                                          .black,
                                                                ),

                                                                trimExpandedText:
                                                                    'Read less',
                                                                moreStyle: AppTheme
                                                                    .bodyText2
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .blue),

                                                                lessStyle: AppTheme
                                                                    .bodyText2
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .blue),
                                                              ),
                                                              //
                                                              // Text(
                                                              //     message.answerDetail
                                                              //                 .length !=
                                                              //             0
                                                              //         ? message
                                                              //             .answerDetail[
                                                              //                 0]
                                                              //             .answer
                                                              //             .toString()
                                                              //         : message
                                                              //             .replyOnMessage
                                                              //             .toString(),
                                                              //     style: AppTheme.bodyText1.copyWith(
                                                              //         color: !(message.userId ==
                                                              //                 userId)
                                                              //             ? const Color.fromARGB(
                                                              //                 255,
                                                              //                 255,
                                                              //                 255,
                                                              //                 255)
                                                              //             : Colors
                                                              //                 .black)),
                                                              //
                                                            )
                                                          : SizedBox(),
                                                    )
                                                  ])

                                              ///?????
                                            ],
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: !(message
                                                              .userId ==
                                                          userId)
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: width *
                                                            0.65, // Adjust the maximum width as needed
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: message.userId == userId
                                                                ? const Color.fromARGB(
                                                                    255, 226, 57, 83)
                                                                : const Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    206,
                                                                    215),
                                                            borderRadius: BorderRadius.only(
                                                                topRight: const Radius.circular(
                                                                    12),
                                                                topLeft:
                                                                    const Radius.circular(
                                                                        12),
                                                                bottomLeft: !(message.userId ==
                                                                        userId)
                                                                    ? Radius.zero
                                                                    : const Radius.circular(12),
                                                                bottomRight: (message.userId == userId) ? Radius.zero : const Radius.circular(12))),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: //
                                                            ReadMoreText(
                                                          message.userQuestion
                                                                  .isNotEmpty
                                                              ? message
                                                                  .userQuestion
                                                                  .toString()
                                                              : chatMessages
                                                                      .items
                                                                      .symptomHistory
                                                                      .where((e) =>
                                                                          e.symptomId ==
                                                                          message
                                                                              .symptomId)
                                                                      .toList()
                                                                      .isEmpty
                                                                  ? ""
                                                                  : message
                                                                          .answerDetail
                                                                          .isEmpty
                                                                      ? chatMessages
                                                                          .items
                                                                          .symptomHistory
                                                                          .where((e) =>
                                                                              e.symptomId ==
                                                                              message
                                                                                  .symptomId)
                                                                          .toList()[
                                                                              0]
                                                                          .symptomData[
                                                                              0]
                                                                          .symptomName
                                                                      : message
                                                                          .answerDetail[
                                                                              0]
                                                                          .answer,
                                                          trimLines: 5,
                                                          // colorClickableText: Colors.blue,
                                                          trimMode:
                                                              TrimMode.Line,
                                                          trimCollapsedText:
                                                              'Read more',
                                                          style: AppTheme
                                                              .bodyText1
                                                              .copyWith(
                                                            color: message
                                                                        .userId ==
                                                                    userId
                                                                ? const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255)
                                                                : Colors.black,
                                                          ),

                                                          trimExpandedText:
                                                              'Read less',
                                                          moreStyle: AppTheme
                                                              .bodyText2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .blue),

                                                          lessStyle: AppTheme
                                                              .bodyText2
                                                              .copyWith(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                        //  Text(
                                                        //     message.userQuestion
                                                        //             .isNotEmpty
                                                        //         ? message
                                                        //             .userQuestion
                                                        //             .toString()
                                                        //         : chatMessages
                                                        //                 .items
                                                        //                 .symptomHistory
                                                        //                 .where((e) =>
                                                        //                     e.symptomId ==
                                                        //                     message
                                                        //                         .symptomId)
                                                        //                 .toList()
                                                        //                 .isEmpty
                                                        //             ? ""
                                                        //             : message.answerDetail
                                                        //                     .isEmpty
                                                        //                 ? chatMessages
                                                        //                     .items
                                                        //                     .symptomHistory
                                                        //                     .where((e) =>
                                                        //                         e.symptomId ==
                                                        //                         message
                                                        //                             .symptomId)
                                                        //                     .toList()[
                                                        //                         0]
                                                        //                     .symptomData[
                                                        //                         0]
                                                        //                     .symptomName
                                                        //                 : message
                                                        //                     .answerDetail[
                                                        //                         0]
                                                        //                     .answer,
                                                        //     // .where((e) => e.question == message.question)
                                                        //     // .toList()[0]
                                                        //     // .answer",
                                                        //     style: AppTheme.bodyText1.copyWith(
                                                        //         color: message.userId == userId
                                                        //             ? const Color.fromARGB(255, 255, 255, 255)
                                                        //             : Colors.black)),
                                                        //
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, left: 6.0),
                                                      child: userIcon,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: (message
                                                              .userId ==
                                                          userId)
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 8.0, right: 4.0),
                                                      child: adminIcon,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints:
                                                          BoxConstraints(
                                                        maxWidth: width *
                                                            0.65, // Adjust the maximum width as needed
                                                      ),
                                                      child: message.replyOnMessage !=
                                                                  null &&
                                                              message
                                                                  .replyOnMessage!
                                                                  .isNotEmpty
                                                          ?
                                                          // Text(message.replyOnMessage
                                                          //     .toString())

                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  color: !(message.userId ==
                                                                          userId)
                                                                      ? const Color.fromARGB(
                                                                          255,
                                                                          226,
                                                                          57,
                                                                          83)
                                                                      : const Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          206,
                                                                          215),
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight: const Radius.circular(12),
                                                                      topLeft: const Radius.circular(12),
                                                                      bottomLeft: (message.userId == userId) ? Radius.zero : const Radius.circular(12),
                                                                      bottomRight: !(message.userId == userId) ? Radius.zero : const Radius.circular(12))),
                                                              padding: const EdgeInsets.all(10.0),
                                                              margin: const EdgeInsets.symmetric(
                                                                vertical: 4.0,
                                                              ),
                                                              child: ReadMoreText(
                                                                message.answerDetail
                                                                            .length !=
                                                                        0
                                                                    ? message
                                                                        .answerDetail[
                                                                            0]
                                                                        .answer
                                                                        .toString()
                                                                    : message
                                                                        .replyOnMessage
                                                                        .toString(),
                                                                trimLines: 5,
                                                                // colorClickableText: Colors.blue,
                                                                trimMode:
                                                                    TrimMode
                                                                        .Line,
                                                                trimCollapsedText:
                                                                    'Read more',
                                                                style: AppTheme
                                                                    .bodyText1
                                                                    .copyWith(
                                                                  color: !(message
                                                                              .userId ==
                                                                          userId)
                                                                      ? const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)
                                                                      : Colors
                                                                          .black,
                                                                ),

                                                                trimExpandedText:
                                                                    'Read less',
                                                                moreStyle: AppTheme
                                                                    .bodyText2
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .blue),

                                                                lessStyle: AppTheme
                                                                    .bodyText2
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .blue),
                                                              )
                                                              //

                                                              //  Text(
                                                              //     message.answerDetail
                                                              //                 .length !=
                                                              //             0
                                                              //         ? message
                                                              //             .answerDetail[
                                                              //                 0]
                                                              //             .answer
                                                              //             .toString()
                                                              //         : message
                                                              //             .replyOnMessage
                                                              //             .toString(),
                                                              //     style: AppTheme.bodyText1.copyWith(
                                                              //         color: !(message.userId ==
                                                              //                 userId)
                                                              //             ? const Color.fromARGB(
                                                              //                 255,
                                                              //                 255,
                                                              //                 255,
                                                              //                 255)
                                                              //             : Colors
                                                              //                 .black)),
                                                              //
                                                              )
                                                          : Column(
                                                              children: [
                                                                ...chatMessages
                                                                    .items
                                                                    .symptomHistory
                                                                    .where((e) =>
                                                                        e.symptomId ==
                                                                        message
                                                                            .symptomId)
                                                                    .toList()[0]
                                                                    .questions
                                                                    .map((e) =>
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                                decoration: BoxDecoration(color: !(message.userId == userId) ? const Color.fromARGB(255, 226, 57, 83) : const Color.fromARGB(255, 255, 206, 215), borderRadius: BorderRadius.only(topRight: const Radius.circular(12), topLeft: const Radius.circular(12), bottomLeft: (message.userId == userId) ? Radius.zero : const Radius.circular(12), bottomRight: !(message.userId == userId) ? Radius.zero : const Radius.circular(12))),
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                margin: const EdgeInsets.symmetric(
                                                                                  vertical: 4.0,
                                                                                ),
                                                                                child: //
                                                                                    ReadMoreText(
                                                                                  e.question,
                                                                                  trimLines: 5,
                                                                                  // colorClickableText: Colors.blue,
                                                                                  trimMode: TrimMode.Line,
                                                                                  trimCollapsedText: 'Read more',
                                                                                  style: AppTheme.bodyText1.copyWith(
                                                                                    color: !(message.userId == userId) ? const Color.fromARGB(255, 255, 255, 255) : Colors.black,
                                                                                  ),

                                                                                  trimExpandedText: 'Read less',
                                                                                  moreStyle: AppTheme.bodyText2.copyWith(color: Colors.blue),

                                                                                  lessStyle: AppTheme.bodyText2.copyWith(color: Colors.blue),
                                                                                )
                                                                                //  Text(e.question, style: AppTheme.bodyText1.copyWith(color: !(message.userId == userId) ? const Color.fromARGB(255, 255, 255, 255) : Colors.black)),
                                                                                ),
                                                                            // show if it's not first
                                                                            // chatMessages!.items.chatDetail.indexOf(message) ==
                                                                            //         message.symptomDetail.length -
                                                                            //             1
                                                                            //     ? SizedBox()
                                                                            //     :

                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                left: 18.0,
                                                                                bottom: 5,
                                                                              ),
                                                                              child: Column(
                                                                                children: [
                                                                                  Stack(
                                                                                    children: [
                                                                                      GestureDetector(
                                                                                        onTap: () {
                                                                                          NewMessageModel newNessage = NewMessageModel(
                                                                                            userId: userId,
                                                                                            symptomId: message.symptomId,
                                                                                            userImage: '',
                                                                                            answer: e.answer,
                                                                                            userQuestion: e.question,
                                                                                          );
                                                                                          // print(newNessage
                                                                                          //     .toJson());
                                                                                          homeBloc.add(ChatAddMessageEvent(message: newNessage));
                                                                                        },
                                                                                        child: Container(
                                                                                            decoration: BoxDecoration(color: !(message.userId == userId) ? const Color.fromARGB(255, 226, 57, 83) : const Color.fromARGB(255, 206, 235, 255), borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12), bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12))),
                                                                                            padding: const EdgeInsets.all(6.0),
                                                                                            margin: const EdgeInsets.symmetric(
                                                                                              vertical: 4.0,
                                                                                            ),
                                                                                            child: ReadMoreText(
                                                                                              e.answer,
                                                                                              trimLines: 5,
                                                                                              // colorClickableText: Colors.blue,
                                                                                              trimMode: TrimMode.Line,
                                                                                              trimCollapsedText: 'Read more',
                                                                                              style: AppTheme.bodyText1.copyWith(
                                                                                                color: !(message.userId == userId) ? const Color.fromARGB(255, 255, 255, 255) : Colors.black,
                                                                                              ),

                                                                                              trimExpandedText: 'Read less',
                                                                                              moreStyle: AppTheme.bodyText2.copyWith(color: Colors.blue),

                                                                                              lessStyle: AppTheme.bodyText2.copyWith(color: Colors.blue),
                                                                                            )
                                                                                            // Text(e.answer, style: AppTheme.bodyText1.copyWith(color: !(message.userId == userId) ? const Color.fromARGB(255, 255, 255, 255) : Colors.black)),
                                                                                            ),
                                                                                      ),
                                                                                      chatMessages.items.chatDetail.length - 1 == chatMessages.items.chatDetail.indexOf(message)
                                                                                          ? const SizedBox()
                                                                                          : Positioned.fill(
                                                                                              child: Container(
                                                                                              decoration: const BoxDecoration(
                                                                                                  color: Colors.black26,
                                                                                                  borderRadius: BorderRadius.only(
                                                                                                    topRight: Radius.circular(12),
                                                                                                    topLeft: Radius.circular(12),
                                                                                                    bottomLeft: Radius.circular(12),
                                                                                                    bottomRight: Radius.circular(12),
                                                                                                  )),
                                                                                              padding: const EdgeInsets.all(6.0),
                                                                                              margin: const EdgeInsets.symmetric(
                                                                                                vertical: 4.0,
                                                                                              ),
                                                                                            ))
                                                                                    ],
                                                                                  ),
                                                                                  e.images.isNotEmpty
                                                                                      ? Wrap(
                                                                                          children: e.images
                                                                                              .map((e) => Padding(
                                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                                    child: ClipRRect(
                                                                                                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                                                                                                      child: CachedNetworkImage(
                                                                                                        placeholder: (context, url) {
                                                                                                          return Shimmer.fromColors(
                                                                                                              baseColor: const Color.fromARGB(255, 103, 103, 103),
                                                                                                              highlightColor: const Color.fromARGB(255, 255, 255, 255),
                                                                                                              child: Container(
                                                                                                                color: Colors.black,
                                                                                                                height: width * 0.5,
                                                                                                                width: width * 0.5,
                                                                                                              ));
                                                                                                        },
                                                                                                        imageUrl: e,
                                                                                                        height: width * 0.5,
                                                                                                        width: width * 0.5,
                                                                                                        errorWidget: (context, url, error) => Container(height: width * 0.5, width: width * 0.5, color: const Color.fromARGB(37, 0, 0, 0), child: Center(child: Text("Image not found "))),
                                                                                                      ),
                                                                                                    ),
                                                                                                  ))
                                                                                              .toList(),
                                                                                        )

                                                                                      // ? Text(e.images.length.toString())
                                                                                      : const SizedBox(),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ))
                                                                    .toList()
                                                              ],
                                                              // style: TextStyle(
                                                              //     fontSize: 16,
                                                              //     color: message.sender == "self"
                                                              //         ? Color.fromARGB(
                                                              //             255, 255, 255, 255)
                                                              //         : Colors.black),
                                                              // style: AppTheme
                                                              //     .bodyText1
                                                              //     .copyWith(
                                                              //         color: message
                                                              //                     .userId ==
                                                              //                 userId
                                                              //             ? const Color
                                                              //                 .fromARGB(
                                                              //                 255,
                                                              //                 255,
                                                              //                 255,
                                                              //                 255)
                                                              //             : Colors
                                                              //                 .black)
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                ),
                                if (state.status == ChatStatus.loading)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      bottom: 6.0,
                                      top: 8.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                top: 8.0, right: 4.0),
                                            child: adminIcon,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints(
                                              maxWidth: width * 0.6,
                                            ),
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              decoration: const BoxDecoration(
                                                // color: false
                                                //     ? Color.fromARGB(255, 226, 57, 83)
                                                //     : Color.fromARGB(
                                                //         255, 255, 206, 215),
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft: Radius.zero,
                                                  bottomRight:
                                                      Radius.circular(12),
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                height: width * 0.1,
                                                width: width * 0.15,
                                                constraints: BoxConstraints(
                                                    maxWidth: width * 0.1),
                                                decoration: const BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 250, 193, 201),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(12),
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                      bottomRight:
                                                          Radius.circular(12),
                                                    )),
                                                // margin: EdgeInsets.only(left: width * 0.035),
                                                child: Transform.scale(
                                                  scale: 2,
                                                  child: Lottie.asset(
                                                    'assets/lottie/typing.json',
                                                    // width: width * 0.5,
                                                    // height: width * 0.5,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            if (state.status == ChatStatus.success)
                              IconButton(
                                  onPressed: () {
                                    // uploadImages(context);
                                    homeBloc.add(ChatAddImagesEvent());
                                  },
                                  icon: const Icon(
                                    Icons.add_circle_outline_rounded,
                                    size: 25,
                                  )),
                            Expanded(
                              child: Container(
                                // margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            107, 99, 99, 99)),
                                    // color: AppTheme.mostusedcontainer,
                                    borderRadius: BorderRadius.circular(12)),
                                margin: const EdgeInsets.all(8),
                                // height: 50,
                                width: width * 1,
                                child: TextField(
                                  // inputFormatters: [
                                  //       FilteringTextInputFormatter.deny(" ")
                                  //     ],
                                  controller: messagecontroller,
                                  onEditingComplete: () {
                                    // chatController.settextfieldicon();
                                    FocusManager.instance.primaryFocus!
                                        .unfocus();
                                  },
                                  // onTap: () {
                                  //   chatController.settextfieldicon();
                                  // },
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    suffixIcon:
                                        // chatController.iswriting
                                        //     ?
                                        state.status == ChatStatus.success
                                            ? IconButton(
                                                onPressed: () {
                                                  // FocusManager
                                                  //     .instance.primaryFocus!
                                                  //     .unfocus();
                                                  if (messagecontroller
                                                      .text.isNotEmpty) {
                                                    if (_validationRegex
                                                        .hasMatch(
                                                            messagecontroller
                                                                .text)) {
                                                      // _chatController.addChatMessage("self",
                                                      //     messagecontroller.text, "4:08 AM");

                                                      NewMessageModel
                                                          newNessage =
                                                          NewMessageModel(
                                                        userId: userId,
                                                        symptomId: "",
                                                        answer: "",
                                                        userQuestion:
                                                            messagecontroller
                                                                .text,
                                                      );
                                                      // print(newNessage
                                                      //     .toJson());
                                                      homeBloc.add(
                                                          ChatAddMessageEvent(
                                                              message:
                                                                  newNessage));

                                                      messagecontroller.clear();
                                                    } else {
                                                      DynamicToast.show(
                                                          "Message can't contain empty spaces");
                                                    }
                                                  } else {
                                                    DynamicToast.show(
                                                        "Message can't be empty");
                                                  }
                                                },
                                                icon: const Icon(
                                                  Icons.send,
                                                  size: 25,
                                                ))
                                            : SizedBox(),
                                    // : IconButton(
                                    //     onPressed: () {
                                    //       // uploadImages(context);
                                    //       homeBloc
                                    //           .add(ChatAddImagesEvent());
                                    //     },
                                    //     icon: const Icon(
                                    //       Icons.add_circle_outline_rounded,
                                    //       size: 25,
                                    //     )),
                                    isDense: true,
                                    contentPadding: const EdgeInsets.all(5),
                                    // enabledBorder: OutlineInputBorder(
                                    //     borderRadius: BorderRadius.circular(12),
                                    //     borderSide: BorderSide.none),
                                    hintText:
                                        translate(context).lbl_your_message,
                                    hintStyle: AppTheme.headline4
                                        .copyWith(color: Colors.grey.shade600),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    //
                    // height: 10,
                    // bottom: chatController.isKeyboardVisible.value ? 10 : 10,
                    // left: 10,
                    // right: 10,
                    // bottom: 10,
                  ],
                ),
              ),
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
