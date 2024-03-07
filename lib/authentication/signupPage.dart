import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Components/constants.dart';
import 'package:demo_app/authentication/loginOrSignupPage.dart';
import 'package:demo_app/authentication/loginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, HomeScreen.id);
        return true;
      },
      child: Scaffold(
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
                    const TopScreenImage(screenImageName: 'signup.png'),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
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
                                onChanged: (value) {
                                  _name = value;
                                },
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                                decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Enter your name',
                                  icon: Icon(
                                    CupertinoIcons.mail,
                                    size: 20.0,
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
                                onChanged: (value) {
                                  _email = value;
                                },
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                                decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Enter your email address',
                                  icon: Icon(
                                    CupertinoIcons.mail,
                                    size: 20.0,
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
                                onChanged: (value) {
                                  _password = value;
                                },
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                                decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Enter your password',
                                  icon: Icon(
                                    LineIcons.key,
                                    size: 22.0,
                                    color: Colors.grey[600],
                                  ),
                                  suffix: GestureDetector(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 3, right: 5),
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

                            Spacer(),
                            CustomBottomScreen(
                              textButton: 'Sign Up',
                              heroTag: 'signup_btn',
                              question: 'Already Have an account? ',
                              buttonPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  _saving = true;
                                });
                                if (_confirmPass == _password) {
                                  try {
                                    await _auth.createUserWithEmailAndPassword(
                                        email: _email, password: _password);

                                    if (context.mounted) {
                                      signUpAlert(
                                        context: context,
                                        title: 'GOOD JOB',
                                        desc: 'Go login now',
                                        btnText: 'Login Now',
                                        onPressed: () {
                                          setState(() {
                                            _saving = false;
                                            Navigator.popAndPushNamed(
                                                context, SignUpScreen.id);
                                          });
                                          // Navigator.pushNamed(
                                          //     context, LoginScreen.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      LoginScreen())));
                                        },
                                      ).show();
                                    }
                                  } catch (e) {
                                    signUpAlert(
                                        context: context,
                                        onPressed: () {
                                          SystemNavigator.pop();
                                        },
                                        title: 'SOMETHING WRONG',
                                        desc: 'Close the app and try again',
                                        btnText: 'Close Now');
                                  }
                                } else {
                                  showAlert(
                                      context: context,
                                      title: 'WRONG PASSWORD',
                                      desc:
                                          'Make sure that you write the same password twice',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }).show();
                                }
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
      ),
    );
  }
}
