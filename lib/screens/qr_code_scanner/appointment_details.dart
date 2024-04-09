import 'package:demo_app/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../Components/doc_info_box.dart';

class AppointmentDetails extends StatefulWidget {
  AppointmentDetails({
    super.key,
    required this.patientName,
    required this.phoneNo,
    required this.date,
    required this.time,
  });
  String patientName;
  String date;
  String time;
  String phoneNo;
  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Appointmet Details",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Card(
            color: Colors.amber[50],
            elevation: 8,
            child: Container(
              height: 400,
              child: Column(
                children: [
                  DocInfoBox(
                      infoLabel: 'Patient Name', infoText: widget.patientName),
                  DocInfoBox(
                      infoLabel: 'Patient Phone No.', infoText: widget.phoneNo),
                  DocInfoBox(
                      infoLabel: 'Appointment Date', infoText: widget.date),
                  DocInfoBox(
                      infoLabel: 'Appointment Time', infoText: widget.time),
                  DocInfoBox(infoLabel: 'Appointment Fees', infoText: '₹ 500'),
                  DocInfoBox(infoLabel: 'Payment Mode', infoText: 'Prepaid'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
