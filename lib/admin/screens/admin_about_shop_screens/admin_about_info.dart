import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_about_controller.dart';
import 'package:flutter_fire_base/admin/model/info_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_title.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminInfoWidget extends StatefulWidget {
  const AdminInfoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminInfoWidget> createState() => _AdminInfoWidgetState();
}

class _AdminInfoWidgetState extends State<AdminInfoWidget> {
  XFile? imagePicked;

  String? imageUrl;

  AboutController aboutController = Get.put(AboutController());
  StorageService storage = StorageService();
  @override
  void initState() {
    // TODO: implement initState
    var info = aboutController.about;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Info?>(
        stream: aboutController.getAboutInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //   aboutController.newAboutInfo.update(
            //     'name',
            //     (_) => snapshot.data?.name,
            //     ifAbsent: () => snapshot.data?.name,
            //   );
            //   aboutController.newAboutInfo.update(
            //     'number',
            //     (_) => snapshot.data?.number,
            //     ifAbsent: () => snapshot.data?.number,
            //   );
            //   aboutController.newAboutInfo.update(
            //     'address',
            //     (_) => snapshot.data?.address,
            //     ifAbsent: () => snapshot.data?.address,
            //   );
            //   aboutController.newAboutInfo.update(
            //     'email',
            //     (_) => snapshot.data?.email,
            //     ifAbsent: () => snapshot.data?.email,
            //   );
            //   aboutController.newAboutInfo.update(
            //     'description',
            //     (_) => snapshot.data?.description,
            //     ifAbsent: () => snapshot.data?.description,
            //   );
            //   aboutController.newAboutInfo.update(
            //     'image',
            //     (_) => snapshot.data?.image,
            //     ifAbsent: () => snapshot.data?.image,
            //   );
            // print(aboutControlle-r.newAboutInfo);
            return Obx(
              () {
                return ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  shrinkWrap: true,
                  primary: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const AdminAboutTitleWidget(
                      title: 'المعلومات',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: MyColors.secondaryColor,
                      ),
                      width: 120,
                      height: 400,
                      child: Stack(
                        fit: StackFit.expand,
                        alignment: AlignmentDirectional.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imagePicked == null
                                ? snapshot.data?.image == null
                                    ? Container(
                                        color: MyColors.secondaryColor,
                                      )
                                    : Image.network(
                                        snapshot.data!.image,
                                        fit: BoxFit.cover,
                                        width: double.maxFinite,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: MyColors.primaryColor,
                                              backgroundColor: Colors.white,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder:
                                            (context, exception, stackTrack) =>
                                                Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          color: MyColors.secondaryColor,
                                          child: Column(
                                            children: const [
                                              Spacer(),
                                              Spacer(),
                                              Icon(
                                                Icons.error,
                                                size: 50,
                                                color: Colors.red,
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
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
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  // color: MyColors.secondaryColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                    child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 40,
                                  color: MyColors.primaryColor.withOpacity(0.5),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'ايقونة المتجر',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: MyColors.secondaryTextColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _builderTextFiel(
                      name: 'name',
                      hintText: 'اسم المتجر',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      name: 'number',
                      hintText: ' الرقم',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.number,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      name: 'address',
                      hintText: 'العنوان',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.address,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      name: 'email',
                      hintText: 'الايميل',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.email,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      minLines: 3,
                      name: 'description',
                      hintText: 'وصف المتجر',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.description,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (aboutController.isUpload)
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
                            ),
                          ),
                        ),
                      ),
                    if (!aboutController.isUpload)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                MyColors.primaryColor.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            minimumSize: const Size.fromHeight(56)),
                        onPressed: () async {
                          try {
                            aboutController.upload.value = true;
                            if (imagePicked != null) {
                              // if (aboutController.newAboutInfo['image'] !=
                              //     null) {
                              //   await aboutController.deleteImage(
                              //       aboutController.newAboutInfo['image']);
                              // }
                              await storage.uploadImage(
                                  imagePicked!, 'options');
                              var image = await storage.getDownloadURL(
                                  imagePicked!.name, 'options');
                              aboutController.newAboutInfo.update(
                                'image',
                                (value) => image,
                                ifAbsent: () => image,
                              );
                            }

                            var info = Info(
                              name: aboutController.newAboutInfo['name'] ??
                                  snapshot.data!.name,
                              image: aboutController.newAboutInfo['image'] ??
                                  snapshot.data?.image,
                              number: aboutController.newAboutInfo['number'] ??
                                  snapshot.data!.number,
                              address:
                                  aboutController.newAboutInfo['address'] ??
                                      snapshot.data!.address,
                              description:
                                  aboutController.newAboutInfo['description'] ??
                                      snapshot.data!.description,
                              email: aboutController.newAboutInfo['email'] ??
                                  snapshot.data!.email,
                            );
                            print(info);
                            await aboutController.setInfo(info);
                            aboutController.upload.value = false;
                          } catch (e) {
                            print(e.toString());
                          } finally {
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
                                        'تم التعديل بنجاح',
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
                                          border:
                                              Border.all(color: Colors.green),
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
                            Future.delayed(const Duration(seconds: 2))
                                .then((value) => Get.back());

                            aboutController.upload.value = false;
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.message,
                        ),
                        label: const Text(
                          '  ارسال البيانات',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            );
          }
          return Center(
            child: Container(),
          );
        });
  }
}

class _builderTextFiel extends StatelessWidget {
  final String name;
  final String hintText;
  String initialValue;
  int? minLines;
  AboutController aboutController;
  _builderTextFiel({
    Key? key,
    required this.name,
    required this.hintText,
    required this.aboutController,
    required this.initialValue,
    this.minLines = 1,
  }) : super(key: key);

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onChanged: (value) {
          aboutController.newAboutInfo.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        },
        maxLines: 3,
        minLines: minLines,
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (name) =>
            name != null && name.length < 2 ? "الحقل فاضي" : null,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
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
