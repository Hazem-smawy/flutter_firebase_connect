import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Signed In as',
                  style: TextStyle(fontSize: 23),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(fontSize: 23),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text(
                      "Sign Out",
                      style: TextStyle(fontSize: 23),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
