
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/category_controller.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminCategoryElevatedButton extends StatelessWidget {
  const AdminCategoryElevatedButton({
    Key? key,
    required CategoryController categoryController,
  })  : _categoryController = categoryController,
        super(key: key);

  final CategoryController _categoryController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primaryColor.withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        _categoryController.newCategory.clear();
        _categoryController.toggleShowNewCategory();
      },
      icon: FaIcon(
        !_categoryController.showNewCategory.value
            ? FontAwesomeIcons.plus
            : FontAwesomeIcons.arrowDown,
      ),
      label: Text(
        !_categoryController.showNewCategory.value
            ? ' اضف تصنيف'
            : 'تراجـــــــع',
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
