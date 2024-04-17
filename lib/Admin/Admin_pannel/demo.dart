import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'details_model.dart';

class ProductManager {
  static Future<List<Product>> getProductList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productListJson = prefs.getString('productList');
    if (productListJson != null) {
      List<dynamic> jsonList = jsonDecode(productListJson);
      List<Product> productList =
      jsonList.map((json) => Product.fromJson(json)).toList();
      return productList;
    } else {
      return [];
    }
  }

  static Future<void> saveProductList(List<Product> productList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String productListJson = jsonEncode(productList);
    prefs.setString('productList', productListJson);
  }

  static Future<void> editProductName(int index, String newName) async {
    List<Product> productList = await getProductList();
    productList[index].productName = newName;
    await saveProductList(productList);
  }
}
