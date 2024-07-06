import 'package:todo_list_provider/app/models/tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';

import './tasks_service.dart';

class TasksServiceImpl implements TasksService {

  //criamos um atributo privativo para receber o repositório da task e encapsular a variável
  final TasksRepository _tasksRepository;

  
  //construtor para receber o repositório da task e associar
  // a variável _tasksRepository que privativa e 
  TasksServiceImpl({required TasksRepository tasksRepository
  }) : _tasksRepository = tasksRepository; 


  //usamos o método saveTask da interface TasksService para salvar a task atraves de um arrow operator(flecha)
  @override
  Future<void> saveTask(DateTime data, String description) => _tasksRepository.saveTask(data, description);

  //usamos o método getToday da interface TasksService para implementar e buscar
  // as tarefas de hoje atraves de uma lista.
  @override
  Future<List<TasksModel>> getToday() {
    return _tasksRepository.findByPeriod(DateTime.now(), DateTime.now());
  }

  //usamos o método getTomorrow da interface TasksService para implementar
  // e buscar as tarefas de amanhã atraves de uma lista.
  @override
  Future<List<TasksModel>> getTomorrow() {
    var tomorrowDate = DateTime.now().add(const Duration(days: 1));
    return _tasksRepository.findByPeriod(tomorrowDate, tomorrowDate);
  }

  @override
  Future<WeekTaskModel> getWeek() async {
    final today = DateTime.now(); //pega a data de hoje
    var startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0); //cria um filtro de data inicial
    DateTime endFilter; // cria uma variável para a data final
    
    if (today.weekday != DateTime.monday) { //se a data de hoje não for segunda
      startFilter = startFilter.subtract( Duration(days: (startFilter.weekday - 1))); //subtrai um dia
    }
  
    endFilter = startFilter.add(const Duration(days: 6)); //adiciona 6 dias a data final
    final tasks = await _tasksRepository.findByPeriod(startFilter, endFilter); //busca as tarefas no banco de dados do filtro criado
    return WeekTaskModel(
      startDate: startFilter,
      endDate: endFilter,
      tasks: tasks,
      ); //retorna as tarefas da semana
  
  }

}





