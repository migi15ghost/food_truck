import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/utils/my_colors.dart';

import 'client_products_detail_controller.dart';

class ClientProductsDetailPage extends StatefulWidget {
  Product product;

  ClientProductsDetailPage({Key key, @required this.product}) : super(key: key);

  @override
  _ClientProductsDetailPageState createState() => _ClientProductsDetailPageState();
}

class _ClientProductsDetailPageState extends State<ClientProductsDetailPage> {

  ClientProductsDetailController _con = new ClientProductsDetailController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh, widget.product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.backgroundColor,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          FadeInImage(
            image: AssetImage('assets/img/hamburguesa.png'),
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 50),
            placeholder: AssetImage('assets/img/no-image.png'),
          ),
          //_imageSlideshow(),
          _textName(),
          _cardDercription(),
          //_standartDelivery(),
          _buttonShoppingBag()
        ],
      ),
    );
  }

  Widget _cardDercription () {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30;
    final double categoryWidth = MediaQuery.of(context).size.width * 0.70;
    return Container(
      width: categoryWidth,
      margin: EdgeInsets.only(right: 20),
      height: categoryHeight,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20.0))),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "INGREDIENTES :",
              style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            _textDescription(),
            Spacer(),
            _addOrRemoveItem(),
          ],
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15),
      child: Text(
        _con.product?.description ?? '',
        style: TextStyle(
            fontSize: 13,
            color: Colors.grey
        ),
      ),
    );
  }

  Widget _textName() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 30, left: 30, top: 15, bottom: 15),
      child: Text(
        _con.product?.name ?? '',
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buttonShoppingBag() {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
      child: ElevatedButton(
        onPressed: _con.addToBag,
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 5),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'AÑADIR AL CARRITO',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _standartDelivery() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        children: [
          Image.asset(
            'assets/img/delivery.png',
            height: 17,
          ),
          SizedBox(width: 7),
          Text(
            'Envio estandar',
            style: TextStyle(
                fontSize: 12,
                color: Colors.green
            ),
          )
        ],
      ),
    );
  }

  Widget _addOrRemoveItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: _con.addItem,
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.black,
                    size: 30,
                  )
              ),
              Text(
                '${_con.counter}',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                ),
              ),
              IconButton(
                  onPressed: _con.removeItem,
                  icon: Icon(
                    Icons.remove_circle_outline,
                    color: Colors.black,
                    size: 30,
                  )
              )
              ,
            ],
          ),
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Text(
              '${_con.productPrice ?? 0} Bs',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

  /*
  Widget _imageSlideshow() {
    return SafeArea(
      child: Stack(
        children: [
          ImageSlideshow(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            initialPage: 0,
            indicatorColor: MyColors.primaryColor,
            indicatorBackgroundColor: Colors.grey,
            children: [
              FadeInImage(
                image: _con.product?.image1 != null
                    ? NetworkImage(_con.product.image1)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
              FadeInImage(
                image: _con.product?.image2 != null
                    ? NetworkImage(_con.product.image2)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
              FadeInImage(
                image: _con.product?.image3 != null
                    ? NetworkImage(_con.product.image3)
                    : AssetImage('assets/img/no-image.png'),
                fit: BoxFit.cover,
                fadeInDuration: Duration(milliseconds: 50),
                placeholder: AssetImage('assets/img/no-image.png'),
              ),
            ],
            onPageChanged: (value) {
              print('Page changed: $value');
            },
            autoPlayInterval: 30000,
          ),
          Positioned(
              left: 5,
              top: 10,
              child: IconButton(
                onPressed: _con.close,
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 35,
                ),
              )
          )
        ],
      ),
    );
  }
*/
  void refresh() {
    setState(() {

    });
  }
}
