import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop/presentation/resource/colors-manager.dart';

import 'business-logic/cubit-home-screen/home_cubit.dart';
import 'business-logic/cubit-user/user_cubit.dart';
import 'data/repository/repository-products.dart';
import 'data/service/global/web-service-product.dart';
import 'presentation/resource/routes_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(
            RepositoryProduct(
              ProductWebService(),
            ),
          )
            ..GetAllProducts()
            ..GetElectronicsProducts()
            ..GetJeweleryProducts()
            ..GetMenProducts()
            ..GetWomenProducts()
            ..getAllProductToCart()
            // ..getLatitudeAndLongitude(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: ColorManager.primaryColor,
            primarySwatch: Colors.indigo),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashScreen,
      ),
    );
  }
}
