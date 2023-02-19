import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/product_controller.dart';
import 'package:flutter_fire_base/admin/model/products_model.dart';
import 'package:flutter_fire_base/client/home/client_home_screen.dart';
import 'package:flutter_fire_base/client/home/client_product_item.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientShowAllProductsInShop extends StatefulWidget {
  const ClientShowAllProductsInShop({
    super.key,
  });

  @override
  State<ClientShowAllProductsInShop> createState() =>
      _ClientShowAllProductsInShopState();
}

class _ClientShowAllProductsInShopState
    extends State<ClientShowAllProductsInShop> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    products = productsController.products;
  }

  ProductsController productsController = Get.find();

  void _runFilter(String searchWord) {
    List<Product> result = [];
    if (searchWord.isEmpty) {
      result = productsController.products;
    } else {
      result = productsController.products
          .where(
              (p0) => p0.name.toLowerCase().contains(searchWord.toLowerCase()))
          .toList();
    }
    setState(() {
      products = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: MyColors.bg,
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const SizedBox(height: 10),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 45,
                          width: 45,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: MyColors.bg,
                              border: Border.all(
                                color: MyColors.lessBlackColor,
                              )),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: 18,
                              color: MyColors.secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                            height: 45,
                            //padding: const EdgeInsets.all(5),
                            //  margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: MyColors.bg,
                                border: Border.all(
                                  color: MyColors.lessBlackColor,
                                )),
                            child: Center(
                              child: TextField(
                                onChanged: (value) => _runFilter(value),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                style: const TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  color: MyColors.blackColor,
                                ),
                                decoration: customInputDecoration('ابحث هنا '),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (products.isEmpty)
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.containerColor,
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (productsController.products.isNotEmpty)
                  Container(
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: MyColors.bg,
                    ),
                    child: MasonryGridView.count(
                      padding: const EdgeInsets.only(bottom: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: products.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      itemBuilder: ((context, index) =>
                          ClientProductItemWidget(product: products[index])),
                    ),
                  ),
                const FooterWidget(),
              ],
            )),
      ),
    );
  }

  customInputDecoration(hintText) => InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
        // hintText: hintText,

        hintText: hintText,
        border: InputBorder.none,
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.green),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // errorStyle: const TextStyle(
        //   fontFamily: 'Cairo',
        //   fontSize: 12,
        //   color: Colors.red,
        // ),
        hintStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: MyColors.secondaryTextColor,
        ),
      );
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
