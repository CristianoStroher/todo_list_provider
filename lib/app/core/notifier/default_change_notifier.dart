
class DefaultChangeNotifier {
  bool _loading = false; //atributo para armazenar se esta carregando
  String? _error; // atributo opcional para armazenar o erro 
  bool _success = false; //atributo para armazenar se a operação foi bem sucedida

  //metodos
  bool get loading => _loading; //metodo get para retornar o valor de loading
  String? get error => _error; //metodo get para retornar o valor de error
  bool get isSuccess => _success; //metodo get para retornar o valor de success
  bool get hasError => _error != null; //metodo get para retornar se tem erro

  void showLoading() => _loading = true; //metodo para mostrar o loading
  void hideLoading() => _loading = false; //metodo para esconder o loading
  void setError(String message) => _error = error; //metodo para setar o erro
  void success() => _success = true; //metodo para mostrar que a operação foi bem sucedida
}