import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_shop_screen.dart';
import 'package:flutter_fire_base/admin/screens/admin_category/admin_category_screen.dart';
import 'package:flutter_fire_base/admin/screens/admin_users_manage/admin_users_manage.dart';
import 'package:flutter_fire_base/client/client_categories/client_categories.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_screen.dart';
import 'package:flutter_fire_base/client/home/client_home_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClientBottomNavigation extends StatefulWidget {
  const ClientBottomNavigation({super.key});

  @override
  State<ClientBottomNavigation> createState() => _ClientBottomNavigationState();
}

class _ClientBottomNavigationState extends State<ClientBottomNavigation> {
  int index = 4;
  List<Widget> pages = [
    const AdminCategoryScreen(),
    const AdminAboutShopScreen(),
    const ClientOrderScreen(),
    const ClientCategoriesScreen(),
    ClientHomeScreen(),
  ];
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
              const DrawerItemWidget(
                title: 'الرئيسية ',
                icon: FontAwesomeIcons.house,
              ),
              const DrawerItemWidget(
                title: 'كل الاصناف ',
                icon: FontAwesomeIcons.barsStaggered,
              ),
              const DrawerItemWidget(
                title: 'المشتريات ',
                icon: FontAwesomeIcons.bagShopping,
              ),
              const DrawerItemWidget(
                title: 'التوصيل ',
                icon: FontAwesomeIcons.truck,
              ),
              const DrawerItemWidget(
                title: 'خدماتنا ',
                icon: FontAwesomeIcons.circleInfo,
              ),
              const DrawerItemWidget(
                title: 'تسجيل الدخول ',
                icon: FontAwesomeIcons.arrowRightToBracket,
              ),
              const Spacer(),
              Container(
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
                      "تسجيل الخروج",
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
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        foregroundColor: MyColors.secondaryTextColor,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Center(
            child: FaIcon(
          FontAwesomeIcons.firefox,
          color: MyColors.primaryColor,
        )),
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
            });
          }),
          items: const [
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.circleInfo),
              label: 'عن المتجر',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'العملاء',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.calendar),
              label: ' الطلبات',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.listUl),
              label: 'الاصناف',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.chartLine),
              label: 'الرئيسيه',
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
