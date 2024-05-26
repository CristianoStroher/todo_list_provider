import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import '../../../services/user/user_service.dart';



class LoginController extends DefaultChangeNotifier {//aleteração da classe para herdar de DefaultChangeNotifier por conta do listener

  final UserService _userService; //atributo para UserService
  String? infoMessage; //atributo para mensagem de informação

  LoginController({required UserService userService}) : _userService = userService; //construtor para inicializar o atributo _userService e encapsular a classe

  bool get hasInfo => infoMessage != null; //método para verificar se tem mensagem de informação
  
  //método para realizar o login com o Google
  Future<void> googleLogin() async {
    try {
      showLoadingAndResetState();//mostra o loader e reseta o estado. Função pronta no DefaultChangeNotifier
      infoMessage = null;//seta a mensagem de informação como nula. Função pronta nesta classe
      notifyListeners();//notifica os listeners e aprsenta o loader.
      final user = await _userService.googleLogin();//chama o método de login com o Google do UserService para
      
      if(user != null) {//checagem se o usuário é diferente de nulo
        success();//chama o método de sucesso
      } else {
        setError('Erro ao realizar login com o Google');//seta o erro
      }
    } on AuthException catch (e, s) {//tratamento de exceção do tipo AuthException
     print(e);//printa a exceção
     print(s);//printa a stacktrace
     setError(e.message);//seta o erro e mostra a mensagem
    }finally {
      hideLoading();//esconde o loader
      notifyListeners();//notifica os listeners
  }
  }
  //metodo para realizar o Login  
  Future<void> login(String email, String password) async {
    try {
      showLoadingAndResetState();//mostra o loader e reseta o estado
      infoMessage = null;//seta a mensagem de informação como nula
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

  Future<void> forgotPassword(String email) async { //método para recuperar a senha
    try {
      showLoadingAndResetState();//mostra o loader e reseta o estado
      infoMessage = null;//seta a mensagem de informação como nula
      notifyListeners();//notifica os listeners
      await _userService.forgotPassword(email);//chama o método de esquecer a senha do UserService
      infoMessage = 'E-mail enviado para recuperação de senha';
    } on AuthException catch (e) {//tratamento de exceção do tipo AuthException
        setError(e.message);//seta o erro e mostra a mensagem
    } catch (e) {//tratamento de exceção genérico
        setError('Erro ao recuperar a senha');//seta o erro e mostra a mensagem
    } finally {
      hideLoading();//esconde o loader
      notifyListeners();//notifica os listeners
    }  


  }
}

  
  
