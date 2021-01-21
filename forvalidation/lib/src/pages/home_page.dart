import 'package:flutter/material.dart';
import 'package:forvalidation/src/bloc/provider.dart';
import 'package:forvalidation/src/models/producto_model.dart';


class HomePage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),      
    );
  }

  _crearBoton(context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: ()=> Navigator.pushNamed(context, "producto")
      );
  }

  _crearListado(ProductosBloc productosBloc) {
    
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){

          final productos = snapshot.data;

          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i) => _crearItem(context, productosBloc, productos[i]),
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }

        
      },
    );
      
  }

  _crearItem(BuildContext context,ProductosBloc productosBloc, ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.redAccent,
          ),
          onDismissed: (direccion){
            productosBloc.borrarProductos(producto.id);
          },
        child: Card(
          child: Column(
            children: [
              (producto.fotoUrl == null)
              ? Image(image: AssetImage("assets/no-image.png"))
              : FadeInImage(
                image: NetworkImage(producto.fotoUrl),
                placeholder: AssetImage("assets/jar-loading1.gif"),
                height: 300.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              ListTile(
              title: Text("${producto.titulo} - ${producto.valor}"),
              subtitle: Text(producto.id),
              onTap: () => Navigator.pushNamed(context, "producto", arguments: producto),

      ),
            ],
          )
        ),
    );
  }


}