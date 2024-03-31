import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/models/medicine_mode.dart';
import 'package:demo_app/screens/medicine_shop/medicine_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MedicineCard extends StatefulWidget {
  final String name;
  final String about;
  final String formula;
  final String image;
  final int index;
  final String constraints;
  const MedicineCard(
      {super.key,
      required this.name,
      required this.about,
      required this.index,
      required this.formula,
      required this.image,
      required this.constraints});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15),
      elevation: 5,
      child: Container(
        // margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 100,
        width: 350,
        decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              Colors.blue[100]!,
              Colors.cyan[50]!,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: CustomStyle.defaultTextStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  widget.formula,
                  style: CustomStyle.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: 'Rubik'),
                ),
                Text(
                  widget.constraints,
                  style: CustomStyle.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Colors.green[600]),
                ),
                // Text(widget.about),
              ],
            ),
            Spacer(
              flex: 15,
            ),
            Image.asset(
              widget.image,
              // height: 80,
              // height: 80,
              width: 50,
            ),
            Spacer(),
            Center(child: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ).onTap(() {
        Get.to(() => MedicineDetailPage(
            name: medList[widget.index].name,
            about: medList[widget.index].about,
            formula: medList[widget.index].formula,
            image: medList[widget.index].image,
            type: medList[widget.index].type,
            goodReviews: medList[widget.index].goodReviews,
            totalScore: medList[widget.index].totalScore,
            satisfaction: medList[widget.index].satisfaction,
            rating: medList[widget.index].rating,
            constraints: medList[widget.index].constraints));
      }),
    );
  }
}

class Constants {
  static const String firstItem = 'Latest';
  static const String secondItem = 'Oldest';

  static const List<String> choices = <String>[
    firstItem,
    secondItem,
  ];
}

void choiceAction(String choice) {
  if (choice == Constants.firstItem) {
    print('Latest clicked');
  } else if (choice == Constants.secondItem) {
    print('Oldest clicked');
  }
}
