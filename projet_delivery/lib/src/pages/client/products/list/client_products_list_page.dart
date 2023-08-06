import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/models/category.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:projet_delivery/src/widgets/no_data_widgets.dart';

class ClientProductsListPage extends StatelessWidget {

  ClientProductsListController controller = Get.put(ClientProductsListController());
  Product product = Product();

  @override
  Widget build(BuildContext context) {

    return Obx(() => DefaultTabController(
      length: controller.categories.length,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(115),
            child: AppBar(
              flexibleSpace: Container(
                margin: EdgeInsets.only(top: 15),
                alignment: Alignment.topCenter,
                child: Wrap(
                  direction: Axis.horizontal,

                  children: [
                    _textFieldSearch(context),
                    _iconShoppingBag()
                  ],
                ),
              ),
              bottom: TabBar(
                isScrollable: true,
                indicatorColor: Colors.amber,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey[600],
                tabs: List<Widget>.generate(controller.categories.length, (index) {
                  return Tab(
                    child: Text(controller.categories[index].name ?? ''),
                  );
                }),
              ),
            ),
          ),
          body: TabBarView(
            children: controller.categories.map((Category category) {
              return FutureBuilder(
                  future: controller.getProducts(category.id ?? '1', controller.productName.value),
                  builder: (context, AsyncSnapshot<List<Product>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.length > 0) {
                        return ListView.builder(
                            itemCount: snapshot.data?.length ?? 0,
                            itemBuilder: (_, index) {
                              return _cardProduct(context, snapshot.data![index]);
                            }
                        );
                      }
                      else {
                        return NoDataWidget(text: 'No hay productos');
                      }
                    }
                    else {
                      return NoDataWidget(text: 'No hay productos');
                    }
                  }
              );
            }).toList(),
          )
      ),
    ));
  }

  Widget _iconShoppingBag() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: controller.items.value > 0
            ? Stack(
          children: [
            IconButton(
                onPressed: () => controller.goToOrderCreate(),
                icon: Icon(
                  Icons.shopping_bag_outlined,
                  size: 33,
                )
            ),

            Positioned(
                right: 4,
                top: 12,
                child: Container(
                  width: 16,
                  height: 16,
                  alignment: Alignment.center,
                  child: Text(
                    '${controller.items.value}',
                    style: TextStyle(
                        fontSize: 12
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                )
            )
          ],
        )
            : IconButton(
            onPressed: () => controller.goToOrderCreate(),
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            )
        ),
      ),
    );
  }

  Widget _textFieldSearch(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width  * 0.75,
        child: TextField(
          onChanged: controller.onChangeText,
          decoration: InputDecoration(
              hintText: 'Buscar producto',
              suffixIcon: Icon(Icons.search, color: Colors.grey),
              hintStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.grey
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      color: Colors.grey
                  )
              ),
              contentPadding: EdgeInsets.all(15)
          ),
        ),
      ),
    );
  }

  Widget _cardProduct(BuildContext context, Product product){
    return GestureDetector(
      onTap: () => controller.openBottomSheet(context, product),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 17, right: 17),
            child: ListTile(
              title: Text(product.name ?? '',
              style: TextStyle(
                fontSize: 17
              ),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 3),
                  Text(product.description ?? '',
                  style: TextStyle(
                    fontSize: 15
                  ),
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Text('Lps '+ product.price.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 10),
                ],
              ),
              trailing: Container(
                height: 70,
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product.image1 != null
                      ? NetworkImage(product.image1!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider,
                    fit: BoxFit.cover,
                    fadeInDuration: Duration(milliseconds: 50),
                  ),
                ),
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey[500], indent: 35, endIndent: 35)
        ],
      ),
    );
  }

  }
