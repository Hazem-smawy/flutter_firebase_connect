import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_about_info.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/admin_add_about_shop.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/contact_info.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/sliders/admin_about_sliders.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminAboutShopScreen extends StatefulWidget {
  const AdminAboutShopScreen({super.key});

  @override
  State<AdminAboutShopScreen> createState() => _AdminAboutShopScreenState();
}

class _AdminAboutShopScreenState extends State<AdminAboutShopScreen> {
  // List optionsWidgets = [
  //   const AdminInfoWidget(),
  //   const AdminContactWidget(),
  //   const AdminOptionAboutShopWidget(),
  //   const AdminSlidersScreen(),
  // ];
  final PageController _pageController = PageController();
  double? index = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        index = _pageController.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              reverse: true,
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.animateToPage(0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.linearToEaseOut);
                      });
                    },
                    child: AdminOptionPartWidget(
                      title: 'المعلومات',
                      icon: FontAwesomeIcons.shop,
                      selected: index == 0,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.animateToPage(1,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.linearToEaseOut);
                      });
                    },
                    child: AdminOptionPartWidget(
                      title: '  التواصل',
                      icon: FontAwesomeIcons.phone,
                      selected: index == 1,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.animateToPage(2,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.linearToEaseOut);
                      });
                    },
                    child: AdminOptionPartWidget(
                      title: 'عن المتجر',
                      icon: FontAwesomeIcons.info,
                      selected: index == 2,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.animateToPage(
                          3,
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linearToEaseOut,
                        );
                      });
                    },
                    child: AdminOptionPartWidget(
                      title: ' عارض الصور',
                      icon: FontAwesomeIcons.image,
                      selected: index == 3,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                //height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  height: 500,
                  child: PageView(
                    controller: _pageController,
                    reverse: true,
                    children: const [
                      SingleChildScrollView(child: AdminInfoWidget()),
                      SingleChildScrollView(child: AdminContactWidget()),
                      SingleChildScrollView(
                          child: AdminOptionAboutShopWidget()),
                      SingleChildScrollView(
                        child: AdminSlidersScreen(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminOptionPartWidget extends StatelessWidget {
  final title;
  IconData icon;
  bool selected;
  AdminOptionPartWidget({
    required this.title,
    required this.icon,
    required this.selected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      // padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: selected == true
            ? MyColors.lessBlackColor
            : MyColors.secondaryColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 15,
          ),
          Text(
            title,
            style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: selected == true
                    ? Colors.white
                    : MyColors.secondaryTextColor,
                fontWeight:
                    selected == true ? FontWeight.normal : FontWeight.normal),
          ),
          // const SizedBox(
          //   width: 10,
          // ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected == true ? MyColors.bg : MyColors.bg,
            ),
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(5),
            child: Center(
              child: FaIcon(
                icon,
                size: 16,
                color: selected == true ? Colors.black : MyColors.blackColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
