import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/categories_screen.dart';
import 'package:flutter_fire_base/admin/screens/products_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _buildeContainer(
                  title: 'Products',
                  color: MyColors.secondaryColor.withOpacity(0.7),
                  gotToPage: (() {
                    Get.to(() => const CategoriesScreen());
                  }),
                ),
                _buildeContainer(
                  color: const Color.fromARGB(255, 4, 0, 255).withOpacity(0.1),
                  title: 'Orders',
                  gotToPage: (() {
                    Get.to(() =>  CategoriesScreen());
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _buildeContainer extends StatelessWidget {
  final title;

  final VoidCallback gotToPage;
  final Color? color;
  const _buildeContainer({
    required this.title,
    required this.gotToPage,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => gotToPage()),
      child: Container(
        width: double.maxFinite,
        height: 300,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Center(
            child: Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 30,
            color: MyColors.lessBlackColor.withOpacity(0.8),
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }
}
