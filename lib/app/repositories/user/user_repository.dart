import 'package:firebase_auth/firebase_auth.dart';

//!Nessa classe vamos importar a classe user do próprio firebase
abstract interface class UserRepository {
    // metodo para registrar um usuário
  Future<User?> registrer(String email, String password);

}