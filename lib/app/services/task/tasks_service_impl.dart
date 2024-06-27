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
  
  
}



