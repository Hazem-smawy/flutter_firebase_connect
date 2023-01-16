import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/category/categories_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: _buildeContainer(
                  icon: FontAwesomeIcons.productHunt,
                  title: 'Products',
                  number: '200',
                  color: MyColors.primaryColor,
                  gotToPage: (() {
                    Get.to(() => const CategoriesScreen());
                  }),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: _buildeContainer(
                  icon: FontAwesomeIcons.users,
                  color: const Color.fromARGB(255, 4, 0, 255),
                  title: 'Category',
                  number: '100',
                  gotToPage: (() {
                    Get.to(() => const CategoriesScreen());
                  }),
                ),
              ),
            ],
          ),

          // second
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: _buildeContainer(
                  icon: FontAwesomeIcons.productHunt,
                  title: 'Users',
                  number: '200',
                  color: const Color.fromARGB(255, 219, 12, 199),
                  gotToPage: (() {
                    Get.to(() => const CategoriesScreen());
                  }),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: _buildeContainer(
                  icon: FontAwesomeIcons.users,
                  color: const Color.fromARGB(255, 20, 231, 31),
                  title: 'Orders',
                  number: '100',
                  gotToPage: (() {
                    Get.to(() => const CategoriesScreen());
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _buildeContainer extends StatelessWidget {
  final String title;
  final IconData icon;
  final String number;
  final VoidCallback gotToPage;
  final Color color;
  const _buildeContainer({
    required this.title,
    required this.gotToPage,
    required this.color,
    required this.icon,
    required this.number,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => gotToPage()),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color.withOpacity(0.1),
        ),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            FaIcon(
              icon,
              size: 25,
              color: color,
            ),
            const SizedBox(
              height: 15,
            ),
            FittedBox(
              child: Text(
                title,
                style: GoogleFonts.roboto(
                  fontSize: 25,
                  color: MyColors.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              number,
              style: GoogleFonts.roboto(
                fontSize: 20,
                color: MyColors.secondaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
