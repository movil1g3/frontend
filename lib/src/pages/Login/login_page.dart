import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'login_controller.dart';

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
            _buttonLogin(context)
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

  Widget _buttonLogin (BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 27),
      child: ElevatedButton(
          onPressed: () => controller.login(context),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)),
          child: const Text(
            "SIGN IN",
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
        "Iniciar Sesion",
        style: TextStyle(
            color: Colors.black,
            fontSize: 20
        ),
      ),
    );
  }

  Widget _textNoHaveAccount (){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("¿No tienes una cuenta?",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            )
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () => controller.goToRegisterPage(),
          child: Text("¡Registrate Aqui!",
            style: TextStyle(
                color: Colors.blue,
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
      height: MediaQuery.of(context).size.height * 0.45,
      color: Colors.deepPurple,
    );
  }


  Widget _TextAppName(){
    return const Text(
      "RECORDATORIOS",
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: Colors.white
      ),
    );
  }


  Widget _imagecover() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child:  Image.asset(
          'assets/img/foto.png',
          width: 150,
          height: 150,
        ),
      ),
    );

  }
}