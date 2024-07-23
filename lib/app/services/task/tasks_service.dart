import 'package:todo_list_provider/app/models/tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';

abstract interface class TasksService {
  
  Future<void> saveTask(DateTime data, String description);

  //criamos os metodos para buscar as tarefas por periodo
  Future<List<TasksModel>> getToday();
  Future<List<TasksModel>> getTomorrow();
  Future<WeekTaskModel> getWeek(); //criamos o metodo para buscar as tarefas da semana
  Future<void> checkOrUncheckTask(TasksModel task); //criamos o metodo para checar ou deschecar a tarefa


}