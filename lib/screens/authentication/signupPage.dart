import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Controllers/auth_controller.dart';
import 'package:demo_app/screens/authentication/loginOrSignupPage.dart';
import 'package:demo_app/screens/authentication/loginPage.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_overlay/loading_overlay.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id = 'signup_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _name;
  late String _password;
  late String _confirmPass;
  bool _saving = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  TextStyle hintStyle = TextStyle(
      color: Colors.grey[500], fontWeight: FontWeight.w400, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5),
                    child: const ScreenTitle(title: 'Sign Up'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5),
                    child: const Text(
                      'Please registrater with email and sign up to continue using our app.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    child: SvgPicture.asset(
                      'assets/signup.svg',
                      semanticsLabel: 'My SVG Image',
                    ),
                  ),
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.45,
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const ScreenTitle(title: 'Sign Up'),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.fullnameController,
                              // onChanged: (value) {
                              //   _name = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your name',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.edit_note_outlined,
                                  size: 24.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Name",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.signup_emailController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your email address',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.mail_outline_outlined,
                                  size: 22.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Email Address",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.signup_passwordController,
                              obscureText: passwordVisible,
                              // onChanged: (value) {
                              //   _password = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your password',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.key,
                                  size: 20.0,
                                  color: Colors.grey[600],
                                ),
                                suffix: GestureDetector(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(top: 3, right: 5),
                                    child: Icon(
                                        passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20.0,
                                        color: Colors.grey[600]),
                                  ),
                                  onTap: () {
                                    setState(
                                      () {
                                        passwordVisible = !passwordVisible;
                                        print(passwordVisible);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                            fieldName: 'Password',
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.aboutController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Write a bit about yourself',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.person,
                                  size: 23.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "About",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.categoryController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Select the category',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.category_outlined,
                                  size: 20.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Category",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.servicesController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText:
                                    'Write a bit about services you offer',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.pending_actions_rounded,
                                  size: 20.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Services",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.phoneNoController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your phone no.',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.phone,
                                  size: 20.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Phone No.",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.addressController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your clinic\'s addesss',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.location_on_outlined,
                                  size: 23.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Address",
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.timingController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter the timing of your clinic',
                                hintStyle: hintStyle,
                                icon: Icon(
                                  Icons.access_time,
                                  size: 23.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            fieldName: "Timing",
                          ),
                          SizedBox(
                            height: 15,
                          ),

                          CustomBottomScreen(
                            textButton: 'Sign Up',
                            heroTag: 'signup_btn',
                            question: 'Already Have an account? ',
                            buttonPressed: () async {
                              controller.signupUser(true, context);
                            },
                            questionPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) => LoginScreen())));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
