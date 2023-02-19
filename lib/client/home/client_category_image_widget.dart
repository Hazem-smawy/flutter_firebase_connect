import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class ClientCategoryImageWidget extends StatelessWidget {
  final image;
  const ClientCategoryImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);
  Color getBackgroundColor() {
    List colors = [
      //767676  cfcfbcb   403735  e1d9ce b9dafd  976745 ffffff 00000
      const Color(0xff767676),
      const Color(0xffcfcfbc),
      const Color(0xff403735),
      // const Color(0xffffffff),
      const Color(0xffe1d9ce),
      const Color(0xffb9dafd),
      const Color(0xff976745),
      const Color(0x0ff00000),
    ];
    final random = Random();
    var i = random.nextInt(colors.length);
    return colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getBackgroundColor(),
        boxShadow: const [
          // BoxShadow(
          //   color: MyColors.lessBlackColor.withOpacity(0.2),
          //   offset: const Offset(1, 1),
          //   blurRadius: 20,
          // ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      width: double.infinity,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          image,
          width: double.infinity,
          // height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrack) => const SizedBox(
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
    );
  }
}
