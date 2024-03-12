import 'package:demo_app/Components/doc_info_box.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
                Padding(
                  padding: const EdgeInsets.only(left: 05.0, top: 10),
                  child: Container(
                          child: Icon(FontAwesomeIcons.edit,
                              size: 25, color: Colors.black54))
                      .onTap(() {}),
                ),
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
                    infoLabel: "Name", infoText: controller.docName.value),
                DocInfoBox(
                    infoLabel: "Email", infoText: controller.docEmail.value),
                DocInfoBox(
                    infoLabel: "Phone", infoText: controller.docPhone.value),
                DocInfoBox(
                    infoLabel: "Address",
                    infoText: controller.docAddress.value),
                DocInfoBox(
                    infoLabel: "About", infoText: controller.docAbout.value),
                DocInfoBox(
                    infoLabel: "Services",
                    infoText: controller.docServices.value),
                DocInfoBox(
                    infoLabel: "Category",
                    infoText: controller.docCategory.value),
                DocInfoBox(
                    infoLabel: "Timing", infoText: controller.docTiming.value),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
