import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/auth/utils.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormFieldState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // height: MediaQuery.of(context).size.height / 2,
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: MyColors.lessBlackColor.withOpacity(0.3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.secondaryColor,
                  ),
                  child: TextFormField(
                    textAlign: TextAlign.right,
                    controller: emailController,
                    decoration: customInputDecoration(
                      'الايميل',
                      Icons.email_outlined,
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) => email == null ? "Enter Email " : null,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    resetPassword();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: MyColors.primaryColor,
                      minimumSize: const Size.fromHeight(50)),
                  icon: const Icon(
                    Icons.message,
                    size: 20,
                  ),
                  label: const Text(
                    ' للتحقق من ايملك',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
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

  customInputDecoration(hintText, IconData icon) => InputDecoration(
        contentPadding: const EdgeInsets.only(top: 10, bottom: 10),
        // hintText: hintText,
        suffixIcon: Container(
          width: 30,
          alignment: Alignment.center,
          child: FaIcon(
            icon,
            color: MyColors.secondaryTextColor,
          ),
        ),
        hintText: hintText,
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
        errorStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: Colors.red,
        ),
        hintStyle: const TextStyle(
          fontFamily: 'Cairo',
          fontSize: 12,
          color: MyColors.secondaryTextColor,
        ),
      );

  Future resetPassword() async {
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
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );

      Utils.showSnackBar('لقد ارسلنا رمز التحقق الى بريدك', type: 'info');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    Get.back();
  }
}
