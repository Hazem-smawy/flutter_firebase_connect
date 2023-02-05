import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminSearchWidget extends StatelessWidget {
  const AdminSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
       Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyColors.secondaryColor,
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: MyColors.secondaryTextColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.secondaryColor,
                    ),
                    child: const TextField(
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          left: 5,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        hintText: 'ابحث هنا',
                        hintStyle: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: MyColors.secondaryTextColor,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
    ],);
  }
}