// Step 5: Make a firestore service
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference persons = FirebaseFirestore.instance.collection(
    'persons',
  );

  //create
  Future<void> addPerson(String personName, String personEmail, int personAge) {
    return persons.add({
      'name': personName,
      'email': personEmail,
      'age': personAge,
    });
  }

  //read
  Stream<QuerySnapshot> getPersons() {
    return persons.orderBy('timestamp', descending: true).snapshots();
  }

  //get by id
  Future<Map<String, dynamic>> getPersonById(String personId) async {
    final doc = await persons.doc(personId).get();
    return (doc.data() as Map<String, dynamic>?) ?? {};
  }

  //update
  Future<void> updatePerson(
    String personId,
    String personName,
    String personEmail,
    int personAge,
  ) {
    return persons.doc(personId).update({
      'name': personName,
      'email': personEmail,
      'age': personAge,
    });
  }

  //delete
  Future<void> deletePerson(String personId) {
    return persons.doc(personId).delete();
  }
}
