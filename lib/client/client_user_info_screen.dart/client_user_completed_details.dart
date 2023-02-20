import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/client/client_product_details_screen/client_product_details_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as timeFormat;

class ClientUserCompletedOrderDetails extends StatelessWidget {
  OrderCompleted orderCompleted;
  ClientUserCompletedOrderDetails({
    required this.orderCompleted,
    super.key,
  });

  // Initial Selected Value
  ProductsController productsController = Get.put(ProductsController());

  OrderController orderController = Get.put(OrderController());

  TextEditingController noteController = TextEditingController();
  String getStatusName(int value) {
    switch (value) {
      case 0:
        return 'قيد الانتضار';
      case 1:
        return 'تم الاستلام';
      case 2:
        return 'قيد التوصيل';
      case 3:
        return 'تم التوصيل';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = orderCompleted.order.orderDetails.map((order) {
      return productsController.products
          .firstWhere((product) => product.id == order.productId);
    }).toList();

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   foregroundColor: Colors.black,
        // ),
        backgroundColor: MyColors.bg,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  //  height: 300,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(8),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.lessBlackColor,
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          text:
                                              orderCompleted.order.customerName,
                                          style: const TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: MyColors.containerColor,
                                          ),
                                        )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const FaIcon(
                                          FontAwesomeIcons.user,
                                          size: 15,
                                          color: MyColors.containerColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 10,
                                      ),
                                      child: RichText(
                                          textDirection: TextDirection.rtl,
                                          text: TextSpan(
                                              text: 'رقم الطلب : ',
                                              style: const TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.containerColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: orderCompleted.id,
                                                )
                                              ])),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 10,
                                      ),
                                      child: Text(
                                        timeFormat.DateFormat.yMMMMEEEEd()
                                            .format(orderCompleted.completedOn),
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.secondaryTextColor,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        right: 10,
                        bottom: -5,
                        child: Container(
                            width: 140,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: MyColors.bg,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: MyColors.primaryColor,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  getStatusName(orderCompleted.order.status),
                                  style: const TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    // fontWeight: FontWeight.bold,
                                    color: MyColors.bg,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        'المنتجات',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: MyColors.lessBlackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: orderCompleted.order.orderDetails.length,
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return AdminOrderDetailItemWidget(
                        product: products[index],
                        orderDetails: orderCompleted.order.orderDetails[index],
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // color: MyColors.containerColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        ' ملاحظه',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: MyColors.lessBlackColor,
                          fontSize: 14,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        //margin: const EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MyColors.containerColor,
                          borderRadius: BorderRadius.circular(10),
                          // color: MyColors.containerColor,
                        ),
                        child: Text(
                          orderCompleted.order.orderNote.isEmpty
                              ? 'ليس هنالك اي ملاحضه'
                              : orderCompleted.order.orderNote,
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: MyColors.secondaryTextColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: 300,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(
                    top: 20,
                    right: 20,
                    left: 20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.containerColor,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textDirection: TextDirection.rtl,
                            text: const TextSpan(
                                text: '2989',
                                style: TextStyle(
                                  color: MyColors.lessBlackColor,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                ),
                                children: [
                                  TextSpan(
                                    text: '  ر.س',
                                    style: TextStyle(
                                      color: MyColors.secondaryTextColor,
                                      fontSize: 10,
                                      // fontFamily: 'Cairo',
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            ': السعر ',
                            // textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: MyColors.lessBlackColor,
                              fontSize: 14,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                text:
                                    orderCompleted.order.totalAbount.toString(),
                                style: const TextStyle(
                                  color: MyColors.lessBlackColor,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                ),
                                children: const [
                                  TextSpan(
                                    text: '  ر.س',
                                    style: TextStyle(
                                      color: MyColors.secondaryTextColor,
                                      fontSize: 10,
                                      // fontFamily: 'Cairo',
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            ': الخصم ',
                            //  textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: MyColors.lessBlackColor,
                              fontSize: 14,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ],
                      ),
                      //  const SizedBox(height: 20),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                                text:
                                    orderCompleted.order.totalAbount.toString(),
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                                children: const [
                                  TextSpan(
                                    text: '  ر.س',
                                    style: TextStyle(
                                      color: MyColors.secondaryTextColor,
                                      fontSize: 10,
                                      // fontFamily: 'Cairo',
                                    ),
                                  ),
                                ]),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            ': الاجمالي',
                            // textDirection: TextDirection.rtl,
                            style: TextStyle(
                              color: Color.fromARGB(255, 39, 129, 42),
                              fontSize: 14,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      //const Divider(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // add order

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminOrderDetailItemWidget extends StatelessWidget {
  AdminOrderDetailItemWidget({
    Key? key,
    required this.product,
    required this.orderDetails,
  }) : super(key: key);
  Product product;
  OrderDetails orderDetails;
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      // height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: MyColors.bg,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(20, 0, 0, 0),
              offset: Offset(1, 1),
              blurRadius: 10,
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // orders details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 70,
                height: 60,
                child: Stack(
                  clipBehavior: Clip.none,
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Text(
                          (double.parse(product.price) *
                                  orderDetails.itemQuantity)
                              .toString(),
                          style: const TextStyle(
                            color: MyColors.lessBlackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30, left: 30),
                      child: const Text(
                        ' ر.س ',
                        style: TextStyle(
                          color: MyColors.primaryColor,
                          fontSize: 10,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          // // orders details and user

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    text: product.name,
                    style: const TextStyle(
                      color: MyColors.blackColor,
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                      text: product.price,
                      style: const TextStyle(
                        color: MyColors.lessBlackColor,
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                      children: const [
                        TextSpan(
                          text: ' ر.س ',
                          style: TextStyle(
                            color: MyColors.secondaryTextColor,
                            fontSize: 12,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        // width: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: MyColors.secondaryColor,
                        ),
                        child: Row(
                          children: [
                            Container(
                              //width: 0,
                              //height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.secondaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  orderDetails.itemQuantity.toString(),
                                  //OrderDetails.itemQuantity.toString(),
                                  style: const TextStyle(
                                    color: MyColors.lessBlackColor,
                                    fontSize: 8,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              ' : الكمية',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontSize: 8,
                                color: MyColors.secondaryTextColor,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          //user details

          GestureDetector(
            onTap: () =>
                Get.to(() => ClientProductDetailsScreen(product: product)),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  // height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, exception, stackTrack) =>
                      const SizedBox(
                    height: 150,
                    child: Center(
                      child: Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                          backgroundColor: Colors.white,
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*


  
 

*/
