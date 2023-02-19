import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fire_base/client/client_order_screen/client_order_screen.dart';
import 'package:flutter_fire_base/main.dart';
//import 'package:flutter_fire_base/admin/model/user_model.dart';

class ClientOrderRedirectScreen extends StatelessWidget {
  const ClientOrderRedirectScreen({super.key});
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return const ClientOrderScreen();
          } else {
            return const AdminMainPage();
          }
        },
      ),
    );

    // user == null ? const AdminMainPage() :;
  }
}
