import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/Controllers/auth_controller.dart';
import 'package:demo_app/Controllers/settings_controller.dart';
import 'package:demo_app/constants/color.dart';
import 'package:demo_app/screens/authentication/loginOrSignupPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingssView extends StatefulWidget {
  SettingssView({super.key});

  @override
  State<SettingssView> createState() => _SettingssViewState();
}

class _SettingssViewState extends State<SettingssView> {
  var settingsList = [
    "Change Password",
    "Payment Setup",
    "Payment History",
    "Terms & Conditions",
    "Signout",
    "About Us",
  ];

  var settingsListIcons = [
    Icons.lock_outline,
    Icons.edit_note_sharp,
    FontAwesomeIcons.indianRupeeSign,
    FontAwesomeIcons.history,
    Icons.logout,
    Icons.info_outline,
  ];

  var colors = [
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.deepPurpleAccent,
    Colors.blueGrey,
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingsController());
    return Column(
      children: [
        Obx(
          () => controller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      // leading: CircleAvatar(
                      //   child: Image.asset("assets/doctor.png"),
                      // ),
                      title: Text(
                        controller.docName.value,
                        style: CustomStyle.defaultTextStyle.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        // controller.docEmail.value,
                        "Neurosurgeon, Heart Specialist",
                        style: CustomStyle.descriptionTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Divider(
                      endIndent: 10,
                      indent: 10,
                    ),
                    // 5.heightBox,s
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                        settingsList.length,
                        (index) => GestureDetector(
                          onTap: () async {
                            if (index == 4) {
                              AuthController().signout(context);
                              Get.offAll(() => LoginOrSignupScreen());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              height: 60,
                              decoration: BoxDecoration(
                                  // color: Colors.grey[50],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 55,
                                    width: 55,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colors[index].withOpacity(0.2)),
                                    child: Icon(
                                      settingsListIcons[index],
                                      color: colors[index],
                                      size: 28,
                                    ),
                                  ),
                                  10.widthBox,
                                  Text(
                                    settingsList[index],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.grey[500],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
