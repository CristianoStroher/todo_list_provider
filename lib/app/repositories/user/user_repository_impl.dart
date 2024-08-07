// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import './user_repository.dart';

final Logger logger = Logger();
class UserRepositoryImpl implements UserRepository {

  final FirebaseAuth _firebaseAuth; //cria uma instânica do tipo FirebaseAuth
  
  //Constructor
  UserRepositoryImpl({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth; //como o atributo é privado, ele  é inicializado no construtor de forma diferente.
  
  //pede para implementar o método de registrar da interface UserRepository
  @override
  Future<User?> register(String email, String password) async {
    //criamos uma variável para receber o usuário que foi criado.
    try {
      final userCredential =  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user; //.user é opcional para pegar o objeto no firebase
   //vamos tratar o erros no login_page.dart quando chamar esse método
   // e para isso vamos encapsular o método em um try catch.
  } on FirebaseAuthException catch (e, s) {
    logger.e('Erro: $e, Stack Trace: $s');
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

  //implementa o método de login da interface UserRepository
  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e, s) { //tratamento de erro de plataforma
      logger.e('Erro: $e, Stack Trace: $s');
      throw AuthException(
        message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e, s) { //tratamento de erro do firebase
      logger.e('Erro: $e, Stack Trace: $s');
      if(e.code == 'user-not-found' || e.code == 'wrong-password'){
        throw AuthException(
          message: 'E-mail ou senha inválidos');
      } else {
        throw AuthException(
          message: e.message ?? 'Erro ao realizar login');
      }
    }
  }
  
  @override
  Future<void> forgotPassword(String email) async { //método para recuperar a senhav no firebase
    try {
      final loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email); //verifica se o email existe
    
      if(loginMethods.contains('password')) { //se o email existir ele envia o email para recuperar a senha
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } else if (loginMethods.contains('google')) {
        throw AuthException(
        message: 'Cadastro com Google, utilize o Google para logar.');
      } else {
        throw AuthException(
        message: 'E-mail não cadastrado.');
      }
    } on PlatformException catch (e, s) {
      logger.e('Erro: $e, Stack Trace: $s'); //se der erro ele mostra o erro
      throw AuthException(
        message: e.message ?? 'Erro ao recuperar senha');
  }
}
  // metodo para logar com o google
  @override
  Future<User?> googleLogin() async {
    List<String>? loginMethods; //cria uma lista de string para armazenar os métodos de login
    try {
  final googleSignIn = GoogleSignIn(); //cria uma instância do GoogleSignIn
  final googleUser = await googleSignIn.signIn(); //chama o método de signIn do GoogleSignIn(ab)
  
  if(googleUser != null) { //se o googleUser for diferente de nulo quer dizer que o usuário logou com o google ou tentou logar
    loginMethods = await _firebaseAuth.fetchSignInMethodsForEmail(googleUser.email); //so que antes de logar ele verifica se o email já está cadastrado para evitar subscrever o email
    // entao se ele constata que tem o cadastro usando o email se senha do cadastro ele não deixa logar com o google.
    if(loginMethods.contains('password')) {
      throw AuthException(
        message: 'E-mail já cadastrado, utilize o login com e-mail e senha');
    } else {
      final googleAuth = await googleUser.authentication; //se não ele pega as credenciais do googleUser
      final firebaseCredential = GoogleAuthProvider.credential( //cria uma credencial com o GoogleAuthProvider
        accessToken: googleAuth.accessToken, //passa o accessToken do google de autorização
        idToken: googleAuth.idToken, // passa o idToken do google de identificação
      );
      final userCredential = await _firebaseAuth.signInWithCredential(firebaseCredential); //faz o login com a credencial
      return userCredential.user; //retorna o usuário
    }
  }
} on FirebaseAuthException catch (e, s) {
  logger.e('Erro: $e, Stack Trace: $s'); //se der erro ele mostra o erro
  if(e.code == 'account-exists-with-different-credential') {  //essa mensagem é padrão do firebase de que a conta já existe com um provedor diferente
    throw AuthException(
      message: '''E-mail já cadastrado, utilize o login com os seguintes provedores: ${loginMethods?.join(', ')}'''); //se o email já estiver cadastrado ele mostra a mensagem com os provedores que já estão cadastrados como facebook, google, etc.
  } else {
    throw AuthException(
      message: e.message ?? 'Erro ao realizar login com Google');
  }

}
  
  }
  
  //metodo para deslogar
  @override
  Future<void> logout() async{
    await GoogleSignIn().signOut(); //chama o método de signOut do GoogleSignIn
    _firebaseAuth.signOut(); //chama o método de signOut do FirebaseAuth
  }
  
  //metodo para alterar o nome do usuário
  @override
  Future<void> updateDisplayName(String name) async {
    // para alterar o nome do usuário, vamos pegar o usuário atual e atualizar o displayName
    final user = _firebaseAuth.currentUser; //pega o usuário atual
    if(user != null) { //se o usuário for diferente de nulo
      await user.updateDisplayName(name); //atualiza o displayName do usuário
      user.reload();//atualiza o usuário
    } else {
      throw AuthException(
        message: 'Usuário não autenticado');
    }
    
  }
}

