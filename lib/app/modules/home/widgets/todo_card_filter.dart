import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class TodoCardFilter extends StatelessWidget {

  const TodoCardFilter({ super.key });

   @override
   Widget build(BuildContext context) {
       return Container(
        constraints: const BoxConstraints(
          minHeight: 120,
          minWidth: 150,
        ),
        margin: const EdgeInsets.only(right: 10), //adiciona uma margem no container
        decoration: BoxDecoration(
          color: context.primaryColor, //muda a cor do container para a cor primária do tema
          borderRadius: BorderRadius.circular(10), //borda arredondada
          boxShadow: [ //adiciona uma sombra no container
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //cor da sombra
              spreadRadius: 1, //raio de espalhamento da sombra 
              blurRadius: 7, //raio de desfoque da sombra
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
       );
   }
}