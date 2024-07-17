import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility( //widget que controla a visibilidade de um widget
      visible: context.select<HomeController, bool>((controller) => controller.filterSelected == TaskFilterEnum.week), //define se o widget é visivel ou não quando o filtro selecionado for semana
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'DIA DA SEMANA',
            style: context.titleStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 95,
            child: Selector<HomeController, DateTime>(
              selector: (context, controller) => controller.initialDateOfWeek ?? DateTime.now(),
              builder: (_, value, __) {
                return DatePicker( //cria um datepicker para selecionar a data
                  value, //data inicial do datepicker que é hoje
                  height: 2, //altura do datepicker
                  initialSelectedDate: value, //data inicial selecionada é o valor da data inicial da semana 
                  selectionColor: context.primaryColor, //cor da seleção do datepicker
                  selectedTextColor: Colors.white, //cor do texto selecionado
                  locale: 'pt_BR', //linguagem do datepicker que é br 
                  daysCount: 7, //quantidade de dias que o datepicker vai mostrar
                  monthTextStyle: const TextStyle(fontSize: 8), //estilo do texto do mês 
                  dayTextStyle: const TextStyle(fontSize: 13), //estilo do texto do dia
                  dateTextStyle: const TextStyle(fontSize: 13), //estilo do texto da data
                           
                );
              },)
      
          )
        ],
      ),
    );
  }
}
