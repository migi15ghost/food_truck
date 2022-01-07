import 'package:flutter/material.dart';
import 'package:food_truck/src/models/category.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/pages/client/products/detail/client_products_detail_page.dart';
import 'package:food_truck/src/provider/categories_provider.dart';
import 'package:food_truck/src/provider/products_provider.dart';
import 'package:food_truck/src/utils/shared_pref.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ClientProductsListController {

  BuildContext context;
  SharedPref _sharedPref = new SharedPref();
  Function refresh;
  User user;
  CategoriesProvider _categoriesProvider = new CategoriesProvider();
  List<Category> categories = [];
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  ProductsProvider _productsProvider = new ProductsProvider();


  Future init (BuildContext context, Function refresh) async{
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    _categoriesProvider.init(context, user);
    _productsProvider.init(context, user);
    getCategories();
    refresh();
  }

  Future<List<Product>> getProducts(String idCategory) async {
    return await _productsProvider.getByCategory(idCategory);

    /*if (productName.isEmpty) {
      return await _productsProvider.getByCategory(idCategory);
    }
    else {
      return await _productsProvider.getByCategoryAndProductName(idCategory, productName);
    }*/
  }

  void getCategories() async {
    categories = await _categoriesProvider.getAll();
    refresh();
  }

  logout(){
    _sharedPref.logout(context, user.id);
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }

  void goToCaterory() {
    getProducts("2");
    refresh();
  }

  void openBottomSheet(Product product) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => ClientProductsDetailPage(product: product)
    );
  }

  void goToOrderCreatePage() {
    Navigator.pushNamed(context, 'client/orders/create');
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

}