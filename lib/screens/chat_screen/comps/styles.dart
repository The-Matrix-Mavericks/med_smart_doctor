import 'package:demo_app/constants/color.dart';
import 'package:flutter/material.dart';

class Styles {
  static TextStyle h1() {
    return const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white);
  }

  static friendsBox() {
    return const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)));
  }

  static messagesCardStyle(check) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: check ? Colors.indigo.shade300 : Colors.grey.shade300,
    );
  }

  static messageFieldCardStyle() {
    return BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400]!,
              offset: Offset(0, 5),
              spreadRadius: 2,
              blurRadius: 5)
        ],
        borderRadius: BorderRadius.circular(25));
  }

  static messageTextFieldStyle({required Function() onSubmit}) {
    return InputDecoration(
        border: InputBorder.none,
        hintText: 'Message',
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        suffixIcon: Container(
          height: 50,
          width: 50,
          decoration:
              BoxDecoration(color: primaryColor, shape: BoxShape.circle),
          child: IconButton(
            onPressed: onSubmit,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ));
  }

  static searchTextFieldStyle() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Name',
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      suffixIcon:
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
    );
  }
}
