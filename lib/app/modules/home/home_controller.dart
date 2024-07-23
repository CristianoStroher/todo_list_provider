import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/tasks_model.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/models/week_task_model.dart';
import 'package:todo_list_provider/app/services/task/tasks_service.dart';


class HomeController extends DefaultChangeNotifier {

  //cria uma variável do tipo TasksService para receber o serviço de tarefas
  final TasksService _tasksService; 
  var filterSelected = TaskFilterEnum.today; //cria uma variável do tipo TaskFilterEnum e atribui o valor today na inicialização
  TotalTasksModel? todayTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas totais/finalizadas de hoje
  TotalTasksModel? tomorrowTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas num total/finalizadas de amanhã
  TotalTasksModel? weekTotalTasks; //cria uma variável do tipo TotalTasksModel para receber as tarefas da semana
  List<TasksModel> alltasks = []; //cria uma lista de tarefas vazia para receber as tarefas
  List<TasksModel> filteredTasks = []; //cria uma lista de tarefas vazia para receber as tarefas filtradas
  DateTime? initialDateOfWeek; //cria uma variável do tipo DateTime para receber a data inicial da semana
  DateTime? selectedDay; //cria uma variável do tipo DateTime para receber a data selecionada
  bool showFinishedTasks = false; //!cria uma variável do tipo booleano para mostrar as tarefas finalizadas,
  //!por padrão ela é falsa, ou seja, não mostra as tarefas finalizadas

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

  //método para buscar as tarefas e atualizar a lista de tarefas
  Future<void> findTasks({required TaskFilterEnum filter}) async {
    filterSelected = filter; //atribui o filtro selecionado
    showLoading(); //mostra o loading caso demore a buscar as tarefas
    notifyListeners(); //notifica os ouvintes
    List<TasksModel> tasks; //cria uma lista de tarefas

    switch (filter) { //verifica o filtro selecionado
      case TaskFilterEnum.today: //caso seja hoje
        tasks = await _tasksService.getToday(); //busca as tarefas de hoje
        break;
      case TaskFilterEnum.tomorrow: //caso seja amanhã
        tasks = await _tasksService.getTomorrow(); //busca as tarefas de amanhã
        break;
      case TaskFilterEnum.week: //caso seja semana
        final weekModel = await _tasksService.getWeek(); //busca as tarefas da semana
        tasks = weekModel.tasks; //atribui as tarefas da semana
        /* tasks = await _tasksService.getWeek().then((value) => value.tasks); */ //busca as tarefas da semana
        initialDateOfWeek = weekModel.startDate; //atribui a data inicial da semana
        break; // mesma coisa de cima apresentado pelo chat gpt ( é menos entedivel)
    }

    filteredTasks = tasks; //atribui as tarefas filtradas
    alltasks = tasks; //atribui todas as tarefas

    //!corrigido o bug de não mostrar as tarefas da semana
    if(filter == TaskFilterEnum.week) { //verifica se o filtro é semana
      if(selectedDay != null) { //verifica se a data selecionada é diferente de nulo
        filterByDay(selectedDay!); //filtra as tarefas pela data selecionada
      } else if(initialDateOfWeek != null) { //verifica se a data inicial da semana é diferente de nulo
        filterByDay(initialDateOfWeek!); //filtra as tarefas pela data inicial da semana
      } 
    }else {
      selectedDay = null; //atribui nulo para a data selecionada
    }

    if(!showFinishedTasks) { //verifica se as tareras finalizadas não estão sendo mostradas
      filteredTasks = filteredTasks.where((task) => !task.finished).toList(); // o filterTasks recebe as tarefas
      //que não estão finalizadas através do método where onde a tarefa é diferente de finalizada.
    }

    hideLoading(); //esconde o loading
    notifyListeners(); //notifica os ouvintes
  
  }

  void filterByDay(DateTime date){
   selectedDay = date; //atribui a data selecionada
    filteredTasks = alltasks.where((task) => task.dateTime == date).toList(); //filtra as tarefas pela data selecionada
    notifyListeners(); //notifica os ouvintes
  }

  Future<void> refreshPage() async {
    await findTasks(filter: filterSelected); //chama o método para buscar as tarefas
    await loadTotalTasks(); //chama o método para carregar as tarefas totais
    notifyListeners(); //notifica os ouvintes
  }

  Future<void> checkOrUncheckTask(TasksModel task) async {
    showLoadingAndResetState(); //mostra o loading e reseta o estado
    notifyListeners(); //notifica os ouvintes

    final taskUpdated = task.copyWith(
      finished: !task.finished, //altera o estado da tarefa invertendo o valor
    ); //chama o método para marcar ou desmarcar a tarefa
    await _tasksService.checkOrUncheckTask(taskUpdated); //chama o método para atualizar a tarefa
    hideLoading(); //esconde o loading
    refreshPage(); //chama o método para atualizar a página
  }

  void showOrHidefinishedTasks() {
    showFinishedTasks = !showFinishedTasks; //filtra as tarefas que não estão finalizadas invertendo o valor
    refreshPage(); //chama o método para atualizar a página
  }

}