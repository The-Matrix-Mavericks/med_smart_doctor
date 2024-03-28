// import 'package:demo_app/constants/appstyles.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:velocity_x/velocity_x.dart';

// class AppointmentDetailsView extends StatelessWidget {
//   final DocumentSnapshot doc;
//   const AppointmentDetailsView({super.key, required this.doc});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: AppStyles.normal(title: doc['appointmentWithName'], size: AppSizes.size18),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(10),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppStyles.normal(
//                   title: "Select Appointment Day", size: AppSizes.size22),
//               5.heightBox,
//               AppStyles.normal(title: doc['appointmentDay']),
//               10.heightBox,
//               AppStyles.normal(
//                   title: "Select Appointment Time", size: AppSizes.size22),
//               5.heightBox,
//               AppStyles.normal(title: doc['appointmentTime']),
//               10.heightBox,
//               AppStyles.normal(title: "Mobile Number", size: AppSizes.size22),
//               5.heightBox,
//               AppStyles.normal(title: doc['appointmentMobileNo']),
//               10.heightBox,
//               AppStyles.normal(title: "Name", size: AppSizes.size22),
//               5.heightBox,
//               AppStyles.normal(title: doc['appointmentName']),
//               10.heightBox,
//               AppStyles.normal(title: "Message", size: AppSizes.size22),
//               5.heightBox,
//               AppStyles.normal(title: doc['appointmentMessage']),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
