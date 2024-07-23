import 'package:todo_list_provider/app/models/tasks_model.dart';

abstract interface class TasksRepository {

  //metodo para salvar tasks no repositorio 
  Future<void> saveTask(DateTime data, String description);

  //metodo para buscar todas as tasks pelo periodo, uma inicial e outra final
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end);

  //metodo para checar se a task finalizada
  Future<void> checkOrUncheckTask(TasksModel task);

}