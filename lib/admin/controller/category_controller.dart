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

  var newCategory = {}.obs;

  bool get status => newCategory['cstatus'];
  void updateProductStatus(int index, Category category, bool value) {
    category.cstatus = value;
    categories[index] = category;
  }

  void saveNewCategoryStatus(Category category, String field, bool value) {
    database.updateField(category, field, value);
  }

  void deleteCategory(String id, String imageURL) {
    storageService.deleteImageURL(imageURL);
    database.deleteField(id);
  }

  void updateDocument(Category category) {
    //print('controller update');
    database.updateDoc(category);
  }
}
