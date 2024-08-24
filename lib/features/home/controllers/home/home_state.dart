part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState {
  const HomeState({
    required this.status,
    this.error,
  });

  final HomeStatus status;
  final String? error;

  // @override
  // List<Object?> get props => [status, error];

  HomeState copyWith({
    HomeStatus? status,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error,
    );
  }
}

class HomeRefreshLoadState extends HomeState {
  const HomeRefreshLoadState({
    required super.status,
    required this.ProductCategories,
    required this.product,
    required this.tipsModel,
  });
  final TipsModel tipsModel;
  final List<Symptoms> product;
  final List<RelatedProductCategory> ProductCategories;
}

class HomeRelatedProductCategoryLoadedState extends HomeState {
  const HomeRelatedProductCategoryLoadedState({
    required super.status,
    required this.relatedProductCategories,
  });
  final List<RelatedProductCategory> relatedProductCategories;
}

class HomeProductLoadedState extends HomeState {
  const HomeProductLoadedState({
    required super.status,
    required this.product,
  });
  final List<RelatedProductCat> product;
}

class HomeToSymptomsLoadedState extends HomeState {
  HomeToSymptomsLoadedState({required super.status, required this.products});
  final List<AllProductsItem> products;
}
