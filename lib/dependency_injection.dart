import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_localization/flutter_localization.dart';

final locator = GetIt.instance;
final FlutterLocalization _localization = locator<FlutterLocalization>();

GetStorage storage = locator<GetStorage>();

void setup() {
  // locator.registerSingleton(Get.put(HomeController()));
  // locator.registerSingleton(Get.put(ShopController()));
  // locator.registerSingleton(Get.put(CartController()));
  locator.registerSingleton(FlutterLocalization.instance);

  locator.registerLazySingleton(() => GetStorage());
}
