import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class ClientCategoriesScreen extends StatelessWidget {
  const ClientCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            ClientCategoryItemWidget(
              image: 'assets/images/category1.jpg',
            ),
            SizedBox(
              height: 20,
            ),
            ClientCategoryItemWidget(
              image: 'assets/images/category2.jpg',
            ),
            SizedBox(
              height: 20,
            ),
            ClientCategoryItemWidget(
              image: 'assets/images/category3.jpg',
            ),
            SizedBox(
              height: 20,
            ),
            ClientCategoryItemWidget(
              image: 'assets/images/category4.jpg',
            ),
            SizedBox(
              height: 20,
            ),
            ClientCategoryItemWidget(
              image: 'assets/images/category5.jpg',
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class ClientCategoryItemWidget extends StatelessWidget {
  final image;
  const ClientCategoryItemWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(1, 1),
          blurRadius: 5,
        )
      ]),
      height: 130,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              image,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            // color: MyColors.primaryColor,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Colors.transparent,
                  // Colors.black,
                  Colors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                //stops: [0.5, 1],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'يضهر هنا اسم ',
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyColors.bg,
                  ),
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
                Text(
                  'الوصف للمنتج يضهر هنا اسم المنتج هنا  المنتج هنا',
                  style: TextStyle(
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
