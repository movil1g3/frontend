import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:projet_delivery/src/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: Container(
        height: 50,
        child: _textNoHaveAccount(),
      ),
      body: Stack(
        children: [
          _backgroundCover(context),
          _boxForm(context),
          Column(
            children: [
              _imagecover(),
              _TextAppName()
            ],
          )
        ],
      )
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.36, left: 50, right: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textInfoBF(),
            _textFieldEmailBF(),
            _textFieldPasswordBF(),
            _buttonLogin()
          ],
        ),
      ),
    );
  }

  Widget _textFieldEmailBF() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: controller.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: Icon(Icons.email),
        ),
      ),
    );
  }

  Widget _textFieldPasswordBF() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child:  TextField(
        controller: controller.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: Icon(Icons.lock),
        ),
      ),
    );
  }

  Widget _buttonLogin () {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 27),
      child: ElevatedButton(
          onPressed: () => controller.login(),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.black
            ),
          )),
    );
  }

  Widget _textInfoBF () {
    return Container(
      margin: EdgeInsets.only(top: 35, bottom: 30),
      child: const Text(
        "ENTER YOUR INFORMATION",
        style: TextStyle(
          color: Colors.black,
          fontSize: 16
        ),
      ),
    );
  }

  Widget _textNoHaveAccount (){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't Have Account?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16
          )
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => controller.goToRegisterPage(),
          child: Text("Register Here!",
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),),
        )
      ],
    );
  }

  Widget _backgroundCover(BuildContext context){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.amber,
    );
  }


  Widget _TextAppName(){
    return const Text(
      "El PORVENIR STEAKS",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
    );
  }


  Widget _imagecover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child:  Image.asset(
          'assets/img/delivery.png',
          width: 130,
          height: 130,
        ),
      ),
    );

  }
}
