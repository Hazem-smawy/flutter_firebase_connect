import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/client/home/client_category_image_widget.dart';
import 'package:flutter_fire_base/client/home/client_product_item.dart';
import 'package:flutter_fire_base/client/home/client_slider_widget.dart';
import 'package:flutter_fire_base/client/products_list/client_show_all_category.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientHomeScreen extends StatelessWidget {
  ClientHomeScreen({super.key});
  List items = [
    {
      'image': 'assets/images/images.jpg',
      'title':
          'الوصف للمنتج يضهر هنا اسم المنتج هنا الوصف للمنتج يضهر هنا اسم المنتج هنا',
      'price': '200'
    },
    {
      'image': 'assets/images/images2.jpg',
      'title':
          'الوصف للمنتج يضهر هنا اسم المنتج هنا الوصف للمنتج يضهر هنا اسم المنتج هنا',
      'price': '100'
    },
    {
      'image': 'assets/images/images3.jpg',
      'title': 'الوصف للمنتج يضهر هنا اسم المنتج هنا اسم المنتج هنا',
      'price': '300'
    },
    {
      'image': 'assets/images/images4.jpg',
      'title':
          'الوصف للمنتج يضهر هنا اسم المنتج هنا الوصف للمنتج يضهر هنا اسم المنتج هنا',
      'price': '200'
    },
    {
      'image': 'assets/images/images5.jpg',
      'title': 'الوصف للمنتج يضهر هنا اسم المنتج هنا  المنتج هنا',
      'price': '400'
    },
    {
      'image': 'assets/images/background.jpg',
      'title': 'الوصف للمنتج يضهر هنا اسم المنتج هنا  المنتج هنا',
      'price': '400'
    },
    {
      'image': 'assets/images/background2.jpg',
      'title': 'الوصف للمنتج يضهر هنا اسم المنتج هنا  المنتج هنا',
      'price': '400'
    },
  ];
  CategoryController categoryController = Get.put(CategoryController());
  ProductsController productsController = Get.put(ProductsController());
  DatabaseService databaseService = DatabaseService();
  Future<void> refreshPage() async {
    categoryController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: refreshPage,
      child: Scaffold(
        drawer: const Drawer(),
        body: SingleChildScrollView(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const ClientShowSliderWidget(),
                const SizedBox(height: 20),
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, i) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClientCategoryImageWidget(
                                    image:
                                        categoryController.categories[i].image),
                                const SizedBox(height: 20),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyColors.bg,
                                    boxShadow: [
                                      BoxShadow(
                                        color: MyColors.lessBlackColor
                                            .withOpacity(0.07),
                                        offset: const Offset(1, 1),
                                        blurRadius: 10,
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.angleLeft,
                                        size: 18,
                                        color: MyColors.secondaryTextColor,
                                      ),
                                      GestureDetector(
                                        onTap: () => Get.to(
                                            () => ClientShowAllCategoryProductsScreen(
                                                  category: categoryController
                                                      .categories[i],
                                                )),
                                        child: const Text(
                                          '  عرض الكل',
                                          style: TextStyle(
                                            fontFamily: 'Cairo',
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                            color: MyColors.lessBlackColor,
                                          ),
                                          maxLines: 1,
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        categoryController.categories[i].title,
                                        style: const TextStyle(
                                          fontFamily: 'Cairo',
                                          fontSize: 16,
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
                              ],
                            ),
                          ),
                          FutureBuilder<List<Product>>(
                              future:
                                  databaseService.getProductsOfCategoryAndLimit(
                                categoryController.categories[i].cid,
                              ),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.waiting:
                                    return Container(
                                      height: 400,
                                      width: double.infinity,
                                      margin: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: MyColors.containerColor,
                                      ),
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  case ConnectionState.active:
                                    return const Text('active');
                                  case ConnectionState.done:
                                    return snapshot.hasData
                                        ? MasonryGridView.count(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 30,
                                            ),
                                            shrinkWrap: true,
                                            itemCount: snapshot.data?.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 15,
                                            crossAxisSpacing: 10,
                                            itemBuilder: ((context, index) =>
                                                ClientProductItemWidget(
                                                  product:
                                                      snapshot.data![index],
                                                )),
                                          )
                                        : const Text("some Error");
                                  default:
                                    return const Text('data');
                                }
                                // if (ConnectionState ==
                                //     ConnectionState.waiting) {
                                //   return const Text('waitting');
                                // }
                                // if (ConnectionState == ConnectionState.done)
                                // print(snapshot.data?.length);
                              }),
                        ],
                      );
                    }),
                const FooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            //  borderRadius: BorderRadius.circular(10),
            color: MyColors.blackColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'للتواصل معانا',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 14,
                  color: MyColors.secondaryTextColor,
                ),
              ),
              const Divider(
                color: MyColors.secondaryTextColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  FooterSocialIcon(icon: FontAwesomeIcons.facebook),
                  SizedBox(width: 15),
                  FooterSocialIcon(icon: FontAwesomeIcons.whatsapp),
                  SizedBox(width: 15),

                  FooterSocialIcon(icon: FontAwesomeIcons.instagram),
                  SizedBox(width: 15),

                  FooterSocialIcon(icon: FontAwesomeIcons.twitter),
                  SizedBox(width: 15),

                  FooterSocialIcon(icon: FontAwesomeIcons.telegram),

                  // FooterSocialIcon(icon: FontAwesomeIcons.facebook),
                  // SizedBox(width: 10),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'hazemsmawy@gmail.com',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 13,
                  // fontWeight: FontWeight.bold,
                  color: MyColors.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          color: MyColors.containerColor,
          child: const Text(
            'حقوق الطبع محفوضة',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: MyColors.secondaryTextColor,
            ),
          ),
        ),
      ],
    );
  }
}

class FooterSocialIcon extends StatelessWidget {
  final IconData icon;
  const FooterSocialIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //  margin: const EdgeInsets.only(left: 20),
      child: FaIcon(
        icon,
        size: 20,
        color: MyColors.secondaryTextColor,
      ),
    );
  }
}
