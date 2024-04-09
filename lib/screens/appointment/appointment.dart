import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/models/consultant.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:demo_app/widgets/banner_card.dart';
import 'package:demo_app/widgets/consultant_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<AppointmentScreen> {



  // Firebase Authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Other code remains the same...

  // Function to store appointment details in Firestore
  Future<void> _storeAppointmentDetails(String userId) async {
    try {
      // Get the current user's document ID
      String userDocId = userId;

      // Get other appointment details
      // For example: dropdownvalue, day, duration, patient

      // Example: Storing appointment details in Firestore

// Assuming _firestore is an instance of FirebaseFirestore
final QuerySnapshot querySnapshot = await _firestore
    .collection('timeSlots')
    .where('userId', isEqualTo: userDocId)
    .get();

if (querySnapshot.docs.isNotEmpty) {
  // If a document with the specified userId exists, update it
  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  await _firestore.collection('timeSlots').doc(documentSnapshot.id).update({
    'numberOfSlots': dropdownvalue,
    'dayOff': day,
    'duration': duration,
    'patientsPerSlot': patient,
    // Add more fields as needed
  });
} else {
  // If no document with the specified userId exists, add a new document
  await _firestore.collection('timeSlots').add({
    'userId': userDocId,
    'numberOfSlots': dropdownvalue,
    'dayOff': day,
    'duration': duration,
    'patientsPerSlot': patient,
    // Add more fields as needed
  });
}


      // Show a success message or perform any additional actions
      print('Appointment details stored successfully.');
    } catch (e) {
      // Handle errors
      print('Error storing appointment details: $e');
    }
  }



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
  var durations = ['1 hr', '45 mins', '2 hr'];

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
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Appointment Schedule',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SafeArea(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
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
                              value: dropdownvalue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: [
                                DropdownMenuItem(
                                  value: items[0],
                                  child: Text(items[0]),
                                ),
                                DropdownMenuItem(
                                  value: items[1],
                                  child: Text(items[1]),
                                ),
                                DropdownMenuItem(
                                  value: items[2],
                                  child: Text(items[2]),
                                ),
                              ],
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
                              value: duration,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: [
                                DropdownMenuItem(
                                  value: durations[0],
                                  child: Text(durations[0]),
                                ),
                                DropdownMenuItem(
                                  value: durations[1],
                                  child: Text(durations[1]),
                                ),
                                DropdownMenuItem(
                                  value: durations[2],
                                  child: Text(durations[2]),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  duration = newValue!;
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
                              value: day,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: [
                                DropdownMenuItem(
                                  value: days[0],
                                  child: Text(days[0]),
                                ),
                                DropdownMenuItem(
                                  value: days[1],
                                  child: Text(days[1]),
                                ),
                                DropdownMenuItem(
                                  value: days[2],
                                  child: Text(days[2]),
                                ),
                                DropdownMenuItem(
                                  value: days[3],
                                  child: Text(days[3]),
                                ),
                                DropdownMenuItem(
                                  value: days[4],
                                  child: Text(days[4]),
                                ),
                                DropdownMenuItem(
                                  value: days[5],
                                  child: Text(days[5]),
                                ),
                                DropdownMenuItem(
                                  value: days[6],
                                  child: Text(days[6]),
                                ),
                              ],
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
                              value: patient,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: [
                                DropdownMenuItem(
                                  value: patients[0],
                                  child: Text(patients[0]),
                                ),
                                DropdownMenuItem(
                                  value: patients[1],
                                  child: Text(patients[1]),
                                ),
                                DropdownMenuItem(
                                  value: patients[2],
                                  child: Text(patients[2]),
                                ),
                                DropdownMenuItem(
                                  value: patients[3],
                                  child: Text(patients[3]),
                                ),
                                DropdownMenuItem(
                                  value: patients[4],
                                  child: Text(patients[4]),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                setState(() {
                                  patient = newValue!;
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
                  ],
                ),
              );
            }),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            _storeAppointmentDetails(_auth.currentUser!.uid);
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                color: kTextColor,
              ),
              height: 60.0,
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Epilogue'),
                ),
              ),
            ),
          ),
        ));
  }
}
