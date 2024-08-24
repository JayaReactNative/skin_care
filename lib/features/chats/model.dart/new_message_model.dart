// To parse this JSON data, do
//
//     final newMessageModel = newMessageModelFromJson(jsonString);

import 'dart:convert';

NewMessageModel newMessageModelFromJson(String str) =>
    NewMessageModel.fromJson(json.decode(str));

String newMessageModelToJson(NewMessageModel data) =>
    json.encode(data.toJson());

class NewMessageModel {
  String userId;
  String? symptomId;
  String answer;
  String? userQuestion;
  String? userImage;

  NewMessageModel({
    required this.userId,
    required this.symptomId,
    required this.answer,
    this.userImage,
    this.userQuestion,
  });

  factory NewMessageModel.fromJson(Map<String, dynamic> json) =>
      NewMessageModel(
          userId: json["userId"] ?? "",
          symptomId: json["symptomId"],
          answer: json["answer"] ?? "",
          userQuestion: json["userQuestion"] ?? "",
          userImage: json["userImage"] ?? ""
          //  != null)

          // ? List<String>.from(json["userImage"].map((x) => x))
          // : [],
          );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "symptomId": symptomId ?? '',
        "answer": answer,
        "userQuestion": userQuestion ?? '',
        "userImage": userImage ?? ''
        // == null
        // ? null : List<String>.from(userImage!.map((x) => x)),
      };
}
