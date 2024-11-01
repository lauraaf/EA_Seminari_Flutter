import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
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
        context.go('/home');
        /*final token = responseData['token']; // El token de autenticación de la respuesta

        if (token != null) {
          // Si la autenticación es exitosa, navega a la página principal
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage(token: token)),
          );
        } else {
          setState(() {
            _errorMessage = 'Error: No se recibió un token de autenticación';
          });
        }*/
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
            SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}