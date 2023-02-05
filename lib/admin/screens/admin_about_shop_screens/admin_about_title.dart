import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class AdminAboutTitleWidget extends StatelessWidget {
  final  title;
  const AdminAboutTitleWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Row(
            children:  [
              Expanded(
                  child: Divider(
                color: MyColors.lessBlackColor,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(title
                 ,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: MyColors.lessBlackColor,
                  ),
                ),
              ),
              Expanded(
                  child: Divider(
                color: MyColors.lessBlackColor,
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
    ],);
  }
}