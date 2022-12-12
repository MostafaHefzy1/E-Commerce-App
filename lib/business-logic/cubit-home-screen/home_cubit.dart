import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:geocoding/geocoding.dart';

import '../../data/model/cart-product-model.dart';
import '../../data/model/product-model.dart';
import '../../data/repository/repository-products.dart';
import '../../data/service/local/sqflite/cart-service.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final RepositoryProduct repositoryProduct;

  HomeCubit(this.repositoryProduct) : super(CharactersInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  //HomeScreen Logic
  int currentIndex = 1;
  int element = 0;

  ProductModel function(int index) {
    if (element == 1) {
      return electronics[index];
    }
    if (element == 2) {
      return jewelery[index];
    }
    if (element == 3) {
      return men[index];
    }
    if (element == 4) {
      return women[index];
    }
    return productModel[index];
  }

  int functionLength() {
    if (element == 0) {
      return productModel.length;
    }
    if (element == 1) {
      return electronics.length;
    }
    if (element == 2) {
      return jewelery.length;
    }
    if (element == 3) {
      return men.length;
    }
    if (element == 4) {
      return women.length;
    }
    return 0;
  }

  List<ProductModel> productModel = [];

  List<ProductModel>? GetAllProducts() {
    repositoryProduct.getAllProduct().then((products) {
      emit(ProductLoaded(products));
      print(' products $products');

      this.productModel = products;
    });
  }

  List<ProductModel> jewelery = [];

  List<ProductModel>? GetJeweleryProducts() {
    repositoryProduct.getAllProductInJewelery().then((products) {
      emit(JeweleryProductLoaded(products));
      print(' jewelery $products');
      this.jewelery = products;
    });
  }

  List<ProductModel> electronics = [];

  List<ProductModel>? GetElectronicsProducts() {
    repositoryProduct.getAllProductInElectronics().then((products) {
      emit(ElectronicsProductLoaded(products));
      print(' electronics $products');
      this.electronics = products;
    });
  }

  List<ProductModel> women = [];

  List<ProductModel>? GetWomenProducts() {
    repositoryProduct.getAllProductInWomen().then((products) {
      emit(WomanProductLoaded(products));
      print(' women $products');
      this.women = products;
    });
  }

  List<ProductModel> men = [];

  List<ProductModel>? GetMenProducts() {
    repositoryProduct.getAllProductInMen().then((products) {
      emit(MenProductLoaded(products));
      print(' men $products');
      this.men = products;
    });
  }

  // Cart

  List<CartModel> cartProductModel = [];
  addProductToCart(CartModel cartModel) async {
    for (int i = 0; i < cartProductModel.length; i++) {
      if (cartProductModel[i].id == cartModel.id) return;
    }
    var dbHelper = CartService.dataBaseHelper;
    await dbHelper.insertProductInCart(cartModel);
    cartProductModel.add(cartModel);
    print(
        '--------------------------${cartProductModel.length}++++++++++++++++');
    ;
    print('1111111111111111111111${cartProductModel}++++++++++++++++');
    getTotalPrice();
    emit(InsertProductInCart());
  }

  getAllProductToCart() async {
    var dbHelper = CartService.dataBaseHelper;
    cartProductModel = (await dbHelper.getAllProductInCart())!;
    print(cartProductModel.length);
    getTotalPrice();
    emit(GetAllProductInCart());
  }

  double totalPrice = 0;

  getTotalPrice() {
    totalPrice = 0;
    for (int i = 0; i < cartProductModel.length; i++) {
      totalPrice += cartProductModel[i].price * cartProductModel[i].quantity;
    }
  }

  increaseQuatity(int index) async {
    cartProductModel[index].quantity = (cartProductModel[index].quantity + 1);
    totalPrice += cartProductModel[index].price;
    await CartService.dataBaseHelper
        .updateProductInCart(cartProductModel[index]);
    emit(IncreaseQuantityInCart());
  }

  decreaseQuatity(int index) async {
    if (cartProductModel[index].quantity == 1) {
      await CartService.dataBaseHelper.deleteProduct(cartProductModel[index]);
      getAllProductToCart();
      emit(DeleteProductInCart());
    } else {
      cartProductModel[index].quantity = (cartProductModel[index].quantity - 1);
      totalPrice -= cartProductModel[index].price;
      await CartService.dataBaseHelper
          .updateProductInCart(cartProductModel[index]);
      emit(DecreaseQuantityInCart());
    }
  }

  deleteToCart(CartModel cartModel) async {
    await CartService.dataBaseHelper.deleteProduct(cartModel);
    getAllProductToCart();
    emit(DeleteProductInCart());
  }


}
