import 'package:get/get.dart';
import 'package:flutter_application_1/models/experienceModel.dart';
import 'package:flutter_application_1/services/experience.dart';

class ExperienceListController extends GetxController {
  var isLoading = true.obs;
  var experienceList = <ExperienceModel>[].obs;
  final ExperienceService experienceService = ExperienceService();

  @override
  void onInit() {
    super.onInit();
    fetchExperiences();  // Llamada a fetchExperiences al inicializar el controlador
  }

  // Método para obtener las experiencias
  Future<void> fetchExperiences() async {
    try {
      isLoading(true);  // Establecemos el estado de carga a true
      var experiences = await experienceService.getExperiences();
      if (experiences != null) {
        experienceList.assignAll(experiences); // Asignamos las experiencias a la lista
      }
    } catch (e) {
      print("Error fetching experiences: $e");
    } finally {
      isLoading(false);  // Establecemos el estado de carga a false una vez que termine
    }
  }

  // Método para editar una experiencia
  Future<void> editExperience(String id, ExperienceModel updatedExperience) async {
    try {
      isLoading(true);  // Establecemos el estado de carga a true
      var statusCode = await experienceService.EditExperience(updatedExperience, id);
      if (statusCode == 201) {
        Get.snackbar('Éxito', 'Experiencia actualizada con éxito');
        fetchExperiences();  // Recargamos la lista de experiencias después de editar
      } else {
        Get.snackbar('Error', 'Error al actualizar la experiencia');
      }
    } catch (e) {
      print("Error editing experience: $e");
    } finally {
      isLoading(false);  // Establecemos el estado de carga a false una vez que termine
    }
  }
}
