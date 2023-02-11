import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_slider_controller.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/sliders/admin_create_new_slide.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/sliders/admin_slider_button.dart';
import 'package:flutter_fire_base/admin/screens/admin_about_shop_screens/sliders/amdin_sliders_item.dart';
import 'package:get/get.dart';

class AdminSlidersScreen extends StatefulWidget {
  // final BuildContext cnx;
  const AdminSlidersScreen({super.key});

  @override
  State<AdminSlidersScreen> createState() => _AdminSlidersScreenState();
}

class _AdminSlidersScreenState extends State<AdminSlidersScreen> {
  final SliderController sliderController = Get.put(SliderController());
  // final ProductsController _productsController = Get.put(ProductsController());

  // bool showAddNewCategory = false;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            // const AdminSearchWidget(),
            Container(
              // height: 200,
              alignment: Alignment.centerRight,

              child: AdminSliderElevatedButton(
                sliderController: sliderController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (sliderController.showNewSlider.value)
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: const AdminCreateNewSlider(),
              ),
            const SizedBox(
              height: 20,
            ),
            if (sliderController.sliders.isEmpty) const SizedBox(),
            // Container(
            //   // height: 100,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: MyColors.bg,
            //   ),
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            //   margin: const EdgeInsets.all(5),
            //   child: Center(
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         const FaIcon(
            //           FontAwesomeIcons.exclamation,
            //           size: 40,
            //           color: MyColors.primaryColor,
            //         ),
            //         const Text(
            //           'لم تقم باضافة اي تصنيف',
            //           style: TextStyle(
            //             color: MyColors.secondaryTextColor,
            //             fontFamily: 'Cairo',
            //             fontWeight: FontWeight.bold,
            //           ),
            //         ),
            //         const SizedBox(
            //           height: 10,
            //         ),
            //         AdminCategoryElevatedButton(
            //             categoryController: _categoryController),
            //         const SizedBox(
            //           height: 20,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            if (sliderController.sliders.isNotEmpty)
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sliderController.sliders.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, i) {
                  return AdminSlidersItem(
                    slider: sliderController.sliders[i],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
