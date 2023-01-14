import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage(XFile image) async {
    await storage
        .ref('category_images/${image.name}')
        .putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL =
        await storage.ref('category_images/$imageName').getDownloadURL();
    return downloadURL;
  }

  Future<void> deleteImageURL(String url) async {
    return await storage.refFromURL(url).delete();
  }
}
