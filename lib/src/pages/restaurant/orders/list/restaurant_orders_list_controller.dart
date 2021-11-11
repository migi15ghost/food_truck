import 'package:flutter/material.dart';
import 'package:food_truck/src/models/category.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/utils/shared_pref.dart';

class RestaurantOrdersListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  Function refresh;
  User user;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  List<Category> categories = [];


  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();

  }

  logout(){
    _sharedPref.logout(context);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToCategoryCreate() {
    Navigator.pushNamed(context, 'restaurant/categories/create');
  }

  void goToProductCreate() {
    Navigator.pushNamed(context, 'restaurant/products/create');
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

}
