import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gbesoin/models/listelement.dart';
import 'package:gbesoin/providers/storage_firestore.dart';
import 'package:gbesoin/screens/choicescreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.idGroup}) : super(key: key);
  final int idGroup;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isValide = false;
  TextEditingController nameElementController = TextEditingController();
  int idElement = 0;
  String name = "";

  void getTextFieldValue() {
    if (nameElementController.text.isNotEmpty) {
      StorageHelper().saveElement(
          name: nameElementController.text, idGroup: widget.idGroup);
      nameElementController.clear();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var list = FirebaseFirestore.instance
        .collection('element')
        .where('idGroup', isEqualTo: widget.idGroup)
        .snapshots();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    StorageHelper().getGroupById(widget.idGroup).then(
      (value) {
        setState(() {
          name = value.toList()[0]['name'];
        });
      },
    );
    return StreamBuilder(
        stream: list,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                    leading: null,
                    automaticallyImplyLeading: false,
                    title: Text(
                      name.toUpperCase(),
                      style: const TextStyle(
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
                              builder: (context) => const ChoiceScreen(
                                    isFirstTime: false,
                                  )));
                        },
                      )
                    ]),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Alert(
                        context: context,
                        title: "De quoi avez vous besoin",
                        content: Column(
                          children: <Widget>[
                            TextField(
                              autofocus: true,
                              onSubmitted: (value) {
                                getTextFieldValue();
                              },
                              controller: nameElementController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.shopping_cart),
                                  labelText: '',
                                  errorText: isValide
                                      ? "Il n'y a pas d'élement"
                                      : null),
                            ),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            onPressed: () {
                              getTextFieldValue();
                            },
                            child: const Text(
                              "Ajouter",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          )
                        ]).show();
                  },
                  child: const Icon(Icons.add),
                ),
                backgroundColor: const Color(0xff262129),
                body: Padding(
                  padding: EdgeInsets.only(
                      left: width * 0.1, right: width * 0.1, top: 20),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(40))),
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.01,
                          left: width * 0.05,
                          right: width * 0.05,
                          bottom: height * 0.01),
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ListElement(
                              text: data['name'],
                              idGroup: widget.idGroup,
                              reference: document.reference.id);
                        }).toList(),
                      ),
                    ),
                  ),
                ));
          } else if (snapshot.hasError) {
            return const Center(child: Text("Une erreur est survenue"));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
