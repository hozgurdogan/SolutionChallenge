import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RankrowItemWidget extends StatelessWidget {
  const RankrowItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 13.v,
              bottom: 12.v,
            ),
            child: Text(
              "2     ",
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 6.h,
              top: 16.v,
              bottom: 15.v,
            ),
            child: CustomIconButton(
              height: 20.adaptSize,
              width: 20.adaptSize,
              padding: EdgeInsets.all(2.h),
              decoration: IconButtonStyleHelper.fillPrimary,
              child: CustomImageView(
                imagePath: ImageConstant.imgWhatsappGRsel87x84,
              ),
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgWhatsappGRsel87x84,
            height: 50.adaptSize,
            width: 50.adaptSize,
            margin: EdgeInsets.only(
              left: 6.h,
              top: 1.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 6.h,
              top: 18.v,
              bottom: 15.v,
            ),
            child: Text(
              "Oğuzhan Yavaş",
              style: CustomTextStyles.bodyLargePrimary,
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgSolarStarBold,
            height: 30.adaptSize,
            width: 30.adaptSize,
            margin: EdgeInsets.only(
              left: 25.h,
              top: 11.v,
              bottom: 10.v,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.h,
              top: 17.v,
              bottom: 16.v,
            ),
            child: Text(
              "160",
              style: CustomTextStyles.bodyLargePrimary,
            ),
          ),
        ],
      ),
    );
  }
}
