import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gbesoin/providers/auth_firebase.dart';

class StorageHelper {
  var uid = AuthenticationHelper().getUid();
//Group
  CollectionReference groups = FirebaseFirestore.instance.collection('group');
  void saveGroup({name, password, idGroup}) {
    groups.add({"name": name, "password": password, "idGroup": idGroup});
  }

  Future<List> getGroupById(idGroup) async {
    var res = [];
    await groups
        .where("idGroup", isEqualTo: idGroup)
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }

  Future<List> getGroupByName(name) async {
    var res = [];
    await groups
        .where("name", isEqualTo: name.toString().toLowerCase())
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }

  Future<int> getNumberOfGroup() async {
    int res = 0;
    await groups
        .get()
        .then((querySnapshot) => {res = querySnapshot.docs.length});
    return res;
  }

//Elements
  CollectionReference elements =
      FirebaseFirestore.instance.collection('element');

  void saveElement({name, idGroup}) {
    elements.add({"name": name, "idGroup": idGroup});
  }

  Future<List> getElementbyName(name) async {
    var res = [];
    await elements
        .where("name".toLowerCase(), isEqualTo: name.toString().toLowerCase())
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }

  Future<List> getElementbyNameAndId(name, idGroup) async {
    var res = [];
    await elements
        .where("idGroup", isEqualTo: idGroup)
        .where("name".toLowerCase(), isEqualTo: name.toString().toLowerCase())
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }
}
