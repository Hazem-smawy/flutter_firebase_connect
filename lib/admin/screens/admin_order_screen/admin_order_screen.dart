import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/screens/admin_order_screen/admin_order_details_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as dateFormat;

class AdminOrderScreen extends StatefulWidget {
  const AdminOrderScreen({super.key});

  @override
  State<AdminOrderScreen> createState() => _AdminOrderScreenState();
}

class _AdminOrderScreenState extends State<AdminOrderScreen> {
  final Map<String, List> _elements = {
    'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
    'Team B': ['Toyah Downs', 'Tyla Kane'],
    'Team c': ['Toyah Downs', 'Tyla Kane', 'Kane', 'Kane kdk'],
  };
  OrderController orderController = Get.put(OrderController());

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    //orderController.todaysOrderCompleted.value =
    // orderController.todaysOrderCompleted.reversed.toList();
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Obx(
          () => Column(
            //  mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {},
                      child: const FaIcon(FontAwesomeIcons.arrowDownShortWide)),
                  Container(
                    child: const Text(
                      'الطلبات',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (orderController.todaysOrderCompleted.isEmpty &&
                  orderController.lastWeekOrderCompleted.isEmpty &&
                  orderController.lastMonthOrderCompleted.isEmpty)
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.containerColor,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.circleInfo,
                          color: MyColors.primaryColor.withOpacity(0.7),
                          size: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'لاتوجد اي طلبات بعد',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 12,
                            color: MyColors.secondaryTextColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              if (orderController.todaysOrderCompleted.isNotEmpty ||
                  orderController.lastWeekOrderCompleted.isNotEmpty ||
                  orderController.lastMonthOrderCompleted.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: MyColors.bg,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(11, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10),
                      ]),
                  child: Column(
                    children: [
                      if (orderController.todaysOrderCompleted.isNotEmpty)
                        Column(
                          children: [
                            const Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                'اليوم',
                                style: TextStyle(
                                  color: MyColors.secondaryTextColor,
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            )),
                            ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  orderController.todaysOrderCompleted.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AdminOrderItemWidget(
                                  order: orderController
                                      .todaysOrderCompleted[index].order,
                                  section: 0,
                                  index: index,
                                  orderCompleted: orderController
                                      .todaysOrderCompleted[index],
                                );
                              },
                            ),
                          ],
                        ),
                      // weeks
                      if (orderController.lastWeekOrderCompleted.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                'قبل اسبوع',
                                style: TextStyle(
                                  color: MyColors.secondaryTextColor,
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            )),
                            ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  orderController.lastWeekOrderCompleted.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AdminOrderItemWidget(
                                  order: orderController
                                      .lastWeekOrderCompleted[index].order,
                                  section: 1,
                                  index: index,
                                  orderCompleted: orderController
                                      .lastWeekOrderCompleted[index],
                                );
                              },
                            ),
                          ],
                        ),
                      // month
                      if (orderController.lastMonthOrderCompleted.isNotEmpty)
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Center(
                                child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              child: Text(
                                'قبل شهر',
                                style: TextStyle(
                                  color: MyColors.secondaryTextColor,
                                  fontSize: 12,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            )),
                            ListView.builder(
                              primary: true,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderController
                                  .lastMonthOrderCompleted.length,
                              itemBuilder: (BuildContext context, int index) {
                                return AdminOrderItemWidget(
                                  section: 2,
                                  order: orderController
                                      .lastMonthOrderCompleted[index].order,
                                  index: index,
                                  orderCompleted: orderController
                                      .lastMonthOrderCompleted[index],
                                );
                              },
                            ),
                          ],
                        )
                    ],
                  ),
                )

              // GroupListView(
              //         shrinkWrap: true,
              //         primary: true,
              //         physics: const NeverScrollableScrollPhysics(),
              //         sectionsCount: orderController.orders.keys.toList().length,
              //         countOfItemInSection: (int section) {
              //           return orderController.orders.values
              //               .toList()[section]
              //               .length;
              //         },
              //         itemBuilder: (BuildContext context, IndexPath index) {
              //           return Container(
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(20),
              //                   color: MyColors.bg,
              //                   boxShadow: const [
              //                     BoxShadow(
              //                         color: Color.fromARGB(11, 0, 0, 0),
              //                         offset: Offset(1, 1),
              //                         blurRadius: 10),
              //                   ]),
              //               child: const AdminOrderItemWidget());
              //         },
              //         groupHeaderBuilder: (BuildContext context, int section) {
              //           return Center(
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 15, vertical: 8),
              //               child: Text(
              //                 orderController.orders.keys.toList()[section],
              //                 style: const TextStyle(
              //                   color: MyColors.secondaryTextColor,
              //                   fontSize: 12,
              //                   fontFamily: 'Cairo',
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //         separatorBuilder: (context, index) => Container(
              //           height: 10,
              //           // color: Colors.red,
              //         ),
              //         sectionSeparatorBuilder: (context, section) => Container(
              //           height: 10,
              //         ),
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdminOrderItemWidget extends StatelessWidget {
  Order order;
  final int section;
  final int index;
  OrderCompleted orderCompleted;
  AdminOrderItemWidget({
    Key? key,
    required this.order,
    required this.section,
    required this.index,
    required this.orderCompleted,
  }) : super(key: key);

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

  Color getStatusColor(int value) {
    switch (value) {
      case 0:
        return const Color.fromARGB(255, 247, 168, 163);
      case 1:
        return const Color.fromARGB(255, 247, 238, 157);
      case 2:
        return const Color.fromARGB(255, 166, 209, 245);
      case 3:
        return const Color.fromARGB(255, 181, 243, 183);
      default:
        return const Color.fromARGB(255, 178, 243, 181);
    }
  }

  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => AdminOrderDetailsScreen(
            section: section,
            index: index,
            order: order,
            orderCompleted: orderCompleted,
          )),
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        // height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
                            order.totalAbount.toString(),
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
                          'ر.س',
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
                  child: Center(
                    child: Text(
                      dateFormat.DateFormat.Hm().format(order.orderOn),
                      style: const TextStyle(
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
            // orders details and user

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'رقم الطلب : ',
                        style: const TextStyle(
                          color: MyColors.secondaryTextColor,
                          fontSize: 13,
                          fontFamily: 'Cairo',
                        ),
                        children: [
                          TextSpan(
                            text: orderCompleted.id,
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 14,
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ]),
                  ),
                  RichText(
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                        text: 'الاسم : ',
                        style: const TextStyle(
                          color: MyColors.secondaryTextColor,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                        ),
                        children: [
                          TextSpan(
                            text: order.customerName,
                            style: const TextStyle(
                              color: MyColors.blackColor,
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
                          //textDirection: TextDirection.rtl,
                          text: TextSpan(
                              text: ' المنتجات :  ',
                              style: const TextStyle(
                                color: MyColors.secondaryTextColor,
                                fontSize: 9,
                                fontFamily: 'Cairo',
                              ),
                              children: [
                                TextSpan(
                                  text: order.orderDetails.length.toString(),
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
                      Container(
                        // width: 60,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: getStatusColor(order.status),
                        ),
                        child: RichText(
                          // textDirection: TextDirection.rtl,
                          text: TextSpan(
                              text: 'الحالة :  ',
                              style: const TextStyle(
                                color: MyColors.secondaryTextColor,
                                fontSize: 10,
                                fontFamily: 'Cairo',
                              ),
                              children: [
                                TextSpan(
                                  text: getStatusName(order.status),
                                  style: const TextStyle(
                                    color: MyColors.blackColor,
                                    fontSize: 9,
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]),
                        ),
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

            const SizedBox(
              height: 100,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: MyColors.lessBlackColor,
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
