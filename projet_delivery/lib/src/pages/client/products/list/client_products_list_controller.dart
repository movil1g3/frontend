import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:projet_delivery/src/models/category.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/pages/client/products/detail/client_product_detail_page.dart';
import 'package:projet_delivery/src/providers/categories_provider.dart';
import 'package:projet_delivery/src/providers/products_provider.dart';

class ClientProductsListController extends GetxController {

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Product> selectedProducts = [];

  List<Category> categories = <Category>[].obs;

  var productName = ''.obs;
  Timer? searchOnStoppedTyping;
  var items = 0.obs;

  ClientProductsListController() {
    getCategories();
    if (GetStorage().read('shopping_bag') != null) {
      if (GetStorage().read('shopping_bag') is List<Product>) {
        selectedProducts = GetStorage().read('shopping_bag');
      }
      else {
        selectedProducts = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      selectedProducts.forEach((p) {
        items.value = items.value + (p.quantity!);
      });

    }
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory,  productName) async {

    if (productName.isEmpty) {
      return await productsProvider.findByCategory(idCategory);
    }
    else {
      return await productsProvider.findByNameAndCategory(idCategory, productName);
    }
  }

  void onChangeText(String text) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }

    searchOnStoppedTyping = Timer(duration, () {
      productName.value = text;
      print('TEXTO COMPLETO: ${text}');
    });
  }

  void goToOrderCreate() {
    Get.toNamed('/client/orders/create');
  }

  void openBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => ClientProductDetailPage(product: product
        )
    );
  }

}