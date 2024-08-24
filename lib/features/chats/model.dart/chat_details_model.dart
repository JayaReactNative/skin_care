// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  bool status;
  int subCode;
  String message;
  String error;
  Items items;

  ChatModel({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });

  ChatModel copyWith({
    bool? status,
    int? subCode,
    String? message,
    String? error,
    Items? items,
  }) =>
      ChatModel(
        status: status ?? this.status,
        subCode: subCode ?? this.subCode,
        message: message ?? this.message,
        error: error ?? this.error,
        items: items ?? this.items,
      );

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        status: json["status"],
        subCode: json["subCode"],
        message: json["message"],
        error: json["error"],
        items: Items.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subCode": subCode,
        "message": message,
        "error": error,
        "items": items.toJson(),
      };
}

class Items {
  List<SymptomHistory> symptomHistory;
  List<ChatDetail> chatDetail;

  Items({
    required this.symptomHistory,
    required this.chatDetail,
  });

  Items copyWith({
    List<SymptomHistory>? symptomHistory,
    List<ChatDetail>? chatDetail,
  }) =>
      Items(
        symptomHistory: symptomHistory ?? this.symptomHistory,
        chatDetail: chatDetail ?? this.chatDetail,
      );

  // factory Items.fromJson(Map<String, dynamic> json) => Items(
  //     symptomHistory: List<SymptomHistory>.from(json["symptomHistory"].map((x) => SymptomHistory.fromJson(x))),
  //     chatDetail: List<ChatDetail>.from(json["chatDetail"].map((x) => ChatDetail.fromJson(x))),
  // );
  factory Items.fromJson(Map<String, dynamic> json) => Items(
        symptomHistory: (json["symptomHistory"] != null)
            ? List<SymptomHistory>.from(
                json["symptomHistory"].map((x) => SymptomHistory.fromJson(x)))
            : [],
        chatDetail: (json["chatDetail"] != null)
            ? List<ChatDetail>.from(
                json["chatDetail"].map((x) => ChatDetail.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "symptomHistory":
            List<dynamic>.from(symptomHistory.map((x) => x.toJson())),
        "chatDetail": List<dynamic>.from(chatDetail.map((x) => x.toJson())),
      };
}

class ChatDetail {
  String id; //
  String userId; //
  String symptomId; //
  String userQuestion; //
  String replyOnMessage; //
  // String question;
  // String answer;
  int v; //
  List<SymptomDetail> symptomDetail; //
  String userImage; //
  String lastUpdated, createdAt, updatedAt; //
  List<AnswerDetail> answerDetail; //

  ChatDetail({
    required this.id,
    required this.userId,
    required this.symptomId,
    required this.userQuestion,
    required this.replyOnMessage,
    // required this.question,
    // required this.answer,
    required this.answerDetail,
    required this.createdAt,
    required this.lastUpdated,
    required this.updatedAt,
    required this.v,
    required this.symptomDetail,
    required this.userImage,
  });

  ChatDetail copyWith({
    String? id,
    String? userId,
    String? symptomId,
    String? userQuestion,
    String? replyOnMessage,
    // String? question,
    // String? answer,
    int? v,
    List<SymptomDetail>? symptomDetail,
    List<AnswerDetail>? answerDetail,
    String? lastUpdated,
    createdAt,
    updatedAt,
    String? userImage,
  }) =>
      ChatDetail(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        symptomId: symptomId ?? this.symptomId,
        userQuestion: userQuestion ?? this.userQuestion,
        replyOnMessage: replyOnMessage ?? this.replyOnMessage,
        // question: question ?? this.question,
        // answer: answer ?? this.answer,
        v: v ?? this.v,
        symptomDetail: symptomDetail ?? this.symptomDetail,
        userImage: userImage ?? this.userImage,
        answerDetail: answerDetail ?? this.answerDetail,
        createdAt: createdAt ?? this.createdAt,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  // factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
  //     id: json["_id"],
  //     userId: json["userId"],
  //     symptomId: json["symptomId"],
  //     userQuestion: json["userQuestion"],
  //     replyOnMessage: json["replyOnMessage"],
  //     question: json["question"],
  //     answer: json["answer"],
  //     v: json["__v"],
  //     symptomDetail: List<SymptomDetail>.from(json["symptomDetail"].map((x) => SymptomDetail.fromJson(x))),
  // );

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
        id: json["_id"] ?? '',
        userId: json["userId"] ?? '',
        symptomId: json["symptomId"] ?? '',
        userQuestion: json["userQuestion"] ?? '',
        replyOnMessage: json["replyOnMessage"] ?? '',
        // question: json["question"] ?? '',
        // answer: json["answer"] ?? '',
        v: json["__v"] ?? 0,
        symptomDetail: (json["symptomDetail"] != null)
            ? List<SymptomDetail>.from(
                json["symptomDetail"].map((x) => SymptomDetail.fromJson(x)))
            : [],
        userImage: json["userImage"] ?? '',
        //  != null)
        //     ? List<String>.from(json["userImage"].map((x) => x))
        //     : [],
        answerDetail: (json["answerDetail"] != null)
            ? List<AnswerDetail>.from(
                json["answerDetail"].map((x) => AnswerDetail.fromJson(x)))
            : [],
        createdAt: json['createdAt'] ?? '',
        lastUpdated: json['lastUpdated'] ?? '',
        updatedAt: json['updatedAt'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "symptomId": symptomId,
        "userQuestion": userQuestion,
        "replyOnMessage": replyOnMessage,
        // "question": question,
        // "answer": answer,
        "__v": v,
        "symptomDetail":
            List<dynamic>.from(symptomDetail.map((x) => x.toJson())),
        "answerDetail": List<dynamic>.from(answerDetail.map((x) => x.toJson())),
        "userImage":
            // List<String>.from(
            userImage,
        // .map((x) => x)),
        'lastUpdated': lastUpdated,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AnswerDetail {
  String question;
  String answer;
  String? userImage;
  String answeredAt;
  String lastUpdated;
  String createdAt;

  String updatedAt;

  AnswerDetail({
    required this.question,
    required this.answer,
    required this.userImage,
    required this.answeredAt,
    required this.lastUpdated,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance from a JSON map
  factory AnswerDetail.fromJson(Map<String, dynamic> json) {
    return AnswerDetail(
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      userImage: json['userImage'] ?? '',
      answeredAt: json['answeredAt'] ?? '',
      lastUpdated: json['lastUpdated'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  // Method to convert an instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'userImage': userImage,
      'question': question,
      'answer': answer,
      'answeredAt': answeredAt,
      'lastUpdated': lastUpdated,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class SymptomDetail {
  String id;
  String symptomName;
  List<String> symptomImage;
  int status;
  String timestamp;

  SymptomDetail({
    required this.id,
    required this.symptomName,
    required this.symptomImage,
    required this.status,
    required this.timestamp,
  });

  SymptomDetail copyWith({
    String? id,
    String? symptomName,
    List<String>? symptomImage,
    int? status,
    String? timestamp,
  }) =>
      SymptomDetail(
        id: id ?? this.id,
        symptomName: symptomName ?? this.symptomName,
        symptomImage: symptomImage ?? this.symptomImage,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
      );

  factory SymptomDetail.fromJson(Map<String, dynamic> json) => SymptomDetail(
        id: json["_id"],
        symptomName: json["symptomName"],
        symptomImage: List<String>.from(json["symptomImage"].map((x) => x)),
        status: json["status"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "symptomName": symptomName,
        "symptomImage": List<dynamic>.from(symptomImage.map((x) => x)),
        "status": status,
        "timestamp": timestamp,
      };
}

class Question {
  String question;
  String answer;
  List<String> images;
  String id;

  Question({
    required this.question,
    required this.answer,
    required this.images,
    required this.id,
  });

  Question copyWith({
    String? question,
    String? answer,
    List<String>? images,
    String? id,
  }) =>
      Question(
        question: question ?? this.question,
        answer: answer ?? this.answer,
        images: images ?? this.images,
        id: id ?? this.id,
      );

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["question"],
        answer: json["answer"],
        images:
            // List<String>.from(json["images"].map((x) => x)),
            (json["images"] != null)
                ? List<String>.from(json["images"].map((x) => x))
                : [],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "images": List<dynamic>.from(images.map((x) => x)),
        "_id": id,
      };
}

class SymptomHistory {
  String id;
  String symptomId;
  List<Question> questions;
  int v;
  List<SymptomDatum> symptomData;

  SymptomHistory({
    required this.id,
    required this.symptomId,
    required this.questions,
    required this.v,
    required this.symptomData,
  });

  SymptomHistory copyWith({
    String? id,
    String? symptomId,
    List<Question>? questions,
    int? v,
    List<SymptomDatum>? symptomData,
  }) =>
      SymptomHistory(
        id: id ?? this.id,
        symptomId: symptomId ?? this.symptomId,
        questions: questions ?? this.questions,
        v: v ?? this.v,
        symptomData: symptomData ?? this.symptomData,
      );

  factory SymptomHistory.fromJson(Map<String, dynamic> json) => SymptomHistory(
        id: json["_id"],
        symptomId: json["symptomId"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        v: json["__v"],
        symptomData: List<SymptomDatum>.from(
            json["symptomData"].map((x) => SymptomDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "symptomId": symptomId,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "__v": v,
        "symptomData": List<dynamic>.from(symptomData.map((x) => x.toJson())),
      };
}

class SymptomDatum {
  String id;
  String symptomName;
  List<String> symptomImage;
  int status;
  String timestamp;

  SymptomDatum({
    required this.id,
    required this.symptomName,
    required this.symptomImage,
    required this.status,
    required this.timestamp,
  });

  SymptomDatum copyWith({
    String? id,
    String? symptomName,
    List<String>? symptomImage,
    int? status,
    String? timestamp,
  }) =>
      SymptomDatum(
        id: id ?? this.id,
        symptomName: symptomName ?? this.symptomName,
        symptomImage: symptomImage ?? this.symptomImage,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
      );

  factory SymptomDatum.fromJson(Map<String, dynamic> json) => SymptomDatum(
        id: json["_id"],
        symptomName: json["symptomName"],
        symptomImage: List<String>.from(json["symptomImage"].map((x) => x)),
        status: json["status"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "symptomName": symptomName,
        "symptomImage": List<dynamic>.from(symptomImage.map((x) => x)),
        "status": status,
        "timestamp": timestamp,
      };
}
