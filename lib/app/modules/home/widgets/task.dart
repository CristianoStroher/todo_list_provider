import 'package:flutter/material.dart';

class Task extends StatelessWidget {

  const Task({ super.key });

   @override
   Widget build(BuildContext context) {
       return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [ 
              BoxShadow(color: Colors.grey), //adiciona uma sombra no container
            ],),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: IntrinsicHeight(//cria um widget que serve para limitar o tamanho do widget na altura
            child: ListTile(//cria um item de lista
              contentPadding: const EdgeInsets.all(8),
              leading: Checkbox(
                value: true, //adiciona um checkbox
                onChanged: (value) {}, //adiciona uma função para o checkbox
              ),
              title: const Text(
                'Descrição da Tarefa',
                 style: TextStyle(
                  decoration: TextDecoration.lineThrough,//adiciona uma linha no texto
                  //! aqui vamos implementar assim false ? Textdecoartion.lineThrough : null,
                  //! para que a linha só apareça quando o checkbox for true
                  ),),
              subtitle: const Text(
                '10/10/2021',
                style: TextStyle(
                  decoration: TextDecoration.lineThrough,//adiciona uma linha no texto
                  //! aqui vamos implementar assim false ? Textdecoartion.lineThrough : null,
                  //! para que a linha só apareça quando o checkbox for true
                ),
                ),//adiciona um subtitulo no item de lista
                shape: RoundedRectangleBorder( //adiciona um formato no item de lista. Uma borda esfumaciado
                  borderRadius: BorderRadius.circular(20),
                  side: const BorderSide(width: 1), //adiciona uma borda arredondada no item de lista
                )
            ),),
       );
    
  }
}