import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gbesoin/providers/auth_firebase.dart';

class StorageHelper {
  var uid = AuthenticationHelper().getUid();
//Group
  CollectionReference groups = FirebaseFirestore.instance.collection('group');
  void saveGroup({name, password, idGroup}) {
    groups.add({"name": name, "password": password, "idGroup": idGroup});
  }

  Future<List> getGroup(idGroup) async {
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

//Elements
  CollectionReference elements =
      FirebaseFirestore.instance.collection('element');
  void saveElement({name, idElement, idGroup}) {
    elements.add({"name": name, "idElement": idElement, "idGroup": idGroup});
  }

  Future<List> getElement(idElement) async {
    var res = [];
    await elements
        .where("idElement", isEqualTo: idElement)
        .get()
        .then((querySnapshot) => {
              for (var document in querySnapshot.docs)
                {res.add(document.data())}
            });
    return res;
  }
}
