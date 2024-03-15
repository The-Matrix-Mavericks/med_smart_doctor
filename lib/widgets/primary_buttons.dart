import 'package:demo_app/Components/text_styles.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isActive;

  const PrimaryButton({
    super.key,
    this.isActive = true,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppColors.primaryColor : AppColors.grayColor,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap ?? () {},
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isActive ? Colors.white : AppColors.textGrayColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryWhiteButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isActive;

  const PrimaryWhiteButton({
    super.key,
    this.isActive = true,
    this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.white,
      borderRadius: BorderRadius.circular(10),

      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap ?? () {},
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              title,
              style: CustomStyle.defaultTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
