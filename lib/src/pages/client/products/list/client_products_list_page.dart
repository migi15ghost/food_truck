import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_truck/src/models/category.dart';
import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:food_truck/src/utils/my_colors.dart';
import 'package:food_truck/src/widgets/no_data_widget.dart';

class ClientProductsListPage extends StatefulWidget {
  const ClientProductsListPage({Key key}) : super(key: key);

  @override
  _ClientProductsListPageState createState() => _ClientProductsListPageState();
}

class _ClientProductsListPageState extends State<ClientProductsListPage> {

  ClientProductsListController _con = new ClientProductsListController();
  String _page = "1";

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
            centerTitle: true,
            title: const Text(
              'KING FOOD TRUCK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
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
        body: FutureBuilder(
            future:_con.getProducts(_page),
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              if(snapshot.hasData){
                if(snapshot.data.length > 0){
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7
                      ),
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (_, index) {
                        return _cardProduct(snapshot.data[index]);
                      }
                  );
                }else{
                  return NoDataWidget(text: 'No hay productos');
                }
              }else{
                return NoDataWidget(text: 'No hay productos');
              }
            }
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
      child: Container(
        color: MyColors.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: EdgeInsets.zero,
              height: 100.0,
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
              child: new Column(
                children: createCategoriesProducts(),
              ),
            ),
          ],
        ),
      )
    );
  }

  createCategoriesProducts (){
    var textEditingControllers = <TextEditingController>[];

    var categoriesProducts = <ListTile>[];
    var list = new List<int>.generate(_con.categories.length, (i) => i + 1 );
    print(list);

    list.forEach((i) {
      var textEditingController = new TextEditingController(text: "test $i");
      textEditingControllers.add(textEditingController);
      return categoriesProducts.add(
          new ListTile(
            onTap: (){
              _handleTap(_con.categories[i-1].id ?? '0');
              Navigator.of(context).pop(false);
            },
            title: Text(
                  _con.categories[i-1].name ?? '',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
              ),
            leading:
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: const DecorationImage(
                  image: AssetImage('assets/img/no-image.png'),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          )
      );
    });
    categoriesProducts.add(
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
          trailing: Icon(Icons.person_outline),
        )
    );
    return categoriesProducts;
  }

  void _handleTap(String index) {
    setState(() {
      _page = index;
    });
  }

  Widget _cardProduct(Product product) {
    return GestureDetector(
      onTap: () {
        _con.openBottomSheet(product);
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
                      image:
                         product.image1 != null? NetworkImage(product.image1) :
                      AssetImage('assets/img/hamburguesa.png'),
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
                          product.name ?? '',
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
                      '${product.price ?? 0} Bs',
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
              Icons.shopping_cart_outlined,
              color: Colors.white,
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
