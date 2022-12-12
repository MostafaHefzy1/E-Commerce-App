import 'package:flutter/material.dart';


import '../../data/model/product-model.dart';
import '../checkout-screen.dart';
import '../details-product-screen.dart';
import '../home-layout/home-layout-screen.dart';
import '../show-screens/on-boarding-screen.dart';
import '../show-screens/splash-screen.dart';
import '../user-screens/login-screen.dart';
import '../user-screens/otp-screen.dart';

class Routes {
  static const String splashScreen = '/';

  static const String onBoardingScreen = '/onBoardingScreen';

  static const String loginScreen = '/loginScreen';

  static const String oTPScreen = '/oTPScreen';

  static const String homeLayoutScreen = '/homeLayoutScreen';

  static const String detailsProductScreen = '/detailsProductScreen';

  static const String checkOutScreen = '/checkOutScreen';


}


late ProductModel productModel ;
class RouteGenerator {
  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.oTPScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => OTPScreen(phoneNumber: phoneNumber));
      case Routes.homeLayoutScreen:
        return MaterialPageRoute(builder: (_) => const HomeLayoutScreen());
      case Routes.checkOutScreen:
        return MaterialPageRoute(builder: (_) =>  CheckOutScreen());
    }
    return null;
  }
}
