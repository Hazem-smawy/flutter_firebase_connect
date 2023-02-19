import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/home/bottom_navigation.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/client/client_user_info_screen.dart/client_user_completed_orders.dart';
import 'package:flutter_fire_base/client/client_user_info_screen.dart/client_user_favorite_products.dart';
import 'package:flutter_fire_base/main.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientUserInfoScreen extends StatefulWidget {
  const ClientUserInfoScreen({super.key});

  @override
  State<ClientUserInfoScreen> createState() => _ClientUserInfoScreenState();
}

class _ClientUserInfoScreenState extends State<ClientUserInfoScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  bool isAdmin = false;
  DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    if (user != null) {
      await databaseService.getUser(user?.email).then((value) {
        setState(() {
          isAdmin = value?.isAdmin ?? false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return user == null
        ? const AdminMainPage()
        : Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      if (isAdmin)
                        GestureDetector(
                          onTap: (() =>
                              Get.to(() => const AdminBottomNavigation())),
                          child: const FaIcon(
                            FontAwesomeIcons.pen,
                            color: MyColors.secondaryTextColor,
                            size: 20,
                          ),
                        ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (() =>
                            Get.to(() => ClientUserFavoriteProducts())),
                        child: const FaIcon(
                          FontAwesomeIcons.heart,
                          color: MyColors.secondaryTextColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => ClientUserCompletedOrdersScreen(
                                userId: user?.uid,
                              ));
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: MyColors.secondaryTextColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: MyColors.lessBlackColor,
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'hazem smawy',
                    style: TextStyle(
                      fontFamily: 'Cario',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: MyColors.lessBlackColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'hazemsmawy@gmail.com',
                    style: TextStyle(
                      fontFamily: 'Cario',
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: MyColors.secondaryTextColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    // height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.lessBlackColor.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: const [
                            FaIcon(
                              FontAwesomeIcons.mapLocation,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('address'),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            )
                          ]),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Divider(
                              color: MyColors.lessBlackColor,
                            )),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),

                        // second

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: const [
                            FaIcon(
                              FontAwesomeIcons.user,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('account'),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            )
                          ]),
                        ),
                      ],
                    ),
                  )

                  //second container
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    // height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.lessBlackColor.withOpacity(0.1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: const [
                            FaIcon(
                              FontAwesomeIcons.bell,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('notification'),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            )
                          ]),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Divider(
                              color: MyColors.lessBlackColor,
                            )),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),

                        // second

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: const [
                            FaIcon(
                              FontAwesomeIcons.user,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('account'),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            )
                          ]),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                                child: Divider(
                              color: MyColors.lessBlackColor,
                            )),
                            SizedBox(
                              width: 30,
                            )
                          ],
                        ),

                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(children: const [
                            FaIcon(
                              FontAwesomeIcons.bell,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('notification'),
                            Spacer(),
                            FaIcon(
                              FontAwesomeIcons.angleRight,
                              color: MyColors.lessBlackColor,
                              size: 20,
                            )
                          ]),
                        ),
                        // Row(
                        //   children: const [
                        //     SizedBox(
                        //       width: 30,
                        //     ),
                        //     Expanded(
                        //         child: Divider(
                        //       color: MyColors.lessBlackColor,
                        //     )),
                        //     SizedBox(
                        //       width: 30,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
