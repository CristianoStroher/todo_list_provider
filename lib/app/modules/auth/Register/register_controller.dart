import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

//!colocamos a regra de negocio no controller
class RegisterController extends ChangeNotifier {
  //atributo
  final UserService _userService;
  String? error; //atributo opcional para armazenar o erro caso ocorra
  bool sucess = false; //atributo para armazenar se o registro foi bem sucedido

  //construtor associando o atributo visto que ele é privado
  RegisterController({required UserService userService})
    : _userService = userService;
  
  //metodo para registrar um usuário onde quando o usuario clicar em registrar ele aciona esse metodo
  // que chamara o metodo register do UserService passando o email e senha.
  Future<void> registerUser(String email, String password) async {
    try {
      error = null; //limpa o erro quando chamar o metodo
      sucess = false; //limpa o sucesso quando chamar o metodo
      notifyListeners();//notifica os listeners que houve uma mudança
      final user = await _userService.register(email, password);
      if(user != null) {
        sucess = true;//caso o usuario seja diferente de nulo ele armazena que o registro foi bem sucedido  
        
        } else {
        error = 'Erro ao registrar o usuário';//caso ocorra um erro ele armazena a mensagem de erro

      }
    } on AuthException catch (e) {
      error = e.message;//caso ocorra um erro ele armazena a mensagem de erro do AuthException
    } finally {
      notifyListeners();//notifica os listeners que houve uma mudança 
    }

  }

  
}