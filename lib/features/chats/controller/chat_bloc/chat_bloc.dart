import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skin_care/features/chats/model.dart/image_history.dart';
import 'package:skin_care/features/chats/model.dart/new_message_model.dart';
import 'package:skin_care/features/chats/repo/chat_repo.dart';
import 'package:skin_care/shared/dynamictoast.dart';

import '../../../../dependency_injection.dart';
import '../../model.dart/chat_details_model.dart';

part 'chat_events.dart';
part 'chat_state.dart';

// ChatMessage(
//   sender: 'John Doe',
//   data:
//      text -> "Thank you for contacting GTCA Please choose the option that best describes your reason for contact today",
//      cat -> {
//        text -> "please select a cateogry"
//        selelct-from -> ["akne", "cleanser", etc...]
//      }
//      image -> "https://www.youtube.com/watch?v=cdUVbpT-Vks-abc.png"
//   timestamp: "3:02 AM",
//   tag: "text/cat/image/"
// ),
/*
List<ChatModel> chatMessages = [
  ChatMessage(
    sender: 'John Doe',
    // data:
    text:
        "Thank you for contacting GTCA Please choose the option that best describes your reason for contact today",
    //  cat -> {
    //   text -> "please select a cateogry"
    //   selelct-from -> ["akne", "cleanser", etc...]}
    //  image -> "https://www.youtube.com/watch?v=cdUVbpT-Vks-abc.png"
    timestamp: "3:02 AM",
    // tag: "text/cat/image/"
  ),
  ChatMessage(
    sender: 'self',
    text: 'Hi ',
    timestamp: "5:02 PM",
  ),
  ChatMessage(
    sender: 'John Doe',
    text: 'That\'s good to hear!',
    timestamp: "8:02 AM",
  ),
  ChatMessage(
    sender: 'self',
    text: 'Hey guys, what\'s up?',
    timestamp: "9:45 PM",
  ),
  ChatMessage(
    sender: 'John Doe',
    text: 'Not much, just chilling. How about you?',
    timestamp: "8:12 AM",
  ),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "5:02 AM"),
  ChatMessage(
      sender: 'John Doe',
      text: 'Just got back from work, feeling tired.',
      timestamp: "7:02 AM"),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "1:02 PM"),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "1:02 PM"),
  ChatMessage(
    sender: 'self',
    text: 'Hi ',
    timestamp: "5:02 PM",
  ),
  ChatMessage(
    sender: 'John Doe',
    text: 'That\'s good to hear!',
    timestamp: "8:02 AM",
  ),
  ChatMessage(
    sender: 'self',
    text: 'Hey guys, what\'s up?',
    timestamp: "9:45 PM",
  ),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "1:02 PM"),
  ChatMessage(
    sender: 'John Doe',
    text: 'Not much, just chilling. How about you?',
    timestamp: "8:12 AM",
  ),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "5:02 AM"),
  ChatMessage(
      sender: 'John Doe',
      text: 'Just got back from work, feeling tired.',
      timestamp: "7:02 AM"),
  ChatMessage(
      sender: 'self',
      text: 'Just got back from work, feeling tired.',
      timestamp: "1:02 PM"),
];
*/
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  bool loaddata = true;
  ChatBloc()
      : super(const ChatState(
          status: ChatStatus.initial,
        )) {
    on<ChatLoadEvent>((event, emit) => _loadChat(emit, state));
    on<ChatClearEvent>((event, emit) => _clearChat(emit, state));
    on<ChatAddMessageEvent>((event, emit) => _addMessage(event, emit));
    on<ChatAddImagesEvent>((event, emit) => _addImages(event, emit));
    on<ImageAddHistoryEvent>((event, emit) => _addHistory(event, emit));
    on<FetchImageHistoryEvent>(
      (event, emit) => _getImages(event, emit),
    );
    on<StopCalling>((event, emit) => _loading(emit, state));
  }

  _loadChat(Emitter<ChatState> emit, ChatState state) async {
    loaddata = true;
    state.copyWith(
      status: ChatStatus.loading,
    );
    Future.delayed(const Duration(seconds: 4));
    while (loaddata) {
      try {
        final response = await ChatRepo.getChatHistory(storage.read('userid'));
        log("chats data " + response.toString());
        // state.copyWith(
        //   status: ChatStatus.success,
        // );

        emit(
          ChatLoadedState(
            status: ChatStatus.success,
            chatMessages: ChatModel.fromJson(response),
          ),
        );
      } on SocketException {
        // add(ChatLoadEvent());
        print("socket exception");
      } catch (e) {
        print(e);
        // add(ChatLoadEvent());
      }

      await Future.delayed(const Duration(seconds: 3));
    }
  }

  //  stop loading chat
  _loading(Emitter<ChatState> emit, ChatState state) async {
    loaddata = false;
  }
  //

  _addMessage(ChatAddMessageEvent event, Emitter<ChatState> emit) async {
    HapticFeedback.mediumImpact();
    emit(state.copyWith(status: ChatStatus.loading));
    var body = {
      "userId": storage.read('userid'),
      "symptomId": event.message.symptomId,
      "answer": event.message.answer,
      "userQuestion": event.message.userQuestion,
      "userImage": event.message.userImage,
    };
    log("this is message body : $body");
    final response = await ChatRepo.addChat(body);
    log("Message sent: ${response}");

    // emit(state.copyWith(status: ChatStatus.loading));
    add(ChatLoadEvent());
    // _loadChat(emit, state);
    // final chat = await ChatRepo.getChatHistory(storage.read('userid'));

    // emit(
    //   ChatLoadedState(
    //     status: ChatStatus.success,
    //     chatMessages: ChatModel.fromJson(chat),
    //   ),
    // );
  }

  _clearChat(Emitter<ChatState> emit, ChatState state) async {
    final response = await ChatRepo.clearChatHistory(storage.read('userid'));
    log("Chat Cleared: ${response}");

    // final chat = await ChatRepo.getChatHistory(storage.read('userid'));

    // emit(
    //   ChatLoadedState(
    //     status: ChatStatus.success,
    //     chatMessages: ChatModel.fromJson(chat),
    //   ),
    // );

    add(ChatLoadEvent());
  }

  _addImages(ChatAddImagesEvent event, Emitter<ChatState> emit) async {
    // final homeBloc = BlocProvider.of<ChatBloc>(context);

    emit(state.copyWith(status: ChatStatus.loading));
    final userId = storage.read('userid') ?? "";
    final ImagePicker _picker = ImagePicker();
    String uploadedImageUrls;
    var images = await _picker.pickImage(source: ImageSource.gallery);

    if (images != null) {
      File file = File(images.path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      try {
        await FirebaseStorage.instance.ref('images/$fileName').putFile(file);

        String downloadURL = await FirebaseStorage.instance
            .ref('images/$fileName')
            .getDownloadURL();

        // setState(() {
        uploadedImageUrls = downloadURL;
        NewMessageModel newNessage = NewMessageModel(
          userId: userId,
          symptomId: null,
          answer: "",
          userQuestion: '',
          userImage: uploadedImageUrls,
        );
        // homeBloc.
        add(ChatAddMessageEvent(message: newNessage));
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<void> _addHistory(
      ImageAddHistoryEvent event, Emitter<ChatState> emit) async {
    emit(state.copyWith(status: ChatStatus.loading));
    final userId = storage.read('userid') ?? "";
    final ImagePicker _picker = ImagePicker();
    List<String> uploadedhistoryUrls = [];
    final List<XFile> images = await _picker.pickMultiImage();
    if (images != null) {
      for (var image in images) {
        File file = File(image.path);
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        try {
          await FirebaseStorage.instance.ref('history/$fileName').putFile(file);

          String downloadURL = await FirebaseStorage.instance
              .ref('history/$fileName')
              .getDownloadURL();

          // setState(() {
          uploadedhistoryUrls.add(downloadURL);
          log(uploadedhistoryUrls.toString());
        } catch (e) {
          print('Error uploading image: $e');
        }
      }
      final body = {"userId": userId, "userImage": uploadedhistoryUrls};
      final response = await ChatRepo.addHistoryImage(body);
      // print("??????????????????????");
      // log(response.toString());
      if (response["subCode"] == 200) {
        final response2 = await ChatRepo.getImageHistory(userId);
        // log(response2.toString());
        List<ImagesDetails> imagesdata = [];

        for (var item in response2['items']) {
          imagesdata.addAll((item['imagesDetails'] as List<dynamic>)
              .map((details) => ImagesDetails.fromJson(details))
              .toList());
        }

        print("??????????thhis is image data????????????");

        log(imagesdata.toString());
        emit(
          ImageHistoryState(
            status: ChatStatus.success,
            chatimage: imagesdata,
          ),
        );
      }

      // NewMessageModel newNessage = NewMessageModel(
      //   userId: userId,
      //   symptomId: null,
      //   answer: "",
      //   userQuestion: "",
      //   userImage: uploadedImageUrls,
      // );
      // homeBloc.

      // add(ChatAddMessageEvent(message: newNessage));
    }
  }

  Future<void> _getImages(
      FetchImageHistoryEvent event, Emitter<ChatState> emit) async {
    final userId = storage.read('userid') ?? "";

    try {
      final response2 = await ChatRepo.getImageHistory(userId);
      List<ImagesDetails> imagesdata = [];

      for (var item in response2['items']) {
        imagesdata.addAll((item['imagesDetails'] as List<dynamic>)
            .map((details) => ImagesDetails.fromJson(details))
            .toList());
      }
      print("??????????thhis is image data????????????");

      log(imagesdata.toString());
      emit(
        ImageHistoryState(
          status: ChatStatus.success,
          chatimage: imagesdata,
        ),
      );
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }
}
