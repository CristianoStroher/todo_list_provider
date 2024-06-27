
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_page.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository_impl.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';
import 'package:todo_list_provider/app/services/task/tasks_service_impl.dart';

class TasksModule extends TodoListModule{

  TasksModule() : 
    super(
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
           TasksServiceImpl( tasksRepository: context.read()),
        ),

        //instanciando o TasksCreateController para ser usado no controller
        ChangeNotifierProvider(
          create: (context) =>
           TasksCreateController(taskService: context.read()),
        ),
      ],
      routers: {
        '/tasks/create': (context) => TasksCreatePage(
            controller: context.read(),),
      }
    );


  
}