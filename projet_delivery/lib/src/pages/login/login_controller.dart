import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../providers/user_provider.dart';

class LoginController extends GetxController{

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  User user = User.fromJson(GetStorage().read('user') ?? {});

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage(){
    Get.toNamed("/register");
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print('Email ${email}');
    print('Password ${password}');

    if (isValidForm(email, password)) {

      ResponseApi responseApi = await usersProvider.login(email, password);

      print('Response Api: ${responseApi.toJson()}');

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data); // DATOS DEL USUARIO EN SESION

        User myUser = User.fromJson(GetStorage().read('user') ?? {});

        if (myUser.roles!.length > 1) {
          goToRolesPage();
        }
        else { // SOLO UN ROL
          goToClientHomePage();
        }
      }
      else {
        Get.snackbar('Login fallido', responseApi.message ?? '');
      }
    }
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el Email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes Ingresar el Password');
      return false;
    }

    return true;
  }

  void goToRolesPage() {
    Get.offNamedUntil('/roles', (route) => false);
  }

  void goToClientHomePage() {
    Get.offNamedUntil('/client/home', (route) => false);
  }
}