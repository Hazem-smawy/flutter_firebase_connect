import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as timeFormat;

class ClientOrderScreen extends StatelessWidget {
  const ClientOrderScreen({
    super.key,
  });

  // Initial Selected Value

  // OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
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
            // margin: const EdgeInsets.all(20),
            // padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //  Row(
                // children: [
                //     GestureDetector(
                //       onTap: (() => Get.to(() => const ClientAllOrderScreen())),
                //       child: Container(
                //         width: 130,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: MyColors.containerColor,
                //         ),
                //         padding: const EdgeInsets.all(10),
                //         margin: const EdgeInsets.symmetric(
                //           horizontal: 20,
                //           vertical: 10,
                //         ),
                //         alignment: Alignment.center,
                //         child: Center(
                //           child: Row(
                //             //mainAxisSize: MainAxisSize.min,
                //             children: const [
                //               Text(
                //                 ' كل الطلبات',
                //                 style: TextStyle(
                //                   fontFamily: 'Cairo',
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.bold,
                //                   color: MyColors.lessBlackColor,
                //                 ),
                //               ),
                //               SizedBox(
                //                 width: 10,
                //               ),
                //               FaIcon(
                //                 FontAwesomeIcons.list,
                //                 size: 18,
                //                 color: MyColors.lessBlackColor,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
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
                                            text: const TextSpan(
                                          text: 'حازم السماوي',
                                          style: TextStyle(
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
                                          text: const TextSpan(
                                              text: 'رقم الطلب : ',
                                              style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: MyColors.containerColor,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: '303',
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
                                            .format(DateTime.now()),
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
                            height: 55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: MyColors.bg,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: Colors.green.withOpacity(0.8),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              child: const Center(
                                child: Text(
                                  'تم الطلب',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
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
                    itemCount: 3,
                    shrinkWrap: true,
                    //scrollDirection: Axis.horizontal,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return const AdminOrderDetailItemWidget();
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
                        // padding: const EdgeInsets.all(10),
                        //margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: MyColors.lessBlackColor),
                          borderRadius: BorderRadius.circular(10),
                          // color: MyColors.containerColor,
                        ),
                        child: const TextField(
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              border: InputBorder.none,
                              hintText: 'اكتب الملاحضه هنا',
                              hintStyle: TextStyle(
                                color: MyColors.secondaryTextColor,
                                fontSize: 10,
                                fontFamily: 'Cairo',
                              ),
                            )),
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
                            text: const TextSpan(
                                text: '2989',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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

                // add order
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryColor.withOpacity(0.8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () async {},
                    icon: const FaIcon(
                      FontAwesomeIcons.message,
                    ),
                    label: const Text(
                      '  اتمام الطلب',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
  const AdminOrderDetailItemWidget({
    Key? key,
    // required this.orderDetails,
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
                      const Positioned(
                        left: 0,
                        top: 0,
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Text(
                            ' 500',
                            style: TextStyle(
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
                    text: const TextSpan(
                      text: 'اسم المنتج هنا ',
                      style: TextStyle(
                        color: MyColors.blackColor,
                        fontSize: 15,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  RichText(
                    textDirection: TextDirection.rtl,
                    text: const TextSpan(
                        text: '300',
                        style: TextStyle(
                          color: MyColors.lessBlackColor,
                          fontSize: 16,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
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
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyColors.secondaryColor,
                          ),
                          child: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.plus,
                                size: 15,
                                color: MyColors.secondaryTextColor,
                              ),
                              Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: MyColors.secondaryColor,
                                ),
                                child: const Center(
                                  child: Text(
                                    '14',
                                    style: TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              const FaIcon(
                                FontAwesomeIcons.minus,
                                size: 15,
                                color: MyColors.secondaryTextColor,
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

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.lessBlackColor,
              ),
              child: Image.asset('assets/images/images2.jpg'),
            ),
          ],
        ),
      ),
    );
  }
}

/*


  
 

*/
