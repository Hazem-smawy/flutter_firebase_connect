import 'dart:ffi';

import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:get/state_manager.dart';

class CategoryController extends GetxController {
  final DatabaseService database = DatabaseService();
  final StorageService storageService = StorageService();
  var categories = <Category>[].obs;
  @override
  void onInit() {
    categories.bindStream(database.getCategories());
    super.onInit();
  }

  Future refreshPage() async {
    categories.bindStream(database.getCategories());
  }

  var showNewCategory = false.obs;

  void toggleShowNewCategory() {
    showNewCategory.value = !showNewCategory.value;
  }

  var newCategory = {}.obs;

  bool get status => newCategory['status'];
  void updateProductStatus(int index, Category category, bool value) {
    category.status = value;
    categories[index] = category;
  }

  void saveNewCategoryStatus(Category category, String field, bool value) {
    database.updateField(category, field, value);
  }

  Future<void> addCategory(Category category) {
    return database.addCategory(category);
  }

  Future<void> deleteImage(String imageURL) async {
    await storageService.deleteImageURL(imageURL);
  }

  Future<void> deleteCategory(String id, String imageURL) async {
    await deleteImage(imageURL);
    await database.deleteField(id);
  }

  Future<void> updateDocument(Category category) async {
    //print('controller update');
    await database.updateDoc(category);
  }
}
