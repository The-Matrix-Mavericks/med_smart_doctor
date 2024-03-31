import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/Components/medicine_card.dart';
import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/models/medicine_mode.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

List<String> icons = [
  "assets/icons/tooth.png",
  "assets/icons/heart.png",
  "assets/icons/hair.png",
  "assets/icons/skin.png",
  "assets/icons/nose.png",
  "assets/icons/stomach.png",
  "assets/icons/lungs.png",
  "assets/icons/bone.png",
  "assets/icons/eye.png",
  "assets/icons/ear.png",
];
List<String> iconsLable = [
  'Fever',
  'Flu',
  'Heart Disease',
  'Diabetes',
  'Asthma',
  'Stomach',
  'Chickenpox',
  'Common Cold',
  'Diarrhoea',
  'Pneumonia',
];

class MedicineShop extends StatefulWidget {
  const MedicineShop({super.key});

  @override
  State<MedicineShop> createState() => _MedicineShopState();
}

class _MedicineShopState extends State<MedicineShop> {
  String selectedValue = 'All';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Medicine Shop",
              style: const TextStyle(
                  fontFamily: 'Ubuntu',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: kTextColor),
            ),
          ),
          // 5.heightBox,
          // Text(
          //   "* Provides best medicines available in the market",
          //   style: const TextStyle(
          //       fontFamily: 'Rubik',
          //       fontSize: 18,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.black),
          // ),
          // 5.heightBox,
          // Text(
          //   "* Medicines for a medical condition.",
          //   style: const TextStyle(
          //       fontFamily: 'Rubik',
          //       fontSize: 18,
          //       fontWeight: FontWeight.w500,
          //       color: Colors.black),
          // ),
          // 5.heightBox,
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "* Formula based medicine",
          //     style: const TextStyle(
          //         fontFamily: 'Rubik',
          //         fontSize: 18,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.black),
          //   ),
          // ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, right: 0, left: 0, bottom: 0),
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 0),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 171, 171, 171).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25)),
              height: MediaQuery.of(context).size.height * 0.06,
              width: double.infinity,
              child: TextField(
                onTap: () {
                  setState(() {});
                },
                decoration: InputDecoration(
                    icon: Icon(
                      FontAwesomeIcons.search,
                      color: Colors.grey[600],
                    ),
                    border: InputBorder.none,
                    hintText: "Search Medicine...",
                    hintStyle:
                        TextStyle(color: Colors.grey[600], fontSize: 16)),
              ),
            ),
          ),

          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _showDropdown(context);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.transparent,
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 10,
                    children: [
                      Text(
                        selectedValue,
                        style: CustomStyle.defaultTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              PopupMenuButton<String>(
                icon: const Icon(Icons.sort),
                onSelected: choiceAction,
                itemBuilder: (BuildContext context) {
                  return Constants.choices.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 0),
          //   child: SizedBox(
          //     height: 50,
          //     child: ListView.builder(
          //         // to show top 3 doctors
          //         physics: BouncingScrollPhysics(),
          //         scrollDirection: Axis.horizontal,
          //         itemCount: icons.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return GestureDetector(
          //             // onTap: () {
          //             //   Get.to(() => DoctorProfileView(
          //             //         doc: data![index],
          //             //       ));
          //             // },
          //             child: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 5),
          //               child: Container(
          //                 padding: EdgeInsets.all(8),
          //                 decoration: BoxDecoration(
          //                     // border: Border.all(
          //                     //     color: Colors.grey[200]!, width: 2),
          //                     // color: Color(0xFF9CC5FF).withOpacity(0.9),
          //                     color: Color.fromARGB(255, 160, 133, 255)
          //                         .withOpacity(0.5),
          //                     // boxShadow: [
          //                     //   BoxShadow(
          //                     //       color: Colors.black45,
          //                     //       blurRadius: 5,
          //                     //       offset: Offset(5, 5))
          //                     // ],
          //                     borderRadius: BorderRadius.circular(12)),
          //                 child: Row(
          //                   children: [
          //                     // 8.heightBox,
          //                     5.widthBox,
          //                     Text(
          //                       iconsLable[index],
          //                       style: TextStyle(
          //                           fontSize: 15,
          //                           fontFamily: 'Inter',
          //                           fontWeight: FontWeight.bold,
          //                           color: Colors.grey[800]),
          //                     ),
          //                     5.widthBox,
          //                     // 5.heightBox
          //                   ],
          //                 ),
          //               ),
          //             ),
          //           );
          //         }),
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          MedicineCard(
              name: medList[0].name,
              about: medList[0].about,
              formula: medList[0].formula,
              image: medList[0].image,
              index: 0,
              constraints: medList[0].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[1].name,
              about: medList[1].about,
              index: 1,
              formula: medList[1].formula,
              image: medList[1].image,
              constraints: medList[1].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[2].name,
              index: 2,
              about: medList[2].about,
              formula: medList[2].formula,
              image: medList[2].image,
              constraints: medList[2].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[3].name,
              index: 3,
              about: medList[3].about,
              formula: medList[3].formula,
              image: medList[3].image,
              constraints: medList[3].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[4].name,
              index: 4,
              about: medList[4].about,
              formula: medList[4].formula,
              image: medList[4].image,
              constraints: medList[4].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[5].name,
              index: 5,
              about: medList[5].about,
              formula: medList[5].formula,
              image: medList[5].image,
              constraints: medList[5].constraints),
          10.heightBox,
          MedicineCard(
              name: medList[6].name,
              about: medList[6].about,
              index: 6,
              formula: medList[6].formula,
              image: medList[6].image,
              constraints: medList[6].constraints),
        ],
      ),
    );
  }
            

  void _showDropdown(BuildContext context) {
    final List<String> options = [
      'Dangue',
      'Malaria',
      'Diabetes',
      'Cold',
      'Fever',
      'All',
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 260,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'Filter by Medical Condition',
                      style: CustomStyle.defaultTextStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(options[index]),
                      onTap: () {
                        setState(() {
                          selectedValue =
                              options[index]; // Perbarui teks yang dipilih
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
