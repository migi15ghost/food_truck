import 'package:flutter/material.dart';
import 'package:food_truck/src/models/category.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:food_truck/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  Function refresh;
  User user;
  List<Category> categories = [];
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();


  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();

  }

  logout(){
    _sharedPref.logout(context);
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void openBottomSheet() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage()
    );
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

}