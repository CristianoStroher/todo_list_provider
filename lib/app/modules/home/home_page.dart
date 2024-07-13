import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';

import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/models/task_filter_enum.dart';
import 'package:todo_list_provider/app/modules/home/home_controller.dart';
import 'package:todo_list_provider/app/modules/home/widgets/filters_home.dart';
import 'package:todo_list_provider/app/modules/home/widgets/header_home.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';

import 'package:todo_list_provider/app/modules/tasks/tasks_module.dart';

class HomePage extends StatefulWidget {

  final HomeController _homeController;

  const HomePage({ Key? key, required HomeController homeController}) :
    _homeController = homeController, //cria um construtor para a classe HomePage
    super(key: key); //cria um construtor para a classe HomePage

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
   super.initState();
   //cria um listener para o homeController usando o DefaultListenerNotifier com a função listener
   DefaultListenerNotifier(changeNotifier: widget._homeController).listener( 
    context: context, //contexto da tela
    sucessCallback: (notifier, listenerInstance) { //callback de sucesso
      listenerInstance.dispose(); //remove o listener
    },
    ); 
    //cria uma instancia do listenerNotifier para o homeController e chama o listener para mostrar o loader
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) { //
      widget._homeController.loadTotalTasks(); //chama o método para carregar as tarefas depois que a tela é construída
      widget._homeController.findTasks(filter: TaskFilterEnum.today); //chama o método para buscar as tarefas do dia atual depois que a tela é construída
    });
    } 
  
  

  void _gotoCreateTask( BuildContext context) {
    //  Navigator.of(context).pushNamed('/tasks/create'); //vai para a pagina de criar tarefa
    Navigator.of(context).push(
      PageRouteBuilder( //cria uma rota para ir para a pagina de criar task
        transitionDuration:const Duration(milliseconds: 400), //duração da transição da pagina
        transitionsBuilder: (context, animation, secundaryAnimation, child) { //cria uma animação na transição da pagina
          animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut); //cria uma curva de animação
          return ScaleTransition(scale: animation, alignment: Alignment.bottomRight, //cria uma anim
          child: child,);//adiciona uma animação na transição da pagina
        },
        pageBuilder: (context, animation, secundaryAnimation) {
          return TasksModule().getPage('/tasks/create', context);
        },
      ),
        ); //vai para a pagina de criar task
      // MaterialPageRoute(
      // builder: (_) => TasksModule().getPage('/task/create', context),));  //vai para a pagina de criar task 
  }  
  //cria uma função para ir para a pagina Task
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            iconTheme: IconThemeData(color: context.primaryColor), //insere um icone no appbar e muda a cor dele
            backgroundColor: const Color(0xFFFAFBFE), //cor do appbar branco 
            elevation: 0, //elevação do appbar retirdo que davá uma sombra
            actions: [
              PopupMenuButton( //cria um menu popup no appbar para filtrar as tarefas
                icon: const Icon(TodoListIcons.filter), //pegamos o icone do filter atraves do arquivo todo_list_icons.dart
                itemBuilder: (_) => [ // cria os itens do menu
                  const PopupMenuItem<bool>(child: Text('Mostrar tarefas concluídas'), //cria um item do menu
                  ),
                ],
              ),
               //cria um menu popup no appbar (itemBuilder é um metodo que criamos para criar os itens do menu
            ],
           ),
           floatingActionButton: FloatingActionButton( //cria um botão flutuante
              backgroundColor: context.primaryColor, //cor do botão flutuante
              onPressed: () {
                _gotoCreateTask(context); //chama a função para ir para a pagina Task 
              }, //cria uma função para o botão flutuante
              child: const Icon(Icons.add, color: Colors.white,), 
           ),
           backgroundColor: const Color(0xFFFAFBFE), //cor de fundo do scaffold
           drawer: HomeDrawer(), //adiciona o drawer que é um widget que criamos separado
           body: LayoutBuilder( //cria um layout builder para ter o controle do tamanho do widget
            builder: (context, contraints) { //cria o builder do layout builder
              return SingleChildScrollView( //cria um scroll na tela
                child: ConstrainedBox( //esse widget serve para limitar o tamanho do widget
                  constraints: BoxConstraints( //cria uma caixa de contraints para limitar o tamanho do widget
                    minHeight: contraints.maxHeight, //tamanho minimo do widget é o tamanho maximo do widget
                    minWidth: contraints.maxWidth, //tamanho minimo do widget é o tamanho maximo do widget
                  ),
                  child: Container( 
                    margin: const EdgeInsets.symmetric(horizontal: 20,), //adiciona uma margem no container
                    child: const IntrinsicHeight( //cria um widget que serve para limitar o tamanho do widget na altura
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //alinhamento do widget para a esquerda
                        children: [
                          HeaderHome(), //adiciona o header_home que é um widget que criamos separado
                          FiltersHome(),//adiciona o filters_home que é um widget que criamos separado
                          HomeWeekFilter(),//adiciona o home_week_filter que é um widget que criamos separado 
                          HomeTasks(),//adiciona o home_tasks que é um widget que criamos separado
                        ],
                      ),) 
                  ) ,
                ),
              );
            },
           ),
           
            );
  }
}