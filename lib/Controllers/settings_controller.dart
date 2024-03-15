import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  @override
  void onInit() {
    getData = (getUserData());
    super.onInit();
  }

  var isLoading = true
      .obs; // when this variable is updaeted, it will automatically setState for the same
  var currentUser = FirebaseAuth.instance.currentUser;
  var docImage = ''.obs;
  var docName = ''.obs;
  var docEmail = ''.obs;
  var docAbout = ''.obs;
  var docServices = ''.obs;
  var docTiming = ''.obs;
  var docAddress = ''.obs;
  var docCategory = ''.obs;
  var docPhone = ''.obs;
  Future? getData;

  Future<void> getUserData() async {
    // print("Is Loading Status ---> ${isLoading}");
    // isLoading(true);
    // print("Is Loading Status ---> ${isLoading}");
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('doctor')
          .doc(currentUser!.uid)
          .get();
      // var docData = doc.data();

      // print("DocData is Printing ----> ${docData}");
      docImage.value = doc!['docImage'];
      docName.value = doc!['docName'] ?? "";
      print("Doctor Name Value : -->  Dikh Ja Bhai Ab to ${docName.value}");
      docEmail.value = currentUser!.email ?? "";
      docAbout.value = doc!['docAbout'] ?? "";
      docServices.value = doc!['docServices'] ?? "";
      docAddress.value = doc!['docAddress'] ?? "";
      docTiming.value = doc!['docTiming'] ?? "";
      docPhone.value = doc!['docPhone'] ?? "";
      docCategory.value = doc!['docCategory'] ?? "";
      isLoading(false);

      print("Is Loading Status ---> ${isLoading}");
    } catch (e) {
      print("Error fetching data $e");
      isLoading(false);
    }
  }
}
