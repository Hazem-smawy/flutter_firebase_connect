import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/auth/utils.dart';
import 'package:flutter_fire_base/client/home/client_bottom_navigation.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

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
  Widget build(BuildContext context) => isEmailVerified
      ? const ClientBottomNavigation()
      : Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/images/background.jpg',
                    ))),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Container(
                height: 300,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.lessBlackColor.withOpacity(0.3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'تم ارسال رسالة للايميل يرجى التحقق من ايميلك واعادة الدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Cairo',
                        color: MyColors.secondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: canRestEmail ? sendVerificationEmail : () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: MyColors.primaryColor,
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        'اعاده ارسال ',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
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
