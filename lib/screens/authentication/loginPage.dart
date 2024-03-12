import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Controllers/auth_controller.dart';
import 'package:demo_app/screens/authentication/loginOrSignupPage.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loading_overlay/loading_overlay.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;
  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5),
                    child: const ScreenTitle(title: 'Login'),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 5, bottom: 15),
                    child: const Text(
                      'Please login to continue using our app.',
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
                      'assets/login.svg',
                      semanticsLabel: 'My SVG Image',
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // const ScreenTitle(title: 'Login'),
                          CustomTextFieldWithFieldName(
                            textField: TextField(
                              controller: controller.emailController,
                              // onChanged: (value) {
                              //   _email = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your email address',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
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
                              obscureText: passwordVisible,
                              controller: controller.passwordController,
                              // onChanged: (value) {
                              //   _password = value;
                              // },
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
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
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.26,
                                color: Colors.black26,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: const Text(
                                  'Sign up using',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width * 0.26,
                                color: Colors.black26,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  radius: 18,
                                  child: Image.asset(
                                      'assets/images/icons/google.png'),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  radius: 18,
                                  child: Image.asset(
                                      'assets/images/icons/facebook.png'),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: CircleAvatar(
                                  radius: 18,
                                  child: Image.asset(
                                      'assets/images/icons/twitter.webp'),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CustomBottomScreen(
                            textButton: 'Login',
                            heroTag: 'login_btn',
                            question: 'Forgot password?',
                            buttonPressed: () async {
                              controller.loginUser(context);
                              controller.emailController.clear();
                              controller.passwordController.clear();
                            },
                            questionPressed: () {
                              // signUpAlert(
                              //   onPressed: () async {
                              //     await FirebaseAuth.instance
                              //         .sendPasswordResetEmail(email: _email);
                              //   },
                              //   title: 'RESET YOUR PASSWORD',
                              //   desc:
                              //       'Click on the button to reset your password',
                              //   btnText: 'Reset Now',
                              //   context: context,
                              // ).show();
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
