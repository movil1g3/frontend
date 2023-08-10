import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projet_delivery/src/models/user.dart';
import 'package:projet_delivery/src/models/Rol.dart';

class RolesController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  void goToPageRol(Rol rol) {
    Get.toNamed(rol.route ?? '');
  }


}