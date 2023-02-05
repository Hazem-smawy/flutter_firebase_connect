import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_about_controller.dart';
import 'package:flutter_fire_base/admin/model/about_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_title.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class AdminOptionAboutShopWidget extends StatefulWidget {
  const AdminOptionAboutShopWidget({
    super.key,
  });

  @override
  State<AdminOptionAboutShopWidget> createState() =>
      _AdminOptionAboutShopWidgetState();
}

class _AdminOptionAboutShopWidgetState
    extends State<AdminOptionAboutShopWidget> {
  bool showNewAbout = false;
  AboutController aboutController = Get.put(AboutController());
  final listController = ScrollController();
  void _scrollTop() {
    listController.animateTo(
      listController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Obx(
        () => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AdminAboutTitleWidget(title: 'عن المتجر'),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(200, 50)),
                    onPressed: () {
                      aboutController.newAbout.clear();
                      setState(() {
                        aboutController.newAboutOpen.value =
                            !aboutController.newAboutOpen.value;
                      });
                    },
                    icon: FaIcon(
                      !aboutController.isOpen
                          ? FontAwesomeIcons.plus
                          : FontAwesomeIcons.angleDown,
                      size: 20,
                    ),
                    label: Text(
                      !aboutController.isOpen ? 'اضافة خدمه' : 'تراجــــع',
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // const SizedBox(
            //   height: 10,
            // ),
            if (aboutController.isOpen) NewAboutWidget(),
            const SizedBox(
              height: 20,
            ),
            if (aboutController.about.isEmpty) const Text('No data'),
            if (aboutController.about.isNotEmpty)
              Obx(
                () => ListView.builder(
                    controller: listController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: aboutController.about.length,
                    itemBuilder: ((context, index) {
                      return AboutItemWidget(
                        onClickScroll: _scrollTop,
                        about: aboutController.about[index],
                      );
                    })),
              )
          ],
        ),
      ),
    );
  }
}

class AboutItemWidget extends StatelessWidget {
  VoidCallback onClickScroll;
  About about;
  AboutItemWidget({
    required this.about,
    required this.onClickScroll,
    Key? key,
  }) : super(key: key);

  quill.QuillController controller = quill.QuillController.basic();

  AboutController aboutController = Get.find();

