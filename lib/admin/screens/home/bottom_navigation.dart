import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_shop_screen.dart';
import 'package:flutter_fire_base/admin/screens/admin_category/admin_category_screen.dart';
import 'package:flutter_fire_base/admin/screens/admin_order_screen/admin_order_screen.dart';
import 'package:flutter_fire_base/admin/screens/admin_users_manage/admin_users_manage.dart';
import 'package:flutter_fire_base/admin/screens/home/home_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  int index = 4;
  List<Widget> pages = [
    const AdminAboutShopScreen(),
    AmdinUserMangage(),
     AdminOrderScreen(),
    const AdminCategoryScreen(),
    AdminHomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Center(
            child: FaIcon(
          FontAwesomeIcons.bell,
          color: MyColors.secondaryTextColor,
        )),
        actions: const [
          Center(
            child: FaIcon(
              FontAwesomeIcons.firefox,
              size: 30,
              color: MyColors.primaryColor,
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: MyColors.secondaryTextColor,
        selectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
        unselectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
        showUnselectedLabels: true,
        elevation: 0,
        onTap: ((value) {
          setState(() {
            index = value;
          });
        }),
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.info),
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
    ));
  }
}
