
import 'package:flutter/material.dart';

class Messages {

  //Portanto, o construtor privado é usado para controlar a criação
  // de instâncias da classe Messages e garantir que ela só possa ser
  // criada de maneira específica, enquanto o construtor
  // público (factory constructor) é usado para criar instâncias da
  // classe de fora dela, seguindo a lógica definida no construtor privado.

  //VARIÁVEL FINAL BUILD CONTEXT QUE INSERE O CONTEXTO DE CONSTRUÇÃO
  final BuildContext context;
  //BuildContext context: Esta é uma variável final na classe Messages,
  // que armazena o contexto de construção. O BuildContext é frequentemente
  // usado em aplicativos Flutter para fornecer acesso a informações
  // sobre a árvore de widgets, como tema, localização e tamanho da tela.

  //construtor privado
  Messages._(this.context);

  //Construtor factory para retornar a instancia da classe usando .of.
  factory Messages.of(BuildContext context) => Messages._(context);

  void showError(String message) => _showMessage(message, Colors.red);
  void showInfo(String message) => _showMessage(message, Colors.red);

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  } 
}