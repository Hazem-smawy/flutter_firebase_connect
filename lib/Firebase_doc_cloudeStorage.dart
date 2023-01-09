import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:date_time_field/date_time_field.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = TextEditingController();
  final controllerName = TextEditingController();
  final controllerAge = TextEditingController();
  late DateEditingController dobController;

  @override
  void initState() {
    super.initState();
    dobController = DateEditingController(
      date: DateTime(2020, 1, 1),
      initialDate: DateTime(2020, 9, 1),
      firstDate: DateTime(2019, 3, 4),
      lastDate: DateTime(2022, 4, 4),
      format: DateFormat('yyyy/MM/dd'),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              // final name = controller.text;
              //  createUser(name: name);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: controllerName,
            decoration: decoration('Name'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: controllerAge,
            decoration: decoration('Age'),
          ),
          const SizedBox(
            height: 20,
          ),
          DateTimeField(
            controller: dobController,
            decoration: decoration("Birthday"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                final user = User(
                    name: controllerName.text,
                    age: int.parse(controllerAge.text),
                    birthday: DateTime.parse(dobController.date.toString()));

                createUserTow(user);
              },
              child: const Text("Create"))
        ],
      ),
    );
  }

  InputDecoration decoration(String label) =>
      InputDecoration(labelText: label, border: const OutlineInputBorder());
  Future createUser({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    // final json = {
    //   'name': name,
    //   'age': 21,
    //   'birthday': DateTime(2001, 7, 28),
    // };
    final user = User(
      id: docUser.id,
      name: name,
      age: 21,
      birthday: DateTime(2001, 7, 23),
    );

    final json = user.toJson();

    await docUser.set(json);
  }

  Future createUserTow(User user) async {
    final docUser = FirebaseFirestore.instance.collection('user').doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}

class User {
  String id;
  final String name;
  final int age;
  final DateTime birthday;

  User({
    this.id = '',
    required this.name,
    required this.age,
    required this.birthday,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'birthday': birthday,
      };
}
