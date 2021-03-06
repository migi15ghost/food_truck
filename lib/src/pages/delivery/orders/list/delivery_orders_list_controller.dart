import 'package:flutter/material.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/utils/shared_pref.dart';

class DeliveryOrdersListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  Function refresh;
  User user;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();


  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void openRegister(){
    _sharedPref.save('item', 0);
  }

  logout(){
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

}

