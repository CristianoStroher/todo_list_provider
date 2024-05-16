import 'package:firebase_auth/firebase_auth.dart';

//!Nessa classe vamos usar a classe user do próprio firebase para realizar a função registrer para criar usauario.
abstract interface class UserRepository {
    // metodo para registrar um usuário
  Future<User?> register(String email, String password);

  //metodo para logar um usuário
  Future<User?> login(String email, String password);

}