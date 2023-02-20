import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_screen.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canRestEmail = false;

  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    // TODO: implement initState
    super.initState();
  }

  Future sendVerificationEmail() async {
    // Get.defaultDialog(
    //     title: '',
    //     backgroundColor: MyColors.bg.withOpacity(0.2),
    //     content: const SizedBox(
    //       width: 200,
    //       height: 200,
    //       child: Center(
    //         child: CircularProgressIndicator(
    //           color: MyColors.primaryColor,
    //           backgroundColor: MyColors.lessBlackColor,
    //         ),
    //       ),
    //     ));
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canRestEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canRestEmail = true;
      });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    // Get.back();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      isEmailVerified
      ? const ClientOrderScreen():
      Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height / 2,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    offset: const Offset(1, 1),
                    blurRadius: 10,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleInfo,
                    size: 50,
                    color: MyColors.primaryColor.withOpacity(0.7),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'تم ارسال رسالة للايميل يرجى التحقق من ايميلك واعادة الدخول',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      color: MyColors.secondaryTextColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: canRestEmail ? sendVerificationEmail : () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: MyColors.primaryColor,
                      minimumSize: const Size(200, 50),
                    ),
                    child: const SizedBox(
                      width: 200,
                      child: Center(
                        child: Text(
                          'اعاده ارسال ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(
                          color: MyColors.secondaryTextColor,
                        ),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const SizedBox(
                      width: 200,
                      child: Center(
                        child: Text(
                          'الغاء',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 16,
                            color: MyColors.secondaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
