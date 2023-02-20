import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/client/products_list/client_show_all_category.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:get/get.dart';

class ClientCategoriesScreen extends StatelessWidget {
  ClientCategoriesScreen({super.key});
  CategoryController categoryController = Get.put(CategoryController());
  Future<void> refresh() async {
    categoryController.refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Obx(
        () => RefreshIndicator(
          onRefresh: refresh,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                if (categoryController.categories.isEmpty)
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (categoryController.categories.isNotEmpty)
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categoryController.categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Get.to(
                              ClientShowAllCategoryProductsScreen(
                                  category:
                                      categoryController.categories[index])),
                          child: ClientCategoryItemWidget(
                            category: categoryController.categories[index],
                          ),
                        );
                      })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClientCategoryItemWidget extends StatelessWidget {
  final Category category;
  const ClientCategoryItemWidget({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(1, 1),
          blurRadius: 5,
          blurStyle: BlurStyle.outer,
        )
      ]),
      height: 150,
      child: Stack(
        children: [
          Hero(
            tag: category.createAt,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                category.image,
                width: double.infinity,
                height: double.infinity,
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
          Container(
            width: double.infinity,
            height: double.infinity,
            // color: MyColors.primaryColor,
            padding: const EdgeInsets.only(right: 20, bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  // Colors.black,
                  // Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                //stops: [0.5, 1],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  category.title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 207, 205, 205),
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
                Text(
                  category.description,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 10,
                    color: MyColors.containerColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
