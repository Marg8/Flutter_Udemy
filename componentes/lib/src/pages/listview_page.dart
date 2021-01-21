import 'dart:async';

import 'package:flutter/material.dart';



class ListaPage extends StatefulWidget {
  @override
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {

  ScrollController _scrollController = new ScrollController();

  List<int> _listasNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState(){
    super.initState();

    _agregar10();

    _scrollController.addListener(() {

      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){

        //_agregar10();
        fetchData();

      } 
      });
  }
  //Cierre de Listener, Ecita fugas de memoria
  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listas"),
        ),
        body: Stack(
          children:[
            _creaLista(),
            _crearLoading()
          ]
        ),
    );
  }

  _creaLista() {
    return RefreshIndicator(

      onRefresh: obtenerPagina1,

        child: ListView.builder(
        controller: _scrollController,
        itemCount: _listasNumeros.length,
        itemBuilder: (BuildContext context, int index){

          final image = _listasNumeros[index];

          return FadeInImage(
            placeholder: AssetImage("assets/jar-loading.gif"),
            height: 299,
            fit: BoxFit.cover, 
            image: NetworkImage("https://picsum.photos/500/300/?image=$image"),
            );
        },

      ),
    );
  }

  Future <Null> obtenerPagina1() async{
    final duration = new Duration(seconds: 2);
    new Timer(duration, (){
      
      _listasNumeros.clear();
      _ultimoItem++;
      _agregar10();
    });
    return Future.delayed(duration);
  }

  void _agregar10() {

    for (var i = 1; i < 10; i++) {
      _ultimoItem++;
      _listasNumeros.add(_ultimoItem);
    }
    setState(() {});
  }

  Future<Null> fetchData() async{
    _isLoading = true;
    setState(() {
      
    });
    final duration = new Duration(seconds: 2);
    return new Timer(duration, respuestasHTTP);
      }
    
      void respuestasHTTP() {
        _isLoading = false;
        _scrollController.animateTo(
        _scrollController.position.pixels + 100,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 250)
        );
        _agregar10();
  }

  _crearLoading() {
    if(_isLoading){
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:<Widget> [
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 15.0),
        ],
      );
    }else{
      return Container();
    } 
  }
}