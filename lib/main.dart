import 'package:flutter/material.dart';
import 'package:gbesoin/screens/homescreen.dart';
import 'package:gbesoin/screens/loginscreen.dart';

void main() {
  runApp(const MyApp(
    isFirstTime: false,
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: getScreen(),
    );
  }
}
