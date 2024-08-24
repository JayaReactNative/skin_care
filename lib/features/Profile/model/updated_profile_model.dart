// To parse this JSON data, do
//
//     final updatedUserProfileData = updatedUserProfileDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UpdatedUserProfileData updatedUserProfileDataFromJson(String str) => UpdatedUserProfileData.fromJson(json.decode(str));

String updatedUserProfileDataToJson(UpdatedUserProfileData data) => json.encode(data.toJson());

class UpdatedUserProfileData {
    bool status;
    int subCode;
    String message;
    String error;
    Items items;

    UpdatedUserProfileData({
        required this.status,
        required this.subCode,
        required this.message,
        required this.error,
        required this.items,
    });

    UpdatedUserProfileData copyWith({
        bool? status,
        int? subCode,
        String? message,
        String? error,
        Items? items,
    }) => 
        UpdatedUserProfileData(
            status: status ?? this.status,
            subCode: subCode ?? this.subCode,
            message: message ?? this.message,
            error: error ?? this.error,
            items: items ?? this.items,
        );

    factory UpdatedUserProfileData.fromJson(Map<String, dynamic> json) => UpdatedUserProfileData(
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
    String id;
    String authId;
    String firstName;
    String lastName;
    int mobileNumber;
    String password;
    int status;
    int v;
    String userProfileImage;
    String gender;
    String address;

    Items({
        required this.id,
        required this.authId,
        required this.firstName,
        required this.lastName,
        required this.mobileNumber,
        required this.password,
        required this.status,
        required this.v,
        required this.userProfileImage,
        required this.gender,
        required this.address,
    });

    Items copyWith({
        String? id,
        String? authId,
        String? firstName,
        String? lastName,
        int? mobileNumber,
        String? password,
        int? status,
        int? v,
        String? userProfileImage,
        String? gender,
        String? address,
    }) => 
        Items(
            id: id ?? this.id,
            authId: authId ?? this.authId,
            firstName: firstName ?? this.firstName,
            lastName: lastName ?? this.lastName,
            mobileNumber: mobileNumber ?? this.mobileNumber,
            password: password ?? this.password,
            status: status ?? this.status,
            v: v ?? this.v,
            userProfileImage: userProfileImage ?? this.userProfileImage,
            gender: gender ?? this.gender,
            address: address ?? this.address,
        );

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        id: json["_id"],
        authId: json["authId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
        password: json["password"],
        status: json["status"],
        v: json["__v"],
        userProfileImage: json["userProfileImage"],
        gender: json["gender"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "authId": authId,
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "password": password,
        "status": status,
        "__v": v,
        "userProfileImage": userProfileImage,
        "gender": gender,
        "address": address,
    };
}
