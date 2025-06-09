import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final CollectionReference tiketCollection =
      FirebaseFirestore.instance.collection('Tiket');

  Stream<QuerySnapshot> getTiket() {
    return tiketCollection.snapshots();
  }
}

