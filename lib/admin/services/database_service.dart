import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_base/admin/model/about_model.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/model/contact_model.dart';
import 'package:flutter_fire_base/admin/model/info_model.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart' as Order;
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/model/user_model.dart';

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

  // about
  Future<void> addAboutInfo(Info info) async {
    await _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('info')
        .doc('YtBEjqTSl3Fd6c55aksO')
        .update(info.toMap());
  }

  Stream<Info> getAboutInfo() {
    return _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('info')
        .doc('YtBEjqTSl3Fd6c55aksO')
        .snapshots()
        .map((snap) => Info.fromSnapshot(snap));
  }

  Future<void> addAboutContact(Contact contact) async {
    await _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('contact')
        .doc('lvWxhuOwo41iFtlduvd9')
        .set(contact.toMap());
  }

  Stream<Contact> getAboutContact() {
    return _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('contact')
        .doc('lvWxhuOwo41iFtlduvd9')
        .snapshots()
        .map((snap) => Contact.fromSnapshot(snap));
  }

  Stream<List<About>> getAbout() {
    return _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('about')
        .snapshots()
        .map((snap) {
      return snap.docs.map((e) => About.fromSnapshot(e)).toList();
    });
  }

  Future<void> addAbout(About about) async {
    await _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('about')
        .add(about.toMap());
  }

  Future<void> deleteAbout(String id) async {
    var doc = await _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('about')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => value.docs.first.reference.delete());
  }

  Future<void> updateAbout(String id, About about) async {
    await _firebaseFirestore
        .collection('options')
        .doc('Je8QP35wBGLiAaGlk7ew')
        .collection('about')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => value.docs.first.reference.update(about.toMap()));
  }

  //users

  Stream<List<User>> getUsers() {
    return _firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => User.fromSnapshot(e)).toList();
    });
  }

  Future<void> addUser(User user) async {
    final doc = _firebaseFirestore.collection('users').doc(user.email);
    await doc.set(user.toMap());
  }

  Future<void> updateUser(String id, bool isAdmin) async {
    return _firebaseFirestore
        .collection('users')
        .doc(id)
        .update({'isAdmin': isAdmin});
  }

  Future<void> deleteUser(String id) async {
    return _firebaseFirestore
        .collection('users')
        .where('email', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }

  //orders
  Stream<List<Order.Order>> getOrders() {
    return _firebaseFirestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => Order.Order.fromSnapshot(e)).toList();
    });
  }

  Stream<List<Order.Order>> getTodayOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('orderOn',
            isGreaterThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 1)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Order.Order.fromSnapshot(e)).toList();
    });
  }

  Stream<List<Order.Order>> getLastWeekOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('orderOn',
            isLessThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 1)).toString())
                .millisecondsSinceEpoch)
        .where('orderOn',
            isGreaterThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 7)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Order.Order.fromSnapshot(e)).toList();
    });
  }

  Stream<List<Order.Order>> getLastMonthOrders() {
    return _firebaseFirestore
        .collection('orders')
        .where('orderOn',
            isLessThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 7)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Order.Order.fromSnapshot(e)).toList();
    });
  }

  Future<void> addOrder(Order.Order order) async {
    final doc = _firebaseFirestore.collection('orders').doc();
    await doc.set(order.toMap());
  }

    Future<void> updateOrder(Order.Order order, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((value) => {
              value.docs.first.reference.update(
                {field: newValue},
              ),
            });
  }
}
