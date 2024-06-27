import 'package:flutter/material.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';
import 'package:todo_list_provider/app/modules/tasks/widget/calendar_button.dart';
import 'package:validatorless/validatorless.dart';

class TasksCreatePage extends StatelessWidget {

  // atributo para armazenar o controller
  final TasksCreateController _controller;
    // atributo para armazenar o titulo da task
  final descriptionEC = TextEditingController();

  TasksCreatePage({ super.key, required TasksCreateController controller }) :
   _controller = controller;
   
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false, //remove o botão de voltar
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.black              
                ),
                onPressed: () {
                  Navigator.of(context).pop(); //fecha a tela
                },
              )],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {},
              label: const Text('Salvar Task', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold),),
              backgroundColor: context.primaryColor,),
         body: Form(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //alinha o conteudo no centro
              crossAxisAlignment: CrossAxisAlignment.start, //alinha o conteudo no inicio
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Criar Task',
                    style: context.titleStyle.copyWith(
                      fontSize: 20,
                )),                   
                ),
                const SizedBox(height: 30),
                TodoListField(label: '',
                  controller: descriptionEC,
                  validator: Validatorless.required('Descrição obrigatória'),
                  ),
                const SizedBox(height: 20),
                const CalendarButton(),

                
                
              ],
            )
          ),),
       );
  }
}