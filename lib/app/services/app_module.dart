import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/services/app_widget.dart';

//! fica aqui as configurações genéricas da aplicação e tudo que for compartilhado pela
//! aplicação toda. classes que vão ser compartilhadas por vários módulos
class AppModule extends StatelessWidget {

  const AppModule({ super.key });

   @override
   Widget build(BuildContext context) {
       return MultiProvider(
        providers: [
          Provider(
            create: (_) => SqliteConnectionFactory(),
            lazy: false, //quando cria a aplicação ja instancia e cria a estrutura da migration
            )         
        ],
        child: const AppWidget(),
       );
       
  }
}