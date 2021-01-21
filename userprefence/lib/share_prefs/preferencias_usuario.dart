import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario{

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async{
    this._prefs = await SharedPreferences.getInstance();
  }

  //get & set del genero
  get genero{
    return _prefs.getInt("genero") ?? 1;
  }

  set genero(int value){
    _prefs.setInt("genero", value);
  }

  //get & set del Color
  get colorSec{
    return _prefs.getBool("colorSec") ?? false;
  }

  set colorSec(bool value){
    _prefs.setBool("colorSec", value);
  }

  //get & set del Usuario
  get nombreUsuario{
    return _prefs.getString("nombreUsuario") ?? "";
  }

  set nombreUsuario(String value){
    _prefs.setString("nombreUsuario", value);
  }

   //get & set del Ultima pagina
  get lastPage{
    return _prefs.getString("lastPage") ?? "home";
  }

  set lastPage(String value){
    _prefs.setString("lastPage", value);
  }


}