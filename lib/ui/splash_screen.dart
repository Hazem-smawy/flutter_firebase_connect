import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fire_base/const/AppColors.dart';
import 'package:flutter_fire_base/ui/registration_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const RegistrationScreen())));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.deep_orange,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'E-commerce',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 44.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.h,
              ),
              const CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
