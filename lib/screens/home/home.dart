import 'package:demo_app/Components/bottom_nav_bar/custom_bottom_navbar.dart';
import 'package:demo_app/Components/custom_appbar/custom_appbar.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/auth_controller.dart';
import 'package:demo_app/screens/appointment/appointment.dart';
import 'package:demo_app/screens/chat_screen/char_screen.dart';
import 'package:demo_app/screens/home/home_screen.dart';
import 'package:demo_app/screens/profile_screen/profile_screen.dart';
import 'package:demo_app/screens/setting_screen/setting_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:unicons/unicons.dart';

import '../../constants/color.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static String id = 'main_screen';

  @override
  State<Home> createState() => _MainScreenState();
}

class _MainScreenState extends State<Home> {
  static List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AppointmentScreen(),
    ChatScreen(),
    ProfileScreen(),
    SettingssView()
  ];

  static const List<IconData> iconList = [
    UniconsLine.home_alt,
    Icons.calendar_month_outlined,
    // UniconsLine.chat_info,
    FontAwesomeIcons.commentDots,
    UniconsLine.user,
    UniconsLine.setting,
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 25.0,
            ),
            child: Column(
              children: [
                const CustomAppbar(),
                _widgetOptions.elementAt(_selectedIndex),
              ],
            ),
          ),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Colors.deepPurple[100],
          gapLocation: GapLocation.none,
          splashSpeedInMilliseconds: 500,
          iconSize: 30,
          height: 60,
          icons: iconList,
          activeIndex: _selectedIndex,
          // leftCornerRadius: 32,
          // rightCornerRadius: 32,
          onTap: (index) => _onItemTapped(index),
          activeColor: primaryColor,
          inactiveColor: Color.fromARGB(255, 165, 165, 165),
        ),
      ),
    );
  }
}
