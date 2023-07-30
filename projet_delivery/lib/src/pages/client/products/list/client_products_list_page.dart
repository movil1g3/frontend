import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/pages/client/products/list/clientt_products_list_controller.dart';
import 'package:projet_delivery/src/pages/client/profile/info/client_profile_info_page.dart';
import '../../../delivery/orders/list/delivery_orders_list_page.dart';
import '../../../register/register_page.dart';
import '../../../restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:projet_delivery/src/utils/custom_animated_bottom_bar.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: _bottomBar(),
        body: Obx(() => IndexedStack(
          index: controller.indexTab.value,
          children: [
            RestaurantOrdersListPage(),
            DeliveryOrdersListPage(),
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
      onItemSelected: (index) => controller  .changeTab(index),
      items: [
        BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text('Home'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Mis pedidos'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
        BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text('Perfil'),
            activeColor: Colors.white,
            inactiveColor: Colors.black
        ),
      ],
    ));
  }
  }
