import 'package:flutter_fire_base/admin/model/user_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:get/state_manager.dart';

class UserController extends GetxController {
  final DatabaseService database = DatabaseService();
  final StorageService storageService = StorageService();
  var users = <User>[].obs;
  var newUser = {}.obs;
  @override
  void onInit() {
    users.bindStream(database.getUsers());

    super.onInit();
  }

  var upload = false.obs;
  final _isAdmin = false.obs;

  get isAdmin => _isAdmin.value;
  set setAdmin(value) => _isAdmin.value = value;

  Future<void> addUser(User user) async {
    await database.addUser(user);
    // productsOfCategory.add(product);
  }

  Future<void> deleteImage(String imageURL) async {
    await storageService.deleteImageURL(imageURL);
  }

  Future<void> deleteUser(String id, String imageURL) async {
    if (id.isNotEmpty) {
      await database.deleteUser(id);
      await deleteImage(imageURL);
    }
  }

  Future<void> updateUser(User user, index, newValue) async {
    user.isAdmin = newValue;
    users[index] = user;

    await database.updateUser(user.email, newValue);
  }
}
