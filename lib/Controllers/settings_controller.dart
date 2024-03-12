import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    getData = getUserData();
    super.onInit();
  }

  var isLoading = false
      .obs; // when this variable is updaeted, it will automatically setState for the same
  var currentUser = FirebaseAuth.instance.currentUser;
  var docName = ''.obs;
  var docEmail = ''.obs;
  var docAbout = ''.obs;
  var docServices = ''.obs;
  var docTiming = ''.obs;
  var docAddress = ''.obs;
  var docCategory = ''.obs;
  var docPhone = ''.obs;
  Future? getData;

  getUserData() async {
    isLoading(true);
    DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
        .instance
        .collection('doctor')
        .doc(currentUser!.uid)
        .get();
    var docData = doc.data();
    docName.value = doc!['docName'] ?? "";
    docEmail.value = currentUser!.email ?? "";
    docAbout.value = doc!['docAbout'] ?? "";
    docServices.value = doc!['docServices'] ?? "";
    docAddress.value = doc!['docAddress'] ?? "";
    docTiming.value = doc!['docTiming'] ?? "";
    docPhone.value = doc!['docPhone'] ?? "";
    docCategory.value = doc!['docCategory'] ?? "";
    isLoading(false);
  }
}
