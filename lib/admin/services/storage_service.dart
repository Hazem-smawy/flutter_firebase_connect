import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class StorageService {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImage(XFile image,String fileName) async {
    await storage
        .ref('$fileName/${image.name}')
        .putFile(File(image.path));
  }

  Future<String> getDownloadURL(String imageName,String fileName) async {
    String downloadURL =
        await storage.ref('$fileName/$imageName').getDownloadURL();
    return downloadURL;
  }

  Future<void> deleteImageURL(String url) async {
    return await storage.refFromURL(url).delete();
  }
}
