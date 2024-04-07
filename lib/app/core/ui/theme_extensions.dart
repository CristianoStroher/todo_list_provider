import 'package:flutter/material.dart';

//! extensão para o tema onde vou incluir uma propriedade de contexto
extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColorDark => Theme.of(this).primaryColorDark;  
  Color get buttonColor => Theme.of(this).buttonTheme.colorScheme?.primary ?? Colors.black; // Added line
  //! Explicando a alteração acima: Portanto, essa linha de código busca a cor
  //! primária do botão do tema atual. Se a cor não estiver definida
  //! ou se houver qualquer valor nulo ao longo do caminho, a cor
  //! preta será usada como um valor padrão. Isso ajuda a evitar
  //! erros de nulidade durante a execução do aplicativo.
  TextStyle get titleLarge => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );
  
}