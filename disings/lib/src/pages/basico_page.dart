import 'package:flutter/material.dart';

class BasicoPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: SingleChildScrollView(
       child: Column(
         children: <Widget>[
        _crearImagen(),
        _tituloSubtitulo(),
        _multiAcciones(),
        _cajaTexto(),
        _cajaTexto(),
        _cajaTexto(),
        _cajaTexto(),
        _cajaTexto(), 
        

      ],
       ),      
     ),
    );
  }

  Widget _crearImagen() {
    return Image(image: NetworkImage("https://blogdestinia.com/wp-content/uploads/2019/06/parque-nacional-banff-768x550.jpg"),
      );
  }

  Widget _tituloSubtitulo() {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Row(
            children:<Widget> [

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
               Text("Lago con piedras", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
               SizedBox(height: 7.0,),
              Text("Un lago que se encuentra en Japon"),
              ],
             ),
             Icon(Icons.star, color: Colors.red, size: 30.0),
             Text("42", style: TextStyle(fontSize: 20.0),)
            ],
          ),
        ),
    );
  }

  Widget _multiAcciones(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _accion(Icons.call, "Call"),
        _accion(Icons.near_me, "Route"),
        _accion(Icons.share, "Share"),
      ],
    );
  }

  Widget _accion(IconData icon, String texto) {
   return Column(
     children: [
       Icon(icon, color: Colors.blue, size: 40.0,),
       Text(texto, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
     ],
   );
  }

  Widget _cajaTexto() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Text("Lago de japon, una de las grandes maravilas del mundo que se pueden apreciar, habra que ir a ver lo personalmente, Lago de japon, una de las grandes maravilas del mundo que se pueden apreciar, habra que ir a ver lo personalmente",
      textAlign: TextAlign.justify,
      ),
      );
  }

  
}