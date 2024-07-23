import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
import 'package:todo_list_provider/app/models/tasks_model.dart';
import 'package:todo_list_provider/app/repositories/tasks/tasks_repository.dart';


//subscrevemos o metodo saveTask da interface TasksResository para salvar no banco de dados
class TasksRepositoryImpl implements TasksRepository {

  //atributo para receber a conexão com o banco de dados e usar os metodos daquela classe que criamos anteriormente
  final SqliteConnectionFactory _sqliteConnectionFactory;

  //construtor para receber a conexão com o banco de dados onde associamos a variável
  // _sqliteConnectionFactory visto que é uma variável privada.
  TasksRepositoryImpl({required SqliteConnectionFactory sqliteConnectionFactory
  }) : _sqliteConnectionFactory = sqliteConnectionFactory;


  @override
  Future<void> saveTask(DateTime data, String description) async {
    //abrimos a conexão com o banco de dados utilizando a função openConnection da classe SqliteConnectionFactory
    final connection = await _sqliteConnectionFactory.openConnection();
    await connection.insert(
      'todo',
      {
        'id': null, //porque ele autoincremental
        'descricao': description, //recebe a descrição
        'data_hora': data.toIso8601String(), //converte a data para string
        'finalizado': 0, //por padrão é 0 que é false
      },
      conflictAlgorithm: ConflictAlgorithm.replace, //caso tenha conflito ele substitui
    );

    
  }
  //subscrevemos o metodo findByPeriod da interface TasksResository para buscar no banco de dados
  @override
  Future<List<TasksModel>> findByPeriod(DateTime start, DateTime end) async {
  final sartFilter = DateTime(start.year, start.month, start.day, 0,0,0); //cria um filtro de data inicial 
  final endFilter = DateTime(end.year, end.month, end.day, 23,59,59); //cria um filtro de data final
  
  final conn = await _sqliteConnectionFactory.openConnection(); //abre a conexão com o banco de dados
  //faz a query no banco de dados
  final result = await conn.rawQuery(''' 
      SELECT *
       FROM todo
       WHERE data_hora BETWEEN ? AND ?
       ORDER BY data_hora
       ''', [
        sartFilter.toIso8601String(), //converte a data inicial para string
        endFilter.toIso8601String()], //converte a data final para string
  ); //faz a query no banco de dados

  //retorna a lista de tarefas numa lista de TasksModel
  // usando a fabrica de tarefas do arquivo tasks_model.dart
  return result.map((e) => TasksModel.loadFromDB(e)).toList(); //retorna a lista de tarefas
  
  
  }
  //subscrevemos o metodo checkOrUncheckTask da interface TasksResository para checar no banco de dados
  @override
  Future<void> checkOrUncheckTask(TasksModel task) async {
    final conn =await _sqliteConnectionFactory.openConnection(); //abre a conexão com o banco de dados
    final finished = task.finished ? 1 : 0; //se a tarefa for finalizada recebe 1 senão 0

  //atualiza a tarefa no banco de dados e seta o valor de finalizado
    await conn.rawUpdate('''
      UPDATE todo
      SET finalizado = ?
      WHERE id = ?
    ''', [finished, task.id]);
  
  }
  

}