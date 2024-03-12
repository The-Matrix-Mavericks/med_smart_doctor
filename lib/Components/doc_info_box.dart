import 'package:demo_app/Components/text_styles.dart';
import 'package:flutter/material.dart';

class DocInfoBox extends StatelessWidget {
  String infoLabel;
  String infoText;
  DocInfoBox({super.key, required this.infoLabel, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          // color: Colors.grey[100],
          ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 0, top: 10),
            child: Text(
              infoLabel,
              style: CustomStyle.defaultTextStyle.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 10),
            child: Text(
              infoText,
              style: CustomStyle.descriptionTextStyle
                  .copyWith(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[200],
            ),
          )
          // Text(infoText),
        ],
      ),
    );
  }
}
