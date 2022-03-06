import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:gbesoin/providers/storage_firestore.dart';
import 'package:crypt/crypt.dart';

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
  bool isValide = false;
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

  void loginToGroup(int i) {
    print(StorageHelper().getGroupById(i));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isCreate) {
      return Scaffold(
          backgroundColor: const Color(0xff262129),
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
                            onPressed: () {
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
                                StorageHelper().saveGroup(
                                    idGroup: 1,
                                    name: groupNameController.text,
                                    password:
                                        Crypt.sha256(passwordController.text)
                                            .toString());
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
                            color: Colors.green,
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ));
    } else {
      return Scaffold(
          backgroundColor: const Color(0xff262129),
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
                          decoration: const InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Mot de passe du groupe',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: AnimatedButton(
                            onPressed: () {
                              loginToGroup(1);
                              setState(() {
                                groupNameController.text.isNotEmpty
                                    ? isGroupNameNull = false
                                    : isGroupNameNull = true;
                              });
                            },
                            child: const Text(
                              "Se connecter",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            color: Colors.green,
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
