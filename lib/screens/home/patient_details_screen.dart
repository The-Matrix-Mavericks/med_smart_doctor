import 'dart:io';

import 'package:demo_app/Components/doc_info_box.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/patient_controller.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/widgets/user_image_picker.dart';
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
  @override
  Widget build(BuildContext context) {
    var controller =
        Get.put(PatientDetailsController(patientID: widget.patientID));

    return SafeArea(
      child: Scaffold(
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
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
