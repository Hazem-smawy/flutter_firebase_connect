import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_slider_controller.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminSliderElevatedButton extends StatelessWidget {
  const AdminSliderElevatedButton({
    Key? key,
    required SliderController sliderController,
  })  : _sliderController = sliderController,
        super(key: key);

  final SliderController _sliderController;

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
        _sliderController.newSlider.clear();
        _sliderController.toggleShowNewSlider();
      },
      icon: FaIcon(
        !_sliderController.showNewSlider.value
            ? FontAwesomeIcons.plus
            : FontAwesomeIcons.arrowDown,
        size: 20,
      ),
      label: Text(
        !_sliderController.showNewSlider.value ? ' اضف  صورة' : 'تراجـــــــع',
        style: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
