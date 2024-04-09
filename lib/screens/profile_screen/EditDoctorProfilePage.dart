import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditDoctorProfilePage extends StatefulWidget {
  EditDoctorProfilePage({Key? key}) : super(key: key);

  @override
  _EditDoctorProfilePageState createState() => _EditDoctorProfilePageState();
}

class _EditDoctorProfilePageState extends State<EditDoctorProfilePage> {
  late TextEditingController _aboutController;
  late TextEditingController _addressController;
  late TextEditingController _categoryController;
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _ratingController;
  late TextEditingController _servicesController;
  late TextEditingController _timingController;
  late TextEditingController _feesController;

  @override
  void initState() {
    super.initState();
    _aboutController = TextEditingController();
    _addressController = TextEditingController();
    _categoryController = TextEditingController();
    _emailController = TextEditingController();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _ratingController = TextEditingController();
    _servicesController = TextEditingController();
    _timingController = TextEditingController();
    _feesController=TextEditingController();
    getDoctorData();
  }

  @override
  void dispose() {
    _aboutController.dispose();
    _addressController.dispose();
    _categoryController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _ratingController.dispose();
    _servicesController.dispose();
    _timingController.dispose();
    _feesController.dispose();
    super.dispose();
  }

  Future<void> getDoctorData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot doctorDoc = await FirebaseFirestore.instance
            .collection('doctor')
            .doc(user.uid)
            .get();
        setState(() {
          _aboutController.text = doctorDoc['docAbout'];
          _addressController.text = doctorDoc['docAddress'];
          _categoryController.text = doctorDoc['docCategory'];
          _emailController.text = doctorDoc['docEmail'];
          _nameController.text = doctorDoc['docName'];
          _phoneController.text = doctorDoc['docPhone'];
          _ratingController.text = doctorDoc['docRating'].toString();
          _servicesController.text = doctorDoc['docServices'];
          _timingController.text = doctorDoc['docTiming'];
          _feesController.text=doctorDoc['docFees'];
        });
      }
    } catch (e) {
      print('Error fetching doctor data: $e');
    }
  }

  Future<void> updateDoctorProfile() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance.collection('doctor').doc(user.uid).update({
          'docAbout': _aboutController.text,
          'docAddress': _addressController.text,
          'docCategory': _categoryController.text,
          'docEmail': _emailController.text,
          'docName': _nameController.text,
          'docPhone': _phoneController.text,
          'docRating': int.parse(_ratingController.text),
          'docServices': _servicesController.text,
          'docTiming': _timingController.text,
          'docFees':_feesController.text,
        });
        setState(() {
          
        });
        // Show success message or navigate to another page
      }
    } catch (e) {
      print('Error updating doctor profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Doctor Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(
              controller: _aboutController,
              decoration: InputDecoration(labelText: 'About'),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _ratingController,
              decoration: InputDecoration(labelText: 'Rating'),
            ),
            TextField(
              controller: _servicesController,
              decoration: InputDecoration(labelText: 'Services'),
            ),
            TextField(
              controller: _timingController,
              decoration: InputDecoration(labelText: 'Timing'),
            ),
            TextField(
              controller: _feesController,
              decoration: InputDecoration(labelText: 'Appointment Fees'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                updateDoctorProfile();                
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
