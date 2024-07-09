
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/home_page.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';
import 'package:todo_list_provider/app/services/task/tasks_service_impl.dart';

class HomeModule extends TodoListModule {
  HomeModule()
      : super(
            bindings: [
              //instanciando o TasksRepositoryImpl para ser usado no controller
              // e no provider para ser usado no banco de dados
              Provider<TasksRepository>(
                create: (context) => TasksRepositoryImpl(
                  sqliteConnectionFactory: context.read(),
                ),
              ),

              //instanciando o TasksServiceImpl para ser usado no controller
              Provider<TasksService>(
                create: (context) =>
                    TasksServiceImpl(tasksRepository: context.read()),
              ),

              ChangeNotifierProvider(
                  //cria um provider para o ChangeNotifier
                  create: (context) => HomeController(
                      tasksService: context
                          .read())), //lista de bindings que serve para injetar dependências
            ], //lista de bindings que serve para injetar dependências
            routers: {
              '/home': (context) => HomePage(homeController: context.read(),), //rota para a Home Page
            });
}
