import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeWeekFilter extends StatelessWidget {
  const HomeWeekFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: DatePicker( //cria um datepicker para selecionar a data
            DateTime.now(), //data inicial do datepicker que é hoje
            initialSelectedDate: DateTime.now(), //data inicial selecionada que é hoje
            selectionColor: context.primaryColor, //cor da seleção do datepicker
            selectedTextColor: Colors.white, //cor do texto selecionado
            locale: 'pt_BR', //linguagem do datepicker que é br 
            daysCount: 7, //quantidade de dias que o datepicker vai mostrar
            monthTextStyle: const TextStyle(fontSize: 8), //estilo do texto do mês 
            dayTextStyle: const TextStyle(fontSize: 13), //estilo do texto do dia
            dateTextStyle: const TextStyle(fontSize: 13), //estilo do texto da data
            onDateChange: (date) { //metodo que é chamado quando a data é alterada
              // New date selected
            },

          ),

        )
      ],
    );
  }
}
