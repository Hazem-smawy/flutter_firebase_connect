import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/client/client_categories/client_categories.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_screen.dart';
import 'package:flutter_fire_base/client/client_search_screen/client_search_screen.dart';
import 'package:flutter_fire_base/client/client_user_info_screen.dart/client_user_info_screen.dart';
import 'package:flutter_fire_base/client/home/client_home_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientBottomNavigation extends StatefulWidget {
  const ClientBottomNavigation({super.key});

  @override
  State<ClientBottomNavigation> createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  int index = 4;
  List<Widget> pages = [
    const ClientUserInfoScreen(),
    const ClientOrderScreen(),
    // const ClientShowMapScreen(),
    ClientCategoriesScreen(),
    const ClientSearchScreen(),
    ClientHomeScreen(),
  ];
  User? user = FirebaseAuth.instance.currentUser;
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      endDrawer: Drawer(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        )),
        backgroundColor: MyColors.containerColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: MyColors.lessBlackColor,
                          width: 2,
                        )),
                    child: const Center(
                        child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 25,
                      color: MyColors.lessBlackColor,
                    )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      children: const [
                        Text(
                          'hazem smawy',
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: MyColors.lessBlackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'hazemsmawy@gmail.com',
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            color: MyColors.secondaryTextColor,
                            fontSize: 9,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: MyColors.secondaryTextColor,
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () => Get.offAll(() => const ClientBottomNavigation()),
                child: const DrawerItemWidget(
                  title: '???????????????? ',
                  icon: FontAwesomeIcons.house,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 2;
                    Get.back();
                  });
                },
                child: const DrawerItemWidget(
                  title: '???? ?????????????? ',
                  icon: FontAwesomeIcons.barsStaggered,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index = 3;
                    Get.back();
                  });
                },
                child: const DrawerItemWidget(
                  title: '?????????????????? ',
                  icon: FontAwesomeIcons.bagShopping,
                ),
              ),
              const DrawerItemWidget(
                title: '?????????????? ',
                icon: FontAwesomeIcons.truck,
              ),
              const DrawerItemWidget(
                title: '?????????????? ',
                icon: FontAwesomeIcons.circleInfo,
              ),
              const DrawerItemWidget(
                title: '?????????? ???????????? ',
                icon: FontAwesomeIcons.arrowRightToBracket,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  if (user != null) {
                    FirebaseAuth.instance.signOut();
                    Utils.showSnackBar('???? ?????????? ?????????? ??????????');
                    Get.back();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.blackColor.withOpacity(0.02),
                    // border: Border.all(
                    //   color: Colors.red.withOpacity(0.7), width: 2)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "?????????? ????????????",
                        textAlign: TextAlign.end,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowRightToBracket,
                        color: Colors.red,
                        size: 18,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: MyColors.secondaryTextColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(
          () => Row(
            children: [
              // const SizedBox(
              //   width: 20,
              // ),
              const Center(
                  child: FaIcon(
                FontAwesomeIcons.firefox,
                color: MyColors.primaryColor,
              )),
              const SizedBox(
                width: 10,
              ),
              if (orderController.showNewProductAddToOrder.value)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });

                    orderController.showNewProductAddToOrder.value = false;
                  },
                  child: Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Center(
                            child: FaIcon(
                          FontAwesomeIcons.bagShopping,
                          color: MyColors.lessBlackColor,
                          size: 19,
                        )),
                        Positioned(
                            top: -6,
                            right: -10,
                            child: Container( 
                              padding: const EdgeInsets.all(3),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Text(
                                orderController.orderDetails.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 7,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        // actions: const [
        //   Center(
        //     child: FaIcon(
        //       FontAwesomeIcons.bars,
        //       size: 20,
        //       color: MyColors.secondaryTextColor,
        //     ),
        //   ),
        //   SizedBox(
        //     width: 20,
        //   )
        // ],
      ),
      body: pages[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: MyColors.blackColor,
        ),
        child: BottomNavigationBar(
          currentIndex: index,
          selectedItemColor: MyColors.secondaryColor,
          unselectedItemColor: MyColors.containerColor,
          selectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
          showUnselectedLabels: true,
          backgroundColor: MyColors.blackColor,
          enableFeedback: true,
          elevation: 0,
          onTap: ((value) {
            setState(() {
              index = value;
              if (value == 1) {
                orderController.showNewProductAddToOrder.value = false;
              }
            });
          }),
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: ' ????????????????',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bagShopping),
              label: '??????????',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.listUl),
              label: ' ??????????????',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              label: '??????????',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.house),
              label: '????????????????',
            ),
          ],
        ),
      ),
    ));
  }
}

class DrawerItemWidget extends StatelessWidget {
  final IconData icon;
  final title;
  const DrawerItemWidget({
    Key? key,
    this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.blackColor.withOpacity(0.03),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            textAlign: TextAlign.end,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              fontFamily: 'Cairo',
              color: MyColors.secondaryTextColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FaIcon(
            icon,
            color: MyColors.secondaryTextColor,
            size: 18,
          )
        ],
      ),
    );
  }
}
