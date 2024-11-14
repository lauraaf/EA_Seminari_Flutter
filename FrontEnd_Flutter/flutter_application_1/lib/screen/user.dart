import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/controllers/userListController.dart';
import 'package:flutter_application_1/models/userModel.dart';

class UserPage extends StatelessWidget {
  final UserListController userController = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Usuarios')),
      body: Obx(() {
        if (userController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (userController.userList.isEmpty) {
          return Center(child: Text("No hay usuarios disponibles"));
        } else {
          return ListView.builder(
            itemCount: userController.userList.length,
            itemBuilder: (context, index) {
              return UserCard(user: userController.userList[index]);
            },
          );
        }
      }),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(user.mail),
            const SizedBox(height: 8),
            Text(user.comment ?? "Sin comentarios"),
          ],
        ),
      ),
    );
  }
}
