import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  AdminHomeScreen({super.key});
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(25),
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
                      // Get.to(() => const CategoriesScreen());
                    }),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Obx(
                    () => _buildeContainer(
                      icon: FontAwesomeIcons.productHunt,
                      color: const Color.fromARGB(255, 4, 0, 255),
                      title: 'المنتجات',
                      number: productsController.products.length.toString(),
                      gotToPage: (() {}),
                    ),
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
                      // Get.to(() => const CategoriesScreen());
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
                      // Get.to(() => const CategoriesScreen());
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
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
          borderRadius: BorderRadius.circular(10),
          color: color.withOpacity(0.07),
        ),
        child: Center(
            child: Column(
          children: [
            FaIcon(
              icon,
              size: 30,
              color: color,
            ),
            const SizedBox(
              height: 10,
            ),
            FittedBox(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 20,
                  color: MyColors.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              number,
              style: const TextStyle(
                fontFamily: 'Cairo',
                fontSize: 15,
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
