import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/screens/home/patient_details_screen.dart';
import 'package:demo_app/screens/home/reschedule_screen.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:demo_app/widgets/primary_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "dart:math";

import 'package:velocity_x/velocity_x.dart';

String getRandomElement<String>() {
  List list = ['1.jpg', '2.jpg', '3.jpg', '4.jpeg'];
  final random = new Random();
  var i = random.nextInt(list.length);
  return list[i];
}

class PatientCardBuilder extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String patientID;
  final String phone;
  final String profession;
  String? imageUrl;
  final String date;
  final String appID;
  final String time;

  PatientCardBuilder({
    required this.name,
    required this.gender,
    required this.age,
    required this.phone,
    required this.appID,
    required this.profession,
    this.imageUrl,
    required this.date,
    required this.time,
    super.key,
    required this.patientID,
  });

  @override
  Widget build(BuildContext context) {
    imageUrl = getRandomElement();
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 325.0,
        height: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Color.fromARGB(255, 219, 221, 255),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 14.0,
              ),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 22,
                              backgroundColor: AppColors.primaryColor,
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    AssetImage('assets/images/$imageUrl'),
                                // child: Icon(
                                //   Icons.person,
                                //   color: Colors.white,
                                //   size: 18,
                                // ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: CustomStyle.defaultTextStyle.copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${profession.toUpperCase()}  $age years    ${gender.toUpperCase()}",
                                  style:
                                      CustomStyle.descriptionTextStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => PatientDetailScreen(
                                      patientID: patientID,
                                    ));
                              },
                              child: Text(
                                "View details",
                                style: CustomStyle.defaultTextStyle.copyWith(
                                  fontSize: 12,
                                  color: kTextColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                          child: Divider(),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.calendar_month_outlined,
                                    size: 12,
                                    color: AppColors.darkGrayColor,
                                  ),
                                  Text(
                                    date,
                                    style: CustomStyle.descriptionTextStyle
                                        .copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.timer_outlined,
                                    size: 12,
                                    color: AppColors.darkGrayColor,
                                  ),
                                  Text(
                                    time,
                                    style: CustomStyle.descriptionTextStyle
                                        .copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Wrap(
                                spacing: 8,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.phone,
                                    size: 12,
                                    color: AppColors.darkGrayColor,
                                  ),
                                  Text(
                                    phone,
                                    style: CustomStyle.descriptionTextStyle
                                        .copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            PrimaryButton(
                              title: 'Reschedule',
                              onTap: () {
                                Get.to(() => RescheduleAppointmentScreen(
                                      // patientID: patientID,
                                      appID: appID,
                                    ));
                              },
                            ),
                            const SizedBox(
                              width: 36,
                            ),
                            const PrimaryWhiteButton(title: 'Chat'),
                            // TextButton(
                            //   onPressed: () {},
                            //   style: TextButton.styleFrom(
                            //     padding: EdgeInsets.zero,
                            //     side: BorderSide(color: Vx.white),
                            //     minimumSize: const Size(50, 30),
                            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            //     alignment: Alignment.centerLeft,
                            //   ),
                            //   child: Text(
                            //     'Chat',
                            //     style: CustomStyle.defaultTextStyle.copyWith(
                            //       fontSize: 14,
                            //       fontWeight: FontWeight.bold,
                            //       color: AppColors.primaryColor,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
