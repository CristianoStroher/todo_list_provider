import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';


class HeaderHome extends StatelessWidget {

  const HeaderHome({ super.key });

   @override
   Widget build(BuildContext context) {
       return const Row(
        children: [
          Text(
            'Bem vindo, Cristiano Stroher',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF263238),
            ),
          ),

        ],


       );
  }
}