import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repo.dart';
import 'package:food_delivery/models/cart_model.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  Map<int, CartModel> _items = {};
  // 0, 1,2,3,
  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];
  /*
  only for storage and sharedpreference
  */

  void addItem(ProductModel product, int quantity) {
    // update the item in cart
    var totalQuantity = 0;

    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product, // add new field
        );
      });

      if (totalQuantity <= 0) {
        _items.remove(product.id);
      }
    } else {
      if (quantity > 0) {
        // print("length of the item is " + _items.length.toString());
        _items.putIfAbsent(product.id!, () {
          // print("adding item to the cart id " +
          //     product.id!.toString() +
          //     " Quantity " +
          //     quantity.toString());
          // _items.forEach(((key, value) {
          //   print("quantity is " + value.quantity.toString());
          // }));

          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            // add field
            product: product,
          );
        });
      } else {
        Get.snackbar(
          "item Count",
          "You shoild at least add an  item in the cart",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white,
        );
      }
    }

    // add to cart in history
    cartRepo.addToCartList(getItems); // add item to save sharedprefecerce
    update(); // update immdeiatein this ui

    // productid field
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel product) {
    var quantity = 0;
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!; // loop two times
    });
    return totalQuantity;
  }

  // create new mthod show to cartpage
  List<CartModel> get getItems {
    return _items.entries.map((e) {
      return e.value; // only return modelvalue and store to list
    }).toList();
  }

  // total amount from cartmodel
  int get totalAmount {
    var total = 0;

    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });

    return total;
  }

  // save data to storage
  List<CartModel> getCartData() {
    /*
    setCart = List[

    ]
    */
    setCart = cartRepo.getCartList();
    return storageItems;
  }

  set setCart(List<CartModel> items) {
    storageItems = items;
    //print("length of cart items " + storageItems.length.toString());
    for (int i = 0; i < storageItems.length; i++) {
      _items.putIfAbsent(storageItems[i].product!.id!, () => storageItems[i]);
    }
  }

  void addToHistory() {
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear() {
    _items = {};
    update();
  }

  //  getcartHistory
  List<CartModel> getCartHistoryList() {
    return cartRepo.getCartHistoryList();
  }
}
