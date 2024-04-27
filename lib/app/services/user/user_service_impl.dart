import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  //atributo
  final UserRepository _userRepository;

  //Constructor
  UserServiceImpl({required UserRepository userRepository}) : _userRepository = userRepository;

  //metodo
  @override
  Future<User?> registrer(String email, String password) =>
       _userRepository.registrer(email, password);

}