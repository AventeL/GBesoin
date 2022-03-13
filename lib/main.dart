import 'package:flutter/material.dart';
import 'package:gbesoin/providers/local_storage.dart';
import 'package:gbesoin/screens/homescreen.dart';
import 'package:gbesoin/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget screen = const LoginScreen();
  void getScreen() async {
    int idGroup = 0;
    await LocalStorage().readIdGroup().then((value) => {
          if (value != null)
            {
              setState(() {
                idGroup = int.parse(value);
                screen = HomeScreen(idGroup: idGroup);
              })
            }
          else
            {screen = const LoginScreen()}
        });
  }

  @override
  Widget build(BuildContext context) {
    getScreen();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GBesoin',
        theme: ThemeData(
            primarySwatch: Colors.green, backgroundColor: Colors.black87),
        home: screen);
  }
}
