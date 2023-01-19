import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Category>> getCategories() {
    return _firebaseFirestore
        .collection('category')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Category.fromSnapshot(e)).toList();
    });
  }

  Future<void> addCategory(Category category) {
    return _firebaseFirestore.collection('category').add(category.toMap());
  }

  Future<void> updateDoc(Category category) {
    final json = category.toMap();
    return _firebaseFirestore
        .collection('category')
        .where('cid', isEqualTo: category.cid)
        .get()
        .then((value) => value.docs.first.reference.update(json));
  }

  Future<void> updateField(Category category, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('category')
        .where('cid', isEqualTo: category.cid)
        .get()
        .then((value) => {
              value.docs.first.reference.update(
                {field: newValue},
              ),
            });
  }

  Future<void> deleteField(String id) {
    return _firebaseFirestore
        .collection('category')
        .where('cid', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }

  // product database

  Stream<List<Product>> getProducts() {
    return _firebaseFirestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    });
  }

  Future<List<Product>> getProductsOfCategory(String cid) {
    return _firebaseFirestore
        .collection('products')
        .where('cid', isEqualTo: cid)
        .get()
        .then((snap) {
      return snap.docs.map((e) => Product.fromSnapshot(e)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore.collection('products').add(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    final json = product.toMap();
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((value) => value.docs.first.reference.update(json));
  }

  Future<void> deleteProduct(String id) {
    return _firebaseFirestore
        .collection('products')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }
}
