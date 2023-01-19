import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:get/state_manager.dart';

class ProductsController extends GetxController {
  final DatabaseService database = DatabaseService();
  final StorageService storageService = StorageService();
  var products = <Product>[].obs;
  var productsOfCategory = <Product>[].obs;
  @override
  void onInit() {
    products.bindStream(database.getProducts());
    super.onInit();
  }

  var categoryId = ''.obs;
  var upload = false.obs;

  var newProduct = {}.obs;

  Future<List<Product>> getProductsForCategory(String cid) async {
    productsOfCategory.value = await database.getProductsOfCategory(cid);
    return productsOfCategory;
  }

  Future<void> addProduct(Product product) async {
    await database.addProduct(product);
    productsOfCategory.add(product);
  }

  Future<void> deleteImage(String imageURL) async {
    await storageService.deleteImageURL(imageURL);
  }

  Future<void> deleteProduct(String id, String imageURL) async {
    await database.deleteProduct(id);
    await deleteImage(imageURL);
  }

  Future<void> updateDocument(Product product) async {
    await database.updateProduct(product);

    productsOfCategory.value =
        await database.getProductsOfCategory(categoryId.value);
  }
}
