import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AdminCategoryScreen extends StatefulWidget {
  // final BuildContext cnx;
  const AdminCategoryScreen({super.key});

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {
  final CategoryController _categoryController = Get.put(CategoryController());

  bool showAddNewCategory = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Container(
            // height: 200,
            alignment: Alignment.centerRight,
            child:
                _buildElevatedButton(categoryController: _categoryController),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_categoryController.showNewCategory.value)
            AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: const _buildCreateNewCategory()),
          const SizedBox(
            height: 20,
          ),
          if (_categoryController.categories.isEmpty)
            Container(
              // height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.bg,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              margin: const EdgeInsets.all(5),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.exclamation,
                      size: 40,
                      color: MyColors.primaryColor,
                    ),
                    const Text(
                      'لم تقم باضافة اي تصنيف',
                      style: TextStyle(
                        color: MyColors.secondaryTextColor,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _buildElevatedButton(
                        categoryController: _categoryController),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          if (_categoryController.categories.isNotEmpty)
            GridView.builder(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _categoryController.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, i) {
                return _buildCategoryItem(
                  category: _categoryController.categories[i],
                );
              },
            ),
        ],
      ),
    );
  }
}

class _buildElevatedButton extends StatelessWidget {
  const _buildElevatedButton({
    Key? key,
    required CategoryController categoryController,
  })  : _categoryController = categoryController,
        super(key: key);

  final CategoryController _categoryController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        _categoryController.toggleShowNewCategory();
      },
      icon: FaIcon(
        !_categoryController.showNewCategory.value
            ? FontAwesomeIcons.plus
            : FontAwesomeIcons.arrowDown,
      ),
      label: const Text(
        ' اضف تصنيف',
        style: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _buildCategoryItem extends StatelessWidget {
  Category category;
  _buildCategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.containerColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                category.image,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      color: MyColors.primaryColor,
                      backgroundColor: Colors.white,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            )),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: MyColors.secondaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  category.title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: MyColors.lessBlackColor,
                  ),
                  maxLines: 1,
                ),
                Text(
                  category.description,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 10,
                    color: MyColors.secondaryTextColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}

Future<Object?> customDialog(BuildContext context) {
  return showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: 'categoryes',
    context: context,
    pageBuilder: (context, _, __) =>
        const Center(child: null // _buildCreateNewCategory(),
            ),
  );
}

class _buildCreateNewCategory extends StatefulWidget {
  const _buildCreateNewCategory({
    Key? key,
  }) : super(key: key);

  @override
  State<_buildCreateNewCategory> createState() =>
      _buildCreateNewCategoryState();
}

class _buildCreateNewCategoryState extends State<_buildCreateNewCategory> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool? setStatus = true;
  XFile? imagePicked;
  final formKey = GlobalKey<FormState>();
  bool upload = false;

  StorageService storage = StorageService();
  final CategoryController _categoryController = Get.find();
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
                '  تصنيف جديد',
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
                              controller: nameController,
                              numLine: 1,
                              hintText: '  اسم التصنيف',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'الحالة',
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
                                ? Container(
                                    color: MyColors.secondaryColor,
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
                controller: descriptionController,
                numLine: 1,
                hintText: '  وصف التصنيف',
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
                      if (!valid && imagePicked == null) return;
                      var uuid = const Uuid();

                      final category = Category(
                        cid: uuid.v1(),
                        title: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        image: imagePicked!.name,
                        status: setStatus ?? true,
                        id: 1,
                      );

                      try {
                        setState(() {
                          upload = true;
                        });
                        await storage.uploadImage(imagePicked!);
                        final imageString =
                            await storage.getDownloadURL(imagePicked!.name);

                        final category = Category(
                          cid: uuid.v1(),
                          title: nameController.text.trim(),
                          description: descriptionController.text.trim(),
                          image: imageString,
                          status: setStatus ?? true,
                          id: 1,
                        );

                        await _categoryController.addCategory(category);
                        nameController.clear();
                        descriptionController.clear();
                        imagePicked = null;
                        setStatus = true;
                      } catch (e) {
                        print(e);
                      } finally {
                        setState(() {
                          _categoryController.toggleShowNewCategory();

                          upload = false;
                        });
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
                      'اضافه',
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
  final String hintText;
  final controller;
  File? image;
  final int numLine;
  _builderTextFiel(
      {Key? key,
      required this.hintText,
      required this.numLine,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (name) =>
            name != null && name.length < 2 ? "الحقل فاضي" : null,
        minLines: numLine,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          hintText: hintText,
          border: OutlineInputBorder(
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
