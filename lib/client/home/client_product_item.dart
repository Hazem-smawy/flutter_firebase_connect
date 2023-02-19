import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/client/client_product_details_screen/client_product_details_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientProductItemWidget extends StatelessWidget {
  Product product;
  ClientProductItemWidget({Key? key, required this.product}) : super(key: key);
  OrderController orderController = Get.put(OrderController());
  Color getBackgroundColor() {
    List colors = [
      //767676  cfcfbcb   403735  e1d9ce b9dafd  976745 ffffff 00000
      const Color(0xff767676),
      const Color(0xffcfcfbc),
      const Color(0xff403735),
      const Color(0xffffffff),
      const Color(0xffe1d9ce),
      const Color(0xffb9dafd),
      const Color(0xff976745),
      const Color(0x0ff00000),
    ];
    final random = Random();
    var i = random.nextInt(colors.length);
    return colors[i];
  }

  @override
  Widget build(BuildContext context) {
    Color c = getBackgroundColor();
    return GestureDetector(
      onTap: () => Get.to(() => ClientProductDetailsScreen(
            product: product,
          )),
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
            color: MyColors.bg,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.lessBlackColor.withOpacity(0.07),
                offset: const Offset(1, 1),
                blurRadius: 10,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                constraints: const BoxConstraints(minHeight: 150),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  // height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrack) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getBackgroundColor(),
                    ),
                    height: 200,
                    child: const Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: c,
                      ),
                      height: 20,
                      child: const Center(
                          // child: CircularProgressIndicator(
                          //   color: MyColors.primaryColor,
                          //   backgroundColor: Colors.white,
                          //   value: loadingProgress.expectedTotalBytes != null
                          //       ? loadingProgress.cumulativeBytesLoaded /
                          //           loadingProgress.expectedTotalBytes!
                          //       : null,
                          // ),
                          ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
                bottom: 8,
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      // fontWeight: FontWeight.bold,
                      color: MyColors.lessBlackColor,
                    ),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (orderController.orderDetails.isNotEmpty) {
                        var index = orderController.orderDetails
                            .indexWhere((p0) => p0.productId == product.id);
                        print(index);
                        if (index >= 0) {
                          orderController.updateQuantity(
                            orderController.orderDetails[index],
                            index,
                            1,
                            product,
                          );
                          Utils.showSnackBar('تم زياده كمية  المنتج  +1');
                        } else {
                          orderController.orderDetails.add(
                            OrderDetails(
                              id: 1,
                              productId: product.id,
                              itemQuantity: 1,
                              price: double.parse(product.price),
                              note: '',
                            ),
                          );
                          // print(quantity);
                          Utils.showSnackBar(
                              'تم اضافة  ${product.name} الى السله');
                        }
                      }

                      if (orderController.orderDetails.isEmpty) {
                        orderController.orderDetails.add(
                          OrderDetails(
                            id: 1,
                            productId: product.id,
                            itemQuantity: 1,
                            price: double.parse(product.price),
                            note: '',
                          ),
                        );
                        // print(quantity);
                        Utils.showSnackBar(
                            'تم اضافة  ${product.name} الى السله');
                      }

                      print(orderController.orderDetails);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: MyColors.containerColor,
                      ),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              style: const TextStyle(
                                color: MyColors.blackColor,
                                fontSize: 20,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                              ),
                              text: product.price,
                              children: const [
                                TextSpan(
                                  text: ' ر.س ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: MyColors.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          const SizedBox(
                            height: 50,
                            child: Center(
                              child: FaIcon(
                                FontAwesomeIcons.bagShopping,
                                size: 20,
                                color: MyColors.lessBlackColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
