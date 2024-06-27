abstract interface class TasksRepository {

  //metodo para salvar tasks no repositorio 
  Future<void> saveTask(DateTime data, String description);

}