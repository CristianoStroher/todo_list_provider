import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:todo_list_provider/app/core/notifier/default_listener_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/Login/login_controller.dart';
import 'package:validatorless/validatorless.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();//chave para o formulario
  final _emailEC = TextEditingController();//controlador para o campo de email
  final _passwordEC = TextEditingController(); //controlador para o campo de senha
  final _emailFocus = FocusNode(); //focus node para o campo de senha

  @override
  void initState() {
    super.initState(); //
    DefaultListenerNotifier(changeNotifier: context.read<LoginController>())
      .listener(
        context: context,
        everCallback: (notifier, listenerInstance) {
          if(notifier is LoginController){
            if(notifier.hasInfo){
              Messages.of(context).showInfo(notifier.infoMessage!);//mostra a mensagem de informação
            }
          } 
        },
        sucessCallback: (notifier, listenerInstance) {
          print('Logado com sucesso');//chamou o callback de sucesso dando um printc
        },
    );//chamou o listener que foi criado no DefaultListenerNotifier e passou o contexto e o callback de sucesso0     
    //FirebaseFirestore.instance.collection("USERS").add({"email": "cristiano@gmail.com", "senha" : "12345"});//! adicionando um usuário no banco de dados
  }
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
                          child: Form(
                            key: _formKey, //!chave para o formulário
                            child: Column(
                            children: [
                              TodoListField(
                                label: 'E-mail',
                                controller: _emailEC,
                                focusNode: _emailFocus, // passando o focus node para o campo de email
                                validator: Validatorless.multiple([
                                  Validatorless.required('E-mail obrigatório'),
                                  Validatorless.email('E-mail inválido'),
                                ])
                              ),
                              const SizedBox(height: 20,),
                              TodoListField(
                                label: 'Senha',
                                controller: _passwordEC,
                                validator: Validatorless.multiple([
                                  Validatorless.required('Senha obrigatória'),
                                  Validatorless.min(6, 'Senha muito curta'),
                                ]),
                                obscureText: true,),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: (){ //! estrutura de
                                      if(_emailEC.text.isNotEmpty){ //se o email não estiver vazio ele chama o método de esqueci a senha
                                        context.read<LoginController>().forgotPassword(_emailEC.text); //chamando o método de esqueci a senha

                                      } else { //se o email estiver vazio ele mostra uma mensagem de erro
                                        _emailFocus.requestFocus(); //chama o metodo que foca no campo de email
                                        Messages.of(context).showError('Digite o email para recuperar a senha'); 
                                      }
                                    },
                                    child: const Text('Esqueceu a senha?'),
                                  ),
                                  ElevatedButton(
                                      onPressed: (){
                                        final formValid = _formKey.currentState?.validate() ?? false; //se
                                        if(formValid){ //se o formulario for valido ele pega o email e a senha e chama o método de login
                                          final email = _emailEC.text;
                                          final password = _passwordEC.text;
                                          context.read<LoginController>().login(email, password);
                                        }
                                      },
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