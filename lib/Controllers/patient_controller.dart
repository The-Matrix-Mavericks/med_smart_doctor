import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PatientDetailsController extends GetxController {
  final String patientID;
  PatientDetailsController({required this.patientID});
  @override
  void onInit() {
    getData = (getUserData());
    super.onInit();
  }

  var isLoading = true
      .obs; // when this variable is updaeted, it will automatically setState for the same
  var currentUser = FirebaseAuth.instance.currentUser;
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userAbout = ''.obs;
  var userAddress = ''.obs;
  var userPhone = ''.obs;
  var userAge = ''.obs;
  var userGender = ''.obs;
  var userHeight = ''.obs;
  var userWeight = ''.obs;
  var userProfession = ''.obs;
  Future? getData;

  Future<void> getUserData() async {
    // print("Is Loading Status ---> ${isLoading}");
    // isLoading(true);
    // print("Is Loading Status ---> ${isLoading}");
    try {
      DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
          .instance
          .collection('user')
          .doc(patientID)
          .get();
      // var docData = user.data();

      // print("DocData is Printing ----> ${docData}");

      print("Doctor Name Value : -->  Dikh Ja Bhai Ab to ${userName.value}");
      userName.value = user!['userName'] ?? "";
      userEmail.value = currentUser!.email ?? "";
      userAbout.value = user!['userAbout'] ?? "";
      userAddress.value = user!['userAddress'] ?? "";
      userProfession.value = user!['userProfession'] ?? "";
      userHeight.value = user!['userHeight'] ?? "";
      userWeight.value = user!['userWeight'] ?? "";
      userAge.value = user!['userAge'] ?? "";
      userGender.value = user!['userGender'] ?? "";
      userPhone.value = user!['userPhone'] ?? "";
      isLoading(false);

      print("Is Loading Status ---> ${isLoading}");
    } catch (e) {
      print("Error fetching data $e");
      isLoading(false);
    }
  }
}
