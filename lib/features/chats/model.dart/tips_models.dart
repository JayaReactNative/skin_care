// To parse this JSON data, do
//
//     final tipsModel = tipsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TipsModel tipsModelFromJson(String str) => TipsModel.fromJson(json.decode(str));

String tipsModelToJson(TipsModel data) => json.encode(data.toJson());

class TipsModel {
    bool status;
    int subCode;
    String message;
    String error;
    List<Item> items;

    TipsModel({
        required this.status,
        required this.subCode,
        required this.message,
        required this.error,
        required this.items,
    });

    TipsModel copyWith({
        bool? status,
        int? subCode,
        String? message,
        String? error,
        List<Item>? items,
    }) => 
        TipsModel(
            status: status ?? this.status,
            subCode: subCode ?? this.subCode,
            message: message ?? this.message,
            error: error ?? this.error,
            items: items ?? this.items,
        );

    factory TipsModel.fromJson(Map<String, dynamic> json) => TipsModel(
        status: json["status"],
        subCode: json["subCode"],
        message: json["message"],
        error: json["error"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "subCode": subCode,
        "message": message,
        "error": error,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    String id;
    String title;
    String subTitle;
    int status;
    String createdAt;
    int v;

    Item({
        required this.id,
        required this.title,
        required this.subTitle,
        required this.status,
        required this.createdAt,
        required this.v,
    });

    Item copyWith({
        String? id,
        String? title,
        String? subTitle,
        int? status,
        String? createdAt,
        int? v,
    }) => 
        Item(
            id: id ?? this.id,
            title: title ?? this.title,
            subTitle: subTitle ?? this.subTitle,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            v: v ?? this.v,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        title: json["title"],
        subTitle: json["subTitle"],
        status: json["status"],
        createdAt: json["createdAt"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "subTitle": subTitle,
        "status": status,
        "createdAt": createdAt,
        "__v": v,
    };
}
