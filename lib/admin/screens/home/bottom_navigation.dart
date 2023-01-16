import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/category/categories_screen.dart';
import 'package:flutter_fire_base/admin/screens/home/admin_category_screen.dart';
import 'package:flutter_fire_base/admin/screens/home/home_screen.dart';
import 'package:flutter_fire_base/admin/screens/products_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminBottomNavigation extends StatefulWidget {
  const AdminBottomNavigation({super.key});

  @override
  State<AdminBottomNavigation> createState() => _AdminBottomNavigationState();
}

class _AdminBottomNavigationState extends State<AdminBottomNavigation> {
  int index = 3;
  List<Widget> pages = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const AdminCategoryScreen(),
    const AdminHomeScreen(),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.secondaryColor,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: MyColors.secondaryTextColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.secondaryColor,
                    ),
                    child: const TextField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        hintText: 'ابحث هنا',
                        hintStyle: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: MyColors.secondaryTextColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            pages[index]
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: MyColors.primaryColor,
        unselectedItemColor: MyColors.secondaryTextColor,
        selectedLabelStyle: const TextStyle(fontFamily: 'Cairo'),
        elevation: 0,
        onTap: ((value) {
          setState(() {
            index = value;
          });
        }),
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users),
            label: 'العملاء',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.firstOrder),
            label: 'الطلبات',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.box),
            label: 'الاصناف',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'الرئيسيه',
          ),
        ],
      ),
    ));
  }
}
