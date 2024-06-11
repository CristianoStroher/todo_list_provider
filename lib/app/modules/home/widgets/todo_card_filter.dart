import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatelessWidget {
  const TodoCardFilter({super.key});

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
            '10 TASKS',
            style: context.titleStyle.copyWith(
              fontSize: 10,
              color: Colors.white,
            ),
          ),
          const Text( // cria um texto
            'HOJE',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          LinearProgressIndicator( //cria um indicador de progresso linear
            value: 0.4,
            backgroundColor: context.primaryColorLight,
            valueColor: const AlwaysStoppedAnimation<Color>( //muda a cor do indicador de progresso
              Colors.white,),), 
        ],
      ),
    );
  }
}
