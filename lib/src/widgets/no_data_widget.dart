import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {

  String text;

  NoDataWidget({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 100, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/no_items.png'),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                child: Text(text)
            )
          ],
        ),
      ),
    );
  }
}
