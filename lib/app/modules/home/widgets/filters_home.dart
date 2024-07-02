import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
class FiltersHome extends StatelessWidget {
    @override
   Widget build(BuildContext context) {
       return Column(
        crossAxisAlignment: CrossAxisAlignment.start,//alinhamento do widget para a esquerda
        children: [
          Text(
            'FILTROS',
            style: context.titleStyle,//estilo do texto
            ),
          const SizedBox(height: 10,),//adiciona um espaço entre os widgets
           const SingleChildScrollView( //cria um scroll na tela
            scrollDirection: Axis.horizontal,
            child: Row( //cria uma linha de widgets
              children: [
                TodoCardFilter(
                  label: 'Hoje',
                  ), //adiciona o todo_card_filter que é um widget que criamos separado
                TodoCardFilter(
                  label: 'Amanhã',
                  ),
                TodoCardFilter(
                  label: 'Semana',
                ),
                      
                
                
              ],
            ),
          ),
        ],
       );
  }
}