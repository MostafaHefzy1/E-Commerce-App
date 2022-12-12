import '../model/product-model.dart';
import '../service/global/web-service-product.dart';

class RepositoryProduct {


  final ProductWebService productWebService;

  RepositoryProduct(this.productWebService);

  Future <List<ProductModel>>getAllProduct ()async {
    try{
      List product = await productWebService.getAllProduct() ;
      List <ProductModel> products = []  ;
      for(int i = 0 ; i<product.length;i++)
      {
        products.add( ProductModel(
          category:product[i]['category']  ,
          description:product[i]['description']  ,
          image: product[i]['image']   ,
          price:product[i]['price']    ,
          title: product[i]['title']    ,
          id: product[i]['id']    ,
        ))  ;
      }
      return products ;

    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }


  Future <List<ProductModel>>getAllProductInJewelery ()async {
    try{
      List product = await productWebService.getAllProductInJewelery() ;
      List <ProductModel> products = []  ;
      for(int i = 0 ; i<product.length;i++)
      {
        products.add( ProductModel(
          category:product[i]['category']  ,
          description:product[i]['description']  ,
          image: product[i]['image']   ,
          price:product[i]['price']    ,
          title: product[i]['title']    ,
          id: product[i]['id']    ,
        ))  ;
      }
      return products ;

    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }
  Future <List<ProductModel>>getAllProductInElectronics ()async {
    try{
      List product = await productWebService.getAllProductInElectronics() ;
      List <ProductModel> products = []  ;
      for(int i = 0 ; i<product.length;i++)
      {
        products.add( ProductModel(
          category:product[i]['category']  ,
          description:product[i]['description']  ,
          image: product[i]['image']   ,
          price:product[i]['price']    ,
          title: product[i]['title']    ,
          id: product[i]['id']    ,
        ))  ;
      }
      return products ;

    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }
  Future <List<ProductModel>>getAllProductInMen ()async {
    try{
      List product = await productWebService.getAllProductInMen() ;
      List <ProductModel> products = []  ;
      for(int i = 0 ; i<product.length;i++)
      {
        products.add( ProductModel(
          category:product[i]['category']  ,
          description:product[i]['description']  ,
          image: product[i]['image']   ,
          price:product[i]['price']    ,
          title: product[i]['title']    ,
          id: product[i]['id']    ,
        ))  ;
      }
      return products ;

    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }
  Future <List<ProductModel>>getAllProductInWomen ()async {
    try{
      List product = await productWebService.getAllProductInWomen() ;
      List <ProductModel> products = []  ;
      for(int i = 0 ; i<product.length;i++)
      {
        products.add( ProductModel(
          category:product[i]['category']  ,
          description:product[i]['description']  ,
          image: product[i]['image']   ,
          price:product[i]['price']    ,
          title: product[i]['title']    ,
          id: product[i]['id']    ,
        ))  ;
      }
      return products ;

    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }






}