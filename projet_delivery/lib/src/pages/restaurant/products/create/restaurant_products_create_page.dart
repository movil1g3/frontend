import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/models/category.dart';
import 'package:projet_delivery/src/pages/restaurant/products/create/restaurant_products_create_controller.dart';

class RestaurantProductsCreatePage extends StatelessWidget {

  RestaurantProductsCreateController controller = Get.put(RestaurantProductsCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => Stack( // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context),
        ],
      )),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldName(),
            _textFieldDescription(),
            _textFieldPrice(),
            _dropDownCategories(controller.categories),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetBuilder<RestaurantProductsCreateController> (
                      builder: (value) =>_cardImage(context, controller.imageFile1, 1),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController> (
                      builder: (value) =>_cardImage(context, controller.imageFile2, 2),
                  ),
                  SizedBox(width: 5),
                  GetBuilder<RestaurantProductsCreateController> (
                      builder: (value) =>_cardImage(context, controller.imageFile3, 3),
                  )
                ],
              ),
            ),
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _dropDownCategories(List<Category> categories) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        margin: EdgeInsets.only(top: 18),
        child: DropdownButton(
          underline: Container(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.arrow_drop_down_circle,
              color: Colors.amber,
            ),
          ),
          elevation: 3,
          isExpanded: true,
          hint: Text(
            'Seleccionar Categoria',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15
            ),
          ),
          items: _dropDownItems(categories),
          value: controller.idCategory.value == '' ? null : controller.idCategory.value,
          onChanged: (option) {
            print('Opcion --->>> ${option.toString()}');
            controller.idCategory.value = option.toString();
          },
        ),
      );
  }

  List<DropdownMenuItem<String?>> _dropDownItems(List<Category> categories){
    List<DropdownMenuItem<String>> list = [];
    categories.forEach((category) {
      list.add(DropdownMenuItem(
        value: category.id,
        child: Text(category.name ?? '')
      ));
    });

    return list;
  }

  Widget _cardImage(BuildContext context, File? imageFile, int numberFile){
      return GestureDetector(
        onTap: () => controller.showAlertDialog(context, numberFile),
        child:   Card(
          elevation: 3,
          child:Container(
              padding: EdgeInsets.all(6),
              height: 80,
              width: MediaQuery.of(context).size.width * 0.18,
              child: imageFile != null
                  ? Image.file(
                imageFile,
                fit: BoxFit.cover,
              )
                  : Image(
                image: AssetImage('assets/img/cover_image.png'),
              )
          ),
        )
      );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 1),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre del Producto',
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textFieldPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 1),
      child: TextField(
        controller: controller.priceController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
            hintText: 'Precio',
            prefixIcon: Icon(Icons.attach_money)
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 4,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            prefixIcon: Container(
                margin: EdgeInsets.only(bottom: 55),
                child: Icon(Icons.description))

        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: ()  {
            controller.createProduct(context);
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 13)
          ),
          child: Text(
            'CREAR PRODUCTO',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _textNewCategory(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: const Text(
          'Nuevo Producto',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 25, bottom: 15),
      child: Text(
        'CREA UN PRODUCTO',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

}
