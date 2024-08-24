part of 'product_bloc.dart';

abstract class ProductEvent
//  extends Equatable
{
  const ProductEvent();

  // @override
  // List<Object> get props => [];
}

class ProductLoadEvent extends ProductEvent {
  const ProductLoadEvent({
    required this.relatedProductCategoryList,
    required this.selectedIndex,
    required this.selectedskintypeindex,
  });
  final List<RelatedProductCategory> relatedProductCategoryList;
  final int selectedIndex;
  final int selectedskintypeindex;
}

class Favourite extends ProductEvent {
  String userid;

  String productid;

  Favourite({required this.userid, required this.productid});
}
class ProductFetchFav extends ProductEvent {
  
}

// class Getfavouritelist extends ProductEvent {}

// class Productskintype extends ProductEvent {
//   const Productskintype({
//     required this.Skintype,
//     required this.selectedskintypeindex,
//   });
//   // final List<RelatedProductCategory> relatedProductCategoryList;
//   final List<SkinTypeItem> Skintype;
//   final int selectedskintypeindex;
// }

class HomeToSymptomsEvent extends ProductEvent {
  final String symptomId;
  final String title;


  HomeToSymptomsEvent({required this.symptomId,required this.title,});
}
