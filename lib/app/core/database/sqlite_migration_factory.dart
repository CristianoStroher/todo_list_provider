
import 'package:todo_list_provider/app/core/database/migrations/migration.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v1.dart';
import 'package:todo_list_provider/app/core/database/migrations/migration_v2.dart';

class SqliteMigrationFactory {

  // na factori vamos criar dois metodos para buscar as versões da 
  //migration e usar no SQLITE_CONECTION_FACTORY retornando uma lista de cada
  List<Migration> getCreateMigration() => [
    MigrationV1(),
    MigrationV2(),
  ];
  List<Migration> getUpdateMigration(int version) {
    final migrations = <Migration>[];

    if(version == 1) {
      migrations.add(MigrationV2());
    }

    return migrations;

  }
  
}