import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/amdin_order_controller.dart';
import 'package:flutter_fire_base/admin/model/order_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';

class ClientProductDetailsScreen extends StatefulWidget {
  Product product;
  ClientProductDetailsScreen({super.key, required this.product});

  @override
  State<ClientProductDetailsScreen> createState() =>
      _ClientProductDetailsScreenState();
}

class _ClientProductDetailsScreenState
    extends State<ClientProductDetailsScreen> {
  quill.QuillController controller = quill.QuillController.basic();

  OrderController orderController = Get.find();

  int quantity = 1;
  Color getBackgroundColor() {
    List colors = [
      //767676  cfcfbcb   403735  e1d9ce b9dafd  976745 ffffff 00000
      const Color(0xff767676),
      const Color(0xffcfcfbc),
      const Color(0xff403735),
      //  const Color(0xffffffff),
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
    controller = quill.QuillController(
      document: quill.Document.fromJson(widget.product.description),
      selection: const TextSelection.collapsed(offset: 0),
    );
    return SafeArea(
      child: Scaffold(
        body:
            //  mainAxisAlignment: MainAxisAlignment.end,
            Stack(
          fit: StackFit.loose,
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(
                  top: 10, left: 20, right: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Hero(
                    tag: widget.product.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.product.image,
                        width: double.infinity,
                        // height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, exception, stackTrack) =>
                            Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: getBackgroundColor(),
                          ),
                          height: 300,
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
                          return SizedBox(
                            height: 300,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: MyColors.primaryColor,
                                backgroundColor: Colors.white,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
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
                  // details
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      widget.product.name,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: MyColors.secondaryTextColor,
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: RichText(
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        style: const TextStyle(
                          color: MyColors.lessBlackColor,
                          fontSize: 22,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                        ),
                        text: widget.product.price,
                        children: const [
                          TextSpan(
                            text: ' ر.س ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: MyColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    constraints: const BoxConstraints(minHeight: 400),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: quill.QuillEditor.basic(
                        controller: controller, readOnly: true),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            Positioned(
                child: GestureDetector(
              onTap: (() => Get.back()),
              child: Container(
                margin: const EdgeInsets.only(left: 25, top: 15),
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.lessBlackColor.withOpacity(0.3)),
                child: const FaIcon(
                  FontAwesomeIcons.arrowLeftLong,
                  size: 17,
                  color: MyColors.bg,
                ),
              ),
            )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 70,
                  // margin: const EdgeInsets.only(horizontal: 20),
                  padding: const EdgeInsets.only(
                    bottom: 20,
                    left: 10,
                    right: 25,
                    top: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: MyColors.bg,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //color: MyColors.secondaryColor,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  quantity += 1;
                                }),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 18,
                                    color: MyColors.secondaryTextColor,
                                  ),
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  //color: MyColors.secondaryColor,
                                ),
                                child: Center(
                                  child: Text(
                                    quantity.toString(),
                                    style: const TextStyle(
                                      color: MyColors.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => setState(() {
                                  quantity > 1
                                      ? quantity -= 1
                                      : Utils.showSnackBar('هذه اقل كميه ');
                                }),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.minus,
                                    size: 15,
                                    color: MyColors.secondaryTextColor,
                                  ),
                                ),
                              ),
                            ],
                          )),
                      ElevatedButton.icon(
                          onPressed: () async {
                            //   print(orderController.orderDetails.isNotEmpty);
                            if (orderController.orderDetails.isNotEmpty) {
                              var index = orderController.orderDetails
                                  .indexWhere((p0) =>
                                      p0.productId == widget.product.id);

                              if (index >= 0) {
                                orderController.updateQuantity(
                                  orderController.orderDetails[index],
                                  index,
                                  quantity,
                                  widget.product,
                                );

                                Utils.showSnackBar(
                                    'تم زياده كمية  المنتج  + $quantity');
                              } else {
                                orderController.orderDetails.add(
                                  OrderDetails(
                                    id: 1,
                                    productId: widget.product.id,
                                    itemQuantity: quantity,
                                    price: double.parse(widget.product.price),
                                    note: '',
                                  ),
                                );
                                // print(quantity);
                                Utils.showSnackBar(
                                    'تم اضافة  ${widget.product.name} الى السله');
                              }
                            }

                            if (orderController.orderDetails.isEmpty) {
                              orderController.orderDetails.add(
                                OrderDetails(
                                  id: 1,
                                  productId: widget.product.id,
                                  itemQuantity: quantity,
                                  price: double.parse(widget.product.price),
                                  note: '',
                                ),
                              );
                              // print(quantity);
                              Utils.showSnackBar(
                                  'تم اضافة  ${widget.product.name} الى السله');
                            }

                            print(orderController.orderDetails);
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.bagShopping,
                            size: 20,
                          ),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width - 170, 60),
                            backgroundColor: MyColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          label: const Text(
                            'اضف للسله',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Cairo',
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
