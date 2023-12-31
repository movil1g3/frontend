import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/providers/user_provider.dart';

class RegisterCodesController extends GetxController {

  TextEditingController codeController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void validateCode() async {
    String code = codeController.text;
    if(isValidForm(code)){
      Response response = await usersProvider.findByCode(code);
      if(response.statusCode == 404){
        Get.snackbar('CODIGO INCORRECTO', 'Su codigo es incorrecto, digitelo bien');
      }else{
        Get.snackbar('SIGN IN', 'Inicie Sesion');
        goToHomePage();
      }

    }
  }

  bool isValidForm(
      String code
      ) {

    if (code.isEmpty) {
      Get.snackbar('INFORMACION', 'Campo Correo Electronico Requerido');
      return false;
    }

    return true;
  }

  void goToHomePage() {
    Get.offNamedUntil('/login', (route) => false);
  }

}