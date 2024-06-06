import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {

  final nameVN = ValueNotifier<String>(''); //cria um value notifier para o nome do usuario

  HomeDrawer({ super.key });

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
                  Selector<AuthProvider, String>( //seleciona o valor do usuario
                    selector: (context, authProvider) {
                      return authProvider.user?.photoURL ??
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png';//seleciona a imagem do usuario ou uma imagem padrão
                    },
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
                      child: Selector<AuthProvider, String> (
                          selector: (context, authProvider) {
                            return authProvider.user?.displayName ?? 'Não Informado'; //seleciona o nome do usuario ou um nome padrão
                          },
                          builder: (_, value, __) { //cria o texto do nome do usuario
                            return Text(
                              value, //valor do nome do usuario que ele pega no cadastro do google
                              style: context.titleLarge, //estilo do texto que busca no arquivo theme_extensions.dart
                            );
                        }),
                    ),
                  )
                ],
              )),
              ListTile( //cria um item da lista
                title: const Text('Alterar Nome'), //texto do item
                onTap: () { //ação ao clicar no item
                  showDialog(context: context, builder: (_) { // abre um dialog para alterar o nome
                      return AlertDialog(
                        title: const Text('Alterar Nome'), //titulo do dialog
                        content:  TextField( //campo de texto para digitar o nome
                          decoration:  const InputDecoration(labelText: 'Nome'), //texto de dica do campo
                          onChanged: (value) => nameVN.value = value, //quando o texto é alterado ele atualiza o value notifier
                        ),
                        actions: [
                          TextButton( //botão de cancelar
                            onPressed: () => Navigator.of(context).pop(), //fecha o dialog
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(color: Colors.red),), //texto do botão
                          ),
                          TextButton( //botão de salvar
                            onPressed: () async { //ação ao clicar no botão
                              final nameValue = nameVN.value; //pega o valor do value notifier
                              if(nameValue.isNotEmpty) {
                               Messages.of(context)
                                    .showError('Nome Obrigatório'); //se o campo de texto estiver vazio ele mostra uma mensagem de erro
                              } else {
                                await context.read<UserService>().updateDisplayName(nameValue); //se não ele chama a função de alterar o nome do auth_provider.dart
                                  Navigator.of(context).pop();//fecha dialog
                              }
                            },
                            child: const Text('Alterar'), //texto do botão
                          )
                        ],
                      );
                  });
                },
              ),
              ListTile( //cria um item da lista
                title: const Text('Sair'), //texto do item
                onTap: () { //ação ao clicar no item
                  context.read<AuthProvider>().logout(); //chama a função de logout do auth_provider.dart
                },
              )
          ],
          
          ),
       );
       
  }
}