import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_slider_controller.dart';
import 'package:flutter_fire_base/admin/model/slider_model.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AdminCreateNewSlider extends StatefulWidget {
  const AdminCreateNewSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminCreateNewSlider> createState() => AdminCreateNewSliderState();
}

class AdminCreateNewSliderState extends State<AdminCreateNewSlider> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool? setStatus = true;
  XFile? imagePicked;
  String? imageUrl;
  final formKey = GlobalKey<FormState>();
  bool upload = false;

  StorageService storage = StorageService();
  final SliderController sliderController = Get.put(SliderController());
  @override
  void initState() {
    nameController.text = sliderController.newSlider['title'] ?? '';
    descriptionController.text =
        sliderController.newSlider['description'] ?? '';

    // TODO: implement initState
    super.initState();
    setStatus = sliderController.newSlider['status'] ?? true;
    imageUrl = sliderController.newSlider['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // duration: const Duration(microseconds: 300),
      height: 500,
      width: double.maxFinite,
      // margin: const EdgeInsets.symmetric(
      //   horizontal: 30,
      // ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
          color: MyColors.bg, borderRadius: BorderRadius.circular(40)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                '  ???????????? ????????',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: MyColors.primaryColor,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Column(
                          children: [
                            _builderTextFiel(
                              name: 'title',
                              controller: nameController,
                              numLine: 1,
                              hintText: '  ??????????????',
                              sliderController: sliderController,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  '????????????',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 14,
                                      color: MyColors.secondaryTextColor),
                                ),
                                Checkbox(
                                    activeColor: MyColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: setStatus,
                                    onChanged: ((value) {
                                      if (sliderController
                                          .newSlider.isNotEmpty) {
                                        sliderController.newSlider.update(
                                            'status', (value) => value,
                                            ifAbsent: (() => value));
                                      }

                                      setState(() {
                                        setStatus = value;
                                      });
                                    }))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: MyColors.secondaryColor,
                      ),
                      width: 100,
                      height: 100,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: AlignmentDirectional.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imagePicked == null
                                ? imageUrl == null
                                    ? Container(
                                        color: MyColors.secondaryColor,
                                      )
                                    : Image.network(
                                        imageUrl!,
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                      )
                                : Image.file(
                                    File(imagePicked!.path),
                                    fit: BoxFit.cover,
                                    width: double.maxFinite,
                                  ),
                          ),
                          InkWell(
                            radius: 10,
                            onTap: () async {
                              final imagePicker = ImagePicker();
                              XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image == null) return;
                              setState(() {
                                imagePicked = image;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                // color: MyColors.secondaryColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                  child: FaIcon(
                                FontAwesomeIcons.circlePlus,
                                size: 25,
                                color: MyColors.primaryColor.withOpacity(0.5),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _builderTextFiel(
                name: 'description',
                controller: descriptionController,
                sliderController: sliderController,
                numLine: 1,
                hintText: '  ?????? ??????????????',
              ),
              const SizedBox(
                height: 20,
              ),
              if (upload)
                Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.secondaryColor,
                    ),
                    child: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: Colors.white,
                          color: MyColors.primaryColor,
                        )))),
              //  const FaIcon(FontAwesomeIcons),
              if (!upload)
                ElevatedButton.icon(
                    onPressed: () async {
                      final valid = formKey.currentState!.validate();
                      if (sliderController.newSlider.isNotEmpty) {
                        setState(() {
                          upload = true;
                        });
                        var currentImage = '';
                        if (imagePicked == null) {
                          currentImage = imageUrl!;
                        } else {
                          await storage.uploadImage(imagePicked!, 'sliders');
                          currentImage = await storage.getDownloadURL(
                              imagePicked!.name, 'sliders');
                          await sliderController.deleteImage(imageUrl!);
                        }
                        var updateSlider = ShowSlider(
                          id: sliderController.newSlider['id'],
                          title: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          image: currentImage,
                          status:
                              setStatus ?? sliderController.newSlider['status'],
                        );
                        if (updateSlider.title != '' &&
                            updateSlider.description != '' &&
                            updateSlider.image != '') {
                          await sliderController.updateDocument(updateSlider);
                        }
                        nameController.clear();
                        descriptionController.clear();
                        imagePicked = null;
                        setStatus = true;
                        // print('updated category');
                        // print(updatedCategory);
                        sliderController.toggleShowNewSlider();

                        setState(() {
                          upload = false;
                        });
                        Get.defaultDialog(
                            title: '',
                            // backgroundColor: MyColors.bg.withOpacity(0.2),
                            content: SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '???? ?????????????? ??????????',
                                    style: TextStyle(
                                      color: MyColors.secondaryTextColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    // width: 50,height: 50,

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.green),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 35,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              )),
                            ));
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) => Get.back());
                        return;
                      }
                      if (!valid && imagePicked == null) return;
                      var uuid = const Uuid();

                      try {
                        setState(() {
                          upload = true;
                        });
                        await storage.uploadImage(imagePicked!, 'sliders');
                        final imageString = await storage.getDownloadURL(
                            imagePicked!.name, 'sliders');

                        final showSlider = ShowSlider(
                          id: uuid.v1(),
                          title: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          image: imageString,
                          status: setStatus ?? true,
                        );

                        await sliderController.addSlider(showSlider);
                        nameController.clear();
                        descriptionController.clear();
                        imagePicked = null;
                        setStatus = true;
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          sliderController.toggleShowNewSlider();

                          upload = false;
                        });
                        Get.defaultDialog(
                            title: '',
                            // backgroundColor: MyColors.bg.withOpacity(0.2),
                            content: SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '???? ?????????????? ??????????',
                                    style: TextStyle(
                                      color: MyColors.secondaryTextColor,
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    // width: 50,height: 50,

                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.green),
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 35,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              )),
                            ));
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) => Get.back());
                      }
                    },
                    icon: const FaIcon(FontAwesomeIcons.plus),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(55),
                      backgroundColor: MyColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    label: const Text(
                      '??????????',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                        color: Colors.white,
                      ),
                    ))
            ],
          ),
        ),
      ),
    );
  }
}

class _builderTextFiel extends StatelessWidget {
  final String name;
  final String hintText;
  final controller;
  SliderController sliderController;

  final int numLine;
  _builderTextFiel(
      {Key? key,
      required this.name,
      required this.sliderController,
      required this.hintText,
      required this.numLine,
      required this.controller})
      : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        //  initialValue: " ",
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (name) =>
            name != null && name.length < 2 ? "?????????? ????????" : null,
        minLines: numLine,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: MyColors.secondaryTextColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(15),
          ),
          errorStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: Colors.red,
          ),
          hintStyle: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 12,
            color: MyColors.secondaryTextColor,
          ),
        ),
        style: const TextStyle(
          color: MyColors.blackColor,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
