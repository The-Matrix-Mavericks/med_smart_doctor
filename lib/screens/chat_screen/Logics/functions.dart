import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Functions {
  static void updateAvailability() {
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final data = {
      // 'docName': _auth.currentUser!.displayName ?? _auth.currentUser!.email,
      'date_time': DateTime.now(),
      // 'docEmail': _auth.currentUser!.email,
    };
    try {
      _firestore.collection('doctor').doc(_auth.currentUser!.uid).update(data);
    } catch (e) {
      print(e);
    }
  }
}
