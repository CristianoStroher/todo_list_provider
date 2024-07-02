

import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';


class TodoCardFilter extends StatelessWidget {
  final String label; //cria uma variável do tipo String para
  // receber um label do widget hoje, amanha e semana. Vamos la substituir.

  final TaskFilterEnum taskfilter; //cria uma variável do tipo TaskFilterEnum
  //para receber um filtro de tarefas

  final TotalTasksModel?
      totalTasksModel; //cria uma variável do tipo TotalTasksModel

//construtor da classe
  const TodoCardFilter({
    Key? key,
    required this.label,
    required this.taskfilter,
    this.totalTasksModel,
  }) : super(key: key); //construtor da classe

  //método para calcular a porcentagem de tarefas finalizadas
  double _getPercentFinish() {
    final total = totalTasksModel?.totalTasks ?? 0.0; //pega o total de tarefas
    final totalfinish = totalTasksModel?.totalTasksFinish ?? 0.0; //

    if (total == 0.0) {
      return 0.0;
    }

    final percent = (totalfinish / total) *
        100; //calcula a porcentagem de tarefas finalizadas
    return percent / 100; //retorna a porcentagem de tarefas finalizadas
  }

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
          Text(
            // cria um texto
            label, //define o texto do widget
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            height: 5,
            child: TweenAnimationBuilder<double>(
                tween: Tween(
                  begin: 0.0, //define o valor inicial da animação
                  end: _getPercentFinish(), //define o valor final da animação
                ), //define a animação
                duration:
                    const Duration(seconds: 1), //define a duração da animação
                builder: (context, value, child) => LinearProgressIndicator(
                      //cria um indicador de progresso linear
                      value: value, //define o valor do indicador de progresso
                      backgroundColor: Colors
                          .yellow, //define a cor de fundo do indicador de progresso
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors
                          .white), //define a cor do indicador de progresso
                    )),
          ),
        ],
      ),
    );
  }
}
