import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';


import '../../business-logic/cubit-home-screen/home_cubit.dart';
import '../CartScreen.dart';
import '../productscreen.dart';
import '../resource/colors-manager.dart';
import '../setting-screen.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({Key? key}) : super(key: key);

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  @override
  Widget build(BuildContext context) {
   final List  screens = [
       ProductScreen(),
      const CartScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      bottomNavigationBar:
      Theme(
        data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(
              color: Colors.black54  ,
            )
        ),
        child:CurvedNavigationBar(
          backgroundColor: Colors.white,
          height: 55,
          animationDuration: Duration(
            milliseconds: 300
          ),
          animationCurve: Curves.easeInOut,
          color: ColorManager.colorOtp,
          index: HomeCubit.get(context).currentIndex,
          items: <Widget>[
            const Icon(Icons.home, size: 30),
            const Icon(Icons.shopping_cart, size: 30),
            const Icon(Icons.settings, size: 30),
          ],
          onTap: (index) {
            setState(() {
              HomeCubit.get(context).currentIndex =   index   ;
            });
          },

        ),

      ),
      body:screens[HomeCubit.get(context).currentIndex],
    );
  }
}
