
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

//criamos essa classe que é mixiun de widgetsbindingObserver que
// vai observar o sistema com um todo
class SqliteAdmConnection with WidgetsBindingObserver{
  //nesse metodo ele vai dar opções do que o usuario fez na aplicção
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    final connection = SqliteConnectionFactory(); 

    switch(state) {
      case AppLifecycleState.resumed:
      break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        connection.closeConnection();
        break;
        
    }
    
    super.didChangeAppLifecycleState(state);
  }
  
}