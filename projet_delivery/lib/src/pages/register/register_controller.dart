import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  void register(BuildContext context) async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastnameController.text;
    String phone = phoneController.text;
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, name, lastname, phone, password, confirmPassword)) {

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: "REDIRECCIONANDO...");

      User user = User(
        email: email,
        name: name,
        lastname: lastname,
        phone: phone,
        password: password,
      );

      Stream stream = await usersProvider.createWithImage(user, imageFile!);
      stream.listen((res) {

        progressDialog.close();
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if (responseApi.success == true) {
          GetStorage().write('user', responseApi.data); // DATOS DEL USUARIO EN SESION
          goToHomePage();
        }
        else {
          Get.snackbar('Registro fallido', responseApi.message ?? '');
        }

      });
    }
  }

  bool isValidForm(
      String email,
      String name,
      String lastname,
      String phone,
      String password,
      String confirmPassword
      ) {

    if (email.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Correo Electronico Requerido');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('INFORMACION', 'El Correo Electronico no es valido');
      return false;
    }

    if (name.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Nombres Requerido');
      return false;
    }

    if (lastname.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Apellidos Requerido');
      return false;
    }

    if (phone.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Telefono Requerido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Contraseña Requerido');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Confirmar Contraseña Requerido');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('INFORMACION', 'Las Contraseñas no coinciden');
      return false;
    }

    if (imageFile == null) {
      Get.snackbar('INFORMACION', 'Seleccione Una Imagen, Por Favor');
      return false;
    }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
        onPressed: () {
          Get.back();
          selectImage(ImageSource.gallery);
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
          selectImage(ImageSource.camera);
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

  void goToHomePage() {
    Get.toNamed('/register/codes');
  }

}