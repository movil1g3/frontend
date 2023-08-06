import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:projet_delivery/src/models/category.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/models/response_api.dart';
import 'package:projet_delivery/src/providers/categories_provider.dart';
import 'package:projet_delivery/src/providers/products_provider.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

class RestaurantProductsCreateController extends GetxController{

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile1;
  File? imageFile2;
  File? imageFile3;

  var idCategory = ''.obs;
  List<Category> categories = <Category>[].obs;

  RestaurantProductsCreateController(){
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAll();
    categories.clear();
    categories.addAll(result);
  }

  void createProduct(BuildContext context) async {
    String name = nameController.text;
    String description = descriptionController.text;
    String price = priceController.text;

    ProgressDialog progressDialog = ProgressDialog(context: context);

    if(isValidForm(name, description, price)){
      Product product = Product(
          name: name,
          description: description,
          price: double.parse(price),
        idCategory: idCategory.value,
      );

      progressDialog.show(max: 100, msg: 'Procesando Datos, Espere...');

      List<File> images = [];
      images.add(imageFile1!);
      images.add(imageFile2!);
      images.add(imageFile3!);

      Stream stream = await  productsProvider.create(product, images);
      stream.listen((res) {
        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        Get.snackbar('PRODUCTO REGISTRADO', 'El Producto Ha Sido Registrado Correctamente');

        if (responseApi.success == true) {
          clearForm();
        }
        else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }

      });
    }else{
      Get.snackbar("Formulario No Valido", 'Ingresa Todos Los Campos Para Crear La Categoria');
    }

  }

  bool isValidForm(String name, String description, String price) {
      if(name.isEmpty){
        Get.snackbar("Formulario no Valido", 'INGRESA EL NOMBRE DEL PRODUCTO');
          return false;
      }

      if(description.isEmpty){
        Get.snackbar("Formulario no Valido", 'INGRESA LA DESCRIPCION DEL PRODUCTO');
        return false;
      }

      if(price.isEmpty){
        Get.snackbar("Formulario no Valido", 'INGRESA EL PRECIO DEL PRODUCTO');
        return false;
      }

      if(idCategory.value == ''){
        Get.snackbar("Formulario no Valido", 'DEBES SELECCIONAR UNA CATEGORIA');
        return false;
      }

      if(imageFile1 == null){
        Get.snackbar("Formulario no Valido", 'DEBES SELECCIONAR UNA IMAGEN (1)');
        return false;
      }

      if(imageFile2 == null){
        Get.snackbar("Formulario no Valido", 'DEBES SELECCIONAR UNA IMAGEN (2)');
        return false;
      }

      if(imageFile3 == null){
        Get.snackbar("Formulario no Valido", 'DEBES SELECCIONAR UNA IMAGEN (3)');
        return false;
      }

      return true;
  }

  void clearForm(){
    nameController.text = '';
    descriptionController.text = '';
    priceController.text = '';
    imageFile1 = null;
    imageFile2 = null;
    imageFile3 = null;
    idCategory.value = '';
    update();
  }

  Future selectImage(ImageSource imageSource, int numberFile) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {

      if(numberFile == 1){
        imageFile1 = File(image.path);
      } else if(numberFile == 2){
        imageFile2 = File(image.path);
      }else if(numberFile == 3){
        imageFile3 = File(image.path);
      }
      update();
    }
  }

  void showAlertDialog(BuildContext context, int numberFile) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery, numberFile);
        },
        child: Text(
          'IR A GALERIA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );
    Widget cameraButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.camera, numberFile);
        },
        child: Text(
          'IR A CAMARA',
          style: TextStyle(
              color: Colors.black
          ),
        )
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text('Selecciona una opcion'),
      actions: [
        galleryButton,
        cameraButton
      ],
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

}