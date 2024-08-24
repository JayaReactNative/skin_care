import 'dart:developer';
import 'dart:math' as math;

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skin_care/features/home/model/favourite_list_model.dart';
// import 'package:equatable/equatable.dart';

import '../../../../dependency_injection.dart';
import '../../../../shared/dynamictoast.dart';
import '../../../auth/repo/repository.dart';
import '../../model/all_products.dart';
import '../../model/product_category_model.dart';
import '../../model/product_model.dart';
import '../../model/skin_type_model.dart';
import '../../repo/repository.dart';

part 'product_events.dart';
part 'product_state.dart';

// List<ProductModel> generateProductList() {
//   List<ProductModel> productList = [];
//   for (int i = 1; i <= math.Random().nextInt(6); i++) {
//     productList.add(
//       ProductModel(
//         title: "Title $i",
//         image: "assets/images/item$i.png",
//         desc: "Description for item $i",
//         id: "id_$i",
//         category: "Category $i",
//         skinType: "Skin Type $i",
//       ),
//     );
//   }
//   return productList;
// }

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<AllProductsItem> allproduct = [];
  List<SkinTypeItem> skintype = [];
  List<FavouriteData> favouritedata = [];

  ProductBloc()
      : super(const ProductState(
          skintypeindex: 0,
          status: ProductStatus.initial,
          relatedProductCategoryList: [],
          selectedIndex: 0,
        )) {
    on<ProductLoadEvent>((event, emit) => _homeToProduct(event, emit));
    on<Favourite>(
      (event, emit) => _favourite(event, emit),
    );
    on<ProductFetchFav>((event, emit) => _fetchFavourite(event, emit));
    on<HomeToSymptomsEvent>((event, emit) => _filterSymptom(event, emit));

    // to fetch dT from favourite list
    // on<Getfavouritelist>(
    //   (event, emit) => _fetchFavouriteList(event, emit),
    // );

    // on<Productskintype>(
    //   (event, emit) => _skintype(event, emit),
    // );
  }

  _filterSymptom(HomeToSymptomsEvent event, Emitter<ProductState> emit) async {
    List<AllProductsItem> allproduct = [];
    try {
      emit(
        ProductState(
          skintypeindex: state.skintypeindex,
          status: ProductStatus.loading,
          relatedProductCategoryList: state.relatedProductCategoryList,
          selectedIndex: state.selectedIndex,
        ),
      );

      // await Future.delayed(const Duration(seconds: 4));

      // print("??????????ppppppp?????????????");
      final response = await HomeScreenRepo.getallproducts();

      // log(response.toString());

      if (response['subCode'] == 200) {
        allproduct = response['items']
            .map<AllProductsItem>((item) => AllProductsItem.fromJson(item))
            .toList();
        allproduct = allproduct
            .where((element) => element.symptomId == event.symptomId)
            .toList();
        emit(
          HomeToSymptomsLoadedState(
            // skintypeindex: event.selectedskintypeindex,
            // relatedProductCategoryList: event.relatedProductCategoryList,
            // selectedIndex: event.selectedIndex,
            // productist: allproduct,
            status: ProductStatus.success,
            // skintype: skintype,
            products: allproduct,
            relatedProductCategoryList: state.relatedProductCategoryList,
            selectedIndex: state.selectedIndex,
            skintypeindex: state.skintypeindex,
            title: event.title,
          ),
        );

        log(allproduct.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  _homeToProduct(ProductLoadEvent event, Emitter<ProductState> emit) async {
    log("Init product...");
    HapticFeedback.mediumImpact();
    emit(
      ProductState(
        skintypeindex: event.selectedskintypeindex,
        status: ProductStatus.loading,
        relatedProductCategoryList: event.relatedProductCategoryList,
        selectedIndex: event.selectedIndex,
      ),
    );
    await getallskintype(event, emit);
    // await Future.delayed(const Duration(seconds: 1));
    await getallproduct(event, emit);

    log("Emitted: ProductLoadedState");
  }

  // get all skintype
  Future<void> getallskintype(event, emit) async {
    try {
      final response = await HomeScreenRepo.getskintype();

      if (response['subCode'] == 200) {
        List<SkinTypeItem> parsedItems = List<SkinTypeItem>.from(
          response['items'].map((item) => SkinTypeItem.fromJson(item)),
        );

        skintype = parsedItems;

        // print("???????????????????????");
        // log(skintype.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  // get  all product list
  Future<void> getallproduct(event, emit) async {
    try {
      // print("??????????ppppppp?????????????");
      final response = await HomeScreenRepo.getallproducts();

      // log(response.toString());

      if (response['subCode'] == 200) {
        allproduct = response['items']
            .map<AllProductsItem>((item) => AllProductsItem.fromJson(item))
            .toList();
        emit(
          ProductLoadedState(
              skintypeindex: event.selectedskintypeindex,
              relatedProductCategoryList: event.relatedProductCategoryList,
              selectedIndex: event.selectedIndex,
              productist: allproduct,
              status: ProductStatus.success,
              skintype: skintype),
        );

        log(allproduct.toString());
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  Future<void> _favourite(Favourite event, Emitter<ProductState> emit) async {
    HapticFeedback.mediumImpact();
    try {
      final response =
          await HomeScreenRepo.favouriteproduct(event.userid, event.productid);
      log(response.toString());
      if (response['subCode'] == 200) {
        DynamicToast.show(response['message']);
        List<FavouriteData> favList = await HomeScreenRepo.fetchFavouriteList();
        emit(FavouriteListState(
          status: ProductStatus.success,
          relatedProductCategoryList: state.relatedProductCategoryList,
          selectedIndex: state.selectedIndex,
          skintypeindex: state.skintypeindex,
          favouritelist: favList,
        ));
      } else {
        DynamicToast.show(response['message']);
      }
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  Future<void> _fetchFavourite(
      ProductFetchFav event, Emitter<ProductState> emit) async {
    HapticFeedback.mediumImpact();
    try {
      List<FavouriteData> favList = await HomeScreenRepo.fetchFavouriteList();
      emit(FavouriteListState(
        status: ProductStatus.success,
        relatedProductCategoryList: state.relatedProductCategoryList,
        selectedIndex: state.selectedIndex,
        skintypeindex: state.skintypeindex,
        favouritelist: favList,
      ));
    } catch (e) {
      DynamicToast.show('$e');
    } finally {}
  }

  // get favourite list
  // Future<void> getfavouritelist(
  //     Favourite event, Emitter<ProductState> emit) async {
  //   try {
  //     final response = await HomeScreenRepo.getFavouriteData();

  //     // log(response.toString());

  //     if (response['subCode'] == 200) {
  //       List<FavouriteData> parsedItems = List<FavouriteData>.from(
  //         response['items'].map((item) => FavouriteData.fromJson(item)),
  //       );
  //       favouritedata = parsedItems;
  //       log(favouritedata.toString());
  //       emit(state is FavouriteListState
  //           ? (state as FavouriteListState)
  //               .copyWithData(favouritelist: parsedItems)
  //           : state);

  //       // List<AllProductsItem> parsedItems =
  //       //     response['items'].map((item) => AllProductsItem.fromJson(item));

  //       // log(parsedItems.toString());

  //       // allproduct = parsedItems;

  //       // log(response['items'].toString());
  //     } else {
  //       DynamicToast.show(response['message']);
  //     }
  //   } catch (e) {
  //     DynamicToast.show('$e');
  //   } finally {}
  // }

  // _skintype(Productskintype event, Emitter<ProductState> emit) async {
  //   log(event.selectedskintypeindex.toString());
  //   emit(state.copyWith(skintypeindex: event.selectedskintypeindex));
  // }
}
