import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forvalidation/src/bloc/provider.dart';
import 'package:forvalidation/src/models/producto_model.dart';

import 'package:forvalidation/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final formKey = GlobalKey<FormState>();
  final scaffoldmKey = GlobalKey<ScaffoldState>();
  
  
  ProductosBloc productosBloc;
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;
  

  @override
  Widget build(BuildContext context) {

    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if(prodData != null){
      producto = prodData;
    }

    return Scaffold(
      key: scaffoldmKey,
      appBar: AppBar(
        title: Text("Producto"),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual), 
            onPressed: _seleccionarFoto,
            ),
          IconButton(
            icon: Icon(Icons.camera_alt), 
            onPressed: _tomarFoto,
            ),
          ],
      ),
      
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: "Nombre de Producto"
      ),
      onSaved: (value) => producto.titulo = value,
      validator: (value){
        if(value.length < 3){
          return "Ingrese el nombre del Producto";
        }else{
          return null;
        }
      },
    );
  }

  _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Precio"
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {

        if(utils.isNumeric(value)){
          return null;
        }else{
          return "Solo numeros";
        }        
      },
    );
  }

  _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text("Guardar"),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _sumit,
      );
  }

  void _sumit() async{

    if( !formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }  

    if(producto.id == null){
      productosBloc.agregarProductos(producto);
    }else{
      productosBloc.editarProductos(producto);
    }

    //setState(() {_guardando = false;});
    mostrarSnackbar("Registro Guardado");

    Navigator.pop(context);   

    
    
  }

  _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text("Disponible"),
      activeColor: Colors.blue, 
      onChanged: (value) => setState((){
        producto.disponible = value;
      })
      );
  }

  void mostrarSnackbar(String mensaje){

    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldmKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
 
    if (producto.fotoUrl != null) {
 
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage("assets/jar-loading1.gif"),
        height: 300,
        fit: BoxFit.contain,
      );
 
    } else {
 
      if( foto != null ){
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/no-image.png');
    }
  }

  _seleccionarFoto() async {

    _procesarImagen( ImageSource.gallery );

  }
  
  
  _tomarFoto() async {

    _procesarImagen( ImageSource.camera );

  }

  _procesarImagen( ImageSource origen ) async {

    final _picker = ImagePicker();
 
    final pickedFile = await _picker.getImage(
      source: origen,
    );
    
    foto = File(pickedFile.path);
 
    if (foto != null) {
      producto.fotoUrl = null;
    }
 
    setState(() {
      
    });
  }
}