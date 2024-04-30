import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_field.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_logo.dart';
import 'package:todo_list_provider/app/modules/auth/Register/register_controller.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {


  const RegisterPage({ super.key });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();//chave para o formulario 
  final _emailEC = TextEditingController();//controlador para o campo de email
  final _passwordEC = TextEditingController();//controlador para o campo de senha
  final _confirmPasswordEC = TextEditingController();//controlador para o campo de confirmação de senha

 @override
  void dispose() {
    _emailEC.dispose();//libera a memoria
    _passwordEC.dispose();//libera a memoria
    _confirmPasswordEC.dispose();//
    super.dispose();
    context.read<RegisterController>().removeListener(() {});//remove o listener
  }

  @override
  void initState() {
   super.initState();
   context.read<RegisterController>().addListener(() {//adiciona um listener
     final controller = context.read<RegisterController>();//variavel para armazenar o controller
     var sucess = controller.sucess;//variavel para armazenar se o registro foi bem sucedido  
     var error = controller.error;//variavel para armazenar o erro
     if(sucess){
     Navigator.of(context).pop();//fecha a tela de cadastro
     }else if (error != null && error.isNotEmpty) {
       ScaffoldMessenger.of(context).showSnackBar(//mostra uma mensagem na tela
         SnackBar(
           content: Text(error),//mensagem de erro
           backgroundColor: Colors.red,//cor de fundo da mensagem
         ),
       );
     }
   });
   
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(
            centerTitle: false, // descentraliza o titulo
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
                    key: _formKey,//chave para o formulario
                    child: Column(children: [
                      TodoListField(
                        label: 'E-mail',
                        controller: _emailEC,//controlador para o campo de email 
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo obrigatório'),
                          Validatorless.email('E-mail inválido'),
                        ]),//validação para o campo de email
                        ),
                      const SizedBox(height: 20,),
                      TodoListField(
                        label: 'Senha',
                        obscureText: true,
                        controller: _passwordEC,// controlador para o campo de senha
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo obrigatório'),
                          Validatorless.min(6, 'Senha muito curta'),
                        ]),),
                      const SizedBox(height: 20,),
                      TodoListField(
                        label: 'Confirmação de Senha',
                        obscureText: true,
                        controller: _confirmPasswordEC,//controlador para o campo de confirmação de senha
                        validator: Validatorless.multiple([
                          Validatorless.required('Campo obrigatório'),
                          Validatorless.compare(_passwordEC, 'Senhas não conferem'),
                        ])
                        ),
                      const SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: (){
                            final formValid = _formKey.currentState?.validate() ?? false; //valida o formulario, onde se o formulario for nulo ele retorna false
                            if (formValid) {
                              final email = _emailEC.text;
                              final password = _passwordEC.text;
                              context.read<RegisterController>().registerUser(email, password); //chamou o controller de autenticação e passou o email e senha
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