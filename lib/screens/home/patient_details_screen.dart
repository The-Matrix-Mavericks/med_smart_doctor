import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Components/doc_info_box.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/patient_controller.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/screens/home/home.dart';
import 'package:demo_app/screens/home/patient_medical_history.dart';
import 'package:demo_app/widgets/user_image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicons/unicons.dart';
import 'package:velocity_x/velocity_x.dart';

class PatientDetailScreen extends StatefulWidget {
  final String patientID;
  const PatientDetailScreen({super.key, required this.patientID});

  @override
  State<PatientDetailScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<PatientDetailScreen> {
  late Future<List<DocumentSnapshot>> _medicalRecordsFuture;

  @override
  void initState() {
    super.initState();
    _medicalRecordsFuture = _fetchUserMedicalRecords();
  }

  Future<List<DocumentSnapshot>> _fetchUserMedicalRecords() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('medical_records')
          .where('userId', isEqualTo: widget.patientID)
          .get();
      return querySnapshot.docs;
    } else {
      throw Exception('User is not authenticated.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(PatientDetailsController(patientID: widget.patientID));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient Profile",
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: kTextColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 05.0, top: 0),
                    child: Text(
                      'Taking a look at your patient\'s profile helps you diagnose better.',
                      textAlign: TextAlign.center,
                      style: CustomStyle.descriptionTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700]),
                    ),
                  ),
                  Column(
                    children: [
                      DocInfoBox(
                          infoLabel: "Name",
                          infoText: controller.userName.value),
                      DocInfoBox(
                          infoLabel: "Email",
                          infoText: controller.userEmail.value),
                      DocInfoBox(
                          infoLabel: "Phone",
                          infoText: controller.userPhone.value),
                      DocInfoBox(
                          infoLabel: "Address",
                          infoText: controller.userAddress.value),
                      DocInfoBox(
                          infoLabel: "About",
                          infoText: controller.userAbout.value),
                      DocInfoBox(
                          infoLabel: "Age",
                          infoText: controller.userAge.value),
                      DocInfoBox(
                          infoLabel: "Height",
                          infoText: controller.userHeight.value),
                      DocInfoBox(
                          infoLabel: "Weight",
                          infoText: controller.userWeight.value),
                      DocInfoBox(
                          infoLabel: "Gender",
                          infoText: controller.userGender.value),
                      DocInfoBox(
                          infoLabel: "Profession",
                          infoText: controller.userProfession.value),
                      Container(
                        height: 50,
                        child: FutureBuilder<List<DocumentSnapshot>>(
                          future: _medicalRecordsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else if (snapshot.data!.isEmpty) {
                              return Container();
                            } else {
                              return TextButton(
                                onPressed: () => Get.to(() =>
                                    PatientMedicalHIstory(
                                        patientID: widget.patientID)),
                                child: Text(
                                  'View Medical Records',
                                  style: TextStyle(
                                      fontFamily: 'Inter', fontSize: 16),
                                ),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
