import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart' as myOrder;
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_completed.dart';
import 'package:flutter_fire_base/client/client_product_details_screen/client_product_details_screen.dart';
import 'package:flutter_fire_base/client/home/client_bottom_navigation.dart';
import 'package:flutter_fire_base/client/products_list/client_show_all_products.dart';
import 'package:flutter_fire_base/main.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as timeFormat;
import '../../admin/model/user_model.dart' as myUser;

class ClientOrderScreen extends StatefulWidget {
  const ClientOrderScreen({
    super.key,
  });
  
  @override
  State<ClientOrderScreen> createState() => _ClientOrderScreenState();
}

class _ClientOrderScreenState extends State<ClientOrderScreen> {
  // Initial Selected Value
  User? user = FirebaseAuth.instance.currentUser;
  DatabaseService databaseService = DatabaseService();
  myUser.User? currentUser;
  //late List<Product>? product;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    if (user != null) {
      await databaseService.getUser(user?.email).then((value) {
        setState(() {
          currentUser = value;
        });
      });
    }
  }

  ProductsController productsController = Get.put(ProductsController());
  OrderController orderController = Get.put(OrderController());
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Product> products = orderController.orderDetails.map((order) {
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
          child: Obx(
            () => SizedBox(
              width: double.infinity,
              child: orderController.orderDetails.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  color: MyColors.containerColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: FaIcon(
                                  FontAwesomeIcons.bagShopping,
                                  color: MyColors.primaryColor.withOpacity(0.5),
                                  size: 100,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                'تسوق الان',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 16,
                                  color: MyColors.lessBlackColor,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'نقدم لكم كل ماهو جديد وحصري وبافضل الاسعار',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 12,
                                  color: MyColors.secondaryTextColor,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Get.offAll(
                                      () => const ClientBottomNavigation());
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    backgroundColor: MyColors.blackColor,
                                    minimumSize: const Size(200, 50)),
                                icon: const Icon(Icons.arrow_back),
                                label: const Text(
                                  ' تسوق الان',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Column(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                RichText(
                                                    text: TextSpan(
                                                  text: currentUser?.name ??
                                                      'Unknown',
                                                  style: const TextStyle(
                                                    fontFamily: 'Cairo',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        MyColors.containerColor,
                                                  ),
                                                )),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const FaIcon(
                                                  FontAwesomeIcons.user,
                                                  size: 15,
                                                  color:
                                                      MyColors.containerColor,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 10,
                                              ),
                                              child: RichText(
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  text: const TextSpan(
                                                      text: 'رقم الطلب : ',
                                                      style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: MyColors
                                                            .containerColor,
                                                      ),
                                                      children: [
                                                        TextSpan(
                                                          text: '1',
                                                        )
                                                      ])),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 10,
                                              ),
                                              child: Text(
                                                timeFormat.DateFormat
                                                        .yMMMMEEEEd()
                                                    .format(DateTime.now()),
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors
                                                      .secondaryTextColor,
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
                                        color: Colors.green.withOpacity(0.8),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(2),
                                      alignment: Alignment.center,
                                      child: const Center(
                                        child: Text(
                                          ' لم يتم الطلب',
                                          style: TextStyle(
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
                        if (orderController.orderDetails.isEmpty)
                          Container(
                            margin: const EdgeInsets.all(20),
                            height: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: MyColors.containerColor,
                            ),
                            child: GestureDetector(
                              onTap: () => Get.to(
                                  () => const ClientShowAllProductsInShop()),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Center(
                                    child: FaIcon(
                                      FontAwesomeIcons.bagShopping,
                                      color: MyColors.primaryColor,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'تسوق الان',
                                    style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 16,
                                      color: MyColors.secondaryTextColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                        if (orderController.orderDetails.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.all(10),
                            child: ListView.builder(
                              itemCount: orderController.orderDetails.length,
                              shrinkWrap: true,
                              //scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return AdminOrderDetailItemWidget(
                                  product: products[index],
                                  OrderDetails:
                                      orderController.orderDetails[index],
                                  index: index,
                                  products: products,
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
                                  border: Border.all(
                                      color: MyColors.lessBlackColor),
                                  borderRadius: BorderRadius.circular(10),
                                  // color: MyColors.containerColor,
                                ),
                                child: TextField(
                                    controller: noteController,
                                    textAlign: TextAlign.end,
                                    decoration: const InputDecoration(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              color:
                                                  MyColors.secondaryTextColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(
                                        text: orderController
                                            .getTotal()
                                            .toString(),
                                        style: const TextStyle(
                                          color: MyColors.lessBlackColor,
                                          fontSize: 16,
                                          fontFamily: 'Cairo',
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: '  ر.س',
                                            style: TextStyle(
                                              color:
                                                  MyColors.secondaryTextColor,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    textDirection: TextDirection.rtl,
                                    text: TextSpan(
                                        text: orderController
                                            .getTotal()
                                            .toString(),
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
                                              color:
                                                  MyColors.secondaryTextColor,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: orderController.isLoading.value
                              ? Container(
                                  height: 56,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: MyColors.secondaryColor,
                                  ),
                                  child: const SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        backgroundColor: Colors.white,
                                        color: MyColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primaryColor
                                          .withOpacity(0.8),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      minimumSize: const Size.fromHeight(56)),
                                  onPressed: () async {
                                    if (user == null) {
                                      Get.to(() => const AdminMainPage());
                                      return;
                                    }

                                    try {
                                      orderController.isLoading.value = true;
                                      //  myOrder.Order? order =
                                      //  await orderController.getLastOrder();
                                      DatabaseService databaseService =
                                          DatabaseService();
                                      final myUser = await databaseService
                                          .getUser(user!.email);

                                      myOrder.Order? lastOrder =
                                          await databaseService.getLastOrder();
                                      String lastId = '0';
                                      if (lastOrder != null) {
                                        lastId = lastOrder.id;
                                      }
                                      String id =
                                          (int.parse(lastId) + 1).toString();
                                      // print(id);
                                      myOrder.Order newOrder = myOrder.Order(
                                        id: id,
                                        status: 0,
                                        customerId: user!.uid,
                                        customerName: myUser?.name ?? '',
                                        orderNote: noteController.text.trim(),
                                        orderOn: DateTime.now(),
                                        currencyId: 1,
                                        subtotal: orderController.getTotal(),
                                        amountDescount:
                                            orderController.getTotal(),
                                        totalAbount: orderController.getTotal(),
                                        orderDetails:
                                            orderController.orderDetails,
                                        isCompleted: 0,
                                      );

                                      await orderController.addOrder(newOrder);
                                      Utils.showSnackBar(
                                          'تم اضافة المنتجات للمفضلة');
                                      Get.to(() => ClientOrderCompletedScreen(
                                            order: newOrder,
                                            currentUser: currentUser!,
                                          ));

                                      orderController.isLoading.value = false;
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  },
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
      ),
    );
  }
}

class AdminOrderDetailItemWidget extends StatelessWidget {
  AdminOrderDetailItemWidget({
    Key? key,
    required this.product,
    required this.OrderDetails,
    required this.index,
    required this.products,
  }) : super(key: key);
  Product product;
  List<Product> products;
  final index;
  myOrder.OrderDetails OrderDetails;
  OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    orderController.quantity.value = OrderDetails.itemQuantity;
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
                          orderController
                              .getQuantityPrice(product.price)
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
              GestureDetector(
                onTap: () {
                  orderController.deleteOrder(OrderDetails, index);
                  products.removeAt(index);
                },
                child: Container(
                  //width: 30,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    //color: Colors.red,
                  ),
                  child: const Center(
                      child: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 15,
                    color: Colors.red,
                  )),
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
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: MyColors.secondaryColor,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                orderController.updateQuantity(
                                    OrderDetails, index, 1, product);
                                Utils.showSnackBar('تم زياده كمية  المنتج  +1');
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 5, right: 10, top: 5, bottom: 5),
                                child: FaIcon(
                                  FontAwesomeIcons.plus,
                                  size: 15,
                                  color: MyColors.secondaryTextColor,
                                ),
                              ),
                            ),
                            Container(
                              //width: 0,
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: MyColors.secondaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  OrderDetails.itemQuantity.toString(),
                                  style: const TextStyle(
                                    color: MyColors.primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                if (OrderDetails.itemQuantity > 1) {
                                  orderController.updateQuantity(
                                      OrderDetails, index, -1, product);
                                } else {
                                  Utils.showSnackBar('هذه اقل كميه ');
                                }
                              }),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    right: 5, left: 10, top: 5, bottom: 5),
                                child: FaIcon(
                                  FontAwesomeIcons.minus,
                                  size: 15,
                                  color: MyColors.secondaryTextColor,
                                ),
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
