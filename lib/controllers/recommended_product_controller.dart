// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_delivery/data/repository/recommended_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({
    required this.recommendedProductRepo,
  });

  bool _isLoaded = false;

  bool get isLoaded {
    return _isLoaded;
  }

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      // print("got produts recommended");
      _recommendedProductList = [];
      // response object means body
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      // print(_popularProductList);
      _isLoaded = true;
      update(); // setstate
    } else {
      print(" could not got produts recommended");
    }
  }
}
