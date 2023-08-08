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


  bool isValidForm (String documentNumber) {
    if (cardNumber.value.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el numero de la tarjeta');
      return false;
    }
    if (expireDate.value.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa la fecha de vencimiento de la tarjeta');
      return false;
    }
    if (cardHolderName.value.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el nombre del titular');
      return false;
    }
    if (cvvCode.value.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el codigo de seguridad');
      return false;
    }
    if (idDocument.value.isEmpty) {
      Get.snackbar('Formulario no valido', 'Selecciona el tipo de documento');
      return false;
    }
    if (documentNumber.isEmpty) {
      Get.snackbar('Formulario no valido', 'Ingresa el numero del documento');
      return false;
    }

    return true;
  }

  void goToHome() async {
    Get.offNamedUntil('/client/home', (route) => false);
    List<Product> sendNothing = <Product>[];
    GetStorage().write('shopping_bag', sendNothing);
    Get.snackbar('PAGO EXITOSO', 'Su pago se realizo correctamente');
  }

  void goToCreateOrder(BuildContext context) async {
    Address location = Address.fromJson(GetStorage().read('address') ?? {});
    List<Product> product = [];



    if(GetStorage().read('shopping_bag') is List<Product>){

      product = GetStorage().read('shopping_bag');
    }else{
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

    print(create.toJson());

  }


  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber.value = creditCardModel.cardNumber;
    expireDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

}