import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_products/admin_add_product.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminProductItem extends StatelessWidget {
  Product product;
  AdminProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);
  final ProductsController _productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
            margin: const EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.containerColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image,
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
                errorBuilder: (context, exception, stackTrack) => const Center(
                  child: Icon(
                    Icons.error,
                  ),
                ),
              ),
            )),
        Positioned(
          bottom: -20,
          right: 0,
          left: 0,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: MyColors.secondaryColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  product.name,
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
                  product.price,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 12,
                    color: MyColors.lessBlackColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: product.status ? Colors.green : Colors.red,
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
                                  ' هذا المنتج ؟',
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      backgroundColor: MyColors.secondaryColor,
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
                                        //  _categoryController.deleteCategory(
                                        //     product.cid, category.image);
                                        _productsController.productsOfCategory
                                            .removeWhere((element) =>
                                                element.id == product.id);
                                        _productsController.deleteProduct(
                                            product.id, product.image);

                                        Get.back();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        // minimumSize: const Size.fromHeight(50),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        backgroundColor: MyColors.primaryColor,
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
                        _productsController.newProduct.addAll(product.toMap());

                        Get.to(() => const AdminCreateNewProduct());
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
    );
  }
}
