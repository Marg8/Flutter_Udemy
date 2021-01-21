import 'package:flutter/material.dart';
import 'package:firebase_login_images/src/bloc/provider.dart';
import 'package:firebase_login_images/src/pages/home_page.dart';
import 'package:firebase_login_images/src/pages/login_page.dart';
import 'package:firebase_login_images/src/pages/product_page.dart';
import 'package:firebase_login_images/src/pages/registro_page.dart';
import 'package:firebase_login_images/src/preferencias/preferencias_usuario.dart';

void main() async {  

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
  
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print(prefs.token);    

    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      initialRoute: "home",
      routes: {
        "login"    : (BuildContext context) => LoginPage(),
        "registro" : (BuildContext context) => RegistroPage(),
        "home"     : (BuildContext context) => HomePage(),
        "producto" : (BuildContext context) => ProductPage(),
      },

     ),
    );
    
    
    }
}
