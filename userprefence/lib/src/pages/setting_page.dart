import 'package:flutter/material.dart';
import 'package:userprefence/share_prefs/preferencias_usuario.dart';
import 'package:userprefence/widgets/menu_widget.dart';


class SettingPage extends StatefulWidget {
  
  static final String routeName = "setting";

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool _colorSecundario = true;
  int _genero;
  String _nombre ="Mario";

  TextEditingController _textController;

  final prefs = new PreferenciasUsuario();


  @override
  void initState(){
    super.initState();
    
    prefs.lastPage = SettingPage.routeName;
    _genero = prefs.genero;
    _colorSecundario = prefs.colorSec;
    
    _textController = new TextEditingController(text: prefs.nombreUsuario);
  }

  

  _setRadio(int valor) {

    prefs.genero = valor;
    _genero = valor;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
        backgroundColor: (prefs.colorSec) ? Colors.green : Colors.blue,
      ),
      drawer: MenuWidget(),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            child: Text("Settings", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),),
          ),
          Divider(),
          SwitchListTile(
            value: _colorSecundario,
            title: Text("Color Secundario"), 
            onChanged: (value){
               
              setState(() {
              _colorSecundario = value;
              prefs.colorSec = value;  
              });
            },
          ),

          RadioListTile(
            value: 1, 
            title: Text("Masculino"),
            groupValue: _genero, 
            onChanged: _setRadio,
            
            ),
            Divider(),

            RadioListTile(
            value: 2, 
            title: Text("Femenino"),
            groupValue: _genero, 
            onChanged:_setRadio,
            ),
            Divider(),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  helperText: "Nombre de Usuario"
                ),
                onChanged: (value){
                  prefs.nombreUsuario = value;
                },
              ),
            ),

        ],
      ),
    );
  }
}