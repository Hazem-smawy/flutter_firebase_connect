import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/screens/admin_products/admin_add_product.dart';
import 'package:flutter_fire_base/admin/screens/admin_products/admin_product_item.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AdminAllProductsScreen extends StatefulWidget {
  const AdminAllProductsScreen({super.key});

  @override
  State<AdminAllProductsScreen> createState() => _AdminAllProductsScreenState();
}

class _AdminAllProductsScreenState extends State<AdminAllProductsScreen> {
  final ProductsController _productsController = Get.put(ProductsController());

  @override
  void initState() {
    print(_productsController.products);
    super.initState();
  }

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
              Column(
                children: [
                  Container(
                    // height: 200,
                    alignment: Alignment.centerRight,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              MyColors.primaryColor.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          _productsController.newProduct.clear();
                          Get.to(() => const AdminCreateNewProduct());
                          // _categoryController.newCategory.clear();
                          // _categoryController.toggleShowNewCategory();
                        },
                        icon: const FaIcon(FontAwesomeIcons.plus),
                        label: const Text(
                          ' اضف منتج',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_productsController.products.isNotEmpty)
                    Obx(
                      () => GridView.builder(
                        padding: const EdgeInsets.only(bottom: 40),
                        primary: false,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _productsController.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 25,
                        ),
                        itemBuilder: (context, i) {
                          return AdminProductItem(
                            product: _productsController.products[i],
                          );
                        },
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _buildCreateProductPlaceHolder extends StatelessWidget {
  const _buildCreateProductPlaceHolder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: MyColors.bg,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      margin: const EdgeInsets.all(5),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            FaIcon(
              FontAwesomeIcons.exclamation,
              size: 40,
              color: MyColors.primaryColor,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'لم تقم باضافة اي منتج',
              style: TextStyle(
                color: MyColors.secondaryTextColor,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
