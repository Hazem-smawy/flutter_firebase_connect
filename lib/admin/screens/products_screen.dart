import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 100,
                width: double.infinity,
                child: Row(
                  children: [
                    const Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.primaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.plus,
                            size: 20,
                            color: MyColors.bg,
                          ),
                          Text(
                            'new product',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: MyColors.bg,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return const _buildShowProduct();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildShowProduct extends StatelessWidget {
  const _buildShowProduct({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(5),
      width: double.maxFinite,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.containerColor,
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: MyColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage('assets/images/images4.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            height: 150,
            width: 120,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This is th title of product',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: MyColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'This is th title of product and This is th title of product',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: MyColors.secondaryTextColor,
                    ),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: MyColors.primaryColor, width: 2),
                          //color: MyColors.bg,
                        ),
                        child: Text(
                          'Edit product ',
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            color: MyColors.blackColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: MyColors.primaryColor, width: 2),
                        ),
                        child: Text(
                          'Delete ',
                          style: GoogleFonts.roboto(
                            fontSize: 13,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
