import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/model/category_model.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientShowAllProductHeaderWidget extends StatelessWidget {
  ClientShowAllProductHeaderWidget({super.key, required this.category});
  Category category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.bg,
        boxShadow: [
          BoxShadow(
            color: MyColors.lessBlackColor.withOpacity(0.08),
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
          GestureDetector(
            onTap: () => Get.back(),
            child: const SizedBox(
              width: 100,
              child: SizedBox(
                child: FaIcon(
                  FontAwesomeIcons.arrowLeftLong,
                  size: 18,
                  color: MyColors.secondaryTextColor,
                ),
              ),
            ),
          ),
          const Spacer(),
          Text(
            category.title,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 14,
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
    );
  }
}
