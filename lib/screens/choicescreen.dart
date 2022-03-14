import 'package:flutter/material.dart';
import 'package:gbesoin/providers/auth_firebase.dart';
import 'package:gbesoin/screens/creategroup.dart';
import 'package:animated_button/animated_button.dart';
import 'package:gbesoin/screens/loginscreen.dart';

class ChoiceScreen extends StatelessWidget {
  final bool isFirstTime;
  const ChoiceScreen({Key? key, required this.isFirstTime}) : super(key: key);

  Widget getActions(context) {
    if (isFirstTime) {
      return const SizedBox();
    } else {
      return TextButton(
        onPressed: () async {
          AuthenticationHelper().signOut();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        },
        child:
            const Text("Se déconnecter", style: TextStyle(color: Colors.white)),
      );
    }
  }

  bool checkFirstTime() {
    if (isFirstTime) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xff8D0008);

    return Scaffold(
      backgroundColor: const Color(0xff18181B),
      appBar: AppBar(
        automaticallyImplyLeading: !checkFirstTime(),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          getActions(context),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.15),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Container(
                    width: 200,
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                AnimatedButton(
                  color: mainColor,
                  width: MediaQuery.of(context).size.width * 0.6,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const CreateGroupScreen(
                              isCreate: false,
                            )));
                  },
                  child: const Text(
                    'Rejoindre un groupe',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: AnimatedButton(
                      color: mainColor,
                      width: MediaQuery.of(context).size.width * 0.6,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CreateGroupScreen(
                                  isCreate: true,
                                )));
                      },
                      child: const Text(
                        'Créer un groupe',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
