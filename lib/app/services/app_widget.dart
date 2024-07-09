import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_list_provider/app/core/database/sqlite_adm_connection.dart';
import 'package:todo_list_provider/app/core/navigator/todol_list_navigator.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_ui_config.dart';
import 'package:todo_list_provider/app/modules/auth/auth_module.dart';
import 'package:todo_list_provider/app/modules/home/home_module.dart';
import 'package:todo_list_provider/app/modules/splash/splash_page.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

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
    WidgetsBinding.instance.addObserver(sqliteAdmConnection); // Tinha instance?
  }

  //! adicionamos o dispose para encerrar a observação apos realiza
  //! do método.
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(sqliteAdmConnection); //! tinha ? no instance
  }

   @override
   Widget build(BuildContext context) {
       return MaterialApp(
        title: 'Todo List Provider',
        // initialRoute: '/login', //rota inicial para o login
        theme: TodoListUiConfig.theme,//!vinculei o tema ao app personalizado
        navigatorKey: TodolListNavigator.navigatorKey, //!vinculei a chave do navigator ao app
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [ //adiciona o suporte a localização
          Locale('pt', 'BR'), //adiciona a localização pt-br
        ],
        routes: {
          ...AuthModule().routers,//adiciona as rotas do AuthModule
          ...HomeModule().routers, //!adiciona as rotas do HomeModule
          ...TasksModule().routers, //!adiciona as rotas do TasksModule
        },
        home: const SplashPage(),
        
        
       );
       
  }
  
}