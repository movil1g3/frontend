import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:projet_delivery/src/models/product.dart';
import 'package:projet_delivery/src/pages/client/products/detail/client_product_detail_controller.dart';

class ClientProductDetailPage extends StatelessWidget {

  Product? product;

  ClientProductDetailController controller = Get.put(ClientProductDetailController());

  ClientProductDetailPage({@required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 100,
          child: _buttonsAddToBag(),
    ),
      body: Container(
        margin: EdgeInsets.only(top: 5),
        child: Column(
          children: [
            _imageSlideShow(context),
            _textNameProduct(),
            _textDescriptionProduct(),
            _textPriceProduct()
          ],
        ),
      )
    );
  }

  Widget _buttonsAddToBag(){
    return Column(
      children: [
        Divider(
          height: 1,
          color: Colors.grey[400],
        ),
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('-',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomLeft: Radius.circular(25)

                        )
                    )
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('0',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                  minimumSize: Size(40, 37)
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text('+',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            bottomRight: Radius.circular(25)

                        )
                    )
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Agregar Lps ${product?.price ?? ''}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)
                    )
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _textNameProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.name ?? '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30,
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textDescriptionProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        product?.description ?? '',
        style: TextStyle(
            fontSize: 19,
        ),
      ),
    );
  }

  Widget _textPriceProduct(){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 30, left: 30, right: 30),
      child: Text(
        'Lps ${product?.price.toString() ?? ''}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.black
        ),
      ),
    );
  }

  Widget _imageSlideShow(BuildContext context){
    return SafeArea(
        child: Stack(
          children: [
            ImageSlideshow(
              width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                initialPage: 0,
                indicatorColor: Colors.amber,
                indicatorBackgroundColor: Colors.grey,
                children: [
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image1 != null
                          ? NetworkImage(product!.image1!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image2 != null
                          ? NetworkImage(product!.image2!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  ),
                  FadeInImage(
                    fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                      image: product!.image3 != null
                          ? NetworkImage(product!.image3!)
                          : AssetImage('assets/img/no-image.png') as ImageProvider
                  )
                ]
            )
          ],
        )
    );
  }

}