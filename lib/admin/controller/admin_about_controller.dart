import 'package:flutter_fire_base/admin/model/about_model.dart';
import 'package:flutter_fire_base/admin/model/contact_model.dart';
import 'package:flutter_fire_base/admin/model/info_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:get/state_manager.dart';

class AboutController extends GetxController {
  final DatabaseService database = DatabaseService();
  final StorageService storageService = StorageService();
  var about = <About>[].obs;
  var newAbout = {}.obs;
  var aboutInfo = {}.obs;
  var newAboutInfo = {}.obs;
  var newContact = {}.obs;
  @override
  void onInit() async {
    getAboutInfo();
    getContact();
    about.bindStream(database.getAbout());

    super.onInit();
  }

  Stream<Info> getAboutInfo() {
    return database.getAboutInfo();
  }

  var categoryId = ''.obs;
  var upload = false.obs;
  var newAboutOpen = false.obs;
  var scrollToTop = false.obs;

  get isUpload => upload.value;
  get isOpen => newAboutOpen.value;

  Future<void> setInfo(Info info) async {
    await database.addAboutInfo(info);
  }

  Future<void> deleteImage(String imageURL) async {
    await storageService.deleteImageURL(imageURL);
  }

  Future<void> setContact(Contact contact) async {
    await database.addAboutContact(contact);
  }

  Stream<Contact> getContact() {
    return database.getAboutContact();
  }

  Future<void> addAbout(About about) async {
    await database.addAbout(about);
  }

  Future<void> deleteAbout(String id) async {
    await database.deleteAbout(id);
  }

  Future<void> updateAbout(String id, About about) async {
    await database.updateAbout(id, about);
  }
}
