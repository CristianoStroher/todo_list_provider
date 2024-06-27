import 'package:sqflite/sqflite.dart';
import 'package:todo_list_provider/app/core/database/sqlite_connection_factory.dart';
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

}