// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final FirebaseAuth _firebaseAuth; //cria uma instânica do tipo FirebaseAuth
  
  //Constructor
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth; //como o atributo é privado, ele  é inicializado no construtor de forma diferente.
  
  //pede para implementar o método
  @override
  Future<User?> register(String email, String password) async {
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
      //!como foi depreciado o método fetchSignInMethodsForEmail, vamos fazer a verificação de outra forma.
      //! verificar se o email já está cadastrado no firebase
      final loginTypes = await FirebaseFirestore
        .instance.collection('users')
        .where('email', isEqualTo: email)
        .get();
      //! se o loginTypes.docs não estiver vazio, então o e-mail já está cadastrado
      if(loginTypes.docs.isNotEmpty){
        throw AuthException(
          message: 'E-mail já cadastrado');
      //! se não, então o e-mail já está cadastrado com o Google
      } else {
        throw AuthException(
          message: 'Você já se cadastrou com o Google, por favor utilize esse método para logar');
      } 
      // final loginTypes = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      // if(loginTypes.contains('password')){
      //   throw AuthException(
      //     message: 'E-mail já cadastrado');
      // } else {
      //   throw AuthException(
      //     message: 'Você já se cadastrou com o Google, por favor utilize esse método para logar');
      // }
     } else {
      //!outro tipo de erro, lançar exceção padrão
      throw AuthException(
        message: e.message ?? 'Erro ao registrar usuário');
     }
    }
  }
}

