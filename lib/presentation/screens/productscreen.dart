import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:lottie/lottie.dart';
import 'package:shop/presentation/resource/colors-manager.dart';
import 'package:shop/presentation/widgets/product-widget.dart';


import '../business-logic/cubit-home-screen/home_cubit.dart';
import '../business-logic/cubit-home-screen/home_state.dart';
import 'details-product-screen.dart';
class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  State<ProductScreen> createState() => _ProductScreen();
}
class _ProductScreen extends State<ProductScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Size size =MediaQuery.of(context).size ;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: RichText(
              text: TextSpan(
                  text: 'Shop',
                  style: TextStyle(color: Colors.black45,
                      fontSize: 26, height: 1.4),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'App',
                        style: TextStyle(
                            color: ColorManager.primaryColor ,
                        ) ,
                    )
                  ]),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                  icon: Icon(
                    Icons.search
                  ),
                  color: Colors.black,
                  iconSize: 35,
                  onPressed: (){}
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          body: OfflineBuilder(
            connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
    ) {
      final bool connected = connectivity != ConnectivityResult.none;
      if(connected) {
          return  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(
                    'Categories' ,
                    style: TextStyle(color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 26, height: 1.4),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: (){
                          HomeCubit.get(context).element = 0  ;
                          HomeCubit.get(context).GetAllProducts() ;
                          print(HomeCubit.get(context).element) ;
                        },
                        child: Text(
                          'All' ,
                          style: TextStyle(
                              fontSize: 22 ,
                              color: Colors.black
                          ),
                        ),
                      ) ,
                      TextButton(
                        onPressed: (){
                          HomeCubit.get(context).element = 1  ;
                          HomeCubit.get(context).GetElectronicsProducts() ;
                          print(HomeCubit.get(context).element) ;

                        },
                        child: Text(
                            'electronics' ,
                            style: TextStyle(
                                fontSize: 22 ,
                                color: Colors.black
                            )
                        ),
                      ) ,
                      TextButton(
                        onPressed: (){
                          HomeCubit.get(context).element = 2  ;
                          HomeCubit.get(context).GetJeweleryProducts() ;
                          print(HomeCubit.get(context).element) ;

                        },
                        child: Text(
                          'jewelery' ,
                          style: TextStyle(
                              fontSize: 22 ,
                              color: Colors.black
                          ),
                        ),
                      ) ,
                      TextButton(
                        onPressed: (){
                          HomeCubit.get(context).GetMenProducts() ;
                          HomeCubit.get(context).element = 3  ;
                          print(HomeCubit.get(context).element)  ;

                        },
                        child: Text(
                          '''men's clothing''' ,
                          style: TextStyle(
                              fontSize: 22 ,
                              color: Colors.black
                          ),
                        ),
                      ) ,
                      TextButton(
                        onPressed: (){
                          HomeCubit.get(context).GetWomenProducts() ;
                          HomeCubit.get(context).element = 4  ;
                          print(HomeCubit.get(context).element) ;
                        },
                        child: Text(
                          '''women's clothing''' ,
                          style: TextStyle(
                              fontSize: 22 ,
                              color: Colors.black
                          ),
                        ),
                      ) ,
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                )  ,
                Container(
                  // width:460,
                  height: 470,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index) {
                      return Hero(
                        tag:HomeCubit.get(context).function(index).id ,
                        child: GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsProductScreen(
                                productModel: HomeCubit.get(context).function(index) ,
                              ),
                              ) ,
                              ) ;
                            },
                            child: GetAllProduct(HomeCubit.get(context).function(index))),
                      )  ;
                    } ,
                    separatorBuilder:(context,index)=> SizedBox(
                      width: 25,
                    ),
                    itemCount:HomeCubit.get(context).functionLength(),
                  ),
                ),
              ],
            ),
          ) ;
        }
      else{

        return Column(
            children: [
                 Container(
                height: 400,
              child: Column(
                children: [
                  Center(
                      child: Lottie.asset(
                          'assets/animation-file/noInternet.json')),
                  Text(
                    'Can\'t connect... check internet ' ,
                    style: TextStyle(
                      fontSize: 20,

                    ),
                  ) ,

                ],
              ))  ,

              ],
          ) ;
      }
    } ,
    child: const CircularProgressIndicator()
          )



        );
      },
    );
  }


}
