import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/models/total_tasks_model.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/todo_card_filter.dart';
class FiltersHome extends StatelessWidget {
  const FiltersHome({super.key});

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
            SingleChildScrollView( //cria um scroll na tela
            scrollDirection: Axis.horizontal,
            child: Row( //cria uma linha de widgets
              children: [
                TodoCardFilter(
                  label: 'Hoje'.toUpperCase(), //define o texto do widget
                  taskfilter: TaskFilterEnum.today, //enum do filtro de tarefas
                  totalTasksModel:
                    context.select<HomeController, TotalTasksModel?>(
                      (controller) => controller.todayTotalTasks), //cria um objeto do tipo TotalTasksModel
                  selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.today, //verifica se o filtro selecionado é o de hoje
                  ), //adiciona o todo_card_filter que é um widget que criamos separado
                TodoCardFilter(
                  label: 'Amanhã'.toUpperCase(),
                  taskfilter: TaskFilterEnum.tomorrow,
                  totalTasksModel: context.select<HomeController, TotalTasksModel?>(
                      (controller) => controller.tomorrowTotalTasks),
                  selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.tomorrow,
                  ),
                TodoCardFilter(
                  label: 'Semana'.toUpperCase(),
                  taskfilter: TaskFilterEnum.week,
                  totalTasksModel: context.select<HomeController, TotalTasksModel?>(
                      (controller) => controller.weekTotalTasks),
                  selected: context.select<HomeController, TaskFilterEnum>((value) => value.filterSelected) == TaskFilterEnum.week,
                ),
                      
                
                
              ],
            ),
          ),
        ],
       );
  }
}