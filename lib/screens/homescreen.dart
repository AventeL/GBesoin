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
  Color mainColor = const Color(0xff8D0008);

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
                    toolbarHeight: 130,
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
                    backgroundColor: mainColor,
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
                backgroundColor: mainColor,
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListElement(
                          text: data['name'],
                          idGroup: widget.idGroup,
                          reference: document.reference.id);
                    }).toList(),
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
