import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';

import './user_service.dart';

//classe de implementação de UserService que serve para registrar e logar um usuário  
class UserServiceImpl implements UserService {
  //atributo
  final UserRepository _userRepository;

  //Constructor que serve para inicializar o atributo _userRepository deixando a classe UserServiceImpl dependente de UserRepository
  // protegendo o código de mudanças futuras
  UserServiceImpl({required UserRepository userRepository})
      : _userRepository = userRepository;

  //implementa o método de registrar de UserService
  @override
  Future<User?> register(String email, String password) =>
      _userRepository.register(email, password);

  //implementa o método de login de UserService
  @override
  Future<User?> login(String email, String password) =>
      _userRepository.login(email, password);

  //implementa o método de esquecer a senha de UserService  
  @override
  Future<void> forgotPassword(String email) =>
      _userRepository.forgotPassword(email);

  //implementa o método de login com o google de UserService    
  @override
  Future<User?> googleLogin() => _userRepository.googleLogin();
      
  
}
