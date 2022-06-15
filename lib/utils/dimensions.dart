import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;
// 844/220 = 3.84 height factor
//
  static double pageView = screenHeight / 2.61; // 834/320
  static double pageViewContainer = screenHeight / 3.81;
  static double pageViewTextContainer = screenHeight / 7.00;

  // 844.10 = 84.0
  // dynamic height padding and margin
  static double height10 = screenHeight / 83.4;
  static double height15 = screenHeight / 55.6;
  static double height20 = screenHeight / 41.7;
  static double height30 = screenHeight / 27.8;
  static double height45 = screenHeight / 18.53;
  // height means set-> top -> buttom
  // dynamic width padding and margin
  // width means set -> left -> right
  static double width10 = screenWidth / 83.4;
  static double width15 = screenWidth / 55.6;
  static double width20 = screenWidth / 41.7;
  static double width30 = screenWidth / 27.8;
  static double width45 = screenWidth / 18.53;
  // font size
  static double font16 = screenHeight / 52.16;
  static double font20 = screenHeight / 41.7;
  static double font26 = screenHeight / 32.07;

  // radius
  static double radius15 = screenHeight / 41.7;
  static double radius20 = screenHeight / 55.6;
  static double radius30 = screenHeight / 27.8;

  // icons size
  static double iconSize24 = screenHeight / 34.72;
  static double iconSize16 = screenHeight / 52.12;

  // list view size
  static double listViewImgSize = screenWidth / 3.25;
  static double listViewTextCountSize = screenWidth / 3.9;

  // popular food
  static double popularFoodImgSize = screenHeight / 2.41;

  // bootom height
  static double bottomHeightBar = screenHeight / 6.95;

  //splash screen dimensions
  static double splashImg = screenHeight / 3.38;
}
