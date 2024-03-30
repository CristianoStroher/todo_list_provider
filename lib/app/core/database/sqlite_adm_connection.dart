
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';

//criamos essa classe que é mixiun de widgetsbindingObserver que
// vai observar o sistema com um todo
class SqliteAdmConnection with WidgetsBindingObserver{
  // Este é um método sobrescrito da classe WidgetsBindingObserver.
  // Ele é chamado sempre que o estado do ciclo de vida do aplicativo muda.
  // O parâmetro state contém o novo estado do aplicativo.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    //Nesta linha, uma instância da classe SqliteConnectionFactory é criada.
    // Presumo que esta classe seja responsável por gerenciar a conexão
    //com um banco de dados SQLite.  
    final connection = SqliteConnectionFactory(); 
    //Aqui, um switch-case é usado para determinar a ação apropriada
    // com base no estado do ciclo de vida do aplicativo.
    // Se o estado for paused ou hidden, o método closeConnection()
    // da instância connection será chamado para fechar a conexão
    // com o banco de dados. Isso geralmente é feito para liberar
    // recursos quando o aplicativo é pausado ou oculto.
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
    //Finalmente, a chamada para o método didChangeAppLifecycleState
    // da superclasse é feita para garantir que o comportamento padrão
    //associado a esse método seja mantido.
    super.didChangeAppLifecycleState(state);
  }
  
}