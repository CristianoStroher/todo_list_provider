import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

//! aqui vai ficar a implementação do nosso material app
class AppWidget extends StatelessWidget {

  const AppWidget({ super.key });

   @override
   Widget build(BuildContext context) {
       return const MaterialApp(
        title: 'Todo List Provider',
        home: SplashPage(),
        
       );
  }
}