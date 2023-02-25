import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as timeFormat;

class AdminOrderDetailsScreen extends StatelessWidget {
  AdminOrderDetailsScreen(
      {super.key,
      required this.section,
      required this.order,
      required this.orderCompleted,
      required this.index});
  final int section;
  Order order;
  final int index;
  OrderCompleted orderCompleted;

  // Initial Selected Value

  // List of items in our dropdown menu
  var items = [
    'قيد الانتضار',
    'تم الاستلام',
    'قيد التوصيل',
    'تم التوصيل',
  ];
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

  int getStatusNumber(String value) {
    switch (value) {
      case 'قيد الانتضار':
        return 0;
      case 'تم الاستلام':
        return 1;
      case 'قيد التوصيل':
        return 2;
      case 'تم التوصيل':
        return 3;
      default:
        return 0;
    }
  }

  OrderController orderController = Get.find();
  ProductsController productsController = Get.put(ProductsController());

  @override
  Widget build(BuildContext context) {
    orderController.orderState.value = getStatusName(order.status);
    List<Product> products = order.orderDetails.map((order) {
      return productsController.products
          .firstWhere((product) => product.id == order.productId);
    }).toList();

    print(products);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   foregroundColor: Colors.black,
        // ),
        backgroundColor: MyColors.bg,
        body: SingleChildScrollView(
          child: Obx(
            () => SizedBox(
              // margin: const EdgeInsets.all(20),
              // padding: const EdgeInsets.all(10),
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
                          height: 200,
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
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const FaIcon(
                                  FontAwesomeIcons.arrowLeftLong,
                                  color: MyColors.secondaryTextColor,
                                  size: 25,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                            text: order.customerName,
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
                                                  color:
                                                      MyColors.containerColor,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: orderCompleted.id
                                                          .toString())
                                                ])),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 10,
                                        ),
                                        child: Text(
                                          timeFormat.DateFormat.yMMMMEEEEd()
                                              .format(order.orderOn),
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
                          right: 15,
                          bottom: -5,
                          child: Container(
                              width: 160,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: MyColors.bg,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: MyColors.primaryColor.withOpacity(0.8),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(2),
                                alignment: Alignment.center,
                                child: DropdownButton(
                                  // isDense: true,
                                  alignment: AlignmentDirectional.center,
                                  borderRadius: BorderRadius.circular(13),
                                  underline: const Text(''),
                                  style: const TextStyle(
                                    color: MyColors.bg,
                                    fontFamily: 'Cairo',
                                    fontSize: 12,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  // Initial Value
                                  value: orderController.orderState.value,

                                  // Down Arrow Icon
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: MyColors.bg,
                                  ),
                                  isExpanded: false,
                                  // Array list of items
                                  dropdownColor: MyColors.lessBlackColor,
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              items,
                                              style: const TextStyle(
                                                color: MyColors.bg,
                                                fontFamily: 'Cairo',
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            if (items !=
                                                getStatusName(order.status))
                                              const Divider(
                                                color:
                                                    MyColors.secondaryTextColor,
                                              )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    orderController.orderState.value =
                                        newValue!;
                                    orderController.updateOrder(
                                        orderCompleted,
                                        section,
                                        index,
                                        getStatusNumber(newValue));
                                    // getStatusName(int.parse(newValue!));
                                  },
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
                      itemCount: products.length,
                      shrinkWrap: true,
                      //scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return AdminOrderDetailItemWidget(
                          product: products[index],
                          orderDetails: order.orderDetails[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                              text: const TextSpan(
                                  text: '300',
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
                                  text: order.totalAbount.toString(),
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
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdminOrderDetailItemWidget extends StatelessWidget {
  OrderDetails orderDetails;
  Product product;
  AdminOrderDetailItemWidget({
    Key? key,
    required this.orderDetails,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.end,
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
                            ' ${(orderDetails.price * orderDetails.itemQuantity).toStringAsFixed(1)}',
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
                            color: MyColors.secondaryTextColor,
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
                Container(
                  width: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lessBlackColor,
                  ),
                  child: const Center(
                    child: Text(
                      '05:30',
                      style: TextStyle(
                        color: MyColors.bg,
                        fontSize: 8,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
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
                    maxLines: 2,
                    text: TextSpan(
                      text: product.name,
                      style: const TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                        text: orderDetails.price.toString(),
                        style: const TextStyle(
                          color: MyColors.lessBlackColor,
                          fontSize: 14,
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
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // width: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                        ),
                        child: RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                              text: ' الكمية :  ',
                              style: const TextStyle(
                                color: MyColors.secondaryTextColor,
                                fontSize: 9,
                                fontFamily: 'Cairo',
                              ),
                              children: [
                                TextSpan(
                                  text: orderDetails.itemQuantity.toString(),
                                  style: const TextStyle(
                                    color: MyColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ]),
                        ),
                      ),
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

            SizedBox(
              height: 100,
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
            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'hazem_smawy',
            //   style: TextStyle(
            //     color: MyColors.secondaryTextColor,
            //     fontSize: 7,
            //     fontFamily: 'Cairo',
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

/*


  
 

*/
