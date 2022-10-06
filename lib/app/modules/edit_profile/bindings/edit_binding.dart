
import 'package:get/get.dart';
import '../controller/edit_controller.dart';


class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(
          () => EditProfileController(),
    );
  }
}