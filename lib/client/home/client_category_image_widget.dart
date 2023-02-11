import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class ClientCategoryImageWidget extends StatelessWidget {
  final image;
  const ClientCategoryImageWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: MyColors.lessBlackColor.withOpacity(0.2),
          offset: const Offset(1, 1),
          blurRadius: 20,
        )
      ]),
      width: double.infinity,
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          image,
          width: double.infinity,
          // height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, exception, stackTrack) => SizedBox(
            height: 150,
            child: const Center(
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
