import 'package:flutter/material.dart';
import 'package:food_truck/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:food_truck/src/pages/client/products/list/client_products_list_page.dart';
import 'package:food_truck/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:food_truck/src/pages/login/login_page.dart';
import 'package:food_truck/src/pages/register/register_page.dart';
import 'package:food_truck/src/pages/restaurant/categories/create/restaurant_categories_create_page.dart';
import 'package:food_truck/src/pages/restaurant/orders/list/restaurant_orders_list_page.dart';
import 'package:food_truck/src/pages/restaurant/products/create/restaurant_products_create_page.dart';
import 'package:food_truck/src/pages/roles/roles_page.dart';
import 'package:food_truck/src/utils/my_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'King food app',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'register' : (BuildContext context) => RegisterPage(),
        'roles' : (BuildContext context) => RolesPage(),
        'client/orders/create' : (BuildContext context) => ClientOrdersCreatePage(),
        'client/products/list' : (BuildContext context) => ClientProductsListPage(),
        'restaurant/orders/list' : (BuildContext context) => RestaurantOrdersListPage(),
        'delivery/orders/list' : (BuildContext context) => DeliveryOrdersListPage(),
        'restaurant/categories/create' : (BuildContext context) => RestaurantCategoriesCreatePage(),
        'restaurant/products/create' : (BuildContext context) => RestaurantProductsCreatePage(),
      },
      theme: ThemeData(
        primaryColor: MyColors.backgroundColor,
          scaffoldBackgroundColor: MyColors.backgroundColor,
        appBarTheme: AppBarTheme(elevation: 0)
      ),
    );
  }
}


