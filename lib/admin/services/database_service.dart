import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_fire_base/admin/model/about_model.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/model/contact_model.dart';
import 'package:flutter_fire_base/admin/model/info_model.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart' as Order;
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/model/slider_model.dart';
import 'package:flutter_fire_base/admin/model/user_model.dart';

class DatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<Category>> getCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Category.fromSnapshot(e)).toList();
    });
  }

  Future<void> addCategory(Category category) {
    print(category.cid);
    return _firebaseFirestore
        .collection('categories')
        .doc(category.cid)
        .set(category.toMap());
  }

  // Future<void> updateDoc(Category category) {
  //   final json = category.toMap();
  //   return _firebaseFirestore
  //       .collection('categories')
  //       .where('cid', isEqualTo: category.cid)
  //       .get()
  //       .then((value) => value.docs.first.reference.update(json));
  // }
  Future<void> updateDoc(Category category) {
    final json = category.toMap();
    return _firebaseFirestore
        .collection('categories')
        .doc(category.cid)
        .update(json);
  }

  Future<void> updateField(Category category, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('categories')
        .doc(category.cid)
        .update({field: newValue});
  }

  Future<void> deleteField(String id) {
    return _firebaseFirestore.collection('categories').doc(id).delete();
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

  Future<List<Product>> getProductsOfCategoryAndLimit(String cid) {
    return _firebaseFirestore
        .collection('products')
        .where('cid', isEqualTo: cid)
        .limit(4)
        .get()
        .then((snap) {
      return snap.docs.map((e) => Product.fromSnapshot(e)).toList();
    });
  }

  Stream<List<Product>> getProductsLimit(String cid) {
    return _firebaseFirestore
        .collection('products')
        .where('cid', isEqualTo: cid)
        .limit(4)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Product.fromSnapshot(e)).toList();
    });
  }

  Future<void> addProduct(Product product) {
    return _firebaseFirestore
        .collection('products')
        .doc(product.id)
        .set(product.toMap());
  }

  Future<void> updateProduct(Product product) {
    final json = product.toMap();
    return _firebaseFirestore
        .collection('products')
        .doc(product.id)
        .update(json);
  }

  Future<void> deleteProduct(String id) {
    return _firebaseFirestore.collection('products').doc(id).delete();
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

  Future<User?> getUser(String? id) async {
    if (id == null) {
      return null;
    } else {
      return _firebaseFirestore
          .collection('users')
          .doc(id)
          .get()
          .then((value) => User.fromSnapshot(value));
    }
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

//completed order
  Stream<List<Order.OrderCompleted>> getTodayOrdersCompleted() {
    return _firebaseFirestore
        .collection('completedOrders')
        .where('completedOn',
            isGreaterThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 1)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => Order.OrderCompleted.fromSnapshot(e))
          .toList();
    });
  }

  Stream<List<Order.OrderCompleted>> getLastWeekOrdersCompleted() {
    return _firebaseFirestore
        .collection('completedOrders')
        .where('completedOn',
            isLessThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 1)).toString())
                .millisecondsSinceEpoch)
        .where('completedOn',
            isGreaterThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 7)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => Order.OrderCompleted.fromSnapshot(e))
          .toList();
    });
  }

  Stream<List<Order.OrderCompleted>> getLastMonthOrdersCompleted() {
    return _firebaseFirestore
        .collection('completedOrders')
        .where('completedOn',
            isLessThanOrEqualTo: DateTime.parse(
                    DateTime.now().subtract(const Duration(days: 7)).toString())
                .millisecondsSinceEpoch)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => Order.OrderCompleted.fromSnapshot(e))
          .toList();
    });
  }

  Stream<List<Order.OrderCompleted>> getOrdersCompletedForUser(String userId) {
    return _firebaseFirestore
        .collection('completedOrders')
        .where('order.customerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((e) => Order.OrderCompleted.fromSnapshot(e))
          .toList();
    });
  }

