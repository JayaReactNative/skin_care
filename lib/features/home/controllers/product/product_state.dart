part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState {
  const ProductState({
    required this.status,
    required this.relatedProductCategoryList,
    required this.selectedIndex,
    required this.skintypeindex,
    this.error,
  });
  ProductState copyWith({int? skintypeindex}) {
    return ProductState(
        status: this.status,
        skintypeindex: skintypeindex ?? this.skintypeindex,
        relatedProductCategoryList: this.relatedProductCategoryList,
        selectedIndex: this.selectedIndex);
  }

  final ProductStatus status;
  final int selectedIndex;
  final int skintypeindex;
  final String? error;

  final List<RelatedProductCategory> relatedProductCategoryList;
}

class ProductLoadedState extends ProductState {
  ProductLoadedState({
    required super.relatedProductCategoryList,
    required super.selectedIndex,
    required this.productist,
    required super.status,
    required this.skintype,
    required super.skintypeindex,
  });
  // final List<ProductModel> productist;
  final List<AllProductsItem> productist;

  List<SkinTypeItem> skintype;
}

class ProductIndexChangedState extends ProductState {
  const ProductIndexChangedState({
    required super.relatedProductCategoryList,
    required super.selectedIndex,
    required super.status,
    required super.skintypeindex,
  });
}

class ProductFavLoadedState extends ProductState {
  ProductFavLoadedState({
    required super.status,
    required super.relatedProductCategoryList,
    required super.selectedIndex,
    required super.skintypeindex,
    required this.favouritelist,
  });
  final List<FavouriteData>? favouritelist;
}

// class FavouriteListState extends ProductState {
//   FavouriteListState(
//       {required super.status,
//       required super.relatedProductCategoryList,
//       required super.selectedIndex,
//       required super.skintypeindex,
//       required this.favouritelist});
//   List<FavouriteData> favouritelist;

//   FavouriteListState copyWithData({List<FavouriteData>? favouritelist}) {
//     return FavouriteListState(
//         status: status,
//         relatedProductCategoryList: relatedProductCategoryList,
//         selectedIndex: selectedIndex,
//         skintypeindex: skintypeindex,
//         favouritelist: favouritelist ?? this.favouritelist);
//   }
// }
//
// class FavouriteListState extends ProductState {
//   FavouriteListState({
//     required super.relatedProductCategoryList,
//     required super.selectedIndex,
//     required this.favouritelist,
//     required super.status,

//     required super.skintypeindex,
//   });
//   // final List<ProductModel> productist;
//   final List<FavouriteData> favouritelist;
// }
class FavouriteListState extends ProductState {
  FavouriteListState({
    required ProductStatus status,
    required List<RelatedProductCategory> relatedProductCategoryList,
    required int selectedIndex,
    required int skintypeindex,
    required this.favouritelist,
  }) : super(
          status: status,
          relatedProductCategoryList: relatedProductCategoryList,
          selectedIndex: selectedIndex,
          skintypeindex: skintypeindex,
        );

  final List<FavouriteData> favouritelist;

  // If you need a method to copy the state with new data, you can define it here
  FavouriteListState copyWithData({
    List<FavouriteData>? favouritelist,
  }) {
    return FavouriteListState(
      status: status,
      relatedProductCategoryList: relatedProductCategoryList,
      selectedIndex: selectedIndex,
      skintypeindex: skintypeindex,
      favouritelist: favouritelist ?? this.favouritelist,
    );
  }
}

class HomeToSymptomsLoadedState extends ProductState {
  HomeToSymptomsLoadedState({
    required super.status,
    required this.products,
    required super.relatedProductCategoryList,
    required super.selectedIndex,
    required super.skintypeindex,
    required this.title,
  });
  final List<AllProductsItem> products;
  final String title;
}
