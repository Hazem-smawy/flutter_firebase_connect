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
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_fire_base/admin/model/user_model.dart' as myUser;

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
  bool mapToggle = false;
  Position? currentLocation;
  LatLng? location;

  late GoogleMapController mapController;

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAuth.instance.currentUser;
    _handleLocationPermission();
    // _determinePosition().then((value) {
    //   setState(() {
    //     currentLocation = value;
    //     print(value);
    //     mapToggle = true;
    //   });
    // });
    super.initState();
    country = countries[0];
    cities = yCities;
    city = yCities[0];

    // Geolocator.getCurrentPosition().then((currloc) {
    //   setState(() {
    //     currentLocation = currloc;
    //     mapToggle = true;
    //   });
    // });
  }

  String? currentAddress;

  var country = '';
  var countries = ['اليمن', 'السعودية'];
  var city = '';
  var yCities = ['اب', 'صنعاء'];
  var sCityes = ['الرياض', 'ابها'];
  var cities = [''];

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  // Future<void> _getAddressFromLatLng(Position position) async {
  //   await placemarkFromCoordinates(
  //           currentLocation!.latitude, currentLocation!.longitude)
  //       .then((List<Placemark> placemarks) {
  //     Placemark place = placemarks[0];
  //     setState(() {
  //       currentAddress =
  //           '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

  //       if (currentAddress!.isNotEmpty) {
  //         addressController.text = currentAddress!;
  //       }
  //     });
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Utils.showSnackBar(
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Utils.showSnackBar('Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.showSnackBar(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final Set<Marker> _markers = {};

  void _addMarker(LatLng latLang) {
    setState(() {
      _markers.add(
        Marker(
            markerId: const MarkerId('dkdkd'),
            position: LatLng(latLang.latitude, latLang.longitude),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }

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
          // Container(
          //   //  height: 300,
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(10),
          //   margin: const EdgeInsets.all(8),
          //   child: Stack(
          //     clipBehavior: Clip.none,
          //     children: [
          //       Container(
          //         height: 150,
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           borderRadius: BorderRadius.circular(10),
          //           color: MyColors.lessBlackColor,
          //         ),
          //         margin: const EdgeInsets.only(bottom: 20),
          //         padding: const EdgeInsets.all(20),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 Expanded(
          //                   child: Padding(
          //                     padding: const EdgeInsets.only(left: 10),
          //                     child: Row(
          //                       children: [
          //                         RichText(
          //                             text: TextSpan(
          //                           text: widget.currentUser.name,
          //                           style: const TextStyle(
          //                             fontFamily: 'Cairo',
          //                             fontSize: 16,
          //                             fontWeight: FontWeight.bold,
          //                             color: MyColors.containerColor,
          //                           ),
          //                         )),
          //                         const SizedBox(
          //                           width: 10,
          //                         ),
          //                         const FaIcon(
          //                           FontAwesomeIcons.user,
          //                           size: 15,
          //                           color: MyColors.containerColor,
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //                 Column(
          //                   crossAxisAlignment: CrossAxisAlignment.end,
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                         top: 8.0,
          //                         left: 10,
          //                       ),
          //                       child: RichText(
          //                           textDirection: TextDirection.rtl,
          //                           text: const TextSpan(
          //                               text: 'رقم الطلب : ',
          //                               style: TextStyle(
          //                                 fontFamily: 'Cairo',
          //                                 fontSize: 16,
          //                                 fontWeight: FontWeight.bold,
          //                                 color: MyColors.containerColor,
          //                               ),
          //                               children: [
          //                                 TextSpan(
          //                                   text: '1',
          //                                 )
          //                               ])),
          //                     ),
          //                     Padding(
          //                       padding: const EdgeInsets.only(
          //                         top: 8.0,
          //                         left: 10,
          //                       ),
          //                       child: Text(
          //                         dateFormate.DateFormat.yMMMMEEEEd()
          //                             .format(DateTime.now()),
          //                         style: const TextStyle(
          //                           fontFamily: 'Cairo',
          //                           fontSize: 10,
          //                           fontWeight: FontWeight.bold,
          //                           color: MyColors.secondaryTextColor,
          //                         ),
          //                       ),
          //                     )
          //                   ],
          //                 )
          //               ],
          //             )
          //           ],
          //         ),
          //       ),
          //       Positioned(
          //         right: 10,
          //         bottom: -5,
          //         child: Container(
          //             width: 140,
          //             height: 50,
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(24),
          //               color: MyColors.bg,
          //             ),
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(24),
          //                 color: Colors.green.withOpacity(0.8),
          //               ),
          //               padding: const EdgeInsets.all(8.0),
          //               margin: const EdgeInsets.all(2),
          //               alignment: Alignment.center,
          //               child: const Center(
          //                 child: Text(
          //                   '  قم بتأكيد الطلب',
          //                   style: TextStyle(
          //                     fontFamily: 'Cairo',
          //                     fontSize: 11,
          //                     fontWeight: FontWeight.bold,
          //                     color: MyColors.bg,
          //                   ),
          //                 ),
          //               ),
          //             )),
          //       ),
          //     ],
          //   ),
          // ),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.lessBlackColor,
              boxShadow: [
                BoxShadow(
                  color: MyColors.lessBlackColor.withOpacity(0.08),
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const SizedBox(
                    width: 100,
                    child: SizedBox(
                      child: FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 18,
                        color: MyColors.containerColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                const Text(
                  'تأكيد الطلب',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyColors.containerColor,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  width: 10,
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
                                location = const LatLng(23.8859, 45.0792);

                                mapController.animateCamera(
                                    CameraUpdate.newLatLngZoom(location!, 5 ));
                              });
                            } else {
                              setState(() {
                                cities = yCities;
                                city = yCities[0];
                                location = const LatLng(15.5527, 48.5164);

                                mapController.animateCamera(
                                    CameraUpdate.newLatLngZoom(location!, 5));
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
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.lessBlackColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            offset: const Offset(1, 1),
                            blurRadius: 10,
                            blurStyle: BlurStyle.outer,
                          )
                        ]),
                    child: mapToggle == false
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: GoogleMap(
                              //mapType: MapType.normal,
                              onTap: ((argument) async {
                                _addMarker(argument);
                                // mapController.animateCamera(
                                //  CameraUpdate.newLatLngZoom(argument, 10));

                                setState(() {
                                  var newMarker = Marker(
                                      markerId: const MarkerId('new'),
                                      position: argument);

                                  _markers
                                    ..clear()
                                    ..add(newMarker);
                                });
                                try {
                                  Position position =
                                      await Geolocator.getCurrentPosition(
                                          desiredAccuracy:
                                              LocationAccuracy.high);
                                  List<Placemark> addresses =
                                      await placemarkFromCoordinates(
                                          argument.latitude,
                                          argument.longitude);

                                  var first = addresses.first;
                                  setState(() {
                                    currentAddress =
                                        '${first.administrativeArea}, ${first.locality}, ${first.street}';

                                    addressController.text = currentAddress!;
                                  });

                                  location = argument;
                                } catch (e) {
                                  print(e.toString());
                                }
                                // get address
                              }),
                              onMapCreated: onMapCreated,
                              markers: _markers,
                              initialCameraPosition: CameraPosition(
                                // target: LatLng(15.5527, 48.5164),
                                target:
                                    location ?? const LatLng(15.5527, 48.5164),
                                zoom: 5.0,
                              ),
                            ),
                          )
                        : const SizedBox(
                            child: Center(
                                child: Text(
                              'loading... Please wait..',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 14,
                                color: MyColors.secondaryColor,
                              ),
                            )),
                          )),

                const SizedBox(
                  height: 15,
                ),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lessBlackColor,
                  ),
                  child: currentAddress == null
                      ? const Text(
                          'قم بتحديد اقرب موقع لك على الخريطه',
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: MyColors.containerColor,
                          ),
                        )
                      : Text(
                          currentAddress!,
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: MyColors.secondaryColor,
                          ),
                        ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _builderTextFiel(
                  controller: addressController,
                  numLine: 1,
                  hintText: '   العنوان',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'صوره فاتورة الدفع',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        color: MyColors.secondaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FaIcon(
                        FontAwesomeIcons.arrowRightLong,
                        color: MyColors.secondaryTextColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: MyColors.secondaryColor,
                      ),
                      width: 150,
                      height: 70,
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
                            lang: location?.latitude ?? 0,
                            long: location?.longitude ?? 0,
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
                        backgroundColor: MyColors.primaryColor,
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

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
      // mapController.getLatLng(screenCoordinate)
    });
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
            fontSize: 14),
      ),
    );
  }
}
