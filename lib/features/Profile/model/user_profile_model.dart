// To parse this JSON data, do
//
//     final userProfileData = userProfileDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserProfileData userProfileDataFromJson(String str) => UserProfileData.fromJson(json.decode(str));

String userProfileDataToJson(UserProfileData data) => json.encode(data.toJson());

class UserProfileData {
    bool status;
    int subCode;
    String message;
    String error;
    List<Item> items;

    UserProfileData({
        required this.status,
        required this.subCode,
        required this.message,
        required this.error,
        required this.items,
    });

    UserProfileData copyWith({
        bool? status,
        int? subCode,
        String? message,
        String? error,
        List<Item>? items,
    }) => 
        UserProfileData(
            status: status ?? this.status,
            subCode: subCode ?? this.subCode,
            message: message ?? this.message,
            error: error ?? this.error,
            items: items ?? this.items,
        );

    factory UserProfileData.fromJson(Map<String, dynamic> json) => UserProfileData(
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
    AuthDetails authDetails;

    Item({
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
        required this.authDetails,
    });

    Item copyWith({
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
        AuthDetails? authDetails,
    }) => 
        Item(
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
            authDetails: authDetails ?? this.authDetails,
        );

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
        authDetails: AuthDetails.fromJson(json["authDetails"]),
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
        "authDetails": authDetails.toJson(),
    };
}

class AuthDetails {
    String id;
    String email;
    int otp;
    String timestamp;

    AuthDetails({
        required this.id,
        required this.email,
        required this.otp,
        required this.timestamp,
    });

    AuthDetails copyWith({
        String? id,
        String? email,
        int? otp,
        String? timestamp,
    }) => 
        AuthDetails(
            id: id ?? this.id,
            email: email ?? this.email,
            otp: otp ?? this.otp,
            timestamp: timestamp ?? this.timestamp,
        );

    factory AuthDetails.fromJson(Map<String, dynamic> json) => AuthDetails(
        id: json["_id"],
        email: json["email"],
        otp: json["otp"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "otp": otp,
        "timestamp": timestamp,
    };
}
