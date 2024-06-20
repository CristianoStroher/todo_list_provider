import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/modules/tasks/tasks_create_controller.dart';

class TasksCreatePage extends StatelessWidget {

  TasksCreateController _controller;

  TasksCreatePage({ super.key, required TasksCreateController controller }) :
   _controller = controller;
   
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Task'),),
           body: Container(),
       );
  }
}