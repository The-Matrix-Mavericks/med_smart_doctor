import 'package:demo_app/screens/authentication/loginOrSignupPage.dart';
import 'package:demo_app/screens/home/home.dart';
import 'package:demo_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';


class AuthController extends GetxController {
  UserCredential? userCredential;
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // controllers for signup 
  var signup_emailController = TextEditingController();
  var signup_passwordController = TextEditingController();

  // doctor signup controllers
  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var phoneNoController = TextEditingController();
  var categoryController = TextEditingController();

// USE THIS IN ORIGINAL APP
  isUserAlreadyLoggedIn() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Get.offAll(() => Home());
      } else {
        Get.offAll(() => LoginOrSignupScreen());
      }
    });
  }

// to check is the logged in user has field named 'docName' to check that the user is doctor or not
  // isUserAlreadyLoggedIn() async {
  //   await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
  //     if (user != null) {
  //       var data = await FirebaseFirestore.instance
  //           .collection('doctor')
  //           .doc(user.uid)
  //           .get();
  //       var isDoc = data.data()?.containsKey('docName') ?? false;
  //       if (isDoc) {
  //         Get.offAll(() => AppointmentView());
  //       } else {
  //         Get.offAll(() => Home());
  //       }
  //     } else {
  //       Get.offAll(() => LoginView());
  //     }
  //   });
  // }

  loginUser(context) async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (userCredential != null) {
      VxToast.show(context, msg: "Login successful");
      Get.to(() => const Home());
    }
  }

  signupUser(bool isDoctor, context) async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signup_emailController.text, password: signup_passwordController.text);
    if (userCredential != null) {
      await storeUserdata(userCredential!.user!.uid, fullnameController.text,
          signup_emailController.text, isDoctor);
      if (userCredential != null) {
        Get.to(() => Home());
        VxToast.show(context, msg: "Signup successful");
      }
    }
  }

  storeUserdata(
      String uid, String fullname, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance
        .collection(isDoctor ? 'doctor' : 'user')
        .doc(uid);
    if (isDoctor) {
      await store.set({
        'docAbout': aboutController.text,
        'docAddress': addressController.text,
        'docCategory': categoryController.text,
        'docPhone': phoneNoController.text,
        'docServices': servicesController.text,
        'docTiming': timingController.text,
        'docName': fullname,
        'docID': FirebaseAuth.instance.currentUser?.uid,
        'docRating': 1,
        'docEmail': email,
      });
    } else {
      await store.set({
        'fullname': fullname,
        'email': email,
      });
    }
  }

  signout(context) async {
    await FirebaseAuth.instance.signOut();
    VxToast.show(context, msg: "Signed out");
    Get.offAll(() => LoginOrSignupScreen());
  }
}
