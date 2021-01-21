import 'package:flutter/material.dart';
import 'package:forvalidation/src/bloc/provider.dart';
import 'package:forvalidation/src/pages/home_page.dart';
import 'package:forvalidation/src/pages/login_page.dart';
import 'package:forvalidation/src/pages/product_page.dart';
import 'package:forvalidation/src/pages/registro_page.dart';
import 'package:forvalidation/src/preferencias/preferencias_usuario.dart';

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
      initialRoute: "login",
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
