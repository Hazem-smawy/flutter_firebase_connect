import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_about_controller.dart';
import 'package:flutter_fire_base/admin/model/contact_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_title.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminContactWidget extends StatefulWidget {
  const AdminContactWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminContactWidget> createState() => _AdminContactWidgetState();
}

class _AdminContactWidgetState extends State<AdminContactWidget> {
  AboutController aboutController = Get.put(AboutController());

  @override
  void initState() {
    aboutController.getContact();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Contact>(
        stream: aboutController.getContact(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Obx(
              () => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AdminAboutTitleWidget(
                      title: 'الا تصال والتواصل',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _builderTextFiel(
                      name: 'phone',
                      hintText: ' الهاتف',
                      aboutController: aboutController,
                      initialValue: snapshot.data!.phone,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      name: 'mobile',
                      hintText: ' مبايل',
                      aboutController: aboutController,
                      initialValue: snapshot.data?.mobile ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _builderTextFiel(
                      name: 'email',
                      hintText: 'الايميل',
                      aboutController: aboutController,
                      initialValue: snapshot.data?.email ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AdminContactSotialMediaLinks(
                      icon: FontAwesomeIcons.facebook,
                      color: Colors.blue,
                      hintText: 'فيسبوك',
                      name: 'facebook',
                      intialValue: snapshot.data?.facebook ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AdminContactSotialMediaLinks(
                      icon: FontAwesomeIcons.whatsapp,
                      color: Colors.green,
                      hintText: 'واتساب',
                      name: 'whatsapp',
                      intialValue: snapshot.data?.whatsapp ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AdminContactSotialMediaLinks(
                      icon: FontAwesomeIcons.twitter,
                      color: Colors.blue,
                      hintText: 'تويتر',
                      name: 'twitter',
                      intialValue: snapshot.data?.twitter ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AdminContactSotialMediaLinks(
                      icon: FontAwesomeIcons.instagram,
                      color: const Color.fromARGB(253, 126, 53, 26),
                      hintText: 'اينستجرام',
                      name: 'instegram',
                      intialValue: snapshot.data?.instegram ?? '',
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AdminContactSotialMediaLinks(
                      icon: FontAwesomeIcons.telegram,
                      color: Colors.blue,
                      hintText: 'تلجرام',
                      name: 'telegram',
                      intialValue: snapshot.data?.telegram ?? '',
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
                            var contact = Contact(
                                phone: aboutController.newContact['phone'] ??
                                    snapshot.data?.phone,
                                mobile: aboutController.newContact['mobile'] ??
                                    snapshot.data?.mobile,
                                email: aboutController.newContact['email'] ??
                                    snapshot.data?.email,
                                facebook:
                                    aboutController.newContact['facebook'] ??
                                        snapshot.data?.facebook,
                                whatsapp:
                                    aboutController.newContact['whatsapp'] ??
                                        snapshot.data?.whatsapp,
                                telegram:
                                    aboutController.newContact['telegram'] ??
                                        snapshot.data?.telegram,
                                instegram:
                                    aboutController.newContact['instegram'] ??
                                        snapshot.data?.phone,
                                twitter:
                                    aboutController.newContact['twitter'] ??
                                        snapshot.data?.phone);
                            await aboutController.setContact(contact);
                            aboutController.upload.value = false;
                          } catch (e) {
                            aboutController.upload.value = false;
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
                            Future.delayed(const Duration(seconds: 1))
                                .then((value) => Get.back());
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
                      )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              child: null,
            );
          }
        });
  }
}

class AdminContactSotialMediaLinks extends StatelessWidget {
  IconData icon;
  Color color;
  final hintText;
  final name;
  final intialValue;

  AdminContactSotialMediaLinks({
    super.key,
    required this.icon,
    required this.color,
    required this.hintText,
    required this.intialValue,
    required this.name,
  });
  AboutController aboutController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: _builderTextFiel(
          name: name,
          hintText: hintText,
          aboutController: aboutController,
          initialValue: intialValue,
        )),
        const SizedBox(
          width: 10,
        ),
        Container(
          width: 50,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.secondaryTextColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FaIcon(
              icon,
              size: 25,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _builderTextFiel extends StatelessWidget {
  final String name;
  final String hintText;
  int? minLines;
  AboutController aboutController;
  String initialValue;
  _builderTextFiel({
    Key? key,
    required this.name,
    required this.hintText,
    required this.aboutController,
    required this.initialValue,
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
          aboutController.newContact.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        },
        initialValue: initialValue, //aboutController.newContact[name],
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
