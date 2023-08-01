import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/pages/restaurant/categories/create/restaurant_categories_create_controller.dart';

class RestaurantCategoriesCreatePage extends StatelessWidget {

  RestaurantCategoriesCreateController controller = Get.put(RestaurantCategoriesCreateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // POSICIONAR ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _textNewCategory(context),
        ],
      ),
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
      height: MediaQuery.of(context).size.height * 0.68,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29, left: 50, right: 50),
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
            _buttonCreate(context)
          ],
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 1),
      child: TextField(
        controller: controller.nameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Nombre de Categoria',
            prefixIcon: Icon(Icons.category)
        ),
      ),
    );
  }

  Widget _textFieldDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      child: TextField(
        controller: controller.descriptionController,
        keyboardType: TextInputType.text,
        maxLines: 5,
        decoration: InputDecoration(
            hintText: 'Descripcion',
            prefixIcon: Container(
                margin: EdgeInsets.only(bottom: 70),
                child: Icon(Icons.description))

        ),
      ),
    );
  }

  Widget _buttonCreate(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 25),
      child: ElevatedButton(
          onPressed: ()  {
            controller.createCategory();
          },
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CREAR CATEGORIA',
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
        margin: EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Icon(Icons.category, size: 120,),
            Text(
                'Nueva Categoria',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
      child: Text(
        'CREA UNA CATEGORIA',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

}
