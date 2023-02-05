import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/admin/controller/admin_user_controller.dart';
import 'package:flutter_fire_base/admin/screens/auth/utils.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../model/user_model.dart' as UserModel;

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignUp;

  const SignUpWidget({super.key, required this.onClickedSignUp});

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatePasswordController = TextEditingController();

  UserController userController = Get.put(UserController());
  final formKey = GlobalKey<FormState>();
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: MyColors.bg,
                  child: Image.asset(
                    'assets/images/background.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                child: Container(
                  height: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 250,
                    left: 20,
                    right: 20,
                  ),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: MyColors.lessBlackColor.withOpacity(0.3),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.secondaryColor,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.right,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: customInputDecoration(
                            'الاسم',
                            FontAwesomeIcons.user,
                          ),
                        ),
                      ),
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
                          textInputAction: TextInputAction.next,
                          decoration: customInputDecoration(
                              'الايميل', Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.secondaryColor,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.right,
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          decoration: customInputDecoration(
                            'كلمة المرور',
                            Icons.lock_open,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.secondaryColor,
                        ),
                        child: TextFormField(
                          obscureText: true,
                          textAlign: TextAlign.right,
                          controller: repeatePasswordController,
                          textInputAction: TextInputAction.next,
                          decoration: customInputDecoration(
                            ' اعد كتابة كلمة المرور',
                            Icons.lock_open,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          signUp();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: MyColors.primaryColor,
                            minimumSize: const Size.fromHeight(50)),
                        icon: const Icon(Icons.lock_open),
                        label: const Text(
                          ' انشاء حساب',
                          style: TextStyle(
                            fontSize: 16,
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
                          text: '  لدي حساب من قبل',
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = widget.onClickedSignUp,
                              text: ' تسجيل الدخول',
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
              ),
            ],
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

  Future signUp() async {
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
    //final isValid = formKey.currentState!.validate();
    if (emailController.text.length < 2 &&
        passwordController.text.length < 2 &&
        nameController.text.length < 2) {
      Utils.showSnackBar('ادخل البيانات ');
      Get.back();

      return;
    }
    if (passwordController.text.trim() !=
        repeatePasswordController.text.trim()) {
      Utils.showSnackBar('اعد كتابة كلمة المروور بشكل صحيح');
      Get.back();
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // var userEmail = FirebaseAuth.instance.currentUser?.email;
      // final user = User.User(
      //   name: nameController.text.trim(),
      //   email: userEmail!,
      // );
      userController.newUser.update(
        'name',
        (_) => nameController.text.trim(),
        ifAbsent: () => nameController.text.trim(),
      );

      userController.newUser.update(
        'email',
        (_) => emailController.text.trim(),
        ifAbsent: () => nameController.text.trim(),
      );

      // userController.newUser.update(
      //   'password',
      //   (_) => passwordController.text.trim(),
      //   ifAbsent: () => passwordController.text.trim(),
      // );
      if (userController.newUser.isNotEmpty) {
        await userController.addUser(UserModel.User(
          name: nameController.text.trim(),
          email: emailController.text.trim(),
        ));
      }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      Get.back();
    }
    Get.back();
    // Navigator.pop(context);
  }
}
