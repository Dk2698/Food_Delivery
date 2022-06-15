import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResourse() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    // TODO: implement initState
    /*
      AnyClass(){

        newObject(){
          method
          return ..
        }
      }
       var x = AnyClass() .. newObject() similar
       x = x.newObject()
    */
    super.initState();

    _loadResourse();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..forward();

    // controller = controller.forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    Timer(
      const Duration(seconds: 3),
      () => Get.toNamed(RouteHelper.getInitial()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Image.asset(
              "assets/image/logo2.png",
              width: Dimensions.splashImg,
            ),
          ),
        ],
      ),
    );
  }
}
