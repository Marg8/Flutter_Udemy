import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _valorSlider = 100.0;
  bool _bloquearCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider")
        ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: <Widget>[
            _crearSlider(),
            _checkBox(),
            _checkSwith(),
            Expanded(
              child: _crearImagen() )
            
          ]
        )
      ),
    );
  }

  Widget _crearSlider() {

    return Slider(
      activeColor: Colors.green,
      label: "Image Size",
      //divisions: 20,
      value: _valorSlider,
      min: 10.0,
      max: 400.0,
      onChanged: (_bloquearCheck) ?  null : (valor){

        setState(() {
          _valorSlider = valor;
        });
      },
    );
     
  }

  Widget _crearImagen() {
    return Image(
      image: NetworkImage("https://cdn.mos.cms.futurecdn.net/EHjg4cc4XY9sNsrYYxNLuF.jpg"),
      width: _valorSlider,
      fit: BoxFit.contain,
    );
  }

  Widget _checkBox() {
    return CheckboxListTile(
      title: Text("Bloquear Slider"),
      value: _bloquearCheck, 
      onChanged:(valor){
        setState(() {
          _bloquearCheck = valor;
        });

    });
  }

  Widget _checkSwith() {
    return SwitchListTile(
      title: Text("Bloquear Slider"),
      value: _bloquearCheck, 
      onChanged:(valor){
        setState(() {
          _bloquearCheck = valor;
        });

    });
  }
}