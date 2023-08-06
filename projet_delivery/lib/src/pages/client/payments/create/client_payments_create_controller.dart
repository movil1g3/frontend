import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:get/get.dart';


class ClientPaymentsCreateController extends GetxController {

  TextEditingController documentNumberController = TextEditingController();

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

  void onCreditCardModelChanged(CreditCardModel creditCardModel) {
    cardNumber.value = creditCardModel.cardNumber;
    expireDate.value = creditCardModel.expiryDate;
    cardHolderName.value = creditCardModel.cardHolderName;
    cvvCode.value = creditCardModel.cvvCode;
    isCvvFocused.value = creditCardModel.isCvvFocused;
  }

}