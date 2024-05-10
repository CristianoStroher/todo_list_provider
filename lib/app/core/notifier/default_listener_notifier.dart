
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {

//variavel para armazenar o changeNotifier
 final DefaultChangeNotifier changeNotifier;

//construtor obrigatorio
 DefaultListenerNotifier({
  required this.changeNotifier,
 });

//metodo para adicionar um listener e mostrar o loader
void listener({
  required BuildContext context,// recebe o contexto
}) {  
    changeNotifier.addListener(() {//adiciona um listener
      if(changeNotifier.loading){//se o loading for verdadeiro
        Loader.show(context);//mostra o loader
    }else {
      Loader.hide();//esconde o loader
    }

    if(changeNotifier.hasError){//se tiver erro
      Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');//mostra a mensagem de erro
    } else if(changeNotifier.isSuccess){//se tiver sucesso
    }
  });

}


}