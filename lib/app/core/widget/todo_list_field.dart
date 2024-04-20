import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/todo_list_icons.dart';

class TodoListField extends StatelessWidget {

  //atributos
  final String label; //!campo para quando importar esse componente exiga que descrevemos o lavel
  final IconButton? suffixIconButton; //! para ser preenchido se terá iconButton ou não
  final Icon? suffixIcon; //! para ser preenchido se terá icon ou não
  final bool obscureText;//! para ser preenchido se terá obscureText ou não
  
  //contrutor
  const TodoListField({
    super.key,
    required this.label,
    this.suffixIconButton,
    this.suffixIcon,
    this.obscureText = false, //!deixei como padrão false.
    });

   @override
   Widget build(BuildContext context) {
       return TextFormField(
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
           suffixIcon: suffixIcon ?? //!logica ternario que se existe um icon ele coloca e pede se tem obscure text, caso contrário ele coloca nada null.
            (obscureText == true ? IconButton(
              icon: const Icon(TodoListIcons.eye),
              iconSize: 14,
              onPressed: (){},             
           ) : null),
          ),
          obscureText: obscureText, //!para o campo de senha.. ***
        );       
   }
}