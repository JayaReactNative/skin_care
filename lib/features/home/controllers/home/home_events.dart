part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();

}

class HomeInitEvent extends HomeEvent {}

class HomeRelatedProductCategoryFetchEvent extends HomeEvent {}

class HomeProductFetchEvent extends HomeEvent {}
