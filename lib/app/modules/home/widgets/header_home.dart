import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';

class HeaderHome extends StatelessWidget {

// essa classe é um widget que cria um texto de boas vindas na tela inicial do app
  const HeaderHome({ super.key });

   @override
   Widget build(BuildContext context) {
       return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Selector<AuthProvider, String>( //esse widget serve para pegar um valor do provider e atualizar o widget quando esse valor mudar
              selector: (context, authProvider) => authProvider.user?.displayName ?? "Não Informado", //esse é o valor que vamos pegar do provider
              builder: (_, value, __) { //esse é o builder que vai criar o widget
              return const Text( //cria um texto
                  'Bem vindo, Cristiano',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF263238),
                  ),
                );
            },           
                     ),
          );


       
  }
}