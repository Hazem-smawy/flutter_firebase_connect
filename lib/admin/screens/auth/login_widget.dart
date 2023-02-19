import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/auth/forgot_password.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: 490,
            margin: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              // color: MyColors.lessBlackColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.lessBlackColor,
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      size: 30,
                      color: MyColors.secondaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.lessBlackColor.withOpacity(0.7),
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    controller: emailController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: MyColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration:
                        customInputDecoration('الا يميل', Icons.email_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.lessBlackColor.withOpacity(0.7),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.right,
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: MyColors.secondaryColor,
                    ),
                    decoration: customInputDecoration(
                      'كلمة المرور',
                      Icons.lock_open,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: const Text(
                        "نسيت كلمة المرور ",
                        style: TextStyle(
                          color: Color.fromARGB(255, 143, 51, 51),
                          fontSize: 10,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.bold,
                          // decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => const ForgotPassword());
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    SignIn();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: MyColors.blackColor,
                      minimumSize: const Size.fromHeight(50)),
                  icon: const Icon(Icons.lock_open),
                  label: const Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: const TextStyle(
                      color: MyColors.secondaryTextColor,
                      fontSize: 17,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                    text: ' لا يوجد حساب ؟ ',
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickedSignUp,
                        text: 'انشاء حساب',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          decoration: TextDecoration.underline,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  customInputDecoration(hintText, IconData icon) => InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
        // hintText: hintText,
        suffixIcon: Container(
          width: 30,
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            color: MyColors.containerColor.withOpacity(0.8),
          ),
        ),
        hintText: hintText,
        border: InputBorder.none,
        // focusedBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.green),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // focusedErrorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: const BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(20),
        // ),
        errorStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: Colors.red,
        ),
        hintStyle: TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: MyColors.containerColor.withOpacity(0.8),
          fontWeight: FontWeight.normal,
        ),
      );

  Future SignIn() async {
    Get.defaultDialog(
        title: '',
        backgroundColor: MyColors.bg.withOpacity(0.2),
        content: const SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: CircularProgressIndicator(
              color: MyColors.primaryColor,
              backgroundColor: MyColors.lessBlackColor,
            ),
          ),
        ));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    Get.back();
  }
}
