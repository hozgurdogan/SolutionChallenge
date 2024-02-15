import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:ahmet_s_application2/presentation/main_page/main_page.dart';
import 'package:ahmet_s_application2/service/UserService.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_title_button.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {


  ProfileScreen({Key? key})
      : super(
          key: key,
        );



  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {



    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<InfoUser>(
          future: UserService().getUserInfoByEmail(),
          builder: (context,snapshot){

            if (snapshot.connectionState == ConnectionState.waiting) {
              // Veri yüklenene kadar yükleniyor göstergesi göster.
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // Hata varsa hata mesajını göster.
              return Center(child: Text('Hata: ${snapshot.error}'));
            }else{
              return   Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 10.h,
                  vertical: 43.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 25.h,
                          right: 31.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2.v),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomImageView(
                                    imagePath: ImageConstant.imgWhatsappGRsel,
                                    height: 109.v,
                                    width: 74.h,
                                    radius: BorderRadius.circular(
                                      37.h,
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                  SizedBox(height: 8.v),
                                  Row(
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgSolarStarBold,
                                        height: 35.adaptSize,
                                        width: 35.adaptSize,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 5.h,
                                          top: 9.v,
                                          bottom: 5.v,
                                        ),
                                        child: Text(
                                          "85",
                                          style:
                                          CustomTextStyles.titleMediumOnPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8.h,
                                top: 66.v,
                                bottom: 52.v,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.name!+" "+snapshot.data!.surname!,
                                    style: CustomTextStyles.titleMediumBlack900,
                                  ),
                                  SizedBox(height: 2.v),
                                  Text(
                                    "Member since January 2024",
                                    style: CustomTextStyles.labelMediumBluegray700,
                                  ),
                                ],
                              ),
                            ),
                            CustomElevatedButton(
                              height: 28.v,
                              width: 63.h,
                              text: "Edit",
                              margin: EdgeInsets.only(
                                left: 7.h,
                                bottom: 126.v,
                              ),
                              buttonStyle: CustomButtonStyles.fillGrayTL14,
                              buttonTextStyle: CustomTextStyles.titleMediumBlack900,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    SizedBox(height: 37.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 23.h,
                        right: 49.h,
                      ),
                      child: _buildNumberOfEvents(
                        context,
                        text: "Number of events",
                        text1: "4",
                      ),
                    ),
                    SizedBox(height: 19.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 22.h,
                        right: 49.h,
                      ),
                      child: _buildNumberOfEvents(
                        context,
                        text: "Favorites",
                        text1: "12",
                      ),
                    ),
                    SizedBox(height: 32.v),

                    SizedBox(height: 5.v),
                    CustomImageView(
                      imagePath: ImageConstant.imgVector1,
                      height: 130.v,
                      width: 303.h,
                      margin: EdgeInsets.only(left: 17.h),
                    ),
                  ],
                ),
              );
            }
          },

        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 15.h,
            right: 10.h,
          ),
          child: _buildBottomBar(context),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitleButton(
        margin: EdgeInsets.only(left: 27.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTwitter,
          margin: EdgeInsets.fromLTRB(32.h, 17.v, 32.h, 11.v),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildHeadUpFollowing(BuildContext context) {
    return Container(
      height: 39.v,
      width: 350.h,
      margin: EdgeInsets.only(left: 5.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 38.v,
              width: 350.h,
              decoration: BoxDecoration(
                color: appTheme.gray300,
                borderRadius: BorderRadius.circular(
                  19.h,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                right: 10.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "35",
                        style: CustomTextStyles.titleMediumBlack900,
                      ),
                      Text(
                        "Follow",
                        style:TextStyle(fontSize: 12),

                      ),
                    ],
                  ),
                  Spacer(
                    flex: 53,
                  ),
                  Column(
                    children: [
                      Text(
                        "24",
                        style: CustomTextStyles.titleMediumBlack900,
                      ),
                      Text(
                        "Follower",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 46,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 18.h),
                          child: Text(
                            "3",
                            style: CustomTextStyles.titleMediumBlack900,
                          ),
                        ),
                      ),
                      Text(
                        "Friends",
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(
      onChanged: (BottomBarEnum type) {
        Navigator.pushNamed(
            navigatorKey.currentContext!, getCurrentRoute(type));
      },
    );
  }

  /// Common widget
  Widget _buildNumberOfEvents(
    BuildContext context, {
    required String text,
    required String text1,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.h,
        vertical: 1.v,
      ),
      decoration: AppDecoration.fillGray300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.v),
            child: Text(
              text,
              style: theme.textTheme.titleLarge!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 2.h,
              bottom: 1.v,
            ),
            child: Text(
              text1,
              style: theme.textTheme.titleLarge!.copyWith(
                color: appTheme.black900,
              ),
            ),
          ),
        ],
      ),
    );
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
}
