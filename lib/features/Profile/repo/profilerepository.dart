import '../../../core/constants/constant.dart';
import '../../../core/repository.dart';
import '../../../dependency_injection.dart';

class ProfileRepo {
  static dynamic getuserdetail() {
    return Auth.get("${Constants.getuserdetail}${storage.read('userid')}",
        needToken: true);
  }

  static dynamic updateUserDetail(dynamic body) {
    return Auth.postBody(
        "${Constants.updateProfile}", body,
        needToken: true);
  }
}
