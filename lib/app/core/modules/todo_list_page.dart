import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

//nessa classe vamos encapsular nossas estruturas.
class TodoListPage extends StatelessWidget {

  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  const TodoListPage({
    Key? key,
    List<SingleChildWidget>? bindings,
    required WidgetBuilder page
    }) : _bindings = bindings,
    _page = page,
    super(key: key);

    // colocamos o object(fake) pois o multiprovider exige pelo menos um provider
   @override
   Widget build(BuildContext context) {
    return MultiProvider(providers: _bindings ?? [Provider(create: (_)=>Object())],
    child: Builder(builder: (context) => _page(context),
    ) ,
    );
       
  }
}

/***
Definição da classe TodoListpPage:

Esta classe é uma subclasse de StatelessWidget, o que significa que não possui estado interno.
Ela encapsula a estrutura para exibir uma lista de tarefas.
Construtor:

O construtor TodoListpPage recebe alguns parâmetros:
bindings: Uma lista opcional de SingleChildWidget. Isso permite que a página receba provedores específicos ou outras configurações.
page: Um construtor de widget (WidgetBuilder) obrigatório que será chamado para construir a página real.
O construtor também chama o construtor da classe pai StatelessWidget passando a key e inicializa os campos _bindings e _page.
Método build:

Este é um método obrigatório em qualquer widget do Flutter. Ele retorna o widget que este widget deve renderizar.
Dentro do método build, o widget MultiProvider é usado. O MultiProvider é uma parte do pacote provider que permite fornecer vários provedores de uma só vez.
O MultiProvider recebe uma lista de provedores. Se _bindings for fornecido, esta lista é usada; caso contrário, um provedor fictício é criado usando Provider(create: (_)=>Object()). Isso é feito porque MultiProvider exige pelo menos um provedor.
Dentro do MultiProvider, há um widget Builder. O widget Builder é usado para encapsular uma função de construção que não requer acesso direto ao contexto pai.
A função de construção passada para o Builder chama _page(context), que é o construtor de widget fornecido no construtor TodoListpPage. Isso efetivamente cria e retorna a página real usando o contexto fornecido.
Em resumo, esta classe TodoListpPage encapsula a estrutura para exibir uma lista de tarefas, permitindo que o desenvolvedor passe provedores específicos ou outras configurações para essa página.
***/