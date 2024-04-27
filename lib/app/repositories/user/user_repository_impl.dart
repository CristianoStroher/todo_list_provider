// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  FirebaseAuth _firebaseAuth; //cria uma instânica do tipo FirebaseAuth
  
  //Constructor
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth; //como o atributo é privado, ele  é inicializado no construtor de forma diferente.
  
  //pede para implementar o método
  @override
  Future<User?> registrer(String email, String password) async {
    //criamos uma variável para receber o usuário que foi criado.
    try {
      final userCredential =  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user; //.user é opcional para pegar o objeto no firebase
   //vamos tratar o erros no login_page.dart quando chamar esse método
   // e para isso vamos encapsular o método em um try catch.
  } on FirebaseAuthException catch (e, s) {
    print(e);
    print(s);
    if(e.code == 'email-already-in-use') {
      final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if(loginTypes.contains('password')){
        throw AuthException(
          message: 'E-mail já cadastrado');
      } else {
        throw AuthException(
          message: 'Você já se cadastrou com o Google, por favor utilize esse método para logar');
      }
     } else {
      throw AuthException(
        message: e.message ?? 'Erro ao registrar usuário');
     }
    }
  }
}

