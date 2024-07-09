import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';


class HomeController extends DefaultChangeNotifier {

  //cria uma variável do tipo TasksService para receber o serviço de tarefas
  final TasksService _tasksService; 

  //cria um construtor que recebe um parametro do tipo TasksService
  HomeController({ required TasksService tasksService})
   : _tasksService = tasksService; 

  var filterSelected = TaskFilterEnum.today; //cria uma variável do tipo TaskFilterEnum e atribui o valor today
  
}