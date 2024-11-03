import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String _name = 'Usuario desconocido';
  String _mail = 'No especificado';
  String _comment = 'Sin comentarios';

  String get name => _name;
  String get mail => _mail;
  String get comment => _comment;

  void setUser(String name, String mail, String comment) {
    _name = name;
    _mail = mail;
    _comment = comment;
    notifyListeners();
  }
}
