import '../details_bottomsheet/widgets/eventlist_item_widget.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class DetailsBottomsheet extends StatelessWidget {
  const DetailsBottomsheet({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder50,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 8.v,
            width: 60.h,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(
                4.h,
              ),
            ),
          ),
          SizedBox(height: 5.v),
          Container(
            width: 144.h,
            padding: EdgeInsets.symmetric(
              horizontal: 23.h,
              vertical: 1.v,
            ),
            // decoration: AppDecoration.fillPrimaryContainer.copyWith(
            //   borderRadius: BorderRadiusStyle.roundedBorder9,
            // ),
            child: Text(
              "About the event",
              style: CustomTextStyles.labelLargeGray10001,
            ),
          ),
          SizedBox(height: 4.v),
          _buildEventList(context),
          SizedBox(height: 4.v),
          _buildDetailCard(context),
          SizedBox(height: 4.v),

          _buildMiniMapDetail(context),
          SizedBox(height: 7.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 15.h),
              child: Text(
                "Participants",
                style: CustomTextStyles.titleSmallBlack900,
              ),
            ),
          ),
          SizedBox(height: 3.v),
          Divider(
            indent: 14.h,
            endIndent: 15.h,
          ),
          SizedBox(height: 8.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: _buildP2(
              context,
              dynamicText: "1     ",
              dynamicText1: "Oğuzhan Yavaş",
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: _buildP2(
              context,
              dynamicText: "2     ",
              dynamicText1: "Furkan Uzun",
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: _buildP2(
              context,
              dynamicText: "3     ",
              dynamicText1: "Ahmet Boztemur",
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: _buildP2(
              context,
              dynamicText: "4     ",
              dynamicText1: "Hasan Özgür Doğan",
            ),
          ),
          SizedBox(height: 11.v),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.h),
            child: _buildP2(
              context,
              dynamicText: "5     ",
              dynamicText1: "Enes Silver",
            ),
          ),
          SizedBox(height: 17.v),
          CustomElevatedButton(
            height: 38.v,
            width: 192.h,
            text: "Join the event",
            leftIcon: Container(
              margin: EdgeInsets.only(right: 22.h),
              child: CustomImageView(
                imagePath:
                    ImageConstant.imgFluentarrowjoin20regularErrorcontainer,
                height: 25.adaptSize,
                width: 25.adaptSize,
              ),
            ),
            buttonStyle: CustomButtonStyles.fillOnPrimaryTL19,
            buttonTextStyle: CustomTextStyles.titleMediumErrorContainer,
          ),
          SizedBox(height: 12.v),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEventList(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          height: 35.v,
          child: ListView.separated(
            padding: EdgeInsets.only(
              left: 26.h,
              right: 42.h,
            ),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                width: 40.h,
              );
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return EventlistItemWidget();
            },
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildDetailCard(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: appTheme.gray300,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusStyle.roundedBorder28,
      ),
      child: Container(
        height: 57.v,
        width: 304.h,
        decoration: AppDecoration.fillGray300.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder28,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.h, 11.v, 35.h, 11.v),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 25.adaptSize,
                      width: 25.adaptSize,
                      margin: EdgeInsets.only(
                        top: 3.v,
                        bottom: 5.v,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.h),
                      child: _buildSeventyNine(
                        context,
                        hazRlayan: "Hazırlayan:",
                        oUzhanYava: "Oğuzhan Yavaş",
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.v,
                        bottom: 13.v,
                      ),
                      child: Text(
                        "Other activities",
                        style: CustomTextStyles.bodySmallPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.h,
                  vertical: 10.v,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyle.roundedBorder28,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgLock,
                      height: 25.adaptSize,
                      width: 25.adaptSize,
                      margin: EdgeInsets.only(
                        top: 3.v,
                        bottom: 7.v,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 5.h,
                        bottom: 1.v,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hazırlayan:",
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            "Oğuzhan Yavaş",
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 5.v,
                        right: 27.h,
                        bottom: 15.v,
                      ),
                      child: Text(
                        "Other activities",
                        style: CustomTextStyles.bodySmallPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildMiniMapDetail(BuildContext context) {
    return SizedBox(
      height: 80.v,
      width: 350.h,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle30,
            height: 80.v,
            width: 350.h,
            radius: BorderRadius.circular(
              20.h,
            ),
            alignment: Alignment.center,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 15.h,
                top: 19.v,
                right: 233.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 1.h),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "816",
                            style: CustomTextStyles.labelMediumffffbe58,
                          ),
                          TextSpan(
                            text: " ",
                          ),
                          TextSpan(
                            text: "km",
                            style: CustomTextStyles.bodySmallff232121,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    "Çamlıhemşin, Rize",
                    style: CustomTextStyles.bodySmallPrimaryContainer12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildSeventyNine(
    BuildContext context, {
    required String hazRlayan,
    required String oUzhanYava,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hazRlayan,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          oUzhanYava,
          style: theme.textTheme.titleSmall!.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildP2(
    BuildContext context, {
    required String dynamicText,
    required String dynamicText1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 3.v,
      ),
      decoration: AppDecoration.fillGray300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            dynamicText,
            style: theme.textTheme.labelMedium!.copyWith(
              color: appTheme.black900,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 34.h),
            child: Text(
              dynamicText1,
              style: CustomTextStyles.bodySmallBlack900.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
