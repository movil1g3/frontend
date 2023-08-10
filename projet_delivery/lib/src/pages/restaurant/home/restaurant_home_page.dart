import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import 'package:projet_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:projet_delivery/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import '../../restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:projet_delivery/src/utils/custom_animated_bottom_bar.dart';

import 'restaurant_home_controller.dart';

class RestaurantHomePage extends StatelessWidget {

  RestaurantHomeController controller = Get.put(RestaurantHomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
          index: controller.indexTab.value,
          children: [
            RestaurantOrdersListPage(),
            RestaurantCategoriesCreatePage(),
            RestaurantProductsCreatePage(),
            ClientProfileInfoPage()
          ],
        ))
    );
  }

  Widget _bottomBar() {
    return Obx(() => CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.amber,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      selectedIndex: controller.indexTab.value,
      onItemSelected: (index) => controller.changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: const Icon(Icons.list),
            title: const Text('Pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem (
            icon: const Icon(Icons.category),
            title: const Text('Categoria'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.restaurant),
            title: const Text('Producto'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    ));
  }
  }
