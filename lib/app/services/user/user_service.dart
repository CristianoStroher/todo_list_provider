import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  
  Future<User?> register(String email, String password); //metodo para registrar um usuário
  Future<User?> login(String email, String password); //metodo para logar um usuário
  Future<void> forgotPassword(String email); //metodo para esquecer a senha
  Future<User?> googleLogin(); //metodo para logar com o google
  Future<void> googleLogout(); //metodo para deslogar
}