import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/utils/my_colors.dart';
import 'package:food_truck/src/widgets/no_data_widget.dart';
import 'client_orders_create_controller.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

class ClientOrdersCreatePage extends StatefulWidget {
  const ClientOrdersCreatePage({Key key}) : super(key: key);

  @override
  _ClientOrdersCreatePageState createState() => _ClientOrdersCreatePageState();
}

class _ClientOrdersCreatePageState extends State<ClientOrdersCreatePage> {

  ClientOrdersCreateController _con = new ClientOrdersCreateController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cartColor,
      appBar: AppBar(
        backgroundColor: MyColors.cartColor,
        title: Text(_con.getItem()),
      ),
      bottomNavigationBar: Container(
        color: MyColors.cartColor,
        height: MediaQuery.of(context).size.height * 0.235,
        child: Column(
          children: [
            Divider(
              height: 0,
              color: Colors.black,
              endIndent: 30, // DERECHA
              indent: 30, //IZQUIERDA
            ),
            _textTotalPrice(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buttonBack(),
                _buttonNext(),
              ],
            )
          ],
        ),
      ),
      body: _con.selectedProducts.length > 0
          ? ListView(
        children: _con.selectedProducts.map((Product product) {
          return _cardProduct(product);
        }).toList(),
      )
          : NoDataWidget(text: 'Ningun producto agregado',)
       ,
    );
  }

  Widget _buttonBack() {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
      child: ElevatedButton(
        onPressed: (){
          _con.createOrder();
          _printMesa();
        },
        style: ElevatedButton.styleFrom(
            primary: MyColors.cartHomeColor,
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
                  'PARA LA MESA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
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

  Widget _buttonNext() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: ElevatedButton(
        onPressed: (){
          _con.createOrder();
          _printLlevar();
        },
        style: ElevatedButton.styleFrom(
            primary: MyColors.cartDeliveryColor,
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
                  'PARA LLEVAR',
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColors.textColor,
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

  Widget _numeroPedido(){
    return Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: MyColors.primaryColor,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                offset: Offset(0.0,10.0)
            )
          ]
      ),
      child: Text(
        _con.getItem(),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 50,
            color: MyColors.textColor,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _cardProduct(Product product) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product?.name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 10),
                _addOrRemoveItem(product)
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              _textPrice(product),
              _iconDelete(product)
            ],
          )
        ],
      ),
    );
  }

  Widget _iconDelete(Product product) {
    return IconButton(
        onPressed: () {
          _con.deleteItem(product);
        },
        icon: Icon(Icons.delete, color: MyColors.primaryColor,)
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total:',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
          ),
          Text(
            'Bs ${_con.total} ',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          )
        ],
      ),
    );
  }

  Widget _textPrice(Product product) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Text(
        '${product.price * product.quantity}',
        style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _imageProduct(Product product) {
    return Container(
      width: 90,
      height: 90,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200]
      ),
      child: FadeInImage(
        image: product.image1 != null
            ? NetworkImage(product.image1)
            : AssetImage('assets/img/no-image.png'),
        fit: BoxFit.contain,
        fadeInDuration: Duration(milliseconds: 50),
        placeholder: AssetImage('assets/img/no-image.png'),
      ),
    );
  }

  Widget _addOrRemoveItem(Product product) {
    return Column(
      children: [
        Text('Carne, queso, tomate'),
        SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                _con.removeItem(product);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8)
                    ),
                    color: Colors.grey[200]
                ),
                child: Text('-'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              color: Colors.grey[200],
              child: Text('${product?.quantity ?? 0}'),
            ),
            GestureDetector(
              onTap: () {
                _con.addItem(product);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8)
                    ),
                    color: Colors.grey[200]
                ),
                child: Text('+'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _printLlevar() async {
    // Test regular text
    SunmiPrinter.hr();
    SunmiPrinter.text(
      _con.getItem(),
      styles: SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

    SunmiPrinter.text(
      'Lista del Pedido',
      styles: SunmiStyles(bold: true, underline: true),
    );

    SunmiPrinter.text(
      _con.text_order,
      styles: SunmiStyles(bold: false, underline: false),
    );

    SunmiPrinter.text(
      'PARA LLEVAR',
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.center),
    );

    SunmiPrinter.hr(ch: "-");

    String total = _con.total.toString();

    SunmiPrinter.text(
      total,
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
    );

    SunmiPrinter.emptyLines(3);

  }

  void _printMesa() async {
    // Test regular text
    SunmiPrinter.hr();
    SunmiPrinter.text(
      _con.getItem(),
      styles: SunmiStyles(align: SunmiAlign.center),
    );
    SunmiPrinter.hr();

    SunmiPrinter.text(
      'Lista del Pedido',
      styles: SunmiStyles(bold: true, underline: true),
    );

    SunmiPrinter.text(
      _con.text_order,
      styles: SunmiStyles(bold: false, underline: false),
    );

    SunmiPrinter.text(
      'PARA MESA',
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.center),
    );

    SunmiPrinter.hr(ch: "-");

    String total = _con.total.toString();

    SunmiPrinter.text(
      total,
      styles: SunmiStyles(bold: true, underline: true, align: SunmiAlign.right),
    );

    SunmiPrinter.emptyLines(3);

  }

  void refresh() {
    setState(() {});
  }

}
