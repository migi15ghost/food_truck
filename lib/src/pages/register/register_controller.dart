import 'package:flutter/material.dart';
import 'package:food_truck/src/models/user.dart';
import 'package:food_truck/src/models/response_api.dart';
import 'package:food_truck/src/provider/users_provider.dart';
import 'package:food_truck/src/utils/my_snackbar.dart';

class RegisterController{

  BuildContext context;
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController lastController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();

  Future init (BuildContext context) {
    this.context = context;
    usersProvider.init(context);
  }

  void register () async {
    String email = emailController.text.trim();
    String name = nameController.text;
    String lastname = lastController.text;
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if ( email.isEmpty || name.isEmpty || lastname.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      MySnackbar.show(context, "Ingresa todos los campos");
      return ;
    }

    if(confirmPassword != password){
      MySnackbar.show(context, 'contrasenias no coinciden');
      return;
    }

    if(password.length < 6){
      MySnackbar.show(context, "La contrasenia tiene que tener 6 caracteres");
      return;
    }

    User user = new User(
      email: email,
      name: name,
      lastname: lastname,
      password: password
    );
    ResponseApi responseApi = await usersProvider.create(user);
    MySnackbar.show(context, responseApi.message);

    if (responseApi.success){
      Future.delayed(Duration(seconds: 3), (){
        Navigator.pushReplacementNamed(context, 'login');
      });
    }

    print('Respuesrta: ${responseApi.toJson()}');
  }

  void back() {
    Navigator.pop(context);
  }

}