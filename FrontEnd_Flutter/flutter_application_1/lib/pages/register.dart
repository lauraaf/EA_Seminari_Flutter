import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _registrarse() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // URL de la API de autenticación HTTPS
    final url = Uri.parse('http://10.0.2.2:3000/api/user/newUser');

    try {
      // Realizar solicitud POST con usuario y contraseña
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _usernameController.text,
          'mail': _mailController.text,
          'password': _passwordController.text,
          'comment': _commentController.text,
        }),
      );

      // Verificar si la solicitud fue exitosa
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registrado con exito!'),
            duration: Duration(seconds: 3),
          ),
        );
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

  Future<void> _logInreturn() async {
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrarse')),
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
              controller: _mailController,
              decoration: InputDecoration(labelText: 'Mail'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(labelText: 'Comentario'),
            ),
            SizedBox(height: 16),
            if (_isLoading)
              CircularProgressIndicator()
            else
              ElevatedButton(
                onPressed: _registrarse,
                child: Text('Registrarse'),
              ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ElevatedButton(
              onPressed: _logInreturn,
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}