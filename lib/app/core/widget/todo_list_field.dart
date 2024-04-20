import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {

  //atributos
  final String label; //!campo para quando importar esse componente exiga que descrevemos o lavel
  final IconButton? suffixIconButton; //! para ser preenchido se terá iconButton ou não
  final bool obscureText;//! para ser preenchido se terá obscureText ou não
  final ValueNotifier<bool> obscureTexVN; //!para ser preenchido se terá obscureText ou não E GERENCIAR O ESTADO.
  final TextEditingController? controller; //!controlador do campo de texto e implementar a tela
  final FormFieldValidator<String>? validator; //!validador do campo de texto e implementar a tela

  //contrutor
 TodoListField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.obscureText = false, //!deixei como padrão false.
    this.controller,//! colocamos no construtor
    this.validator, //!colocamos no construtor
    }) : assert(obscureText == true ? suffixIconButton == null : true,
        'obscureText não pode ser enviado em conjunto com suffixIconButton.'), //!validando se o obscureText é true, o suffixIconButton deve ser null pois ja tem o botao do olho como padrão.
      obscureTexVN = ValueNotifier(obscureText);

   @override
   Widget build(BuildContext context) {
       return ValueListenableBuilder<bool>(
           valueListenable: obscureTexVN, //!escutar o estado do obscureTexVN
           builder: (_, obscureTextValue, child) {  //!sempre que o obscureTexVN mudar ele vai chamar o builder
               return TextFormField(
                controller: controller, //!para o campo de texto
                validator: validator, //!para o campo de texto
                decoration: InputDecoration(
                  labelText: label,// texto do label
                  labelStyle: const TextStyle(// estilo do label
                    color: Colors.black,
                    fontSize: 15,
                  ),
                  border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),
                  ),
                  errorBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(30),
                   borderSide: const BorderSide(color: Colors.red),
                  ),
                  isDense: true, //!deixa o botao mais enxuto
                  suffixIcon: suffixIconButton ?? //!logica ternario que se existe um icon ele coloca e pede se tem obscure text, caso contrário ele coloca nada null.
                   (obscureText == true
                    ? IconButton(
                     onPressed: (){
                      obscureTexVN.value = !obscureTexVN.value; //!quando clicar ele vai mudar o estado do obscureTexVN
                     },             
                     icon: Icon( //! usamos um ternario para mostrar o icone do olho aberto ou fechado.
                      !obscureTextValue
                        ? TodoListIcons.eye_slash
                        : TodoListIcons.eye, //!se o obscureTextValue for false ele vai mostrar o olho fechado, caso contrário o olho aberto.),
                     size: 14,
                     ),
                     /***
                     !obscureTextValue: O operador ! antes de obscureTextValue significa "não".
                     Então, !obscureTextValue verifica se obscureTextValue é falso. 
                     Se obscureTextValue for falso (ou seja, o texto no campo de texto não está
                     obscurecido, provavelmente é visível), então o olho deve ser mostrado como
                     fechado (indicando que o texto é visível), representado pelo ícone
                     TodoListIcons.eye_slash.
                    ***/
                    )
                   : null),
                 ),
                 obscureText: obscureTextValue, //!para o campo de senha.. porem agora usamos o obscureTexVN para gerenciar o estado.
               );
           },
       ); 
   }
}