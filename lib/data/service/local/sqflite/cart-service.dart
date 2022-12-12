import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../presentation/resource/constants-manager.dart';
import '../../../model/cart-product-model.dart';

class CartService{

  CartService._();
  static final CartService dataBaseHelper =   CartService._();

  static Database ?_database  ;
  Future<Database?> get database async {
    if (_database == null){
      _database  = await intialDb() ;
      return _database ;
    }else {
      return _database ;
    }
  }

  intialDb() async {
    String path = join(await getDatabasesPath()  , databaseName) ;
    Database database = await openDatabase(path , onCreate: _onCreate , version:1) ;
    return database ;
  }



  _onCreate(Database database , int version) async {
    await database.execute('''
      CREATE TABLE $tableName (
        $columnId INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
        $columnTitle TEXT NOT NULL , 
        $columnImage TEXT NOT NULL  , 
        $columnPrice REAL NOT NULL  , 
        $columnQuantity INTEGER NOT NULL 
      )
     ''') ;
    print(" onCreate =====================================") ;

  }


  Future<void> insertProductInCart(CartModel cartModel) async {
    var dbClient = await database;
    await dbClient
        ?.insert(tableName, cartModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace)
        .then((value) {
      print('insert is success');
    }).catchError((error) {
      print('insert is Failed');
      print(error.toString());
    });
  }

  updateProductInCart(CartModel cartModel)async {
    var ClientDB = await database ;
    ClientDB?.update(tableName, cartModel.toJson() ,
        where: '$columnId=?' ,
        whereArgs: [cartModel.id]
    ).then((value) {
      print('Update Success') ;
    });
  }

  deleteProduct(CartModel model) async {
    var dbClient = await database;
    return await dbClient?.delete(tableName,
        where: '${columnId} = ? ', whereArgs: [model.id]);
  }

  Future<List<CartModel>?>getAllProductInCart()async {
    var ClientDB = await database ;
    List<Map<String, dynamic>>?maps   = await ClientDB?.query(tableName);
    print('maps is length ');
    print(maps?.length) ;
    return maps!.isNotEmpty ? maps.map((user) => CartModel.fromJson(user)).toList() : [] ;
  }










}

