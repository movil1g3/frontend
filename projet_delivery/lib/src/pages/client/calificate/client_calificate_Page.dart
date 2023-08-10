import 'package:flutter/material.dart';
import 'package:projet_delivery/src/pages/client/calificate/client_calificate_controller.dart';

void main() {
  runApp(MyApp());
}

class OrderRatingPage extends StatefulWidget {



  @override
  _OrderRatingPageState createState() => _OrderRatingPageState();
}

class _OrderRatingPageState extends State<OrderRatingPage> {

  ClientCalificateController controller = ClientCalificateController();

  int _rating = 0;

  void _rateOrder(int rating) {
    setState(() {
      _rating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calificar Pedido',
        style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Califica este pedido:',
              style: TextStyle(fontSize: 20,
              color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 1; i <= 5; i++)
                  GestureDetector(
                    onTap: () => _rateOrder(i),
                    child: Icon(
                      i <= _rating ? Icons.star : Icons.star_border,
                      size: 40,
                      color: Colors.yellow,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              _rating == 0
                  ? 'Selecciona una calificación'
                  : 'Has calificado con $_rating estrella${_rating > 1 ? 's' : ''}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => controller.goToClientHome(context),
              child: Text('Enviar Calificación',
              style: TextStyle(
                color: Colors.black
              ),),
            ),
          ],
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      child: MaterialApp(
        title: 'Calificar Pedido',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OrderRatingPage(),
      ),
    );
  }
}
