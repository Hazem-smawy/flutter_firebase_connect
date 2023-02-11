import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/model/slider_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:get/state_manager.dart';

class SliderController extends GetxController {
  final DatabaseService database = DatabaseService();
  final StorageService storageService = StorageService();
  var sliders = <ShowSlider>[].obs;
  @override
  void onInit() {
    sliders.bindStream(database.getSliders());
    super.onInit();
  }

  var showNewSlider = false.obs;

  void toggleShowNewSlider() {
    showNewSlider.value = !showNewSlider.value;
  }

  var newSlider = {}.obs;

  bool get status => newSlider['status'];

  void updateSliderStatus(int index, ShowSlider slider, bool value) {
    slider.status = value;
    sliders[index] = slider;
  }

  void saveNewSiderStatus(ShowSlider slider, String field, bool value) {
    database.updateSliderField(slider, field, value);
  }

  Future<void> addSlider(ShowSlider slider) {
    return database.addSlider(slider);
  }

  Future<void> deleteImage(String imageURL) async {
   await storageService.deleteImageURL(imageURL);
  }

  Future<void> deleteSlider(String id, String imageURL)async {
  await  deleteImage(imageURL);
  await  database.deleteSlider(id);
  }

  Future<void> updateDocument(ShowSlider slider) async{
    //print('controller update');
   await database.updateSlider(slider);
  }
}
