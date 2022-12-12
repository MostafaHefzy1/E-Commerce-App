import 'package:flutter/material.dart';

import 'package:path/path.dart';
import 'package:shop/presentation/resource/colors-manager.dart';
import 'package:shop/presentation/resource/routes_manager.dart';

import '../business-logic/cubit-home-screen/home_cubit.dart';
import '../data/model/cart-product-model.dart';
import '../data/model/product-model.dart';

class DetailsProductScreen extends StatelessWidget {
  final ProductModel productModel   ;

  const DetailsProductScreen({Key? key, required this.productModel}) : super(key: key);



  Widget buildsilverAppBar() {

    return SliverAppBar(
      backgroundColor: Colors.black87,
      elevation: 0.0,
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              productModel.title ,
              style: TextStyle(
                color: Colors.white ,
                fontSize: 16 ,
              ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        background: Hero(
          tag: productModel.id,
          child: Image.network(
            productModel.image ,
            fit: BoxFit.cover,

          ),
        ),
      ),
    ) ;
  }




  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size ;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey[300],
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            buildsilverAppBar() ,
            SliverList(
              delegate:SliverChildListDelegate(
                [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            14, 14, 14, 0),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Description' ,
                              style: TextStyle(
                                  fontSize: 20  ,
                                  fontWeight: FontWeight.bold
                              ),

                            ) ,
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              productModel.description ,
                              style: TextStyle(
                                fontSize: 18  ,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 80,
                                height: 25,
                                color: Colors.blueGrey,
                                child: Center(
                                  child: Text(
                                    '''${productModel.price}' \$''' ,
                                    style: TextStyle(
                                      fontSize: 18 ,
                                      color: Colors.black87
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.colorOtp ,
                            borderRadius: BorderRadius.circular(8)    ,

                        ),
                        width: size.width*1,
                        height: 60,
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Icon(
                                    Icons.shopping_cart_outlined ,
                                  color: Colors.white,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white.withOpacity(0),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(6),
                                        )),
                                    onPressed: () {
                                      HomeCubit.get(context).addProductToCart(CartModel(
                                        id: productModel.id ,
                                        title:productModel.title  ,
                                        price:productModel.price  ,
                                        image:productModel.image  ,
                                        quantity:1  ,
                                      ))   ;
                                      },
                                    child: Text(
                                      'Add To Cart',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Spacer() ,
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(size.width*0.4, 50),
                                    primary: ColorManager.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    )),
                                onPressed: () {
                                  HomeCubit.get(context).addProductToCart(CartModel(
                                    id: productModel.id ,
                                    title:productModel.title  ,
                                    price:productModel.price  ,
                                    image:productModel.image  ,
                                    quantity:1  ,
                                  ))   ;
                                  Navigator.pushNamed(context, Routes.checkOutScreen)  ;

                                },
                                child: Text(
                                  'Buy Now',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            )  ,
                          ],
                        ),
                      ),

                    ],
                  ),
                ]
              ),

            ),
          ],
        ),
      ),
    );
  }
}
