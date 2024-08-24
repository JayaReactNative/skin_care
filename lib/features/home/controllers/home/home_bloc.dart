import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/dynamictoast.dart';
import '../../../chats/model.dart/tips_models.dart';
import '../../model/all_products.dart';
import '../../model/product_category_model.dart';
import '../../model/related_product_model.dart';
import '../../repo/repository.dart';

part 'home_events.dart';
part 'home_state.dart';

List<RelatedProductCategory> productcategory = [
  // RelatedProductCategory(name: "Cleanser", id: "1"),
  // RelatedProductCategory(name: "Moisturizer", id: "2"),
  // RelatedProductCategory(name: "Sunscreen", id: "3"),
  // RelatedProductCategory(name: "Serum", id: "4"),
  // RelatedProductCategory(name: "Toner", id: "5"),
  // RelatedProductCategory(name: "Cleanser", id: "6"),
  // RelatedProductCategory(name: "Moisturizer", id: "7"),
  // RelatedProductCategory(name: "Sunscreen", id: "8"),
  // RelatedProductCategory(name: "Serum", id: "9"),
  // RelatedProductCategory(name: "Toner", id: "10"),
  // Add more categories as needed
];

List<Symptoms> symptomslist = [
  // RelatedProductCat(
  //     name: "Product 1", id: "1", image: "assets/images/product1.png"),
  // RelatedProductCat(
  //     name: "Product 2", id: "2", image: "assets/images/product2.png"),
  // RelatedProductCat(
  //     name: "Product 3", id: "3", image: "assets/images/product3.png"),
  // RelatedProductCat(
  //     name: "Product 4", id: "4", image: "assets/images/product4.png"),
  // RelatedProductCat(
  //     name: "Product 5", id: "5", image: "assets/images/product5.png"),
  // RelatedProductCat(
  //     name: "Product 6", id: "6", image: "assets/images/product6.png"),
  // RelatedProductCat(
  //     name: "Product 7", id: "7", image: "assets/images/product1.png"),
  // RelatedProductCat(
  //     name: "Product 8", id: "8", image: "assets/images/product2.png"),
  // RelatedProductCat(
  //     name: "Product 9", id: "9", image: "assets/images/product3.png"),
  // RelatedProductCat(
  //     name: "Product 10", id: "10", image: "assets/images/product4.png"),
  // RelatedProductCat(
  //     name: "Product 11", id: "11", image: "assets/images/product5.png"),
  // RelatedProductCat(
  //     name: "Product 12", id: "12", image: "assets/images/product6.png"),
  // RelatedProductCat(
  //     name: "Product 13", id: "13", image: "assets/images/product1.png"),
  // RelatedProductCat(
  //     name: "Product 14", id: "14", image: "assets/images/product2.png"),
  // RelatedProductCat(
  //     name: "Product 15", id: "15", image: "assets/images/product3.png"),
  // Add more products as needed
];

TipsModel tipsModel =
    TipsModel(status: false, subCode: 0, message: "", error: "", items: []);

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(const HomeState(
          status: HomeStatus.loading,
        )) {
    on<HomeInitEvent>((event, emit) => _initMethod(event, emit));
  }

  _initMethod(event, emit) async {
    // log("Init home...");
    // await Future.delayed(
    //   const Duration(seconds: 4),
    // );

    // _fetchProductCategory(event, emit);

    // await _fetchProduct(event, emit);
    await fetchcategory(event, emit);
    await getAllSymptoms(event, emit);
    await fetchTips(event, emit);

    emit(state.copyWith(status: HomeStatus.loading));
  }

  //get all symptoms
  Future<void> fetchTips(event, emit) async {
    try {
      final response = await HomeScreenRepo.getTips();

      if (response['subCode'] == 200) {
        tipsModel = TipsModel.fromJson(response);
        // print("symptoms /////////////////");

        // symptomslist = parsedItems;
        log("tip model" + tipsModel.toJson().toString());
        emit(
          HomeRefreshLoadState(
            status: HomeStatus.loading,
            ProductCategories: productcategory,
            product: symptomslist,
            tipsModel: tipsModel,
          ),
        );
        emit(state.copyWith(status: HomeStatus.success));
        // print("symptoms /////////////////");
        // log(response.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  // _fetchProductCategory(event, emit) {
  //   // emit(
  //   //   const HomeRelatedProductCategoryLoadedState(
  //   //     status: HomeStatus.success,
  //   //     RelatedProductCategories: demoCategories,
  //   //   ),
  //   // );
  //   // return demoCategories;
  // }

  // _fetchProduct(event, emit) {
  //   // emit(
  //   //   const HomeProductLoadedState(
  //   //     status: HomeStatus.success,
  //   //     RelatedProductCategories: productList,
  //   //   ),
  //   // );
  //   return productList;
  // }

  //get all symptoms
  Future<void> getAllSymptoms(event, emit) async {
    try {
      final response = await HomeScreenRepo.getSymptoms();

      if (response['subCode'] == 200) {
        List<Symptoms> parsedItems = List<Symptoms>.from(
          response['items'].map((item) => Symptoms.fromJson(item)),
        );
        // print("symptoms /////////////////");

        symptomslist = parsedItems;
        emit(
          HomeRefreshLoadState(
            status: HomeStatus.loading,
            ProductCategories: productcategory,
            product: symptomslist,
            tipsModel: tipsModel,
          ),
        );
        // print("symptoms /////////////////");
        // log(response.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  // fetch category

  Future<void> fetchcategory(event, emit) async {
    try {
      final response = await HomeScreenRepo.productcategory();

      if (response['subCode'] == 200) {
        List<RelatedProductCategory> parsedItems =
            List<RelatedProductCategory>.from(
          response['items']
              .map((item) => RelatedProductCategory.fromJson(item)),
        );
        productcategory = parsedItems;
        emit(
          HomeRefreshLoadState(
            status: HomeStatus.loading,
            ProductCategories: productcategory,
            product: symptomslist,
            tipsModel: tipsModel,
          ),
        );
        log(productcategory.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }
}
