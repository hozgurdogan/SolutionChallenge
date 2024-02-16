import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_title_button.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../service/UserService.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title_button.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../editprofile_screen/editprofile_screen.dart';

// ignore_for_file: must_be_immutable
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key})
      : super(
    key: key,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: FutureBuilder<InfoUser>(
            future: UserService().getUserInfoByEmail(),

        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veri yüklenene kadar yükleniyor göstergesi göster.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Hata varsa hata mesajını göster.
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          return

            SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  _buildTenStack(context),
                  Text(
                    snapshot.data!.name! + " " + snapshot.data!.surname!,
                  ),
                  SizedBox(height: 4.v),
                  Text(
                    snapshot.data!.username!,
                    style: theme.textTheme.labelSmall,
                  ),
                  SizedBox(height: 4.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCodiconLocation,
                        height: 15.adaptSize,
                        width: 15.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.v),
                        child: Text(
                          "Puan" + snapshot.data!.score!.toString(),
                          style: theme.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.v),
                  _buildEditProfileButton(context),
                  SizedBox(height: 4.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 96.h,
                      right: 78.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 12.h),
                              child: Text(
                                "31",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                            Text(
                              "Friends",
                              style: CustomTextStyles.bodySmallBlack900,
                            ),
                          ],
                        ),
                        Spacer(
                          flex: 50,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgSolarStarBold,
                          height: 30.adaptSize,
                          width: 30.adaptSize,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 7.v,
                            bottom: 5.v,
                          ),
                          child: Text(
                            "85",
                          ),
                        ),
                        Spacer(
                          flex: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              "3",
                              style: theme.textTheme.titleSmall,
                            ),
                            Text(
                              "Events",
                              style: CustomTextStyles.bodySmallBlack900,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 23.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 66.h,
                      right: 62.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Active Events",
                          style: theme.textTheme.labelLarge,
                        ),
                        Text(
                          "Last Events",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5.v),
                  Divider(
                    indent: 38.h,
                    endIndent: 37.h,
                  ),
                  SizedBox(height: 10.v),
                  _buildEventCardRow(context),
                  SizedBox(height: 5.v),
                ],
              ),
            );
        }),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitleButton(
        margin: EdgeInsets.only(left: 25.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgTwitter,
          margin: EdgeInsets.symmetric(
            horizontal: 32.h,
            vertical: 14.v,
          ),
        ),
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildTenStack(BuildContext context) {
    return SizedBox(
      height: 249.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
           CustomImageView(
             imagePath: ImageConstant.imgRectangle2,
             height: 174.v,
             width: 375.h,
             alignment: Alignment.topCenter,
           ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 135.adaptSize,
              width: 135.adaptSize,
              padding: EdgeInsets.all(1.h),
              // decoration: AppDecoration.outlineIndigo.copyWith(
              //   borderRadius: BorderRadiusStyle.roundedBorder67,
              // ),
              // child: CustomImageView(
              //   imagePath: ImageConstant.imgEllipse2,
              //   height: 130.adaptSize,
              //   width: 130.adaptSize,
              //   radius: BorderRadius.circular(
              //     65.h,
              //   ),
              //   alignment: Alignment.center,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEditProfileButton(BuildContext context) {
    return CustomElevatedButton(
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditprofileScreen(),));

      },
      height: 16.v,
      width: 100.h,
      text: "Edit Profile",
      leftIcon: Container(
        margin: EdgeInsets.only(right: 5.h),
        // child: CustomImageView(
        //   imagePath: ImageConstant.imgBitcoiniconseditoutline,
        //   height: 15.adaptSize,
        //   width: 15.adaptSize,
        // ),
      ),
      // buttonStyle: CustomButtonStyles.fillTealTL8,
      buttonTextStyle: theme.textTheme.labelLarge!,
    );
  }

  /// Section Widget
  Widget _buildEventDetailsButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "Details",
        margin: EdgeInsets.only(
          top: 1.v,
          right: 6.h,
        ),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 3.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 12.adaptSize,
            width: 12.adaptSize,
          ),
        ),
        buttonStyle: CustomButtonStyles.fillGray,
      ),
    );
  }

  /// Section Widget
  Widget _buildEventEditButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "Edit",
        margin: EdgeInsets.only(left: 6.h),
        leftIcon: Container(
          margin: EdgeInsets.only(right: 3.h),
          // child: CustomImageView(
          //   imagePath: ImageConstant.imgBitcoiniconseditoutlineBlack900,
          //   height: 15.adaptSize,
          //   width: 15.adaptSize,
          // ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEventCardRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16.h,
        right: 9.h,
      ),
      decoration: AppDecoration.fillGray300.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle14,
            height: 130.v,
            width: 202.h,
            radius: BorderRadius.circular(
              20.h,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(6.h, 7.v, 6.h, 4.v),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 135.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cycling",
                      ),
                      Text(
                        "Ahmet Boztemur",
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 11.v),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomImageView(
                      imagePath: ImageConstant.imgFluentMdl2DateTime,
                      height: 15.adaptSize,
                      width: 15.adaptSize,
                      margin: EdgeInsets.only(top: 1.v),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 1.h,
                        top: 1.v,
                        bottom: 3.v,
                      ),
                      child: Text(
                        "2 Weeks Later",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                    // CustomImageView(
                    //   imagePath: ImageConstant.imgCodiconLocationGray900,
                    //   height: 15.adaptSize,
                    //   width: 15.adaptSize,
                    //   margin: EdgeInsets.only(left: 2.h),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 1.v,
                        bottom: 3.v,
                      ),
                      child: Text(
                        "Uludağ",
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.v),
                Container(
                  width: 118.h,
                  margin: EdgeInsets.only(right: 17.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgPhPersonSimpleWalkThin,
                        height: 15.adaptSize,
                        width: 15.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.v),
                        child: Text(
                          "+8",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgHealthiconsAwa,
                        height: 15.adaptSize,
                        width: 15.adaptSize,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 2.v,
                          bottom: 3.v,
                        ),
                        child: Text(
                          "20 point",
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 19.v),
                Container(
                  width: 132.h,
                  margin: EdgeInsets.only(right: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildEventDetailsButton(context),
                      _buildEventEditButton(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
