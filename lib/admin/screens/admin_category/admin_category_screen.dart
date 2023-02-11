import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/screens/admin_category/admin_category_item.dart';
import 'package:flutter_fire_base/admin/screens/admin_category/admin_elevated_button.dart';
import 'package:flutter_fire_base/admin/screens/admin_category/admin_new_category.dart';
import 'package:flutter_fire_base/admin/screens/admin_products/admin_all_products.dart';
import 'package:flutter_fire_base/admin/screens/utilities/search_widget.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:get/get.dart';

class AdminCategoryScreen extends StatefulWidget {
  // final BuildContext cnx;
  const AdminCategoryScreen({super.key});

  @override
  State<AdminCategoryScreen> createState() => _AdminCategoryScreenState();
}

class _AdminCategoryScreenState extends State<AdminCategoryScreen> {
  final CategoryController _categoryController = Get.put(CategoryController());
  final ProductsController _productsController = Get.put(ProductsController());

  bool showAddNewCategory = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const AdminSearchWidget(),
            Container(
              // height: 200,
              alignment: Alignment.centerRight,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.primaryColor.withOpacity(0.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      _productsController.categoryId.value = '';
                      Get.to(() => const AdminAllProductsScreen());
                    },
                    child: const Text(
                      '  كل المنتجات',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  AdminCategoryElevatedButton(
                      categoryController: _categoryController),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (_categoryController.showNewCategory.value)
              AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: const AdminCreateNewCategory()),
            const SizedBox(
              height: 20,
            ),
            if (_categoryController.categories.isEmpty) const SizedBox(),
            // Container(
            //   // height: 100,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: MyColors.bg,
            //   ),
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            //   margin: const EdgeInsets.all(5),
            //   child: Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const FaIcon(
            //           FontAwesomeIcons.exclamation,
            //           size: 40,
            //           color: MyColors.primaryColor,
            //         ),
            //         const Text(
            //           'لم تقم باضافة اي تصنيف',
            //           style: TextStyle(
            //             color: MyColors.secondaryTextColor,
            //             fontFamily: 'Cairo',
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         AdminCategoryElevatedButton(
            //             categoryController: _categoryController),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (_categoryController.categories.isNotEmpty)
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categoryController.categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  return AdminCategoryItem(
                    category: _categoryController.categories[i],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