  @override
  Widget build(BuildContext context) {
    controller = quill.QuillController(
      document: quill.Document.fromJson(about.description),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.bg,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(1, 1),
              blurRadius: 20)
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            'الخدمه',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
              color: MyColors.primaryColor,
              fontWeight: FontWeight.normal,
            ),
          ),

          Text(
            about.title,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 16,
              color: MyColors.secondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text(
          //   'وصف الخدمه',
          //   textAlign: TextAlign.right,
          //   textDirection: TextDirection.rtl,
          //   style: TextStyle(
          //     fontFamily: 'Cairo',
          //     fontSize: 16,
          //     color: MyColors.lessBlackColor,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),

          // Container(
          //   child:
          //       quill.QuillEditor.basic(controller: controller, readOnly: true),
          // ),
          //  Text(

          //   textAlign: TextAlign.right,
          //   textDirection: TextDirection.rtl,
          //   style: TextStyle(
          //     fontFamily: 'Cairo',
          //     fontSize: 13,
          //     color: MyColors.secondaryTextColor,
          //     fontWeight: FontWeight.normal,
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: '',
                      content: Column(
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.question,
                            size: 30,
                            color: MyColors.primaryColor,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'هل انت متأمد من حذف ',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              color: MyColors.lessBlackColor,
                            ),
                          ),
                          Text(
                            ' هذه الخدمة  ؟',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              color: MyColors.lessBlackColor,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                //  minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  // side: const BorderSide(
                                  //  color: MyColors.secondaryTextColor),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: MyColors.secondaryColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  'تراجع',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 15,
                                    color: MyColors.blackColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  aboutController.deleteAbout(about.id);
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  // minimumSize: const Size.fromHeight(50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  backgroundColor: MyColors.primaryColor,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Text(
                                    'حذف',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ],
                        )
                      ]);
                },
                child: const FaIcon(
                  FontAwesomeIcons.trash,
                  color: Colors.red,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  aboutController.newAboutOpen.value = false;
                  aboutController.newAbout.clear();
                  aboutController.newAbout.addAll(about.toMap());
                  print(aboutController.newAbout);
                  aboutController.newAboutOpen.value = true;
                  onClickScroll();
                },
                child: const FaIcon(
                  FontAwesomeIcons.penToSquare,
                  color: Colors.green,
                  size: 20,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NewAboutWidget extends StatelessWidget {
  NewAboutWidget({super.key});
  quill.QuillController quillController = quill.QuillController.basic();
  AboutController aboutController = Get.find();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (aboutController.newAbout['id'] != null) {
      nameController.text = aboutController.newAbout['title'];
      quillController = quill.QuillController(
        document:
            quill.Document.fromJson(aboutController.newAbout['description']),
        selection: const TextSelection.collapsed(offset: 0),
      );
    }
    return Obx(
      () => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _builderTextFiel(
              controller: nameController,
              name: 'title',
              hintText: 'اسم الخدمه',
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'الوصف ',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 16,
                color: MyColors.secondaryTextColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: quill.QuillToolbar.basic(
                showDirection: true,
                showRightAlignment: true,
                showLeftAlignment: true,
                showAlignmentButtons: true,
                fontFamilyValues: const {'cairo': 'Cairo'},
                multiRowsDisplay: false,
                controller: quillController,
                showBackgroundColorButton: true,
                toolbarSectionSpacing: 10,
                toolbarIconSize: 20,
                iconTheme: const quill.QuillIconTheme(
                  borderRadius: 10,
                  iconUnselectedFillColor: MyColors.containerColor,
                  iconSelectedFillColor: MyColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.all(7),
              constraints: const BoxConstraints(minHeight: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: MyColors.containerColor,
              ),
              child: quill.QuillEditor.basic(
                controller: quillController,
                readOnly: false,
              ),
            ),
            const SizedBox(
              height: 20,
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
                      )))),
            //  const FaIcon(FontAwesomeIcons),
            if (!aboutController.isUpload)
              ElevatedButton.icon(
                onPressed: () async {
                  if (nameController.text.length > 2 &&
                      quillController.document.toPlainText().length > 2) {
                    const uuid = Uuid();
                    final id = uuid.v4();
                    final about = About(
                        id: aboutController.newAbout['id'] ?? id,
                        title: nameController.text.trim(),
                        description:
                            quillController.document.toDelta().toJson());
                    print(about);
                    try {
                      aboutController.upload.value = true;

                      aboutController.newAbout['id'] == null
                          ? await aboutController.addAbout(about)
                          : await aboutController.updateAbout(
                              aboutController.newAbout['id'], about);
                      aboutController.upload.value = false;
                      aboutController.newAboutOpen.value = false;
                      aboutController.newAbout.clear();
                    } catch (e) {
                      print(e.toString());
                      aboutController.upload.value = false;
                      aboutController.newAbout.clear();
                    } finally {
                      quillController.clear();
                      nameController.clear();
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
                      Future.delayed(const Duration(seconds: 2))
                          .then((value) => Get.back());
                    }
                  }
                },
                icon: const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 16,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  minimumSize: const Size.fromHeight(55),
                  backgroundColor: MyColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                label: const Text(
                  'اضافه',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: () {
                aboutController.newAboutOpen.value = false;
                aboutController.newAbout.clear();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(55),
                backgroundColor: MyColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'تراجع',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _builderTextFiel extends StatelessWidget {
  final String name;
  final String hintText;
  final controller;
  const _builderTextFiel(
      {Key? key,
      required this.name,
      required this.hintText,
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
            name != null && name.length < 2 ? "الحقل فاضي" : null,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          filled: true,
          fillColor: MyColors.bg,
          contentPadding:
              const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.pink),
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
