import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class AwardScreen extends StatelessWidget {
  AwardScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appTheme.gray100,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 38.h, vertical: 42.v),
                child: Column(children: [
                  SizedBox(height: 39.v),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(right: 16.h),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgLock,
                                    height: 25.adaptSize,
                                    width: 25.adaptSize,
                                    margin: EdgeInsets.only(bottom: 122.v)),
                                Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8.h, top: 3.v),
                                        child: Column(children: [
                                          _buildP2(context,
                                              dynamicText: "1     ",
                                              dynamicText1: "Oğuzhan Yavaş"),
                                          SizedBox(height: 11.v),
                                          _buildP2(context,
                                              dynamicText: "2     ",
                                              dynamicText1: "Furkan Uzun"),
                                          SizedBox(height: 11.v),
                                          _buildP2(context,
                                              dynamicText: "3     ",
                                              dynamicText1: "Ahmet Boztemur"),
                                          SizedBox(height: 11.v),
                                          _buildP2(context,
                                              dynamicText: "4     ",
                                              dynamicText1:
                                                  "Hasan Özgür Doğan"),
                                          SizedBox(height: 11.v),
                                          _buildP2(context,
                                              dynamicText: "5     ",
                                              dynamicText1: "Enes Silver")
                                        ])))
                              ]))),
                  Spacer(),
                  Text("Winner of the week",
                      style: CustomTextStyles.titleMediumOnPrimary_1),
                  SizedBox(height: 4.v),
                  Container(
                      margin: EdgeInsets.only(left: 3.h, right: 7.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 21.h, vertical: 25.v),
                      decoration: AppDecoration.fillGray300.copyWith(
                          borderRadius: BorderRadiusStyle.roundedBorder28),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgWhatsappGRsel87x84,
                                height: 87.v,
                                width: 84.h,
                                radius: BorderRadius.circular(42.h),
                                margin: EdgeInsets.only(top: 3.v, bottom: 8.v)),
                            Padding(
                                padding:
                                    EdgeInsets.only(left: 9.h, bottom: 8.v),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 18.h),
                                          child: Text("furkanuzunz",
                                              style: CustomTextStyles
                                                  .titleMediumBlack900_1)),
                                      SizedBox(height: 2.v),
                                      Text("Member since January 2022",
                                          style: CustomTextStyles
                                              .labelMediumBluegray700),
                                      SizedBox(height: 20.v),
                                      Padding(
                                          padding: EdgeInsets.only(left: 37.h),
                                          child: Row(children: [
                                            CustomImageView(
                                                imagePath: ImageConstant
                                                    .imgSolarStarBold,
                                                height: 35.adaptSize,
                                                width: 35.adaptSize),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: 5.h,
                                                    top: 9.v,
                                                    bottom: 5.v),
                                                child: Text("75",
                                                    style: CustomTextStyles
                                                        .titleMediumOnPrimary))
                                          ]))
                                    ]))
                          ]))
                ])),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: _buildBottomBar(context))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 60.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 36.h, top: 16.v, bottom: 13.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotificationsTeal200,
              margin: EdgeInsets.symmetric(horizontal: 43.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  /// Common widget
  Widget _buildP2(
    BuildContext context, {
    required String dynamicText,
    required String dynamicText1,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 3.v),
        decoration: AppDecoration.fillGray300
            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder12),
        child: Row(mainAxisSize: MainAxisSize.max, children: [
          Text(dynamicText,
              style: theme.textTheme.labelMedium!
                  .copyWith(color: appTheme.black900)),
          Padding(
              padding: EdgeInsets.only(left: 34.h),
              child: Text(dynamicText1,
                  style: CustomTextStyles.bodySmallBlack900
                      .copyWith(color: appTheme.black900)))
        ]));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.mainPage;
      case BottomBarEnum.Score:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.mainPage:
        return MainPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
