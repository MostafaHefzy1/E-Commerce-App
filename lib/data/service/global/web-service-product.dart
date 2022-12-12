import 'package:dio/dio.dart';

import '../../../presentation/resource/constants-manager.dart';


class ProductWebService
{

  late   Dio dio ;

  ProductWebService(){
      BaseOptions options = BaseOptions(
        baseUrl:baseUrl ,
        receiveDataWhenStatusError: true ,
        connectTimeout: 30*1000 ,    //10 Seconds
        receiveTimeout: 30*1000 ,    //10 Seconds
      ) ;
      dio  = Dio(options) ;
    }



   Future <List<dynamic>> getAllProduct ()async{
      try{
      Response response =await dio.get('products') ;
      print(response.data.toString());
      print('Dio is Ok') ;
      return response.data ;
      }catch(error){
        print(error.toString()) ;
        return [] ;
      }
    }


  Future <List<dynamic>> getAllProductInJewelery ()async{
    try{
      Response response =await dio.get('products/category/jewelery') ;
      print(response.data.toString());
      print('Dio is Ok') ;
      return response.data ;
    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }

  Future <List<dynamic>> getAllProductInElectronics ()async{
    try{
      Response response =await dio.get('products/category/electronics') ;
      print(response.data.toString());
      print('Dio is Ok') ;
      return response.data ;
    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }

  Future <List<dynamic>> getAllProductInMen ()async{
    try{
      Response response =await dio.get('''products/category/men's clothing''') ;
      print(response.data.toString());
      print('Dio is Ok') ;
      return response.data ;
    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }

  Future <List<dynamic>> getAllProductInWomen ()async{
    try{
      Response response =await dio.get('''products/category/women's clothing''') ;
      print(response.data.toString());
      print('Dio is Ok') ;
      return response.data ;
    }catch(error){
      print(error.toString()) ;
      return [] ;
    }
  }

}