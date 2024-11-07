import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/userModel.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Perfil de Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${user.name}'),
            Text('Email: ${user.mail}'),
            Text('Comentario: ${user.comment}'),
          ],
        ),
      ),
    );
  }
}