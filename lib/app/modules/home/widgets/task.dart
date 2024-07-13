import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_provider/app/models/tasks_model.dart';

class Task extends StatelessWidget {
  final TasksModel model; //cria uma variável do tipo TasksModel para receber o modelo de tarefas.
  // Assim cada item de lista terá um modelo de tarefas
  final dateFormat = DateFormat('dd/MM/yyyy'); //cria uma variável do tipo DateFormat para formatar a data
  Task({ super.key, required this.model});

   @override
   Widget build(BuildContext context) {
       return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [ 
              BoxShadow(color: Colors.grey), //adiciona uma sombra no container
            ],),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: IntrinsicHeight(//cria um widget que serve para limitar o tamanho do widget na altura
            child: ListTile(//cria um item de lista
              contentPadding: const EdgeInsets.all(8),
              leading: Checkbox(
                value: model.finished, //adiciona um checkbox
                onChanged: (value) {}, //adiciona uma função para o checkbox
              ),
              title: Text(
                 model.description,
                 style: const TextStyle(
                  decoration: TextDecoration.lineThrough,//adiciona uma linha no texto
                  //! aqui vamos implementar assim false ? Textdecoartion.lineThrough : null,
                  //! para que a linha só apareça quando o checkbox for true
                  ),),
              subtitle: Text(
                dateFormat.format(model.dateTime), //adiciona a data formatada no item de lista
                style: const TextStyle(
                  decoration: TextDecoration.lineThrough,//adiciona uma linha no texto
                  //! aqui vamos implementar assim false ? Textdecoartion.lineThrough : null,
                  //! para que a linha só apareça quando o checkbox for true
                ),
                ),//adiciona um subtitulo no item de lista
                shape: RoundedRectangleBorder( //adiciona um formato no item de lista. Uma borda esfumaciado
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(width: 1), //adiciona uma borda arredondada no item de lista
                )
            ),),
       );
    
  }
}