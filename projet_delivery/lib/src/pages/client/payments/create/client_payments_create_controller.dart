import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:projet_delivery/src/models/address.dart';
import 'package:projet_delivery/src/models/order.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/models/response_api.dart';
import 'package:projet_delivery/src/models/user.dart';
import 'package:projet_delivery/src/providers/orders_provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class ClientPaymentsCreateController extends GetxController {

  TextEditingController documentNumberController = TextEditingController();

  OrdersProvider ordersProvider = OrdersProvider();

  List<Address> address = [];

  User user = User.fromJson(GetStorage().read('user') ?? {});
  Order order = Order.fromJson(GetStorage().read('order') ?? {});


  var cardNumber = ''.obs;
  var expireDate = ''.obs;
  var cardHolderName = ''.obs;
  var cvvCode = ''.obs;
  var isCvvFocused = false.obs;
  var idDocument = ''.obs;
  GlobalKey<FormState> keyForm = GlobalKey();



  void goToHome() async {
    Get.offNamedUntil('/client/home', (route) => false);
    List<Product> sendNothing = <Product>[];
    GetStorage().write('shopping_bag', sendNothing);
    Get.snackbar('PAGO EXITOSO', 'Su pago se realizo correctamente');
  }

  void goToCreateOrder(BuildContext context) async {
    Address location = Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> product = [];

    if(isValidForm(cardNumber.value, cardHolderName.value, expireDate.value, cvvCode.value)){
      if (GetStorage().read('shopping_bag') is List<Product>) {
        product = GetStorage().read('shopping_bag');
      } else {
        product = Product.fromJsonList(GetStorage().read('shopping_bag'));
      }

      Order create = Order(
          idClient: user.id,
          idAddress: location.id,
          lat: location.lat,
          lng: location.lng,
          products: product
      );

      ProgressDialog progressDialog = ProgressDialog(context: context);
      progressDialog.show(max: 100, msg: "Registrando Compra...");

      ResponseApi responseApi = await ordersProvider.create(create);

      if (responseApi.success == true) {
        progressDialog.close();
        goToHome();
      }
      else{
        Get.snackbar('INFORMACION', 'Compra Fallida');
      }

      print(cardNumber.value);
      print(expireDate.value);
      print(cvvCode.value);
      print(cardHolderName.value);

    }
  }

  bool isValidForm(
      String getCardNumber,
      String getNameHolder,
      String getExpireDate,
      String getCvv,
      ) {

    if (getCardNumber.isEmpty) {
      Get.snackbar('INFORMACION', 'Numero De Tarjeta Requerido');
      return false;
    }

    if (getNameHolder.isEmpty) {
      Get.snackbar('INFORMACION', 'Nombre Del Titular Requerido');
      return false;
    }

    if (getExpireDate.isEmpty) {
      Get.snackbar('INFORMACION', 'Fecha De Expiracion Requerido');
      return false;
    }

    if (getCvv.isEmpty) {
      Get.snackbar('INFORMACION', 'CVV Requerido');
      return false;
    }

    return true;
  }


  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber.value = creditCardModel.cardNumber;
    expireDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

}