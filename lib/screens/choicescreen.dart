import 'package:flutter/material.dart';
import 'package:gbesoin/screens/creategroup.dart';
import 'package:animated_button/animated_button.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff262129),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.15),
            color: const Color(0xff262129),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Container(
                    width: 200,
                    height: 100,
                    color: Colors.green,
                  ),
                ),
                AnimatedButton(
                  color: Colors.green,
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
                      color: Colors.green,
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
