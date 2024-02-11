import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppbarTitleButton extends StatelessWidget {
  AppbarTitleButton({
    Key? key,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomElevatedButton(
          height: 30.v,
          width: 100.h,
          text: "Settings",
          leftIcon: Container(
            margin: EdgeInsets.only(right: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                7.h,
              ),
            ),
            child: CustomImageView(
              imagePath: ImageConstant.imgClaritysettingsline,
              height: 15.adaptSize,
              width: 15.adaptSize,
            ),
          ),
          buttonStyle: CustomButtonStyles.fillTeal,
          buttonTextStyle: CustomTextStyles.titleMediumGray10001,
        ),
      ),
    );
  }
}
