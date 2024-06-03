
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/navigator/todol_list_navigator.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

// Classe destinada a prover a autenticação, ou seja, verificar
// se usuario está logado ou não, se está autenticado ou não e suas
// alterações. Tudo que acontece no firebase.

class AuthProvider extends ChangeNotifier {

  final FirebaseAuth _firebaseAuth; //cria uma instância do tipo FirebaseAuth
  final UserService _userService; //atributo para UserService
  
  //construtor para inicializar os atributos _firebaseAuth e _userService
  // para evitar mudanças futuras dentro da classe
  AuthProvider({
    required FirebaseAuth firebaseAuth,
    required UserService userService
  }) : _firebaseAuth = firebaseAuth,
       _userService = userService; 

  // metodos auxiliares
  Future<void> logout() => _userService.logout(); //método para deslogar. Ele é um atalho para o método de logout do UserService
  User? get user => _firebaseAuth.currentUser; //método para pegar o usuário atual  

  //metodo para escutar as mudanças dentro do firebase Auth
  void loadListener() {
    _firebaseAuth.userChanges().listen((_) => notifyListeners()); //escuta as mudanças no userchange do firebase Auth e notifica os linesteres
    _firebaseAuth.idTokenChanges().listen((user) {
      if (user != null) {
        TodolListNavigator.to
         .pushNamedAndRemoveUntil('/home', (route) => false); //se o usuário for diferente de nulo, ele navega para a tela home e remove todas as outras telas
      } else {
        TodolListNavigator.to
         .pushNamedAndRemoveUntil('/login', (route) => false); //se o usuário for nulo, ele navega para a tela de login e remove todas as outras telas
               }
    
    }); //escuta as mudanças no token do firebase Auth e notifica os linesteres
    
  }

}