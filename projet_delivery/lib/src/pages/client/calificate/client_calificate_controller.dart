import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ClientCalificateController extends GetxController{

  void goToClientHome(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      Get.offNamedUntil('/client/home', (route) => false);
      Get.snackbar('CALIFICACION','Calificacion Enviada');
    });
  }
}