

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:forvalidation/src/bloc/validators.dart';

class LoginBloc with Validators{
  
  //se usa al convinar Condiones Stream
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

//Este se usa cuando no se convinen Condiciones Stream
  //final _emailController = StreamController<String>.broadcast();
  //final _passwordController = StreamController<String>.broadcast();
  

  //Recuperar los datos del Stream
  Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidStream => Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  //Insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changepassword => _passwordController.sink.add;

  //obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;


  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }
}