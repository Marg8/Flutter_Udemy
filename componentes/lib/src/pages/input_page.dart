import 'package:flutter/material.dart';


class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  String _nombre = "";
  String _email = "";
  String _fecha = "";

  String _opcionSeleccionada = "Volar";

  List<String> _poderes = ["Volar", "Rayos X", "Super Fuerza", "Super Velozidad"];

  TextEditingController _inputFieldDateController =  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inputs de Texto"),
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
          children: <Widget>[
            _crearInput(),
            Divider(),
            _crearEmail(),
            Divider(),
            _crearPassword(),
            Divider(),
            _crearFecha(context),
            Divider(),
            _crearDropdown(),
            Divider(),
            _crearBienvenida(),
            Divider(),
          ],
        ),
    );
  }

  Widget _crearInput() {

    return TextField(
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_nombre.length}"),
        hintText: "Nombre Completo",
        labelText: "Nombre",
        helperText: "Solo para nombres",
        suffixIcon: Icon(Icons.accessibility),
        icon: Icon(Icons.account_circle)
      ),
      onChanged: (valor){
        setState(() {
        _nombre = valor;  
        });       
      
      },
    );
  }

  Widget _crearBienvenida() {

    return ListTile(

      title: Text("Bienvenido $_nombre"),
      subtitle: Text("Email: $_email"),
      trailing: Text(_opcionSeleccionada),

    );
  }

  Widget _crearEmail() {

    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        counter: Text("Letras ${_email.length}"),
        hintText: "Email",
        labelText: "Email",        
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon(Icons.email)
      ),
      onChanged: (valor){
        setState(() {
        _email = valor;  
        });       
      
      },
    );
  }

  Widget _crearPassword() {

    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        
        hintText: "Password",
        labelText: "Password",        
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon(Icons.lock)
      ),
      onChanged: (valor){
        setState(() {
        _email = valor;  
        });       
      
      },
    );
  }

  Widget _crearFecha(contex) {

    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        
        hintText: "Fecha de naciemiento",
        labelText: "Fecha de naciemiento",        
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: (){

        FocusScope.of(context).requestFocus(new FocusNode());

        _selectDate(context);

      },
    );
  }

   _selectDate(BuildContext context)async {

     DateTime picked = await showDatePicker(
     context: context, 
     initialDate: new DateTime.now(), 
     firstDate: new DateTime(2018), 
     lastDate: new DateTime(2025),
     locale: Locale("es")
     );
     if(picked != null){
       setState(() {
         _fecha = picked.toString();
         _inputFieldDateController.text = _fecha;
       });
     }

   }

List<DropdownMenuItem<String>> getOpcionesDropdown(){

  List<DropdownMenuItem<String>> lista = new List();

  _poderes.forEach((poder) {
    
    lista.add( DropdownMenuItem(
      child: Text(poder),
      value: poder,
      ));
  });
  return lista;
}

 Widget _crearDropdown() {

   return DropdownButton(
     value: _opcionSeleccionada,
     items: getOpcionesDropdown(),
     onChanged: (opt){
       setState((){
         _opcionSeleccionada = opt;

       });

     }
   );

  }
}