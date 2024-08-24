import 'package:skin_care/dependency_injection.dart';

import '../../../core/constants/constant.dart';
import '../../../core/repository.dart';
import '../../../shared/dynamictoast.dart';
import '../model/favourite_list_model.dart';

class HomeScreenRepo {
  // get product category
  static dynamic productcategory() {
    return Auth.get(Constants.getallcategory, needToken: true);
  }

  // get all symptoms
  static dynamic getSymptoms() {
    return Auth.get(Constants.getsymptoms, needToken: true);
  }

  // get all tips
  static dynamic getTips() {
    return Auth.get(Constants.getTips, needToken: true);
  }
  // get skin type
  static dynamic getskintype() {
    return Auth.get(Constants.getallskin, needToken: true);
  }

  // get all product
  static dynamic getallproducts() {
    return Auth.get(Constants.getallproduct, needToken: true);
  }

  // favourite Api
  static dynamic favouriteproduct(String userid, String productid) {
    var body = {"userId": userid, "productId": productid};
    return Auth.postBody(Constants.favouriteproduct, body, needToken: true);
  }

  // get favourite list
  static dynamic getFavouriteData() {
    return Auth.get("${Constants.getFavouritedata}${storage.read('userid')}",
        needToken: true);
  }

  static Future<List<FavouriteData>> fetchFavouriteList() async {
    try {
      final response = await HomeScreenRepo.getFavouriteData();

      if (response['subCode'] == 200) {
        List<FavouriteData> parsedItems = List<FavouriteData>.from(
          response['items'].map((item) => FavouriteData.fromJson(item)),
        );
        return parsedItems;
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    }
    return [];
  }
}
