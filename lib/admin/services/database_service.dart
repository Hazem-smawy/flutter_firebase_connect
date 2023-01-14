import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';

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
    print(json);
    return _firebaseFirestore
        .collection('category')
        .where('cid', isEqualTo: category.cid)
        .get()
        .then((value) => value.docs.first.reference.update(json));

    // .where('cid', isEqualTo: category.cid)
    // .get()
    // .then((value) => {value.docs.first.reference.set(json)});
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
}
