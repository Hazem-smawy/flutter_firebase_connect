import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/admin/services/storage_service.dart';
import 'package:flutter_fire_base/client/home/client_bottom_navigation.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_fire_base/admin/model/user_model.dart' as myUser;
import 'package:intl/intl.dart' as timeFormat;

class ClientOrderCompletedScreen extends StatefulWidget {
  Order order;
  myUser.User currentUser;

  ClientOrderCompletedScreen(
      {Key? key, required this.order, required this.currentUser})
      : super(key: key);

  @override
  State<ClientOrderCompletedScreen> createState() =>
      ClientOrderCompletedScreenState();
}

class ClientOrderCompletedScreenState
    extends State<ClientOrderCompletedScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  OrderController orderController = Get.find();

  StorageService storage = StorageService();
  XFile? imagePicked;
  bool upload = false;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser;
    super.initState();
    country = countries[0];
    cities = yCities;
    city = yCities[0];
  }

  var country = '';
  var countries = ['اليمن', 'السعودية'];
  var city = '';
  var yCities = ['اب', 'صنعاء'];
  var sCityes = ['الرياض', 'ابها'];
  var cities = [''];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          // horizontal: 30,
        ),
        child: Column(children: [
          Container(
            //  height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lessBlackColor,
                  ),
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  RichText(
                                      text: TextSpan(
                                    text: widget.currentUser.name,
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MyColors.containerColor,
                                    ),
                                  )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const FaIcon(
                                    FontAwesomeIcons.user,
                                    size: 15,
                                    color: MyColors.containerColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  left: 10,
                                ),
                                child: RichText(
                                    textDirection: TextDirection.rtl,
                                    text: const TextSpan(
                                        text: 'رقم الطلب : ',
                                        style: TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.containerColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '1',
                                          )
                                        ])),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  left: 10,
                                ),
                                child: Text(
                                  timeFormat.DateFormat.yMMMMEEEEd()
                                      .format(DateTime.now()),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: MyColors.secondaryTextColor,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: -5,
                  child: Container(
                      width: 140,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: MyColors.bg,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.green.withOpacity(0.8),
                        ),
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(2),
                        alignment: Alignment.center,
                        child: const Center(
                          child: Text(
                            '  قم بتأكيد الطلب',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: MyColors.bg,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                        ),
                        alignment: Alignment.bottomCenter,
                        child: DropdownButton(
                          // isDense: true,
                          alignment: AlignmentDirectional.center,
                          borderRadius: BorderRadius.circular(13),
                          underline: const Text(''),
                          style: const TextStyle(
                            color: MyColors.bg,
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                          ),
                          // Initial Value
                          value: city,

                          // Down Arrow Icon
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.lessBlackColor,
                          ),
                          isExpanded: true,
                          // Array list of items
                          dropdownColor: MyColors.containerColor,
                          items: cities.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      items,
                                      style: const TextStyle(
                                        color: MyColors.lessBlackColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (items != city)
                                      const Divider(
                                        color: MyColors.secondaryTextColor,
                                      )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              city = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                        ),
                        alignment: Alignment.centerRight,
                        child: DropdownButton(
                          isExpanded: true,

                          alignment: AlignmentDirectional.center,
                          borderRadius: BorderRadius.circular(13),
                          underline: const Text(''),
                          style: const TextStyle(
                            color: MyColors.bg,
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            // fontWeight: FontWeight.bold,
                          ),
                          // Initial Value
                          value: country,
                          // Down Arrow Icon
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: MyColors.lessBlackColor,
                          ),

                          // Array list of items
                          dropdownColor: MyColors.containerColor,
                          items: countries.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      items,
                                      style: const TextStyle(
                                        color: MyColors.lessBlackColor,
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (items != country)
                                      const Divider(
                                        color: MyColors.secondaryTextColor,
                                      )
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (String? newValue) {
                            setState(() {
                              country = newValue!;
                            });

                            if (newValue == countries[1]) {
                              setState(() {
                                cities = sCityes;
                                city = sCityes[0];
                              });
                            } else {
                              setState(() {
                                cities = yCities;
                                city = yCities[0];
                              });
                            }
                          },
                        ),

                        // After selecting the desired option,it will
                        // change button value to selected value
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.lessBlackColor,
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                _builderTextFiel(
                  controller: addressController,
                  numLine: 1,
                  hintText: '   العنوان',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: MyColors.secondaryColor,
                          ),
                          width: 100,
                          height: 100,
                          child: Stack(
                            fit: StackFit.loose,
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Center(
                                      child: FaIcon(
                                    FontAwesomeIcons.noteSticky,
                                    size: 25,
                                    color: MyColors.lessBlackColor,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'صوره فاتورة الدفع',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: MyColors.secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                //const Spacer(),
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
                        ),
                      ),
                    ),
                  ),
                if (!upload)
                  ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          DatabaseService databaseService = DatabaseService();
                          if (imagePicked == null) {
                            Utils.showSnackBar('ادرج الصوره');
                            return;
                          }
                          if (addressController.text.isEmpty) {
                            Utils.showSnackBar('ادخل كل البيانات المطلوبه');
                            return;
                          }
                          setState(() {
                            upload = true;
                          });

                          await storage.uploadImage(
                              imagePicked!, 'order_image');
                          var imageString = await storage.getDownloadURL(
                              imagePicked!.name, 'order_image');

                          OrderCompleted? lastOrderCompleted =
                              await databaseService.getLastCompletedOrder();
                          String lastId = '0';
                          if (lastOrderCompleted != null) {
                            lastId = lastOrderCompleted.id;
                          }
                          String id = (int.parse(lastId) + 1).toString();
                          print(id);
                          final newOrderCompleted = OrderCompleted(
                            id: id,
                            country: country.trim(),
                            city: city.trim(),
                            address: addressController.text.trim(),
                            image: imageString,
                            order: widget.order,
                            completedOn: DateTime.now(),
                          );

                          //print(newOrderCompleted);
                          await databaseService
                              .addCompletedOrder(newOrderCompleted);
                          await databaseService
                              .deleteFavoriteAfterAddedToOrder(widget.order.id);
                          setState(() {
                            upload = false;
                          });
                          Utils.showSnackBar('تم اضافة المنتجات للسله');
                          Get.offAll(() => const ClientBottomNavigation());
                          countryController.clear();
                          cityController.clear();
                          addressController.clear();
                          imageString = '';
                          orderController.orderDetails.clear();
                        } catch (e) {
                          print(e.toString());
                        } finally {}
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.plus,
                        size: 20,
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(55),
                        backgroundColor: MyColors.primaryColor ,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      label: const Text(
                        'تاكيد الطلب',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                          color: Colors.white,
                        ),
                      ))
              ],
            ),
          )
        ]),
      )),
    );
  }
}

class _builderTextFiel extends StatelessWidget {
  final String hintText;
  final controller;

  final int numLine;
  const _builderTextFiel(
      {Key? key,
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
        //  validator: (name) =>
        //  name != null && name.length < 2 ? "الحقل فاضي" : null,
        //  minLines: numLine,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
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
