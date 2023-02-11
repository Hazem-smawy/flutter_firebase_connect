import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_details.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClientAllOrderScreen extends StatefulWidget {
  const ClientAllOrderScreen({super.key});

  @override
  State<ClientAllOrderScreen> createState() => _ClientAllOrderScreenState();
}

class _ClientAllOrderScreenState extends State<ClientAllOrderScreen> {
  final Map<String, List> _elements = {
    'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
    'Team B': ['Toyah Downs', 'Tyla Kane'],
    'Team c': ['Toyah Downs', 'Tyla Kane', 'Kane', 'Kane kdk'],
  };
  OrderController orderController = Get.put(OrderController());

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 30,
          ),
          child: Obx(
            () => Column(
              //  mainAxisAlignment: MainAxisAlignment.center,

              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.bg,
                    boxShadow: [
                      BoxShadow(
                        color: MyColors.lessBlackColor.withOpacity(0.1),
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
                      const Text(
                        ' كل الطلبات',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: MyColors.lessBlackColor,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.end,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.arrowRightLong,
                            size: 18,
                            color: MyColors.secondaryTextColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                if (orderController.todaysOrder.isEmpty &&
                    orderController.lastWeekOrder.isEmpty &&
                    orderController.lastMonthOrder.isEmpty)
                  const SizedBox(),
                if (orderController.todaysOrder.isNotEmpty ||
                    orderController.lastWeekOrder.isNotEmpty ||
                    orderController.lastMonthOrder.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 30,
                      left: 10,
                      right: 10,
                    ),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.bg,
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(11, 0, 0, 0),
                            offset: Offset(1, 1),
                            blurRadius: 10,
                          ),
                        ]),
                    child: Column(
                      children: [
                        if (orderController.todaysOrder.isNotEmpty)
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
                                itemCount: orderController.todaysOrder.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AdminOrderItemWidget(
                                    order: orderController.todaysOrder[index],
                                    section: 0,
                                    index: index,
                                  );
                                },
                              ),
                            ],
                          ),
                        // weeks
                        if (orderController.lastWeekOrder.isNotEmpty)
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
                                itemCount: 3,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () => Get.to(
                                        () => const ClientOrderDetailsScreen()),
                                    child: AdminOrderItemWidget(
                                      order:
                                          orderController.lastWeekOrder[index],
                                      section: 1,
                                      index: index,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        // month
                        if (orderController.lastMonthOrder.isNotEmpty)
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
                                itemCount:
                                    orderController.lastMonthOrder.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return AdminOrderItemWidget(
                                    section: 2,
                                    order:
                                        orderController.lastMonthOrder[index],
                                    index: index,
                                  );
                                },
                              ),
                            ],
                          )
                      ],
                    ),
                  )
              ],
            ),
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
  AdminOrderItemWidget({
    Key? key,
    required this.order,
    required this.section,
    required this.index,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ClientOrderDetailsScreen()),
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
                      DateFormat.Hm().format(order.orderOn),
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
                            text: order.id.toString(),
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
                    //textDirection: TextDirection.rtl,
                    text: TextSpan(
                        text: 'الاسم : ',
                        style: const TextStyle(
                          color: MyColors.secondaryTextColor,
                          fontSize: 12,
                          fontFamily: 'Cairo',
                        ),
                        children: [
                          TextSpan(
                            text: order.customerId,
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
          ],
        ),
      ),
    );
  }
}
