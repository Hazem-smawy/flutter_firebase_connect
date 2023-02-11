import 'package:flutter/material.dart';
import 'package:flutter_fire_base/client/client_product_details_screen/client_product_details_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ClientProductItemWidget extends StatelessWidget {
  final image;
  final title;
  final price;
  const ClientProductItemWidget({
    Key? key,
    this.image,
    this.title,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const ClientProductDetailsScreen()),
      child: Container(
        constraints: const BoxConstraints(minHeight: 200),
        decoration: BoxDecoration(
            color: MyColors.bg,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.lessBlackColor.withOpacity(0.2),
                offset: const Offset(1, 1),
                blurRadius: 10,
              )
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Container(
                constraints: const BoxConstraints(minHeight: 150),
                child: Image.network(
                  image,
                  width: double.infinity,
                  // height: double.infinity,
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
            Padding(
              padding: const EdgeInsets.only(
                right: 8,
                left: 8,
                bottom: 8,
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13,
                      // fontWeight: FontWeight.bold,
                      color: MyColors.lessBlackColor,
                    ),
                    maxLines: 4,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColors.containerColor,
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        RichText(
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            style: const TextStyle(
                              color: MyColors.blackColor,
                              fontSize: 20,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                            ),
                            text: price,
                            children: const [
                              TextSpan(
                                text: ' ر.س ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.cartShopping,
                            size: 20,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
