//essa classe é de configuração de tema, onde eu posso pegar as cores do tema atual

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TodoListUiConfig {
  //!construtor privado
  TodoListUiConfig._();

  static ThemeData get theme => ThemeData(
        textTheme: GoogleFonts.mandaliTextTheme(), //fonte
        primaryColor: const Color(0xff5C77CE),
        primaryColorLight: const Color(0xffABC8F7),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff5C77CE),
          ),
        ),
      );
}
