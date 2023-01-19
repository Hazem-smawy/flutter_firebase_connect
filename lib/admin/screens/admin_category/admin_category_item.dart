import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_products/products_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminCategoryItem extends StatelessWidget {
  Category category;
  AdminCategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);
  final CategoryController _categoryController = Get.find();
  final ProductsController _productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _productsController.categoryId.value = category.cid;
        
        Get.to(() => AdminProductScreen());
      },
      child: SizedBox(
        height: 200,
        child: Stack(clipBehavior: Clip.none, children: [
          // Positioned(
          //     top: -15,
          //     left: 0,
          //     right: 0,
          //     child: Container(
          //       width: 15,
          //       height: 15,
          //       decoration: BoxDecoration(
          //         border: Border.all(
          //             color: category.status ? Colors.green : Colors.red,
          //             width: 2),
          //         shape: BoxShape.circle,
          //         color: MyColors.bg,
          //       ),
          //     )),
          Container(
              margin: const EdgeInsets.only(bottom: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.containerColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  category.image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                        backgroundColor: Colors.white,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: MyColors.secondaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    category.title,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: MyColors.lessBlackColor,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.end,
                  ),
                  Text(
                    category.description,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      color: MyColors.secondaryTextColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color:
                                  category.status ? Colors.green : Colors.red,
                              width: 2),
                          shape: BoxShape.circle,
                          color: MyColors.secondaryColor,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              title: '',
                              content: Column(
                                children: const [
                                  FaIcon(
                                    FontAwesomeIcons.question,
                                    size: 30,
                                    color: MyColors.primaryColor,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'هل انت متأمد من حذف ',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15,
                                      color: MyColors.lessBlackColor,
                                    ),
                                  ),
                                  Text(
                                    ' هذا التصنيف ؟',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 15,
                                      color: MyColors.lessBlackColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        //  minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          // side: const BorderSide(
                                          //  color: MyColors.secondaryTextColor),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor:
                                            MyColors.secondaryColor,
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15,
                                        ),
                                        child: Text(
                                          'تراجع',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 15,
                                            color: MyColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          _categoryController.deleteCategory(
                                              category.cid, category.image);
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          // minimumSize: const Size.fromHeight(50),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          backgroundColor:
                                              MyColors.primaryColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            'حذف',
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              ]);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.trash,
                          size: 17,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          _categoryController.newCategory
                              .addAll(category.toMap());

                          _categoryController.toggleShowNewCategory();
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.penToSquare,
                          size: 17,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
