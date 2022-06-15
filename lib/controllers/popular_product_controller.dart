// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({
    required this.popularProductRepo,
  });

  bool _isLoaded = false;

  bool get isLoaded {
    return _isLoaded;
  }

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0; // global track of cartitem
  int get inCartItems => _inCartItems + _quantity;

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      // print("got produts");
      _popularProductList = [];
      // response object means body
      _popularProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update(); // setstate
    } else {}
  }

// add to cart
  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      // increase something
      // print("icreament" + _quantity.toString());
      _quantity = checkQuantity(_quantity + 1);
      // print("number of items" + _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      // print("decreament" + quantity.toString());
    }

    // ui trigger  getx package
    update(); // update immediate value
  }

  // check quantity
  // _inCartitems = 2;
  //_quantity = 0;
  // _quantity = -2;
  int checkQuantity(int quantity) {
    // local scope
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "item Count",
        "You can't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      Get.snackbar(
        "item Count",
        "You can't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20; // change on based
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    // if exist
    var exist = false;
    exist = _cart.existInCart(product);
    //  print("exist or not" + exist.toString());
    // get from storage _inCartItems = 3
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print(" the quantity in the cart " + _inCartItems.toString());
  }

  //
  void addItem(ProductModel product) {
    // function call and first create instance of controller
    // if (_quantity > 0) {
    _cart.addItem(product, _quantity);

    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      // print("the Id is " + value.id.toString() + " The quantity is " +value.quantity.toString());
    });
    // } else {
    //   Get.snackbar(
    //     "item Count",
    //     "You shoild at least add an  item in the cart",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //   );
    //}
    update();
  }

  // total item
  int get totalItems {
    return _cart.totalItems;
  }

  // create similar to cart method  to call to popular contoller bzs instamce create in cart controller
  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
