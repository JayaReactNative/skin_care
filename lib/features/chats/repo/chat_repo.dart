import '../../../core/constants/constant.dart';
import '../../../core/repository.dart';

class ChatRepo {
  static dynamic getChatHistory(String userId) async {
    return Auth.get(Constants.getChatHistory + userId, needToken: true);
  }

  static dynamic clearChatHistory(String userId) async {
    return Auth.get(Constants.clearChatHistory + userId, needToken: true);
  }

  static dynamic addChat(dynamic body) async {
    // (Constants.login, body, needToken: false);
    return Auth.postBody(Constants.addChat, body, needToken: true);
  }

  static dynamic addHistoryImage(dynamic body) {
    return Auth.postBody(Constants.addImageHistory, body, needToken: true);
  }

  static dynamic getImageHistory(String userId) {
    return Auth.get(Constants.getimageHistory + userId, needToken: true);
  }
}
