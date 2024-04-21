import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
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
                  child: IntrinsicHeight(//! ele pega o tamanho máximo do pai e passa para o filho
                    child: Column(
                      mainAxisSize: MainAxisSize.min,//!minimo de tamanho que ele pode ter
                      children:[
                        const SizedBox (height: 10,),//!dar espaço
                        const TodoListLogo(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20,), //!symetric para dar espaçamento horizontal e vertical
                          child: Form(child: Column(
                            children: [
                              TodoListField(label: 'E-mail',),
                              const SizedBox(height: 20,),
                              TodoListField(label: 'Senha', obscureText: true,),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: (){},
                                    child: const Text('Esqueceu a senha?'),
                                  ),
                                  ElevatedButton(
                                      onPressed: (){},
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ), 
                                    ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Login',
                                          style: TextStyle(color: Colors.white),),
                                      ),
                                  ),                                                                 ],
                              )
                            ],
                          ),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Expanded(
                          child: Container(
                          decoration: BoxDecoration(
                          color: const Color(0xffF0F3F7),
                          border: Border(
                            top: BorderSide(
                              width: 2,
                              color: Colors.grey.withAlpha(50),
                              ),
                              ),
                          ),
                          child: Column(children: [
                            const SizedBox(height: 30,),
                            SignInButton(
                              Buttons.google,
                              text: "Continue com Google",
                              padding: const EdgeInsets.all(5),
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none
                                ),
                              onPressed: (){},
                              ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Não tem conta?'),
                                TextButton(onPressed: (){
                                  Navigator.of(context).pushNamed('/register');//direcionando para a rota de registro
                                },
                                child: const Text('Cadastre-se'),
                                ),
                                ],
                            )
                          ],
                          ),
                          ),
                        ),
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