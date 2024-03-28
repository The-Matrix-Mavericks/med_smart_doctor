import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/appointment_controller.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/models/consultant.dart';
import 'package:demo_app/models/patient_card_builder.dart';
import 'package:demo_app/screens/home/appointment_details.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:demo_app/widgets/banner_card.dart';
import 'package:demo_app/widgets/consultant_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // var currentUser = FirebaseAuth.instance.currentUser;
  // var docData;
  // String docName = " ";
  // getDocData() async {
  //   DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
  //       .instance
  //       .collection('doctor')
  //       .doc(currentUser!.uid)
  //       .get();
  //   docData = doc.data();
  //   setState(() {
  //     docName = docData!['docName'];
  //   });
  //   print(docName);
  // }

  // @override
  // void initState() {
  //   getDocData();
  //   super.initState();
  // }

  String selectedValue = 'All Sessions';

  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    var appointment_controller = Get.put(AppointmentController());
    var appointment_list = appointment_controller.getAppointments();
    return SafeArea(
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Good Afternoon,\n',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: controller.docName.value, // Doctor name here
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
            BannerCard(
              backgroundColor: AppColors.secondaryColor,
              accentColor: AppColors.primaryColor.withOpacity(0.2),
              title: 'Upcomming Session',
              subtitle: 'Sahana V, Msc in Clinical Psychology',
              time: '7:30 PM - 8:30 PM',
              buttonIcon: Icons.play_circle,
              buttonText: 'Join Now',
              textColor: AppColors.primaryColor,
              mainTextColor: const Color(0xFF573926),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    _showDropdown(context);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      children: [
                        Text(
                          selectedValue,
                          style: CustomStyle.defaultTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.sort),
                  onSelected: choiceAction,
                  itemBuilder: (BuildContext context) {
                    return Constants.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
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

            FutureBuilder(
              future: appointment_controller.getAppointments(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.length == 0) {
                  return Container(
                    child: Column(
                      children: [
                        Image.asset('assets/waiting.jpg',
                            height: MediaQuery.of(context).size.height * 0.25),
                        Text(
                          "No appointments",
                          style: CustomStyle.defaultTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var app_list = data[index];
                      print(app_list);
                      // String formattedDate = DateFormat("d MMMM ''yy")
                      //     .format(app_list['appointmentDate']);
                      // String formattedStartTime = DateFormat("h:mm a")
                      //     .format(app_list['appointmentTime']);
                      // String formattedEndTime = DateFormat("h:mm a")
                      //     .format(list.datetime.add(const Duration(hours: 1)));
                      // String formattedDateTimeRange =
                      //     '$formattedStartTime - $formattedEndTime';

                      var appId = snapshot.data!.docs[index].reference.id;
                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child: PatientCardBuilder(
                          name: app_list['appointmentName'],
                          date: app_list['appointmentDay'],
                          time: app_list['appointmentTime'],
                          gender: 'maleee',
                          phone: app_list['appointmentMobileNo'],
                          age: '78',
                          appID: appId,
                          profession: 'studd',
                          patientID: app_list['appointmentBy'],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDropdown(BuildContext context) {
    final List<String> options = [
      'Session 1',
      'Session 2',
      'Session 3',
      'Session 4',
      'All Sessions',
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 260,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'Filter By Session',
                      style: CustomStyle.defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        setState(() {
                          selectedValue =
                              options[index]; // Perbarui teks yang dipilih
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Constants {
  static const String firstItem = 'Latest';
  static const String secondItem = 'Oldest';

  static const List<String> choices = <String>[
    firstItem,
    secondItem,
  ];
}

void choiceAction(String choice) {
  if (choice == Constants.firstItem) {
    print('Latest clicked');
  } else if (choice == Constants.secondItem) {
    print('Oldest clicked');
  }
}
