//classe que cria um enum para os filtros de tarefas
enum TaskFilterEnum {
  today,
  tomorrow,
  week,

  }

  //classe que cria uma descrição para os filtros de tarefas
  extension TaskFilterDescripion on TaskFilterEnum {

  String get description { //método que retorna a descrição do filtro
    switch (this) { //verifica o filtro
      case TaskFilterEnum.today: //caso seja hoje
        return 'DE HOJE';
      case TaskFilterEnum.tomorrow: //caso seja amanhã
        return 'DE AMANHÃ';
      case TaskFilterEnum.week: //caso seja semana
        return 'DA SEMANA';
    }
  }
  }