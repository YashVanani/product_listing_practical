import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:practical/model/product_model.dart';

class ProductController extends GetxController {
  var productsList = <ProductModel>[].obs;
  var favoritesList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void toggleFavorite(ProductModel product) {
    if (!(product.isFavorite ?? false) && !favoritesList.contains(product)) {
      product.isFavorite = true;
      favoritesList.add(product);
    } else {
      product.isFavorite = false;
      favoritesList.remove(product);
    }
    favoritesList.refresh();
    productsList.refresh();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<ProductModel> productList = data.map((json) => ProductModel.fromJson(json)).toList();
        productsList.assignAll(productList);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
    }
  }
}
