// criamos aqui a interface informando os metodos que eles devem implementar
import 'package:sqflite/sqflite.dart';

abstract class Migration {

  //criamos os metodos que serão usadas em cada versão
  void create(Batch batch);
  void update(Batch batch);

}
