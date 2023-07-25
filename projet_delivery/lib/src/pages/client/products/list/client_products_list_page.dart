import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/pages/client/products/list/clientt_products_list_controller.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Client Products List'),
            ElevatedButton(
              onPressed: () => controller.signOut(),
              child: Text(
                'Cerrar sesion',
                style: TextStyle(
                    color: Colors.black
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
