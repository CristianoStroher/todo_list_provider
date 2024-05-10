import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

//!colocamos a regra de negocio no controller
class RegisterController extends DefaultChangeNotifier {

  //atributo privado para armazenar o UserService
  final UserService _userService;


  //construtor associando o atributo visto que ele é privado
  RegisterController({required UserService userService})
    : _userService = userService;
  
  //metodo para registrar um usuário onde quando o usuario clicar em registrar ele aciona esse metodo
  // que chamara o metodo register do UserService passando o email e senha.
  Future<void> registerUser(String email, String password) async {
    try {
      showLoadingAndResetState(); //limpa o sucesso quando chamar o metodo e mostra o loading
      notifyListeners();//notifica os listeners que houve uma mudança
      final user = await _userService.register(email, password);
      if(user != null) {
        success();//caso o usuario seja diferente de nulo ele armazena que o registro foi bem sucedido  
        
        } else {
        setError('Erro ao registrar o usuário');//caso ocorra um erro ele armazena a mensagem de erro

      }
    } on AuthException catch (e) {
      setError(e.message);//caso ocorra um erro ele armazena a mensagem de erro do AuthException
    } finally {
      hideLoading();
      notifyListeners();//notifica os listeners que houve uma mudança 
    }

  }

  
}