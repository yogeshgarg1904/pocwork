import 'package:flutter/material.dart';

//import './products_manager.dart';
import 'Login/loginpage.dart';

// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext contex) {
    return MaterialApp(
      home: LoginPageWidget(),
      /*theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepOrange,
        accentColor: Colors.deepPurple
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('EasyList'),
          ),
          body: ProductManager('Food Tester'),
      ),*/
    );
  }
}
