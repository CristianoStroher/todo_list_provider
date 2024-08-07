// ignore_for_file: public_member_api_docs, sort_constructors_first
//criamos o modelo de tarefas
class TasksModel {
  
  final int id;
  final String description;
  final DateTime dateTime;
  final bool finished;

  TasksModel({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.finished,
  });

  //converte o mapa em um objeto
  factory TasksModel.loadFromDB(Map<String, dynamic> task) {
    return TasksModel(
      id: task['id'] as int,
      description: task['descricao'] as String,
      dateTime: DateTime.parse(task['data_hora'] as String),
      finished: task['finalizado'] == 1,
    );
  }


  //usando o pluguin copyWith para copiar o objeto e alterar apenas o que for necessário
  TasksModel copyWith({
    int? id,
    String? description,
    DateTime? dateTime,
    bool? finished,
  }) {
    return TasksModel(
      id: id ?? this.id,
      description: description ?? this.description,
      dateTime: dateTime ?? this.dateTime,
      finished: finished ?? this.finished,
    );
  }
} 
