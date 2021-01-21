import 'package:flutter/material.dart';
import 'package:userprefence/share_prefs/preferencias_usuario.dart';
import 'package:userprefence/widgets/menu_widget.dart';


class HomePage extends StatelessWidget {
  
  static final String routeName = "home";
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

  prefs.lastPage = HomePage.routeName;  

    return Scaffold(
      appBar: AppBar(        
        title: Text("Preferencias de Usuario"),
        backgroundColor: (prefs.colorSec) ? Colors.green : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: Column(
        children: [
          Text("Color secuandario: ${ prefs.colorSec}"),
          Divider(),
          Text("Genero ${prefs.genero}"),
          Divider(),
          Text("Nombre de Usuario: ${prefs.nombreUsuario}"),
          Divider(),
        ],
      ),
    );
  }

  
  
}