import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/presentation/resource/colors-manager.dart';
import 'package:shop/presentation/resource/routes_manager.dart';

import '../business-logic/cubit-home-screen/home_cubit.dart';
import '../business-logic/cubit-home-screen/home_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size = MediaQuery.of(context).size;
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'My Cart',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
          body: cubit.totalPrice == 0
              ? Container(
                  width: size.width * 1,
                  height: size.height * 1,
                  child: Center(
                    child: Lottie.asset(
                        'assets/animation-file/17990-empty-cart.json'),
                    heightFactor: 1500,
                    widthFactor: 1500,
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                            itemBuilder: (context, index) => Dismissible(
                                  key: ValueKey<int>(
                                      cubit.cartProductModel[index].id),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                  ),
                                  onDismissed: (direction) => cubit.deleteToCart(
                                          cubit.cartProductModel[index]),
                                  child: Container(
                                    height: 160,
                                    decoration:
                                        BoxDecoration(color: Colors.grey[100]),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                child: Image(
                                                  image: NetworkImage(
                                                    HomeCubit.get(context)
                                                        .cartProductModel[index]
                                                        .image,
                                                  ),
                                                  fit: BoxFit.cover,
                                                  height: 159,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${HomeCubit.get(context).cartProductModel[index].title.substring(0, 15)}',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${HomeCubit.get(context).cartProductModel[index].price}',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorManager
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 130,
                                                        color: Colors.grey[300],
                                                        height: 40,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                HomeCubit.get(
                                                                        context)
                                                                    .increaseQuatity(
                                                                        index);
                                                              },
                                                              child: Icon(
                                                                Icons.add,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 2,
                                                            ),
                                                            Text(
                                                              HomeCubit.get(
                                                                      context)
                                                                  .cartProductModel[
                                                                      index]
                                                                  .quantity
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                            Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                bottom: 13,
                                                              ),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  HomeCubit.get(
                                                                          context)
                                                                      .decreaseQuatity(
                                                                          index);
                                                                },
                                                                child: Icon(
                                                                  Icons
                                                                      .minimize,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 4,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 7,
                                ),
                            itemCount: cubit.cartProductModel.length),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                      ),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total Price ',
                                style:
                                    TextStyle(fontSize: 17, color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Center(
                                child: Text(
                                  HomeCubit.get(context)
                                      .totalPrice
                                      .round()
                                      .toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: ColorManager.primaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: 10,
                              right: 10,
                            ),
                            child: Align(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(125, 65),
                                    primary: Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                    )),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.checkOutScreen)  ;
                                },
                                child: Text(
                                  'CheckOut'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );

/*


 */
  }
}
