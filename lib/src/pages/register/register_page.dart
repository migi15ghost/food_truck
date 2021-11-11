import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:food_truck/src/pages/register/register_controller.dart';
import 'package:food_truck/src/utils/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  RegisterController _con = new RegisterController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: MyColors.backgroundColor),
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                  top: -80,
                  left: -100,
                  child: _circleRegister()
              ),
              Positioned(
                  top: 61,
                  left: 25,
                  child: _textRegister()
              ),
              Positioned(
                  top: 50,
                  left: -5,
                  child: _iconBack()
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 150),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _imageUser(),
                      _textFieldEmail(),
                      _textFieldName(),
                      _textFieldApellido(),
                      _textFieldPassword(),
                      _textFieldVerifyPassword(),
                      _buttonRegister(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _imageUser(){
    return CircleAvatar(
      backgroundImage: AssetImage('assets/img/user_profile_2.png') ,
      radius: 60,
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _circleRegister () {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: MyColors.secondaryColor
      ),
    );
  }

  Widget _textFieldEmail(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color : MyColors.primaryColor
            ),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldName(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombre',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color : MyColors.primaryColor
            ),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldApellido(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.lastController,
        decoration: InputDecoration(
            hintText: 'Apellido',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color : MyColors.primaryColor
            ),
            prefixIcon: Icon(
              Icons.person_outline,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _iconBack(){
    return IconButton(
        onPressed: _con.back,
        icon: Icon(Icons.arrow_back_ios ),
        color: MyColors.textColor
    );
  }

  Widget _textFieldPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contrasenia',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color : MyColors.primaryColor
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textFieldVerifyPassword(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)
      ),
      child: TextField(
        controller: _con.confirmPasswordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirmar Contrasenia',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
                color : MyColors.primaryColor
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )
        ),
      ),
    );
  }

  Widget _textRegister(){
    return Text(
      'REGISTRO',
      style: TextStyle(
          color: MyColors.textColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: 'NimbusSans'
      ),
    );
  }

  Widget _buttonRegister(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: ElevatedButton(
        onPressed: _con.register,
        child: Text('INGRESAR'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            )
        ),
      ),
    );
  }

}
