import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/utilities/my_colors.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: 300,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // color: MyColors.lessBlackColor.withOpacity(0.3)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                FirebaseAuth.instance.currentUser?.email ?? '',
                style: const TextStyle(
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
                      'تسجيل خرووج',
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
      );
}
