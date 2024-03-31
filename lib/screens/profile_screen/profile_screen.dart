import 'dart:io';

import 'package:demo_app/Components/doc_info_box.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/screens/profile_screen/EditDoctorProfilePage.dart';
import 'package:demo_app/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicons/unicons.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());

    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 200, // Specify a width
                  height: 200, // Specify a height
                  child: CircleAvatar(
                    backgroundImage: controller.docImage.value.isNotEmpty
                        ? NetworkImage(controller.docImage.value)
                        : const NetworkImage(
                            'https://media.tenor.com/images/bc47a4ab3c7d0c749870b3f3a1e4a95e/tenor.gif'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 05.0, top: 10),
                      child: Align(
                        child: const Text('My Profile',
                            style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: kTextColor)),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditDoctorProfilePage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 05.0, top: 10),
                        child: Icon(FontAwesomeIcons.edit,
                            size: 25, color: Colors.black54),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 05.0, top: 10),
                    //   child: Icon(FontAwesomeIcons.edit,
                    //       size: 25, color: Colors.black54)
                    //      .onTap(() {
                    //       Navigator
                    //      }),
                    // ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 05.0, top: 5),
                  child: Text(
                    'Keep your profile updated for more daily appointments',
                    textAlign: TextAlign.left,
                    style: CustomStyle.descriptionTextStyle.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Column(
                  children: [
                    DocInfoBox(
                        infoLabel: "Name",
                        infoText: controller.docName.value ?? 'No name'),
                    DocInfoBox(
                        infoLabel: "Email",
                        infoText: controller.docEmail.value),
                    DocInfoBox(
                        infoLabel: "Phone",
                        infoText: controller.docPhone.value),
                    DocInfoBox(
                        infoLabel: "Address",
                        infoText: controller.docAddress.value),
                    DocInfoBox(
                        infoLabel: "About",
                        infoText: controller.docAbout.value),
                    DocInfoBox(
                        infoLabel: "Services",
                        infoText: controller.docServices.value),
                    DocInfoBox(
                        infoLabel: "Category",
                        infoText: controller.docCategory.value),
                    DocInfoBox(
                        infoLabel: "Timing",
                        infoText: controller.docTiming.value),
                  ],
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
