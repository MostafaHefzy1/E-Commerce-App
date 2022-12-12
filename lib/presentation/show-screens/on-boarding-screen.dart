import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../resource/colors-manager.dart';
import '../resource/routes_manager.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 60,
        ),
        child: PageView(
          controller: controller,
          children: [
            Center(
              child: Container(
                  color: Colors.white,
                  child: Lottie.asset(
                    'assets/animation-file/71390-shopping-cart-loader.json',
                  )),
            ),
            Center(
              child: Container(
                color: Colors.white,
                child: Lottie.asset(
                  ''
                  'assets/animation-file/85354-location.json',
                ),
              ),
            ),
            Center(
              child: Container(
                color: Colors.white,
                child: Lottie.asset(
                  'assets/animation-file/81792-delivery-concept.json',
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              child: const Text('SKIP',
                  style: TextStyle(color: Color(0xff4756AC), fontSize: 16)),
              onPressed: () {
                Navigator.pushReplacementNamed(context, Routes.loginScreen);
              },
            ),
            Center(
              child: SmoothPageIndicator(
                count: 3,
                controller: controller,
                onDotClicked: (index) {
                  controller.animateToPage(index,
                      duration: const Duration(microseconds: 500),
                      curve: Curves.easeIn);
                },
              ),
            ),
            TextButton(
                child: const Text('NEXT',
                    style: TextStyle(
                        color: ColorManager.primaryColor, fontSize: 16)),
                onPressed: () {
                  if (controller.page == 2) {
                    Navigator.pushReplacementNamed(context, Routes.loginScreen);
                  } else {
                    controller.nextPage(
                        duration: const Duration(microseconds: 500),
                        curve: Curves.easeInOut);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
