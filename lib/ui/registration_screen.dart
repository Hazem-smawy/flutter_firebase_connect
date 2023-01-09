import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/const/AppColors.dart';
import 'package:flutter_fire_base/ui/login_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final bool _obscureText = true;

  signUp() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      var authCredential = userCredential.user;
      print(authCredential!.uid);

      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      } else {
        Fluttertoast.showToast(msg: 'Something is wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: 'example@gmail.com',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff414041),
                  ),
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(fontSize: 15.sp, color: AppColors.deep_orange)),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                  hintText: '1234',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff414041),
                  ),
                  labelText: 'Password',
                  labelStyle:
                      TextStyle(fontSize: 15.sp, color: AppColors.deep_orange)),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 1.sw,
              height: 56.h,
              child: ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deep_orange, elevation: 3),
                child: Text(
                  'sign in',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
