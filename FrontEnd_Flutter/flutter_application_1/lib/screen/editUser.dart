import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/registerController.dart';
import '../models/userModel.dart';

class EditUserPage extends StatefulWidget {
  final UserModel user;

  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditUserPage> {
  final RegisterController registerController = Get.put(RegisterController());

  @override
  void initState() {
    super.initState();
    //Omplir el formulari a,b les dades del user
    registerController.fillFormWithUserData(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar Usuario")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: registerController.nameController,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: registerController.mailController,
              decoration: InputDecoration(labelText: 'Mail'),
            ),
            TextField(
              controller: registerController.passwordController,
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: registerController.commentController,
              decoration: InputDecoration(labelText: 'Comentario'),
            ),
            const SizedBox(height: 16),
            Obx(() {
              if (registerController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ElevatedButton(
                  onPressed: () {
                    registerController.updateUser();
                    Get.back(); // Tornar a la llista d'usuaris despres d'actualizar
                  },
                  child: Text('Actualizar Usuari'),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}