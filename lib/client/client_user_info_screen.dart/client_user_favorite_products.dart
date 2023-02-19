import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/client/home/client_product_item.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientUserFavoriteProducts extends StatelessWidget {
  ClientUserFavoriteProducts({super.key});

  OrderController orderController = Get.put(OrderController());
  ProductsController productsController = Get.find();
  User? user = FirebaseAuth.instance.currentUser;

  List<List<Product>> products = [];
  @override
  Widget build(BuildContext context) {
    // print(productsController.products);
    // print(orderController.favoriteProducts);
    if (user != null) {
      orderController.getUserFavoriteProducts(user!.uid);
    }
    if (orderController.favoriteProducts.isNotEmpty) {
      // List productIds = orderController.favoriteProducts.value.map((e) {
      //   return e.orderDetails.map((d) => d.productId);
      // }).toList();

      for (Order ele in orderController.favoriteProducts) {
        List<Product> product = ele.orderDetails.map((order) {
          return productsController.products
              .firstWhere((product) => product.id == order.productId);
        }).toList();

        products = [
          ...[...products]
        ];
      }
    }

    return SafeArea(
      child: Scaffold(
        // backgroundColor: MyColors.bg,
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 20),
                  // const Text(
                  //   'كل المنتجات',
                  //   style: TextStyle(
                  //     fontFamily: 'Cairo',
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.bold,
                  //     color: MyColors.lessBlackColor,
                  //   ),
                  //   maxLines: 1,
                  //   textAlign: TextAlign.end,
                  // ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.bg,
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.lessBlackColor.withOpacity(0.08),
                          offset: const Offset(1, 1),
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: const SizedBox(
                            width: 100,
                            child: SizedBox(
                              child: FaIcon(
                                FontAwesomeIcons.arrowLeftLong,
                                size: 18,
                                color: MyColors.secondaryTextColor,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "المفضله",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: MyColors.lessBlackColor,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.end,
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
                  if (orderController.favoriteProducts.isEmpty)
                    Column(
                      children: [
                        const SizedBox(height: 100),
                        Center(
                          child: FaIcon(
                            FontAwesomeIcons.heartCirclePlus,
                            color: MyColors.primaryColor.withOpacity(0.5),
                            size: 100,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'نقدم لكم كل ماهو جديد وحصري وبافضل الاسعار',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: MyColors.secondaryTextColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          onPressed: () {
                            // Get.offAll(
                            //  () => const());
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              backgroundColor: MyColors.blackColor,
                              minimumSize: const Size(200, 50)),
                          icon: const Icon(Icons.arrow_back),
                          label: const Text(
                            '  اضافة منتج',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Cairo',
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (products != null)
                    // orderController.favoriteProducts.forEach((value))
                    for (var i = 0;
                        i < orderController.favoriteProducts.length;
                        i++)
                      Container(
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height,
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          //color: MyColors.bg,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(
                                //horizontal: 10,
                                vertical: 20,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.containerColor,
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat.yMMMEd().format(orderController
                                        .favoriteProducts[i].orderOn),
                                    style: const TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 10,
                                      color: MyColors.secondaryTextColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      if (user != null) {
                                        orderController.deleteFavorite(
                                            orderController
                                                .favoriteProducts[i].id,
                                            user!.uid,
                                            i);
                                      }
                                    },
                                    child: FaIcon(
                                      FontAwesomeIcons.xmark,
                                      size: 20,
                                      color: Colors.red.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            MasonryGridView.count(
                                padding: const EdgeInsets.only(bottom: 20),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                //  reverse: true,
                                itemCount: orderController
                                    .favoriteProducts[i].orderDetails.length,
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                                itemBuilder: ((context, index) {
                                  List<Product> product = orderController
                                      .favoriteProducts[i].orderDetails
                                      .map((order) {
                                    return productsController.products
                                        .firstWhere((product) =>
                                            product.id == order.productId);
                                  }).toList();
                                  return ClientProductItemWidget(
                                    product: product[index],
                                  );
                                })),
                          ],
                        ),
                      ),
                  // const FooterWidget(),
                ],
              ),
            )),
      ),
    );
  }
}
