// ignore_for_file: avoid_print

import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/models/consultant.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:demo_app/widgets/banner_card.dart';
import 'package:demo_app/widgets/consultant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<AppointmentScreen> {
  String dropdownvalue = '6';
  var items = [
    '6',
    '7',
    '8',
  ];

  String day = 'Sunday';
  var days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  String duration = '1 hr';
  var durations = [
    '1 hr',
    '45 mins',
    '1.5 hr',
  ];

  String patient = '5';
  var patients = [
    '4',
    '5',
    '6',
    '8',
    '10',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 05.0, top: 10),
              child: Align(
                child: const Text('Appointment Schedule',
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: kTextColor)),
                alignment: Alignment.centerLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 05.0, top: 5),
              child: Text(
                'Set your weekly appointment schedule for online bookings',
                textAlign: TextAlign.left,
                style: CustomStyle.descriptionTextStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image.asset(
                'assets/appointment.png',
                // semanticsLabel: 'My SVG Image',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "How many slots do\nwant on each day?",
                    style: CustomStyle.descriptionTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            15.heightBox,
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "What should be the\nduration of each slot?",
                    style: CustomStyle.descriptionTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child: DropdownButton(
                      // Initial Value
                      value: duration,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: durations.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          day = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            15.heightBox,
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "On what day, do take\noff from work?",
                    style: CustomStyle.descriptionTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 108,
                    child: DropdownButton(
                      // Initial Value
                      value: day,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: days.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          day = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            15.heightBox,
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No. of patients per slot",
                    style: CustomStyle.descriptionTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: DropdownButton(
                      // Initial Value
                      value: patient,

                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),

                      // Array list of items
                      items: patients.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      // After selecting the desired option,it will
                      // change button value to selected value
                      onChanged: (String? newValue) {
                        setState(() {
                          day = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // ListView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
            //   physics: const BouncingScrollPhysics(),
            //   itemCount: consultantList.length,
            //   itemBuilder: (context, index) {
            //     Consultant list = consultantList[index];
            //     String formattedDate =
            //         DateFormat("d MMMM ''yy").format(list.datetime);
            //     String formattedStartTime =
            //         DateFormat("h:mm a").format(list.datetime);
            //     String formattedEndTime = DateFormat("h:mm a")
            //         .format(list.datetime.add(const Duration(hours: 1)));
            //     String formattedDateTimeRange =
            //         '$formattedStartTime - $formattedEndTime';

            //     return Container(
            //       margin: const EdgeInsets.only(
            //         bottom: 12,
            //       ),
            //       child: ConsultantItem(
            //         name: list.name,
            //         degree: list.degree,
            //         imageUrl: list.imageUrl,
            //         date: formattedDate,
            //         time: formattedDateTimeRange,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      );
    });
  }
}
