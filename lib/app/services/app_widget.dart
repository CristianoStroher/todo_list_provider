import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';

//! aqui vai ficar a implementação do nosso material app
//! mudamos agora para statefulwidget para suportar alteração da pagina
//! ao colocar o administrado de conexão com o banco de dados.
class AppWidget extends StatefulWidget {

  const AppWidget({ super.key });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {

//! Aqui inserimos o metodo e quando o app for inicializado ele vai
//!chamar o admin para obsevar a aplicação. Colocamos a variável para 
//! receber nosso admi
final sqliteAdmConnection = SqliteAdmConnection();
@override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(sqliteAdmConnection);
  }

  //! adicionamos o dispose para encerrar a observação apos realiza
  //! do método.
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance?.removeObserver(sqliteAdmConnection);
  }

   @override
   Widget build(BuildContext context) {
       return const MaterialApp(
        title: 'Todo List Provider',
        home: SplashPage(),
        
       );
  }
}