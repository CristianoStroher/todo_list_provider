import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';

import '../../../services/user/user_service.dart';



class LoginController extends DefaultChangeNotifier {//aleteração da classe para herdar de DefaultChangeNotifier por conta do listener

  final UserService _userService; //atributo para UserService

  LoginController({required UserService userService}) : _userService = userService; //construtor para inicializar o atributo _userService e encapsular a classe

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();
  
  //metodo para realizar o Login  
  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();//mostra o loader e reseta o estado
      notifyListeners();//notifica os listeners
      final user = await _userService.login(email, password); //chama o método de login do UserService 
    
      //checagem se o usuário é diferente de nulo
      if(user != null) {
        success();//chama o método de sucesso
        print('Logado com sucesso');
      } else {
        setError('Usuário ou senha inválidos');//seta o erro
      }

    } on AuthException catch (e) { //tratamento de exceção do tipo AuthException
      setError(e.message);//seta o erro e mostra a mensagem
    } finally {
      hideLoading();//esconde o loader
      notifyListeners();//notifica os listeners
    }

  }
}
  
  
}