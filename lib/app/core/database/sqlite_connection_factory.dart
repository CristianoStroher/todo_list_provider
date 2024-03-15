
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_list_provider/app/core/database/sqlite_migration_factory.dart';

//! Na pasta CORE guardamos as informações, componentes genéricos e utilitarios
class SqliteConnectionFactory {

  //varias para versao e nome do banco de dados 
  static const _VERSION = 1;
  static const _DATABASE_NAME = 'TODO_LIST_PROVIDER';

  //instância única da classe com nome de _instance que será usada no sistema com um todo
  static SqliteConnectionFactory? _instance;

  //um atributo opcional para receber um controlador do banco de dados.
  Database? _db;
  //Lock é para trabalhar com multitred configurando concorrência de chamadas.
  final _lock = Lock();
  
  //construtor privada
  SqliteConnectionFactory._();


  // contruror factory para ele controlar a instância
  // usando o ware operator para verificar se _instance for nullo vai chamar
  // o construtor privado SqliteconnectionFactory._(); 
  // o operador ??= verifica se resultado é null. Se for, então atribui o valor à direita à variável.
  // Se resultado não for null, ele permanece inalterado.
  factory SqliteConnectionFactory() => _instance ??= SqliteConnectionFactory._();
  
  //metodo para abrir conexao com o DataBase
  Future<Database> openConnection() async {
      var databasePath = await getDatabasesPath();
      var databasePathFinal = join(databasePath, _DATABASE_NAME);
      if(_db == null) {
        await _lock.synchronized(() async {
          //usei aware operator para dizer que se o banco de dados for nulo entao abra a
          // conexao com banco de dados.
          _db ??= await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDowngrade);
        });
      }
      return _db!;
  }

  // metodo para fechar a conexão quando for aberta.
  void closeConnection(){
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = on'); // vincular as chaves estrangeiras
  }
  Future<void> _onCreate(Database db, int version) async {
    // instanciamos e comitamos a migration
    final batch = db.batch();
    //tmabém precisamos recuperar nossas migrations
    final migrations = SqliteMigrationFactory().getCreateMigration();
    // passamos pela lista exceutando cada versão de create criado.
    for(var migration in migrations) {
      migration.create(batch);
    }
    batch.commit();
  }
  Future<void> _onUpgrade(Database db, int oldVersion,int version) async {
    final batch = db.batch();
    //tmabém precisamos recuperar nossas migrations
    final migrations = SqliteMigrationFactory().getUpdateMigration(oldVersion);
    // passamos pela lista exceutando cada versão de create criado.
    for(var migration in migrations) {
      migration.update(batch);
    }
    batch.commit();
  }
  Future<void> _onDowngrade(Database db, int oldVersion,int version) async {}

}