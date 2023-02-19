import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddCategoryScreen extends StatefulWidget {
  Category? category;
  AddCategoryScreen({this.category});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  File? imageFile;
  final CategoryController categoryController = Get.put(CategoryController());
  final StorageService storage = StorageService();
  final DatabaseService database = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          child: Form(
              child: Column(
            children: [
              _buildTextFormField(
                title: 'id',
                hintText: '  inter the id of category',
                intialValue: widget.category?.cid ?? '',
                name: 'cid',
                categoryController: categoryController,
              ),
              _buildTextFormField(
                title: ' name',
                hintText: ' inter the category name',
                intialValue: widget.category?.title ?? '',
                name: 'title',
                categoryController: categoryController,
              ),
              _buildTextFormField(
                title: 'description',
                hintText:
                    widget.category?.description ?? '  inter some description',
                intialValue: widget.category?.title ?? '',
                name: 'description',
                categoryController: categoryController,
              ),
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: (categoryController.newCategory['status'] == null)
                          ? widget.category?.status ?? false
                          : categoryController.status,
                      onChanged: (value) {
                        categoryController.newCategory.update(
                          'status',
                          (_) => value,
                          ifAbsent: () => value,
                        );
                      },
                    ),
                    Text(
                      'Status ',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: MyColors.blackColor,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: MyColors.containerColor,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      ImagePicker imagePicker = ImagePicker();
                      final XFile? image = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      if (image == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("You don't choose any image")));
                        return;
                      }

                      File? file = File(image.path);
                      setState(() {
                        imageFile = file;
                      });
                      await storage.uploadImage(image,'category_images');
                      var imageURL = await storage.getDownloadURL(image.name,'category_images');
                      categoryController.newCategory.update(
                        'image',
                        (_) => imageURL,
                        ifAbsent: () => imageURL,
                      );

                      // pickedFile = file as Future<PickedFile?>;
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: imageFile == null
                                ? widget.category?.image != null
                                    ? Image.network(
                                        widget.category?.image ?? '',
                                        fit: BoxFit.cover,
                                      )
                                    : const SizedBox()
                                : Image.file(
                                    imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: double.minPositive,
                          // color: MyColors.bg,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.plus,
                                size: 35,
                                color: MyColors.secondaryTextColor,
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              Text(
                                'image',
                                style: GoogleFonts.roboto(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.secondaryTextColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.category != null) {
                    var curentCategory = categoryController.newCategory;
                    var oldCategory = widget.category;
                    var newCategory = Category(
                      cid: curentCategory['cid'] ?? oldCategory?.cid,
                      title: curentCategory['title'] ?? oldCategory?.title,
                      description: curentCategory['description'] ??
                          oldCategory?.description,
                      image: curentCategory['image'] ?? oldCategory?.image,
                      id: curentCategory['id'] ?? oldCategory?.id,
                      createAt:curentCategory['createAt']?? oldCategory?.createAt,
                    );
                    //print(newCategory);

                    categoryController.updateDocument(newCategory);
                    return;
                  }
                  try {
                    await database.addCategory(Category(
                      cid: categoryController.newCategory['cid'],
                      title: categoryController.newCategory['title'],
                      description:
                          categoryController.newCategory['description'],
                      image: categoryController.newCategory['image'],
                      id: 1,
                      createAt: DateTime.now(),
                      status:
                          (categoryController.newCategory['status'] == null)
                              ? false
                              : categoryController.newCategory['status'],
                    ));
                    Get.back();
                  } catch (e) {
                    print('some Error $e');
                  } finally {}
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: MyColors.secondaryTextColor),
                  width: double.maxFinite,
                  height: 60,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.plus,
                          color: MyColors.bg,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'add category',
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MyColors.bg),
                        ),
                      ]),
                ),
              ),
            ],
          )),
        ),
      ),
    ));
  }
}

class _buildTextFormField extends StatelessWidget {
  final title;
  final hintText;
  final intialValue;
  String name;
  CategoryController categoryController;
  _buildTextFormField({
    required this.title,
    required this.hintText,
    required this.intialValue,
    required this.name,
    required this.categoryController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: MyColors.blackColor),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.containerColor,
          ),
          child: TextFormField(
            initialValue: intialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: GoogleFonts.roboto(
                  fontSize: 13, color: MyColors.secondaryTextColor),
            ),
            onChanged: (value) {
              categoryController.newCategory.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
