import 'package:flutter/material.dart';
import 'package:food_truck/src/models/order.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/models/response_api.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/provider/orders_provider.dart';
import 'package:food_truck/src/utils/shared_pref.dart';

class ClientOrdersCreateController {

  BuildContext context;
  Function refresh;

  Product product;

  int counter = 1;
  double productPrice;

  SharedPref _sharedPref = new SharedPref();
  User user;
  List<Product> selectedProducts = [];
  OrdersProvider _orderProvider = new OrdersProvider();
  double total = 0;
  int item = 0;
  String text_order = "";

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    selectedProducts = Product.fromJsonList(await _sharedPref.read('order')).toList;
    _orderProvider.init(context, user);
    item = (await _sharedPref.getNumberOrder()).toInt();
    getTotal();
    refresh();
  }

  void createOrder() async {
    Order order = new Order(
      idClient : user.id,
      products : selectedProducts
    );
    ResponseApi responseApi = await _orderProvider.create(order);
    if(responseApi.success){
      await _sharedPref.setNumberOrder(counter);
    }
    print('Respuesta : ${responseApi.message} ');
  }

  void getTotal() {
    total = 0;
    selectedProducts.forEach((product) {
      total = total + (product.quantity * product.price);
      text_order = text_order + product.name + " - " + product.quantity.toString() + '\n';
    });
    print(text_order);
    refresh();
  }

  void addItem(Product product) {
    int index = selectedProducts.indexWhere((p) => p.id == product.id);
    selectedProducts[index].quantity = selectedProducts[index].quantity + 1;
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void removeItem(Product product) {
    if (product.quantity > 1) {
      int index = selectedProducts.indexWhere((p) => p.id == product.id);
      selectedProducts[index].quantity = selectedProducts[index].quantity - 1;
      _sharedPref.save('order', selectedProducts);
      getTotal();
    }
  }

  void deleteItem(Product product) {
    selectedProducts.removeWhere((p) => p.id == product.id);
    _sharedPref.save('order', selectedProducts);
    getTotal();
  }

  void goToAddress() {
    Navigator.pushNamed(context, 'client/address/list');
  }

  String getItem(){
    return "Mi orden " + item.toString() + "#";
  }

}