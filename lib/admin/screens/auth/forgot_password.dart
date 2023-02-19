import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/screens/utilities/utils.dart';
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 190,
            ),
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
                style: const TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 12,
                  color: MyColors.secondaryColor,
                  fontWeight: FontWeight.bold,
                ),
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
                  backgroundColor: MyColors.blackColor,
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
            color: MyColors.containerColor.withOpacity(0.8),
          ),
        ),
        hintText: hintText,
        border: InputBorder.none,

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

      Utils.showSnackBar('قمنا بارسال رمز التحقق الى بريدك', type: 'info');
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    Get.back();
  }
}
