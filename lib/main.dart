import 'package:flutter/material.dart';
import 'package:gbesoin/providers/local_storage.dart';
import 'package:gbesoin/screens/choicescreen.dart';
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
    const MaterialColor customColor = MaterialColor(0xff8D0008, <int, Color>{
      50: Color(0xff8D0008),
      100: Color(0xff8D0008),
      200: Color(0xff8D0008),
      300: Color(0xff8D0008),
      400: Color(0xff8D0008),
      500: Color(0xff8D0008),
      600: Color(0xff8D0008),
      700: Color(0xff8D0008),
      800: Color(0xff8D0008),
      900: Color(0xff8D0008),
    });
    getScreen();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GBesoin',
        theme: ThemeData(
            primarySwatch: customColor, backgroundColor: Colors.white),
        home: screen);
  }
}
