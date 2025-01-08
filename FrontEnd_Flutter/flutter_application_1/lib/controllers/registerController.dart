import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/services/user.dart';
import 'package:flutter_application_1/models/userModel.dart';

class RegisterController extends GetxController {
  final UserService userService = Get.put(UserService());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  String? userId; 

  /// **Funció per registrar un usuari**
  void signUp() async {
    if (!_validateFields()) return;

    isLoading.value = true;

    try {
      UserModel newUser = UserModel(
        name: nameController.text,
        password: passwordController.text,
        mail: mailController.text,
        comment: commentController.text,
      );

      final response = await userService.createUser(newUser);

      if (response != null && response == 201) {
        Get.snackbar('Èxit', 'Usuari creat correctament');
        clearForm();
        Get.toNamed('/login');
      } else {
        errorMessage.value = 'Aquest correu o telèfon ja estan en ús';
        Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error al registrar l\'usuari';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }


  //Funció per omplir el formulari amb dades de l'usuari seleccionat
  void fillFormWithUserData(UserModel user) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    nameController.text = user.name ?? '';
    mailController.text = user.mail ?? '';
    commentController.text = user.comment ?? '';
    passwordController.text = '';  
    userId = user.id;  
  });
}

  //Funció per actualitzar un usuari existent
  void updateUser() async {
    if (userId == null) return;

    if (!_validateFields()) return;

    isLoading.value = true;

    try {
      UserModel updatedUser = UserModel(
        id: userId,
        name: nameController.text,
        mail: mailController.text,
        comment: commentController.text,
        password: "1234567",
      );

      final response = await userService.EditUser(userId!, updatedUser);

      if (response != null && response == 200) {
        Get.snackbar('Èxit', 'Usuari actualitzat correctament');
        clearForm();
      } else {
        errorMessage.value = 'Error al actualitzar l\'usuari';
        Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      errorMessage.value = 'Error al actualitzar l\'usuari';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  //Validació dels camps
  bool _validateFields() {
    if (nameController.text.isEmpty ||
        mailController.text.isEmpty ||
        commentController.text.isEmpty) {
      errorMessage.value = 'Hi ha camps buits';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    if (!GetUtils.isEmail(mailController.text)) {
      errorMessage.value = 'Format de correu no vàlid';
      Get.snackbar('Error', errorMessage.value, snackPosition: SnackPosition.BOTTOM);
      return false;
    }

    return true;
  }

  //Netejar el formulanri
  void clearForm() {
    nameController.clear();
    passwordController.clear();
    mailController.clear();
    commentController.clear();
    userId = null; 
  }
}