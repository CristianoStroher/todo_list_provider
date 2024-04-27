import 'package:firebase_auth/firebase_auth.dart';

abstract class UserService {
  
  Future<User?> registrer(String email, String password);
}