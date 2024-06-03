import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';

class HomePage extends StatelessWidget {

  const HomePage({ super.key });

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Home Page'),),
           body: Center(
            child: TextButton(
              onPressed: () {
                context.read<AuthProvider>().logout(); //chama o método de logout do AuthProvider
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Logout'),
            )
           ),
       );
  }
}