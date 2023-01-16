import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/screens/category/add_category_screen.dart';
import 'package:flutter_fire_base/admin/screens/products_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.put(CategoryController());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Get.to(() => AddCategoryScreen()),
                      child: Container(
                        width: MediaQuery.of(context).size.width - 200,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: MyColors.primaryColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.plus,
                              size: 20,
                              color: MyColors.bg,
                            ),
                            Text(
                              'new category',
                              style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: MyColors.bg,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => categoryController.categories.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: categoryController.categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _buildShowProduct(
                              category: categoryController.categories[index],
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildShowProduct extends StatelessWidget {
  final Category category;
  const _buildShowProduct({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategoryController categoryController = Get.find();
    return GestureDetector(
      onTap: () {
        Get.to(() => const ProductsScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(5),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.containerColor,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(category.image),
                  fit: BoxFit.cover,
                ),
              ),
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: MyColors.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      category.description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: MyColors.secondaryTextColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '1/2/2022',
                          style: GoogleFonts.roboto(
                              fontSize: 13, color: MyColors.secondaryTextColor),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => AddCategoryScreen(
                                  category: category,
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.green, width: 2),
                              //color: MyColors.bg,
                            ),
                            child: Text(
                              'Edit',
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: MyColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            print(category.cid);
                            categoryController.deleteCategory(
                                category.cid, category.image);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: MyColors.primaryColor, width: 2),
                            ),
                            child: Text(
                              'Delete ',
                              style: GoogleFonts.roboto(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
