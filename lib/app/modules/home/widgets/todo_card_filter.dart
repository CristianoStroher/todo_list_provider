import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/widgets/task.dart';

class TodoCardFilter extends StatelessWidget {

  final String label; //cria uma variável do tipo String para
  // receber um label do widget hoje, amanha e semana. Vamos la substituir.
  
  final TaskFilterEnum taskfilter; //cria uma variável do tipo TaskFilterEnum
  //para receber um filtro de tarefas

  final TotalTasksModel? totalTasksModel; //cria uma variável do tipo TotalTasksModel

  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskfilter,
    this.totalTasksModel,
    }) : super(key: key); //construtor da classe
    
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 120,
        minWidth: 150,
      ),
      margin:
          const EdgeInsets.only(right: 10), //adiciona uma margem no container
      padding: const EdgeInsets.all(20), //adiciona um padding no container
      decoration: BoxDecoration(
        color: context
            .primaryColor, //muda a cor do container para a cor primária do tema
        border: Border.all(
          width: 1, //muda a largura da borda do container para 1
          color: Colors.grey.withOpacity(
              .8), //muda a cor da borda do container para cinza esfumaçado
        ), //adiciona uma borda no container
        borderRadius:
            BorderRadius.circular(20), //adiciona um raio de borda no container
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, //alinhamento do widget para a esquerda
        children: [
          Text(
            '${totalTasksModel?.totalTasks ?? 0} TASKS', //cria um texto
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          Text( // cria um texto
            label, //define o texto do widget
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          const SizedBox(
            width: 100, 
            height: 5,
            child: LinearProgressIndicator( //cria um indicador de progresso linear
              value: .4, //define o valor do indicador de progresso
              backgroundColor: Colors.yellow, //define a cor de fundo do indicador de progresso
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white), //define a cor do indicador de progresso
              ),
          ),
        ],
      ),
    );
  }
}
