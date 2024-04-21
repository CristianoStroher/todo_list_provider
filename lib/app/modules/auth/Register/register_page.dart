import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';

class RegisterPage extends StatelessWidget {

  const RegisterPage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            backgroundColor: Colors.white,
            title: Column( //!colocamos em coluna para ficar um em cima do outro
              crossAxisAlignment: CrossAxisAlignment.start, //!alinhamento do texto
              children: [
                Text(
                  'Todo List',
                  style: TextStyle(
                    color: context.primaryColor,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'Cadastro',
                  style: TextStyle(
                    color: context.primaryColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            automaticallyImplyLeading: false,//tira o botao voltar padrão
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context); //volta para a tela anterior                
              },
              icon: ClipOval( //deixa tudo oval e arredondado os cantos
                child: Container(
                  color: context.primaryColor.withAlpha(20),//pegou a cor do padrão do thema
                  padding: const EdgeInsets.all(8), //deixou o icone mais para dentro
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    size: 20,
                    color: context.primaryColor, ), //trocou o icone de voltar
                ),
              ),
            ),
           ),
            body: ListView( //para ter scroll e estrutura pronta
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5, //pegou 50% da tela
                  child: const FittedBox( //para ajustar o tamanho do logo/widget abaixo dele deixa ele adaptável a tela
                    fit: BoxFit.fitHeight,
                    child: TodoListLogo(),//chamou o logo
                ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20,),
                  child: Form(
                    child: Column(children: [
                      TodoListField(label: 'E-mail'),
                      const SizedBox(height: 20,),
                      TodoListField(label: 'Senha', obscureText: true,),
                      const SizedBox(height: 20,),
                      TodoListField(label: 'Confirmação de Senha', obscureText: true,),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Salvar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],),),
                )
              ],
            ),
       );
  }
}