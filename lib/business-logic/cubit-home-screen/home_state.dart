
import '../../data/model/product-model.dart';

abstract class HomeState {}

class CharactersInitial extends HomeState {}


class ProductLoaded extends HomeState {
  final List<ProductModel> products;

  ProductLoaded(this.products);
}




class JeweleryProductLoaded extends HomeState {
  final List<ProductModel> jewelery;

  JeweleryProductLoaded(this.jewelery);
}

class ElectronicsProductLoaded extends HomeState {
  final List<ProductModel> electronics;

  ElectronicsProductLoaded(this.electronics);
}

class MenProductLoaded extends HomeState {
  final List<ProductModel> men;

  MenProductLoaded(this.men);
}
class WomanProductLoaded extends HomeState {
  final List<ProductModel> woman;

  WomanProductLoaded(this.woman);
}
class GetAllProductInCart extends HomeState{}
class InsertProductInCart extends HomeState{}
class UpdateProductInCart extends HomeState{}
class DeleteProductInCart extends HomeState{}
class IncreaseQuantityInCart extends HomeState{}
class DecreaseQuantityInCart extends HomeState{}



class StateAddLocation extends HomeState{}

