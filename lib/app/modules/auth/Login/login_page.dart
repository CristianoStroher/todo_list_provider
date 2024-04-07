import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class LoginPage extends StatelessWidget {

  const LoginPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
          body: LayoutBuilder( //! pega tamanho máximo de cada tela
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints( //! muito parecido com o container contudo ele da mais funções.
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: const IntrinsicHeight(//! ele pega o tamanho máximo do pai e passa para o filho
                    child: Column(
                      mainAxisSize: MainAxisSize.min,//!minimo de tamanho que ele pode ter
                      children:[
                        SizedBox (height: 10,),//!dar espaço
                        TodoListLogo(),
                      ],
                    
                    ),
                  ),
                ),
              );
            },
          ),
       );
  }
}