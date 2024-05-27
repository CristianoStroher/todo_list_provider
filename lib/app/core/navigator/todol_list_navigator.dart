
import 'package:flutter/material.dart';

// essa classe é um helper para navegar entre as telas e a vantagem
// de usar essa classe é que podemos acessar o Navigator de qualquer lugar
// da aplicação.

/// Sim, navegação sem contexto é uma técnica útil em Flutter e se encaixa bem na ideia de helpers.
/// Essa abordagem permite a navegação entre telas sem a necessidade de
/// passar explicitamente o BuildContext em cada chamada de navegação,
/// facilitando a estruturação do código e melhorando a legibilidade.
/// Para implementar a navegação sem contexto, você pode usar um GlobalKey
/// associado a um Navigator. Isso permite que você acesse o Navigator de
/// qualquer lugar da aplicação, sem a necessidade de passar o contexto.




class TodolListNavigator {

  TodolListNavigator._();

  // cria uma chave global para o Navigator para ser
  // acessado de qualquer lugar da aplicação. Estamos aqui instanciando
  // um GlobalKey que é uma chave global para o NavigatorState.
  static final navigatorKey = GlobalKey<NavigatorState>(); 

  // cria um getter para acessar o NavigatorState de qualquer lugar
  // da aplicação. esse getter é um método estático que retorna o
  // estado do Navigator.
  static NavigatorState? get to => navigatorKey.currentState; 

  
}