import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';

class HomeDrawer extends StatelessWidget {

  const HomeDrawer({ super.key });

   @override
   Widget build(BuildContext context) {
       return Drawer(
        child: ListView( //cria uma lista para ter rolamento
          children: [
            DrawerHeader( //cabeçalho do drawer
            decoration: BoxDecoration( //decoração do cabeçalho
              color: context.primaryColor.withAlpha(70), //cor do cabeçalho usando o contexto do tema (theme_extensions.dart com alpha 70 para transparencia
             ),
              child: Row(
                children: [
                  Selector<AuthProvider, String>( //
                    selector: (context, authProvider) => authProvider.user?.photoURL ??
                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSgbqsAZnSNW6PKkeYpi_qQ0RcMyzWSF6mizg&s', //seleciona a foto do usuário
                    builder: (_, value, __ ) {
                      return CircleAvatar( //cria um avatar circular
                        backgroundImage: NetworkImage(value), //imagem do avatar
                        radius: 30, //raio do avatar
                      );
                    },
                    ),
                  Expanded(//expande o widget até o final
                    child: Padding( //adiciona um padding
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Nome do usuario',
                        style: context.titleLarge,//estilo do texto que busca no arquivo theme_extensions.dart
                                              ),
                    ),
                  )
                ],
              ))
          ],
          
          ),
       );
       
  }
}