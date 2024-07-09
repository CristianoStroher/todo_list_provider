import 'dart:io';

import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/tasks_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';


class HomeController extends DefaultChangeNotifier {

  //cria uma variável do tipo TasksService para receber o serviço de tarefas
  final TasksService _tasksService; 
  var filterSelected = TaskFilterEnum.today; //cria uma variável do tipo TaskFilterEnum e atribui o valor today
  TotalTasksModel? todayTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas de hoje
  TotalTasksModel? tomorrowTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas de amanhã
  TotalTasksModel? weekTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas da semana

  //cria um construtor que recebe um parametro do tipo TasksService
  HomeController({ required TasksService tasksService })
   : _tasksService = tasksService; 

  
  // Chama três métodos assíncronos (_tasksService.getToday(), _tasksService.getTomorrow(), _tasksService.getWeek())
  // e espera até que todos eles sejam concluídos. O resultado é uma lista com os resultados dessas três chamadas.
  Future <void> loadTotalTasks() async {
    final allTasks = await Future.wait([
      _tasksService.getToday(),
      _tasksService.getTomorrow(),
      _tasksService.getWeek(),
    ]); //cria uma lista de tarefas que recebe as tarefas de hoje, amanhã e da semana mediante um objeto de tarefas

    // Converte os resultados de cada chamada para a lista de modelos de tarefas apropriada
    final todayTasks = allTasks[0] as List<TasksModel>; //cria uma variável que recebe a lista de tarefas de hoje
    final tomorrowTasks = allTasks[1] as List<TasksModel>; //cria uma variável que recebe a lista de tarefas de amanhã
    final weekTasks = allTasks[2] as WeekTaskModel; // cria uma variável que recebe um objeto de tarefas da semana

  //pega a variavel criada e atribui um objeto de tarefas totais para hoje
    todayTotalTasks = TotalTasksModel( //cria um objeto de tarefas totais para hoje
      totalTasks: todayTasks.length, //atribui o total de tarefas de hoje
      totalTasksFinish: todayTasks.where((task) => task.finished).length, //atribui o total de tarefas concluídas de hoje
    );
   //pega a variavel criada e atribui um objeto de tarefas totais para
    tomorrowTotalTasks = TotalTasksModel( //cria um objeto de tarefas totais para hoje
      totalTasks: tomorrowTasks.length, //atribui o total de tarefas de hoje
      totalTasksFinish: tomorrowTasks.where((task) => task.finished).length, //atribui o total de tarefas concluídas de hoje
    );

    //pega a variavel criada e atribui um objeto de tarefas totais para
    weekTotalTasks = TotalTasksModel( //cria um objeto de tarefas totais para hoje
      totalTasks: weekTasks.tasks.length, //atribui o total de tarefas de hoje
      totalTasksFinish: weekTasks.tasks.where((task) => task.finished).length, //atribui o total de tarefas concluídas de hoje
    );
    notifyListeners(); //notifica os ouvintes

  }

}