import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_user_controller.dart';
import 'package:flutter_fire_base/admin/model/user_model.dart';
import 'package:flutter_fire_base/admin/services/database_service.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class AmdinUserMangage extends StatelessWidget {
  AmdinUserMangage({super.key});
  DatabaseService databaseService = DatabaseService();
  UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      auth.FirebaseAuth.instance.signOut();
                    },
                    child: const Icon(Icons.logout)),
                const Spacer(),
                const Text(
                  'المستخدمون',
                  style: TextStyle(
                    color: MyColors.blackColor,
                    fontFamily: 'Cairo',
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const FaIcon(FontAwesomeIcons.user),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (userController.users.isEmpty)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: MyColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text('No Users'),
              ),
            if (userController.users.isNotEmpty)
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: userController.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserItemWidget(
                        user: userController.users[index],
                        index: index,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class UserItemWidget extends StatelessWidget {
  User user;
  int index;
  UserItemWidget({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  UserController userController = Get.find();
  Color getRandomElement() {
    List<Color> colors = [
      const Color.fromARGB(255, 27, 97, 155),
      const Color.fromARGB(255, 155, 64, 30),
      const Color.fromARGB(255, 138, 29, 21),
      const Color.fromARGB(255, 129, 20, 148),
    ];
    final random = Random();
    var i = random.nextInt(colors.length);
    return colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 70,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyColors.bg,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(1, 0),
                  blurRadius: 20)
            ]),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor: getRandomElement(),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                    color: MyColors.blackColor,
                    fontFamily: 'Cairo',
                    fontSize: 14,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: user.email,
                    style: const TextStyle(
                      color: MyColors.secondaryTextColor,
                      fontFamily: 'Cairo',
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),

            // const SizedBox(
            //   width: 10,
            // ),
            const Spacer(),
            // is admin
            GestureDetector(
              onTap: () {
                userController.setAdmin = !userController.isAdmin;
                userController.updateUser(user, index, userController.isAdmin);
              },
              child: Container(
                //  padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: user.isAdmin
                      ? Colors.green.withOpacity(0.2)
                      : Colors.transparent,
                  // border: Border.all(
                  //   color: user.isAdmin
                  //       ? Colors.green
                  //       : Colors.red.withOpacity(0.2),
                  //   width: 2,
                  // ),
                ),
                child: Row(
                  children: [
                    Checkbox(
                        // fillColor: Colors.red,
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                          side: const BorderSide(
                            color: MyColors.bg,
                            style: BorderStyle.solid,
                          ),
                        ),
                        value: user.isAdmin,
                        onChanged: (value) {
                          userController.setAdmin = !userController.isAdmin;
                          userController.updateUser(
                              user, index, userController.isAdmin);
                        }),
                    const Text(
                      'admin',
                      style: TextStyle(
                        color: MyColors.lessBlackColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: '',
                    content: Column(
                      children: const [
                        FaIcon(
                          FontAwesomeIcons.question,
                          size: 30,
                          color: MyColors.primaryColor,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'هل انت متأمد من حذف ',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: MyColors.lessBlackColor,
                          ),
                        ),
                        Text(
                          ' هذا المستخدم ؟',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: MyColors.lessBlackColor,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              //  minimumSize: const Size.fromHeight(50),
                              shape: RoundedRectangleBorder(
                                // side: const BorderSide(
                                //  color: MyColors.secondaryTextColor),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              backgroundColor: MyColors.secondaryColor,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: Text(
                                'تراجع',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 15,
                                  color: MyColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                userController.deleteUser(
                                    user.email, 'imageURL');

                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                // minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                backgroundColor: MyColors.primaryColor,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                child: Text(
                                  'حذف',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ],
                      )
                    ]);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                decoration: const BoxDecoration(
                    // color: Colors.red, borderRadius: BorderRadius.circular(4)
                    ),
                child: const FaIcon(
                  FontAwesomeIcons.trashCan,
                  size: 17,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
