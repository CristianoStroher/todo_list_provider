import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';
import 'package:todo_list_provider/app/modules/home/widgets/filters_home.dart';
import 'package:todo_list_provider/app/modules/home/widgets/header_home.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

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
              ), //cria um menu popup no appbar (itemBuilder é um metodo que criamos para criar os itens do menu
            ],
           ),
           floatingActionButton: FloatingActionButton( //cria um botão flutuante
              backgroundColor: context.primaryColor, //cor do botão flutuante
              onPressed: () {}, //cria uma função para o botão flutuante
              child: const Icon(Icons.add), 
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