// favorite
  Stream<List<Order.Order>> getFavorite(String userId) {
    return _firebaseFirestore
        .collection('orders')
        .where('isCompleted', isEqualTo: 0)
        .where('customerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((e) => Order.Order.fromSnapshot(e)).toList();
    });
  }

  Future<void> deleteFavorite(String id, String userId) async {
    return _firebaseFirestore
        .collection('orders')
        .where('isCompleted', isEqualTo: 0)
        .where('customerId', isEqualTo: userId)
        .where('id', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }
    Future<void> deleteFavoriteAfterAddedToOrder(String id) async {
    return _firebaseFirestore
        .collection('orders')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }

  Future<void> addOrder(Order.Order order) async {
    final doc = _firebaseFirestore.collection('orders').doc(order.id);
    await doc.set(order.toMap());
  }

  Future<Order.Order?> getLastOrder() async {
    return _firebaseFirestore
        .collection('orders')
        .orderBy('orderOn', descending: true)
        //.where('cid', isEqualTo: cid)
        .limit(1)
        .get()
        .then((snap) {
      if (snap.docs.isEmpty) return null;
      return Order.Order.fromSnapshot(snap.docs.first);
    });

    // if (doc == null) return null;
    // return doc;
  }

  Future<void> addCompletedOrder(Order.OrderCompleted order) async {
    final doc = _firebaseFirestore.collection('completedOrders').doc(order.id);
    await doc.set(order.toMap());
    print(doc);
  }

  Future<Order.OrderCompleted?> getLastCompletedOrder() async {
    return _firebaseFirestore
        .collection('completedOrders')
        .orderBy('completedOn', descending: false)
        //.where('cid', isEqualTo: cid)
        .limit(1)
        .get()
        .then((snap) {
      if (snap.docs.isEmpty) return null;
      return Order.OrderCompleted.fromSnapshot(snap.docs.first);
    });

    // if (doc == null) return null;
    // return doc;
  }

  // Future<Order.Order?> getTheLastOrderForUser(String userId) async {
  //   return _firebaseFirestore
  //       .collection('orders')
  //       //.orderBy('orderOn', descending: true)
  //       .where('customerId', isEqualTo: userId)
  //       .limit(1)
  //       .get()
  //       .then((snap) {
  //     if (snap.docs.isEmpty) return null;
  //     return Order.Order.fromSnapshot(snap.docs.first);
  //   });
  // }

  Future<void> updateOrderCompleted(Order.OrderCompleted order, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('completedOrders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((value) => {
              value.docs.first.reference.update(
                {field: newValue},
              ),
            });
  }

  // slider

  Stream<List<ShowSlider>> getSliders() {
    return _firebaseFirestore.collection('sliders').snapshots().map((snapshot) {
      return snapshot.docs.map((e) => ShowSlider.fromSnapshot(e)).toList();
    });
  }

  Future<void> addSlider(ShowSlider slider) {
    return _firebaseFirestore.collection('sliders').add(slider.toMap());
  }

  Future<void> updateSlider(ShowSlider slider) {
    final json = slider.toMap();
    return _firebaseFirestore
        .collection('sliders')
        .where('id', isEqualTo: slider.id)
        .get()
        .then((value) => value.docs.first.reference.update(json));
  }

  Future<void> updateSliderField(
      ShowSlider slider, String field, dynamic newValue) {
    return _firebaseFirestore
        .collection('sliders')
        .where('id', isEqualTo: slider.id)
        .get()
        .then((value) => {
              value.docs.first.reference.update(
                {field: newValue},
              ),
            });
  }

  Future<void> deleteSlider(String id) {
    return _firebaseFirestore
        .collection('sliders')
        .where('id', isEqualTo: id)
        .get()
        .then((value) => {value.docs.first.reference.delete()});
  }

  // users

  //update the id for product and categories
  Future<Product?> getLastIdForProducts() async {
    return _firebaseFirestore
        .collection('products')
        .orderBy('createAt', descending: false)
        .limit(1)
        .get()
        .then((snap) {
      if (snap.docs.isEmpty) return null;
      return Product.fromSnapshot(snap.docs.first);
    });
  }

  Future<Category?> getLastIdForCategories() async {
    return _firebaseFirestore
        .collection('categories')
        .orderBy('createAt', descending: false)
        .limit(1)
        .get()
        .then((snap) {
      if (snap.docs.isEmpty) return null;
      return Category.fromSnapshot(snap.docs.first);
    });
  }
}
