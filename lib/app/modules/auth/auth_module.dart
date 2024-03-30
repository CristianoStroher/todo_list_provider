import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_module.dart';
import 'package:todo_list_provider/app/modules/auth/Login/login_controller.dart';
import 'package:todo_list_provider/app/modules/auth/Login/login_page.dart';

//aqui colocamos as rotas e as paginas que esse modulo necessita onde o / login precisa receber todas
// as dependencias do todoListModule
class AuthModule extends TodoListModule {
  AuthModule()
      : super(
        bindings: [
          ChangeNotifierProvider(create: (_) => LoginController()
          ),
        ],
        routers: {
          '/login': (context) => const LoginPage(),
        });
}
