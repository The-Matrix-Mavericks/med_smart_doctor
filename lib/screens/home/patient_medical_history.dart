import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PatientMedicalHIstory extends StatefulWidget {
  final String patientID;
  const PatientMedicalHIstory({super.key, required this.patientID});

  @override
  State<PatientMedicalHIstory> createState() => _PatientMedicalHIstoryState();
}

class _PatientMedicalHIstoryState extends State<PatientMedicalHIstory> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Patient Mecial Records",
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 25,
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
      body: Wrap(
        children: [
          SingleChildScrollView(
            child: Container(
              height: 1000,
              child: FutureBuilder<List<DocumentSnapshot>>(
                future: _medicalRecordsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200,
                          ),
                          Image.asset(
                            'assets/images/no_data.jpg',
                            width: 250,
                          ),
                          Text(
                            'No medical records found',
                            style: TextStyle(fontFamily: 'Inter', fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final document = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 8,
                            color: Colors.grey[50],
                            margin: EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Clinical Issues: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['clinicalIssues']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Ongoing Medicine: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['ongoing_medicine']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Condition: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['condition']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Surgical History: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['surgical_history']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Prescriptions: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['prescription']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Allergies: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['allergies']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Smoking, Alcohol etc. ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text: '${document['allergies']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),

                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Updted on: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black)),
                                    TextSpan(
                                        text:
                                            '${document['timestamp'].toDate().toString().substring(0, 10)} at ${document['timestamp'].toDate().toString().substring(11, 16)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black)),
                                  ])),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
