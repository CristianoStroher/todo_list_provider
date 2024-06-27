import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class CalendarButton extends StatelessWidget {

  const CalendarButton({ super.key });

   @override
   Widget build(BuildContext context) {
       return InkWell( //botão que simula um click
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