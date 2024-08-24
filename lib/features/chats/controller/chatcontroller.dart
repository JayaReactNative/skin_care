import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model.dart/chat_details_model.dart';

class ChatController extends GetxController {
  var isKeyboardVisible = false.obs;
  bool iswriting = false;
  void settextfieldicon() {
    iswriting = !iswriting;
    update();
  }

  // void addChatMessage(String sender, String text, String time) {
  //   ChatMessage newMessage = ChatMessage(
  //     sender: sender,
  //     text: text,
  //     timestamp: time,
  //   );

  //   chatMessages.add(newMessage);
  //   update();
  // }

  // List<ContactChat> contactChats = [
  //   ContactChat(
  //       name: 'John Doe',
  //       lastMessage: 'How are you?',
  //       profilepic: "asset/profileimage/cutegirl.png",
  //       time: "10"),
  //   ContactChat(
  //       name: 'Alice Smith',
  //       lastMessage: 'Did you get the files?',
  //       profilepic: "asset/profileimage/cutegirl1.png",
  //       time: "24"),
  //   ContactChat(
  //     name: 'Bob Johnson',
  //     lastMessage: 'See you later!',
  //     profilepic: "asset/profileimage/cutegirl2.png",
  //     time: "50",
  //   ),
  //   ContactChat(
  //       name: 'Emily Brown',
  //       lastMessage: 'Happy birthday!',
  //       profilepic: "asset/profileimage/cutegirl3.png",
  //       time: "5"),
  //   ContactChat(
  //       name: 'Michael Clark',
  //       lastMessage: 'Can you call me?',
  //       profilepic: "asset/profileimage/cutegirl1.png",
  //       time: "7"),
  //   ContactChat(
  //       name: 'Sophia Wilson',
  //       lastMessage: 'Where are you?',
  //       profilepic: "asset/profileimage/cutegirl2.png",
  //       time: "10"),
  //   ContactChat(
  //       name: 'Daniel Lee',
  //       lastMessage: 'Let\'s meet tomorrow.',
  //       profilepic: "asset/profileimage/cutegirl3.png",
  //       time: "23"),
  //   ContactChat(
  //       name: 'Olivia Miller',
  //       lastMessage: 'Thank you!',
  //       profilepic: "asset/profileimage/cutegirl.png",
  //       time: "44"),
  //   ContactChat(
  //       name: 'David Martinez',
  //       lastMessage: 'How was the trip?',
  //       profilepic: "asset/profileimage/cutegirl1.png",
  //       time: "45"),
  //   ContactChat(
  //       name: 'Emma Taylor',
  //       lastMessage: 'See you at the party!',
  //       profilepic: "asset/profileimage/cutegirl2.png",
  //       time: "9"),
  // ];

/*
  List<ChatMessage> chatMessages = [
    ChatMessage(
      sender: 'John Doe',
      text:
          "Thank you for contacting GTCA Please choose the option that best describes your reason for contact today",
      timestamp: "3:02 AM",
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
}

//model class for chat screen

