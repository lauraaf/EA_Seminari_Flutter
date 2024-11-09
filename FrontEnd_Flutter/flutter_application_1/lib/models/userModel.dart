import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String _name;
  String _mail;
  String _comment;

   // Constructor
  UserModel({required String name, required String mail, required String comment})
      : _name = name,
        _mail = mail,
        _comment = comment; 

  // Getters
  String get name => _name;
  String get mail => _mail;
  String get comment => _comment;

  // Método para actualizar el usuario
  void setUser(String name, String mail, String comment) {
    _name = name;
    _mail = mail;
    _comment = comment;
    notifyListeners();
  }

  // Método fromJson para crear una instancia de UserModel desde un Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? 'Usuario desconocido',
      mail: json['mail'] ?? 'No especificado',
      comment: json['comment'] ?? 'Sin comentarios',
    );
  }

  // Método toJson para convertir una instancia de UserModel en un Map
  Map<String, dynamic> toJson() {
    return {
      'name': _name,
      'mail': _mail,
      'comment': _comment,
    };
  }
}

