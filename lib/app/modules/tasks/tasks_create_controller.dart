
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';

class TasksCreateController extends DefaultChangeNotifier {
  
  //para usar as funções das tasks precisamos ter conexão com
  // a service das tasks atraves do atributo
  TasksService _tasksService; 

  //outro atributo para armazenar a data selecionada
  DateTime? _selectedDate;

  //construtor para receber o serviço de tarefas e encapsular a classe
  TasksCreateController({required TasksService taskService
  }) : _tasksService = taskService; //construtor que recebe o serviço de tarefas

  //metodo set alterar a data atual selecionada e notificar os listeners
  set selectedDate(DateTime? selectedDate) {
    _selectedDate = selectedDate; //setar a data selecionada
    notifyListeners(); //notificar os listeners da alteração

  }

  //metodo para retornar a data selecionada usamos o get
  // para conseguir acessar o atributo
  DateTime? get selectedDate => _selectedDate;

  //metodo para salvar a tarefa
  Future<void> saveTask(String description) async {
    try {
      showLoadingAndResetState(); //mostra o loader e reseta o estado
      notifyListeners(); //notifica os listeners
      if(_selectedDate !=null) { //se a data for diferente de nulo
        await _tasksService.saveTask(_selectedDate!, description); //salva a tarefa
      } else  {
        setError('Data da task não informada'); //se não tiver data informada
      }
}  catch (e, s) {
  print(e);//imprime o erro
  print(s); //imprime o erro (caso tenha )
  setError('Erro ao salvar a tarefa'); //se der erro ao salvar a tarefa
    } finally {
      hideLoading(); //esconde o loader
      notifyListeners(); //notifica os listeners
}

  } 
} 