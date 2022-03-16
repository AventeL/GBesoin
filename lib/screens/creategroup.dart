import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:gbesoin/providers/local_storage.dart';
import 'package:gbesoin/providers/storage_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:gbesoin/screens/homescreen.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key? key, required this.isCreate}) : super(key: key);
  final bool isCreate;

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool isPasswordEquals = false;
  bool isGroupNameNull = false;
  bool isPasswordGood = false;
  bool isPasswordMatch = false;
  bool isValide = false;
  List groups = [];

  @override
  void dispose() {
    groupNameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  bool CheckIsPasswordEquals() {
    if (passwordConfirmController.text == passwordController.text &&
        passwordConfirmController.text != "" &&
        passwordController.text != "") {
      return true;
    } else {
      return false;
    }
  }

  bool checkIsPasswordIsGood() {
    if (passwordController.text.length >= 4) {
      return true;
    } else {
      return false;
    }
  }

  bool checkIsValide() {
    if (isPasswordEquals == false &&
        isPasswordGood == false &&
        isGroupNameNull == false) {
      return true;
    } else {
      return false;
    }
  }

  void getElementFromDataBase(String name) {
    StorageHelper()
        .getGroupByName(name.toLowerCase())
        .then((value) => setState(() {
              groups = value.toList();
            }));
  }

  bool canConnect(String name) {
    if (groups.isEmpty) {
      return false;
    } else if (groups[0]['name']
                .toString()
                .toLowerCase()
                .compareTo(groupNameController.text.toLowerCase()) ==
            0 &&
        Crypt(groups[0]['password']).match(passwordController.text)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = const Color(0xff8D0008);

    if (widget.isCreate) {
      return Scaffold(
          backgroundColor: const Color(0xff18181B),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: groupNameController,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.group),
                              labelText: 'Nom du groupe',
                              errorText: isGroupNameNull
                                  ? 'Le nom du groupe est vide'
                                  : null),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              labelText: 'Mot de passe du groupe',
                              errorText: isPasswordGood
                                  ? "Le mot de passe est trop court"
                                  : null),
                        ),
                        TextField(
                          controller: passwordConfirmController,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              labelText: 'Confirmer le mot de passe',
                              errorText: isPasswordEquals
                                  ? "Les mots de passe ne correspondent pas"
                                  : null),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AnimatedButton(
                            onPressed: () async {
                              setState(() {
                                groupNameController.text.isNotEmpty
                                    ? isGroupNameNull = false
                                    : isGroupNameNull = true;
                                checkIsPasswordIsGood()
                                    ? isPasswordGood = false
                                    : isPasswordGood = true;
                                CheckIsPasswordEquals()
                                    ? isPasswordEquals = false
                                    : isPasswordEquals = true;
                              });
                              if (checkIsValide()) {
                                int newId =
                                    await StorageHelper().getNumberOfGroup() +
                                        1;
                                LocalStorage().storeIdGroup(newId);
                                StorageHelper().saveGroup(
                                    idGroup: newId,
                                    name: groupNameController.text,
                                    password:
                                        Crypt.sha256(passwordController.text)
                                            .toString());
                                await Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreen(idGroup: newId)));
                              }
                            },
                            child: const Text(
                              "Créer",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            color: mainColor,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ));
    } else {
      return Scaffold(
          backgroundColor: const Color(0xff18181B),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.1),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20))),
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: groupNameController,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.group),
                            labelText: 'Nom du groupe',
                            errorText: isGroupNameNull
                                ? 'Le nom du groupe est vide'
                                : null,
                          ),
                        ),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              icon: const Icon(Icons.lock),
                              labelText: 'Mot de passe du groupe',
                              errorText: isPasswordMatch
                                  ? "Aucun groupe ne correspond à ces identifiants"
                                  : null),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AnimatedButton(
                            onPressed: () async {
                              setState(() {
                                groupNameController.text.isNotEmpty
                                    ? isGroupNameNull = false
                                    : isGroupNameNull = true;
                                canConnect(groupNameController.text)
                                    ? isPasswordMatch = false
                                    : isPasswordMatch = true;
                              });
                              getElementFromDataBase(groupNameController.text);
                              if (canConnect(groupNameController.text)) {
                                LocalStorage()
                                    .storeIdGroup(groups[0]['idGroup']);
                                await Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => HomeScreen(
                                              idGroup: groups[0]['idGroup'],
                                            )));
                              }
                            },
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            color: mainColor,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ));
    }
  }
}
