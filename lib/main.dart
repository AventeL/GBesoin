import 'package:flutter/material.dart';
import 'package:gbesoin/screens/homescreen.dart';
import 'package:gbesoin/screens/loginscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp(
    isFirstTime: true,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.isFirstTime}) : super(key: key);
  final bool isFirstTime;

  Widget getScreen() {
    if (isFirstTime) {
      return const LoginScreen(isFirstTime: true);
    } else {
      return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GBesoin',
      theme: ThemeData(
          primarySwatch: Colors.green, backgroundColor: Colors.black87),
      home: getScreen(),
    );
  }
}
