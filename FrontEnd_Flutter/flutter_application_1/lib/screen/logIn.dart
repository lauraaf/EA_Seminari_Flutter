import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // URL de la API de autenticación HTTPS
    final url = Uri.parse('http://10.0.2.2:3000/api/user/logIn');

    try {
      // Realizar solicitud POST con usuario y contraseña
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Inicio de sesion exitoso!'),
            duration: Duration(seconds: 3),
          ),
        );

        final responseData = json.decode(response.body);
        final name = responseData['name'];
        final mail = responseData['mail'];
        final comment = responseData['comment'];

        Provider.of<UserModel>(context, listen: false)
            .setUser(name, mail, comment);

        Get.toNamed('/home');
      } else {
        setState(() {
          _errorMessage = 'Error: Usuario o contraseña incorrectos';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: No se pudo conectar con la API';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _registrarseReturn() async {
    Get.toNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            SizedBox(
              height: 16,
            ),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _login,
                child: Text('Iniciar Sesión'),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: _registrarseReturn,
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
