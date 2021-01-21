import 'package:flutter/material.dart';
import 'package:forvalidation/src/bloc/provider.dart';
import 'package:forvalidation/src/providers/usuario_provider.dart';
import 'package:forvalidation/src/utils/utils.dart';



class LoginPage extends StatelessWidget {

  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        ],
      ),      
    );
  }

  _crearFondo(BuildContext context) {

    final size = MediaQuery.of(context).size;

    final fondomorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        ),
      ),
    );

    final circulos = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );

    final avatarName = Container(
      padding: EdgeInsets.only(top: 80.0),
      child: Column(
        children: [
          Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0,),
          SizedBox(height: 10.0, width: double.infinity),
          Text("Mario Rodriguez", style: TextStyle(color: Colors.white),)
        ],
      ),
    );

    return Stack(
      children: [
        fondomorado,
        Positioned(top: 90.0,left: 30.0, child: circulos),
        avatarName,
        
      ],
      );
  }

  _loginForm(context) {
    
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: [
                Text("Ingreso"),
                _crearEmail(bloc),
                SizedBox(height: 20.0,),
                _creaPassword(bloc),
                SizedBox(height: 30.0,),
                _crearBoton(bloc),
                SizedBox(height: 10.0,),
                
                
              ],
            ),
          ),

          FlatButton(
            child: Text("Registrar Nueva Cuenta"),
            onPressed: ()=> Navigator.pushReplacementNamed(context, "registro"),
          ),
          SizedBox(height: 1000.0),

        ],
      ),
    );
  }

  _crearEmail(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
      return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.black,),
          hintText: "Ejemplo@gmail.com",
          labelText: "Correo Electronico",
          counterText: snapshot.data,
          errorText: snapshot.error 
          ),
          onChanged: bloc.changeEmail,
        ),
       );
      },
    );
  }

  _creaPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(Icons.lock_open_outlined, color: Colors.black,),
          labelText: "Password", 
          counterText: snapshot.data,
          errorText: snapshot.error
        ),
        onChanged: bloc.changepassword,
      ),
     );
    }
   );
  }

  _crearBoton(LoginBloc bloc){

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){

        

          return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text("Ingresar"),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.black,
      textColor: Colors.white,
      onPressed: snapshot.hasData ? ()=> _login(bloc, context) : null
      );
     }
     
    );
  }

  _login(LoginBloc bloc, context) async{

    usuarioProvider.login(bloc.email, bloc.password);

    Map info = await usuarioProvider.login(bloc.email, bloc.password);

    if(info["ok"]){
      Navigator.pushNamed(context, "home");
    }else{
      mostrarAlerta(context, info["mensaje"]);
    }
    

    

  }


}