import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/pages/client/payments/create/client_payments_create_controller.dart';

class ClientPaymentsCreatePage extends StatelessWidget {


  ClientPaymentsCreateController con = Get.put(ClientPaymentsCreateController());

  @override
  Widget build(BuildContext context) {
    return Obx (() => Scaffold(
      bottomNavigationBar: _buttonNext(context),
      body: ListView(
        children: [
          CreditCardWidget(
            cardNumber: con.cardNumber.value,
            expiryDate: con.expireDate.value,
            cardHolderName: con.cardHolderName.value,
            cvvCode: con.cvvCode.value,
            showBackView: con.isCvvFocused.value,
            cardBgColor: Colors.amber,
            obscureCardNumber: true,
            obscureCardCvv: true,
            height: 175,
            labelCardHolder: 'NOMBRE Y APELLIDO',
            textStyle: TextStyle(color: Colors.black),
            width: MediaQuery.of(context).size.width,
            animationDuration: Duration(milliseconds: 1000),
            onCreditCardWidgetChange: (CreditCardBrand ) {  },
            glassmorphismConfig: Glassmorphism(
              blurX: 5.0,
              blurY: 5.0,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.grey.withAlpha(60),
                  Colors.black.withAlpha(60),
                ],
                stops: const <double>[
                  0.3,
                  0,
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: CreditCardForm(
              formKey: con.keyForm, // Required
              onCreditCardModelChange: con.onCreditCardModelChanged, // Required
              themeColor: Colors.red,
              obscureCvv: true,
              obscureNumber: true,
              cardNumberDecoration: const InputDecoration(
                suffixIcon: Icon(Icons.credit_card),
                labelText: 'Numero de la tarjeta',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: const InputDecoration(
                suffixIcon: Icon(Icons.date_range),
                labelText: 'Expira en',
                hintText: 'MM/YY',
              ),
              cvvCodeDecoration: const InputDecoration(
                suffixIcon: Icon(Icons.lock),
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              cardHolderDecoration: const InputDecoration(
                suffixIcon: Icon(Icons.person),
                labelText: 'Titular de la tarjeta',
              ),
              cvvCode: '',
              expiryDate: '',
              cardHolderName: '',
              cardNumber: '',
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buttonNext(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'CONTINUAR',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

}
