
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/home_page.dart';

class HomeModule extends TodoListModule {

  HomeModule() : super (
     bindings: [ ChangeNotifierProvider( //cria um provider para o ChangeNotifier
        create: (context) => HomeController()), //lista de bindings que serve para injetar dependências

     ], //lista de bindings que serve para injetar dependências
    routers: {
      '/home': (context) => const HomePage(), //rota para a Home Page
    }
  );

  
}