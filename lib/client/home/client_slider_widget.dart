import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_slider_controller.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:get/get.dart';

class ClientShowSliderWidget extends StatefulWidget {
  const ClientShowSliderWidget({super.key});

  @override
  State<ClientShowSliderWidget> createState() => _ClientShowSliderWidgetState();
}

class _ClientShowSliderWidgetState extends State<ClientShowSliderWidget> {
  SliderController sliderController = Get.put(SliderController());

  CarouselController buttonCarouselController = CarouselController();

  double currentIndexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() => sliderController.sliders.isEmpty
        ? Container(
            color: MyColors.bg,
            height: 225,
            width: MediaQuery.of(context).size.width,
            child: const Center(child: CircularProgressIndicator()),
          )
        : Container(
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                    viewportFraction: 0.9,
                    onPageChanged: ((index, reason) {
                      setState(() {
                        currentIndexPage = index.toDouble();
                      });
                    }),
                    reverse: true,
                    autoPlay: true,
                    height: 220.0,
                  ),
                  items: sliderController.sliders.map((slide) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(
                              horizontal: 5.0,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              //color: Colors.amber,

                              borderRadius: BorderRadius.circular(10),

                              boxShadow: const [
                                // BoxShadow(
                                //   color: MyColors.lessBlackColor.withOpacity(0.2),
                                //   offset: const Offset(1, 0),
                                //   blurRadius: 5,
                                // ),
                              ],
                              // image: DecorationImage(
                              //   fit: BoxFit.cover,
                              //   image: NetworkImage(slide.image),
                              // ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: MyColors.containerColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Stack(
                                  children: [
                                    Image.network(
                                      slide.image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, exception, stackTrack) =>
                                              const Center(
                                        child: Icon(
                                          Icons.error,
                                        ),
                                      ),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            color: MyColors.primaryColor,
                                            backgroundColor: Colors.white,
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                    ),

                                    // text
                                    Positioned.fill(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              MyColors.lessBlackColor,
                                            ],
                                            stops: [0.6, 1],
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Container(
                                          alignment: Alignment.bottomRight,
                                          margin: const EdgeInsets.all(10),
                                          padding: const EdgeInsets.all(10),
                                          // color: MyColors.primaryColor,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                slide.title,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: MyColors.bg,
                                                ),
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                              ),
                                              Text(
                                                slide.description,
                                                style: const TextStyle(
                                                  fontFamily: 'Cairo',
                                                  fontSize: 10,
                                                  color:
                                                      MyColors.containerColor,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    //
                                  ],
                                ),
                              ),
                            ));
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Container(
                  child: DotsIndicator(
                    reversed: true,
                    dotsCount: sliderController.sliders.length,
                    position: currentIndexPage,
                  ),
                )
              ],
            ),
          ));
  }
}
