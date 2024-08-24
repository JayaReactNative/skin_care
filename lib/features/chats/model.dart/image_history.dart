class ImageHistory {
  ImageHistory({
    required this.status,
    required this.subCode,
    required this.message,
    required this.error,
    required this.items,
  });
  late final bool status;
  late final int subCode;
  late final String message;
  late final String error;
  late final List<Items> items;

  ImageHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    subCode = json['subCode'];
    message = json['message'];
    error = json['error'];
    items = List.from(json['items']).map((e) => Items.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['subCode'] = subCode;
    _data['message'] = message;
    _data['error'] = error;
    _data['items'] = items.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.authId,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.password,
    required this.status,
    required this.V,
    required this.userProfileImage,
    required this.gender,
    required this.address,
    required this.imagesDetails,
  });
  late final String id;
  late final String authId;
  late final String firstName;
  late final String lastName;
  late final int mobileNumber;
  late final String password;
  late final int status;
  late final int V;
  late final String userProfileImage;
  late final String gender;
  late final String address;
  late final List<ImagesDetails> imagesDetails;

  Items.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    authId = json['authId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    password = json['password'];
    status = json['status'];
    V = json['__v'];
    userProfileImage = json['userProfileImage'];
    gender = json['gender'];
    address = json['address'];
    imagesDetails = List.from(json['imagesDetails'])
        .map((e) => ImagesDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['authId'] = authId;
    _data['firstName'] = firstName;
    _data['lastName'] = lastName;
    _data['mobileNumber'] = mobileNumber;
    _data['password'] = password;
    _data['status'] = status;
    _data['__v'] = V;
    _data['userProfileImage'] = userProfileImage;
    _data['gender'] = gender;
    _data['address'] = address;
    _data['imagesDetails'] = imagesDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ImagesDetails {
  ImagesDetails({
    required this.id,
    required this.userId,
    required this.userImage,
    required this.status,
    required this.createAt,
  });
  late final String id;
  late final String userId;
  late final List<String> userImage;
  late final int status;
  late final String createAt;

  ImagesDetails.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    userImage = List.castFrom<dynamic, String>(json['userImage']);
    status = json['status'];
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['userId'] = userId;
    _data['userImage'] = userImage;
    _data['status'] = status;
    _data['createAt'] = createAt;
    return _data;
  }
}
