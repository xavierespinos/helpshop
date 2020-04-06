import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackovid/setup/signIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App",
      home: LoginPage(),
    );
  }
}





