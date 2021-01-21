

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';

class BotonesPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            _fondoApp(),
            
            SingleChildScrollView(
              child: Column(
                children: [
                  _titulos(),
                  _botonesRedondeados()
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _bottomNavigationBar(context)
        );
    
  }

  _fondoApp() {

    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0),
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
       height: 360.0,
       width: 360.0,
       decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80.0),
        gradient: LinearGradient(
        colors: [
          Color.fromRGBO(236, 98, 188, 1.0),
          Color.fromRGBO(241, 142, 172, 1.0),
        ],
        ),
        ),
       ),
      );

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -100.0,
          child: cajaRosa),
      ],
    );
  }

  _titulos() {
    return SafeArea(
          child: Container(
            padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Classify Transaction", style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0),
            Text("Classify This Transaction into a particular Folder Category", style: TextStyle(color: Colors.white, fontSize: 15.0,)),
          ],
        )
        ),
    );
    
  }

  _bottomNavigationBar(context){
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme.copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 152, 1.0)))
      ),
      child: BottomNavigationBar(
          items:<BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: "" 
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: "" 
              ),
              BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "" 
              ),
          ], 
         ),
    );
  }

  _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBottonRedondeado(Colors.blue, Icons.border_all,"General"),
            _crearBottonRedondeado(Colors.purple, Icons.directions_bus, "Bus"),
          ]
        ),
        TableRow(
          children: [
            _crearBottonRedondeado(Colors.pinkAccent,Icons.shop, "Shop"),
            _crearBottonRedondeado(Colors.orange, Icons.insert_drive_file, "Buy"),
          ]
        ),
        TableRow(
          children: [
            _crearBottonRedondeado(Colors.blueAccent, Icons.movie_filter, "Movie"),
            _crearBottonRedondeado(Colors.green, Icons.cloud, "Grocery"),
          ]
        ),
        TableRow(
          children: [
            _crearBottonRedondeado(Colors.red, Icons.collections, "Photos"),
            _crearBottonRedondeado(Colors.teal, Icons.help_outline, "Help"),
          ]
        ),
      ],
    );
  }

  _crearBottonRedondeado(Color color, IconData icondata, String texto) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
        child: Container(
          height: 180.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 5.0,),
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icondata, color: Colors.white, size: 30.0,),
              ),
              Text(texto, style: TextStyle(color: color)),
              SizedBox(height: 5.0,),
            ],
          ),
        ),
      ),
    );
  }
              
 
}