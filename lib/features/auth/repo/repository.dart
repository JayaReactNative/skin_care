import '../../../core/constants/constant.dart';
import '../../../core/repository.dart';
import '../../../dependency_injection.dart';

class Authrepo {
  // login
  static dynamic login(String email, String password) {
    var body = {
      'email': email,
      'password': password,
    };

    return Auth.postBody(Constants.login, body, needToken: false);
  }

// sign up
  static dynamic signup(String firstName, String lastName, String mobileNo,
      String email, String password, String confirmPassword, String gender) {
    var body = {
      'firstName': firstName,
      'lastName': lastName,
      'mobileNumber': mobileNo,
      'gender': gender,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };

    return Auth.postBody(Constants.signup, body, needToken: false);
  }

  // forget  password
  static dynamic forgetpassword(String email) {
    return Auth.get("${Constants.forgetpassword}${email}", needToken: false);
  }

  // otp verification
  static dynamic otpverification(String otp) {
    var body = {
      'email': storage.read('email'),
      "otp": otp,
    };

    return Auth.postBody(Constants.otpverification, body, needToken: false);
  }

// change password
  static dynamic changepassword(
      String authid, String password, String confirmpassword) {
    var body = {
      "authId": authid,
      "newPassword": password,
      "confirmPassword": confirmpassword
    };
    return Auth.postBody(Constants.changepassword, body, needToken: false);
  }
}
