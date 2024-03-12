import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicons/unicons.dart';

import '../text_styles.dart';

class CustomBottomNavBar extends StatefulWidget {
  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Search',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(
          top: BorderSide(
            color: Colors.grey[100]!,
          ),
        ),
      ),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12,
          left: 12,
          bottom: 12,
          top: 6,
        ),
        child: GNav(
          rippleColor: Colors.grey[300]!,
          hoverColor: Colors.grey[300]!,
          gap: 8,
          activeColor: Colors.black,
          iconSize: 30,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          duration: Duration(milliseconds: 400),
          tabBackgroundGradient: LinearGradient(colors: [
            Color.fromARGB(255, 176, 234, 254),
            Color.fromARGB(255, 138, 224, 255),
          ]),
          color: Colors.black,
          tabs: [
            GButton(
              icon: FontAwesomeIcons.home,
              iconSize: 35,
              text: 'Home',
              textStyle: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // onPressed: () => Get.to(() => MainPage()),
            ),
            GButton(
              icon: FontAwesomeIcons.search,
              iconSize: 30,
              text: 'Search',
              textStyle: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // onPressed:()=> Get.to(()=>HomePage()),
            ),
            GButton(
              icon: FontAwesomeIcons.user,
              iconSize: 30,
              text: 'Profile',
              textStyle: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              // onPressed:()=> Get.to(()=>ParentPage()),
            ),
            GButton(
              icon: UniconsLine.setting,
              iconSize: 30,
              text: 'Settings',
              textStyle: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
