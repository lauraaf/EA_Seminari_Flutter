import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? _id; // camp ID
  String _name;
  String _mail;
  String? _password;
  String _comment;

  // Constructor
  UserModel({
    String? id, 
    required String name,
    required String mail,
    String? password,
    required String comment,
  })  : _id = id, 
        _name = name,
        _mail = mail,
        _password = password,
        _comment = comment;

  // Getters
  String? get id => _id; 
  String get name => _name;
  String get mail => _mail;
  String? get password => _password;
  String get comment => _comment;

  // Método para actualizar el usuario
  void setUser(String name, String mail, String password, String comment) {
    _id = id; // Actualitzar ID
    _name = name;
    _mail = mail;
    _password = password;
    _comment = comment;
    notifyListeners();
  }

  // Método fromJson para crear una instancia de UserModel desde un Map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '', 
      name: json['name'] ?? 'Usuario desconocido',
      mail: json['mail'] ?? 'No especificado',
      password: json['password'] ?? 'Sin contraseña',
      comment: json['comment'] ?? 'Sin comentarios',
    );
  }

  // Método toJson para convertir una instancia de UserModel en un Map
  Map<String, dynamic> toJson() {
    return {
      '_id': _id, 
      'name': _name,
      'mail': _mail,
      'password': _password,
      'comment': _comment,
    };
  }
}
