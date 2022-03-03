import 'package:flutter/material.dart';
import 'package:gbesoin/screens/homescreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:animated_button/animated_button.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.2,
        ),
        color: Colors.black87,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: AnimatedButton(
                color: Colors.green,
                width: MediaQuery.of(context).size.width * 0.6,
                onPressed: () {
                  Alert(
                      context: context,
                      title: "Rejoindre un groupe",
                      content: Column(
                        children: const <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.group),
                              labelText: 'Nom du groupe',
                            ),
                          ),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock),
                              labelText: 'Mot de passe du groupe',
                            ),
                          ),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeScreen()));
                          },
                          child: const Text(
                            "Rejoindre",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ]).show();
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
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: AnimatedButton(
                  color: Colors.green,
                  width: MediaQuery.of(context).size.width * 0.6,
                  onPressed: () {
                    Alert(
                        context: context,
                        title: "Créer un groupe",
                        content: Column(
                          children: const <Widget>[
                            TextField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.group),
                                labelText: 'Nom du groupe',
                              ),
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Mot de passe du groupe',
                              ),
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Confirmer le mot de passe',
                              ),
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const HomeScreen()));
                            },
                            child: const Text(
                              "Créer",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ]).show();
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
    );
  }
}
