
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
  required SucessVoidCallback sucessCallback,// recebe um callback de sucesso
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
      if(sucessCallback != null){//se o callback de sucesso não for nulo
        sucessCallback(changeNotifier, this);//chama o callback de sucesso
      }
    }
  });

}

//metodo para liberar a memoria e fechar o listener
void dispose() {
  changeNotifier.removeListener(() {});//remove o listener
}

}

//! o typedef é usado para criar um alias para um tipo de função existente
//! nesse caso ele criu essa função de sucesso que recebe um DefaultChangeNotifier e um DefaultListenerNotifier
//! e não retorna nada
typedef SucessVoidCallback = void Function(
  DefaultChangeNotifier notifier, DefaultListenerNotifier listenerInstance);
