
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

//aqui é modulos nosso que criamos que precisamos das rotas e das dependencias das rotas.
abstract class TodoListModule {

  final Map<String, WidgetBuilder> _routers;
  final List<SingleChildWidget>? _bindings;

  //construtor das variaveis acima
  TodoListModule({
    required Map<String, WidgetBuilder> routers,
    List<SingleChildWidget>? bindings
    }) : _routers = routers, _bindings = bindings;

    //metodo get para declarar dentro do material app transfornado um map em outro map para inserir
    // a paginas dentro do todo_list_page
    Map<String, WidgetBuilder> get routers {
      return _routers.map((key, pageBuilder) => MapEntry(key, (_)=>TodoListPage(
        bindings: _bindings,
        page: pageBuilder,)));

  } 

  //metodo para pegar a pagina e o contexto que vai ser passado para a pagina
  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routers[path]; //pega a rota
    if(widgetBuilder != null) { //se a rota existir
      return TodoListPage( //retorna a pagina
        bindings: _bindings, //passa as dependencias
        page: widgetBuilder); //passa a pagina
      
    }
    throw Exception('Rota não encontrada');
  }
  
}