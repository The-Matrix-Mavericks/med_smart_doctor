import 'package:demo_app/Components/components.dart';
import 'package:demo_app/Components/constants.dart';
import 'package:demo_app/authentication/loginOrSignupPage.dart';
import 'package:demo_app/screens/mainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, MainScreen.id);
        return false;
      },
      child: Scaffold(
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
                    const TopScreenImage(screenImageName: 'login1.png'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
                                  color: Colors.black26,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.26,
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
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  _saving = true;
                                });
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: _email, password: _password);

                                  if (context.mounted) {
                                    setState(() {
                                      _saving = false;
                                      Navigator.popAndPushNamed(
                                          context, LoginScreen.id);
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                MainScreen())));
                                  }
                                } catch (e) {
                                  signUpAlert(
                                    context: context,
                                    onPressed: () {
                                      setState(() {
                                        _saving = false;
                                      });
                                      Navigator.popAndPushNamed(
                                          context, HomeScreen.id);
                                    },
                                    title: 'WRONG PASSWORD OR EMAIL',
                                    desc:
                                        'Confirm your email and password and try again',
                                    btnText: 'Try Now',
                                  ).show();
                                }
                              },
                              questionPressed: () {
                                signUpAlert(
                                  onPressed: () async {
                                    await FirebaseAuth.instance
                                        .sendPasswordResetEmail(email: _email);
                                  },
                                  title: 'RESET YOUR PASSWORD',
                                  desc:
                                      'Click on the button to reset your password',
                                  btnText: 'Reset Now',
                                  context: context,
                                ).show();
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
