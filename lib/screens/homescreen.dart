import 'package:flutter/material.dart';
import 'package:gbesoin/models/listelement.dart';
import 'package:gbesoin/screens/choicescreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "VENUS",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3,
                fontStyle: FontStyle.italic,
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            actions: [
              IconButton(
                icon: const Icon(Icons.group),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ChoiceScreen()));
                },
              )
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Alert(
                context: context,
                title: "De quoi avez vous besoin",
                content: Column(
                  children: const <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.shopping_cart),
                        labelText: '',
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Ajouter",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color(0xff262129),
        body: Padding(
          padding:
              EdgeInsets.only(left: width * 0.1, right: width * 0.1, top: 20),
          child: Container(
            height: height * 0.75,
            width: width * 0.8,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.7),
                    blurRadius: 4,
                    offset: const Offset(4, 8), // Shadow position
                  ),
                ],
                color: Colors.white,
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(Radius.circular(40))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: height * 0.01,
                  left: width * 0.05,
                  right: width * 0.05,
                  bottom: height * 0.01),
              child: ListView(
                shrinkWrap: true,
                children: const [ListElement("Frites", 1)],
              ),
            ),
          ),
        ));
  }
}
