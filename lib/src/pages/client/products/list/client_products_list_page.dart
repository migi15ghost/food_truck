import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_truck/src/models/category.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:food_truck/src/utils/my_colors.dart';


class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {

  ClientProductsListController _con = new ClientProductsListController();

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
        key: _con.key,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryColor,
          actions: [
            _shoppingBag()
          ],
          flexibleSpace: Column(
            children: [
              SizedBox(height: 40),
              _menuDrawer(),
            ],
          )
        ),
        drawer: _drawer(),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/LOGO.png"),
              ),
            ),
          child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7
              ),
              itemCount: 4,
              itemBuilder: (_, index) {
                return _cardProduct();
              }
          ),
        )
    );
  }

  Widget _menuDrawer() {
    return GestureDetector(
      onTap: _con.openDrawer,
      child: Container(
        margin: EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Image.asset('assets/img/back.png', width: 28, height: 28),
            Text(
                "MENÚ",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),
            )
          ],
        ),
      ),
    );
  }

  Widget _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.zero,
            height: 100.0,
            color: MyColors.primaryColor,
            child: DrawerHeader(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/img/back.png', width: 28, height: 28),
                    Text(
                      'MENÚ',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                    ),
                  ],
                )
            ),
          ),
          Container (
            color: MyColors.primaryColor,
            child: new Column(
              children: [
                ListTile(
                  onTap: _con.goToRoles,
                  title: Text(
                      'HAMBURGUESA',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  leading:  Image.asset('assets/img/burger_desing.png', width: 28, height: 28),
                ),
                _con.user != null ?
                _con.user.roles.length > 1 ?
                ListTile(
                  onTap: _con.goToRoles,
                  title: Text(
                      'Seleccionar rol',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )
                  ),
                  leading:   Icon(Icons.person_outline),
                ) : Container() : Container(),
                ListTile(
                  onTap: _con.logout,
                  title: Text('Cerrar sesion'),
                  leading: Icon(Icons.power_settings_new),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                ),
                ListTile(
                  onTap: _con.logout,
                  title: Text(''),
                )
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _cardProduct() {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet();
      },
      child: Container(
        height: 250,
        child: Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width * 0.45,
                    padding: EdgeInsets.all(20),
                    child: FadeInImage(
                      image: AssetImage('assets/img/hamburguesa.png'),
                      fit: BoxFit.contain,
                      fadeInDuration: Duration(milliseconds: 50),
                      placeholder: AssetImage('assets/img/no-image.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Text(
                          'HAMBURGUESA HAWAIANA',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Text(
                      'Bs 16',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _shoppingBag() {
    return GestureDetector(
      onTap: _con.goToOrderCreatePage,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 13),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: Colors.black,
            ),
          ),
          Positioned(
              right: 16,
              top: 15,
              child: Container(
                width: 9,
                height: 9,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
              )
          )
        ],
      ),
    );
  }

  void refresh() {
    setState(() {}); // CTRL + S
  }



}
