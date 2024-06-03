import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository.dart';
import 'package:todo_list_provider/app/repositories/user/user_repository_impl.dart';
import 'package:todo_list_provider/app/services/app_widget.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import 'package:todo_list_provider/app/services/user/user_service_impl.dart';

//! fica aqui as configurações genéricas da aplicação e tudo que for compartilhado pela
//! aplicação toda. classes que vão ser compartilhadas por vários módulos
class AppModule extends StatelessWidget {

  const AppModule({ super.key });

   @override
   Widget build(BuildContext context) {
       return MultiProvider(
        providers: [
          Provider(
            create: (_) => FirebaseAuth.instance),
          Provider(
            create: (_) => SqliteConnectionFactory(),
            lazy: false, //quando cria a aplicação ja instancia e cria a estrutura da migration
            ),
          Provider<UserRepository>(
            create: (context) => UserRepositoryImpl(firebaseAuth: context.read())
            ),
          Provider<UserService>(
            create: (context) => UserServiceImpl(
              userRepository: context.read()),
          ),
          ChangeNotifierProvider(
            create: (context) => AuthProvider(
              firebaseAuth: context.read(),
              userService: context.read(),
              )..loadListener(),
              lazy: false, //não cria a instância até que seja chamado
          ),  
        ],
        child: const AppWidget(),
       );
       
  }
}