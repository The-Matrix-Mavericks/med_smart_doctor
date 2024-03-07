import 'package:flutter/material.dart';
// import 'package:login_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed,
      this.width = 280});

  final String buttonText;
  final bool isOutlined;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Material(
        borderRadius: BorderRadius.circular(30),
        elevation: 4,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.white : kTextColor,
            border: Border.all(color: kTextColor, width: 2.5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 218, 221, 255),
                offset: Offset(0, 2),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isOutlined ? kTextColor : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage('assets/images/$screenImageName'),
        ),
      ),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.left,
      style: const TextStyle(
          fontSize: 35, fontWeight: FontWeight.bold, color: kTextColor),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.textField});
  final TextField textField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.grey[300]!,
        ),
      ),
      child: textField,
    );
  }
}

class CustomTextFieldWithFieldName extends StatelessWidget {
  CustomTextFieldWithFieldName(
      {super.key, required this.textField, required this.fieldName});
  final TextField textField;
  final String fieldName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3.0, bottom: 5),
          child: Text(
            fieldName,
            style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
        ),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey[300]!,
            ),
          ),
          child: textField,
        ),
      ],
    );
  }
}

class CustomBottomScreen extends StatelessWidget {
  const CustomBottomScreen({
    super.key,
    required this.textButton,
    required this.question,
    this.heroTag = '',
    required this.buttonPressed,
    required this.questionPressed,
  });
  final String textButton;
  final String question;
  final String heroTag;
  final Function buttonPressed;
  final Function questionPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: heroTag,
          child: CustomButton(
            buttonText: textButton,
            width: 150,
            onPressed: () {
              buttonPressed();
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: GestureDetector(
            onTap: () {
              questionPressed();
            },
            child: Text(question),
          ),
        ),
      ],
    );
  }
}

Alert signUpAlert({
  required Function onPressed,
  required String title,
  required String desc,
  required String btnText,
  required BuildContext context,
}) {
  return Alert(
    context: context,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: () {
          onPressed();
        },
        width: 120,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    ],
  );
}

Alert showAlert({
  required Function onPressed,
  required String title,
  required String desc,
  required BuildContext context,
}) {
  return Alert(
    context: context,
    type: AlertType.error,
    title: title,
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: () {
          onPressed();
        },
        width: 120,
        child: const Text(
          "OK",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      )
    ],
  );
}
