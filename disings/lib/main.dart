import 'package:disings/src/pages/basico_page.dart';
import 'package:disings/src/pages/botones_page.dart';
import 'package:disings/src/pages/scroll_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  
  
  @override
  Widget build(BuildContext context) {
    
    //Color de barra de arriba con hora y wifi
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent
    ));

    return MaterialApp(
      title: "UI",
      debugShowCheckedModeBanner: false,
      initialRoute: "scroll",
      routes: {
        "basico" : (BuildContext context) => BasicoPage(),
        "scroll" : (BuildContext context) => ScrollPage(),
        "botones" : (BuildContext context) => BotonesPage(),
      },     
    );
  }
}