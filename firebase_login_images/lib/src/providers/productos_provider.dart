import 'dart:convert';
import 'dart:io';
import 'package:firebase_login_images/src/models/producto_model.dart';
import 'package:firebase_login_images/src/preferencias/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';


class ProductosProvider{

  final String _url = "https://flutter-varius-5610a-default-rtdb.firebaseio.com";
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearProducto(ProductoModel producto) async {

    final url = "$_url/Productos.json?auth=${_prefs.token}";

    final resp = await http.post(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

   Future<bool> editarProducto(ProductoModel producto) async {

    final url = "$_url/Productos/${producto.id}.json?auth=${_prefs.token}";

    final resp = await http.put(url, body: productoModelToJson(producto));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProductoModel>> cargarProductos() async{

    final url ="$_url/Productos.json?auth=${_prefs.token}";
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProductoModel> productos = new List.empty();

    if(decodedData == null) return [];
    if(decodedData["error"] != null) return []; //accion de Token expirado

    decodedData.forEach((id, prod) {

      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;

      productos.add(prodTemp);
      
    });

    //print(productos);

    
    return productos;
  }

  

  Future<int> borrarProducto(String id)async{

    final url = "$_url/Productos/$id.json?auth=${_prefs.token}";
    final resp = await http.delete(url);

    print(json.decode(resp.body));

    return 1;

  }

  Future<String> subirImagen(File imagen) async {

    final url = Uri.parse("https://api.cloudinary.com/v1_1/dcvp1cmb4/image/upload?upload_preset=f0naa9lf");    
    final mimeType = mime(imagen.path).split("/"); //image/jpg, identificacion de formato de imagen cargada

    final imageUploadRequest = http.MultipartRequest(
      "POST",
      url
    );

    final file = await http.MultipartFile.fromPath("file",
    imagen.path,
    contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print("Algo Salio mal");
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData["secure_url"];

  }
}