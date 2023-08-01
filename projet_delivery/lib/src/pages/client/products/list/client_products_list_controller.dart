import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:projet_delivery/src/models/category.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/pages/client/products/detail/client_product_detail_page.dart';
import 'package:projet_delivery/src/providers/categories_provider.dart';
import 'package:projet_delivery/src/providers/products_provider.dart';

class ClientProductsListController extends GetxController {

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  ClientProductsListController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await productsProvider.findByCategory(idCategory);
  }

  void openBottomSheet(BuildContext context, Product product){
    showMaterialModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) => ClientProductDetailPage(product: product
        )
    );
  }

}