import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';

class CalendarButton extends StatelessWidget {

  const CalendarButton({ super.key });

   @override
   Widget build(BuildContext context) {
       return InkWell( //botão que simula um click
          onTap: () async{

            var lastDate = DateTime.now().add(const Duration(days: 10 * 365)); //variavel que recebe a data atual mais 10 x 365 dias

            final DateTime? selectedDate = await showDatePicker ( // cria uma variavel que recebe a data selecionada
              context: context, //contexto
              initialDate: DateTime.now(), //data inicial é a data atual	
              firstDate: DateTime(2000, 8), //data inicial é 2000
              lastDate: lastDate, //data final é o calculo acima.
            );
            //leitura do controller task e usar a função para
            // setar/alterar a data selecionada
            context.read<TasksCreateController>().selectedDate = selectedDate; 
          },
          borderRadius: BorderRadius.circular(30),
          child: Container(
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
          child: Row(
            mainAxisSize: MainAxisSize.min,//ajusta o tamanho do container
            children: [
              IconButton(
                icon: const Icon(Icons.today, color: Colors.grey,),
                onPressed: () {},
              ),
              const SizedBox(width: 5),
              Text('SELECIONE UMA DATA', style: context.titleStyle,),
              const SizedBox(width: 15),
            ],
          ),
         ),
       );
       
  }
}