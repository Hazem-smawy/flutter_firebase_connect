import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/client/home/client_category_image_widget.dart';
import 'package:flutter_fire_base/client/home/client_home_screen.dart';
import 'package:flutter_fire_base/client/home/client_product_item.dart';
import 'package:flutter_fire_base/client/home/client_show_all_product_header.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ClientShowAllCategoryProductsScreen extends StatelessWidget {
  ClientShowAllCategoryProductsScreen({
    super.key,
    required this.category,
  });
  Category category;
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
          ' للمنتج يضهر هنا اسم المنتج هنا الوصف الوصف للمنتج يضهر هنا اسم المنتج هنا الوصف للمنتج يضهر هنا اسم المنتج هنا',
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
  ];
  ProductsController productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: MyColors.bg,
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                ClientShowAllProductHeaderWidget(
                  category: category,
                ),
                const SizedBox(height: 20),
                ClientCategoryImageWidget(
                  image: category.image,
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: MyColors.bg,
                  ),
                  child: FutureBuilder<List<Product>>(
                      future: productsController
                          .getProductsForCategory(category.cid),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return SizedBox(
                              height: MediaQuery.of(context).size.height - 100,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          case ConnectionState.done:
                            return MasonryGridView.count(
                              padding: const EdgeInsets.only(bottom: 20),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data?.length,
                              crossAxisCount: 2,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 10,
                              itemBuilder: ((context, index) =>
                                  ClientProductItemWidget(
                                    product: snapshot.data![index],
                                  )),
                            );

                          default:
                            return const Text('some error');
                        }
                      }),
                ),
                const FooterWidget(),
              ],
            )),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final index;
  const Tile({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: MyColors.secondaryColor,
      ),
      child: Center(child: Text(index.toString())),
    );
  }
}

/*
StaggeredGrid.count(
  crossAxisCount: 4,
  mainAxisSpacing: 4,
  crossAxisSpacing: 4,
  children: const [
    StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Tile(index: 0),
    ),
    StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Tile(index: 1),
    ),
    StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Tile(index: 2),
    ),
    StaggeredGridTile.count(
      crossAxisCellCount: 1,
      mainAxisCellCount: 1,
      child: Tile(index: 3),
    ),
    StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: 2,
      child: Tile(index: 4),
    ),
  ],
);

*/
