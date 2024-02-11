import 'package:ahmet_s_application2/service/OrganizationService.dart';

import '../main_page/widgets/eventcard_item_widget.dart';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_search_view.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class MainPage extends StatelessWidget {
  MainPage({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        resizeToAvoidBottomInset: false,
        body:

          Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillGray,
            child: Column(
              children: [
                _buildSeven(context),
                SizedBox(
                  height: 827.v,
                  width: double.maxFinite,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _buildEventCard(context),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 127.v,
                          width: double.maxFinite,
                          margin: EdgeInsets.only(bottom: 68.v),
                          decoration: BoxDecoration(
                            color: appTheme.gray10001.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );


  }

  /// Section Widget
  Widget _buildCreateButton(BuildContext context) {
    return CustomElevatedButton(
      height: 29.v,
      width: 92.h,
      text: "Create",
      margin: EdgeInsets.only(
        left: 17.h,
        bottom: 1.v,
        top: 25.v,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 5.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgOuimlcreatesinglemetricjob,
          height: 15.adaptSize,
          width: 15.adaptSize,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillGray,
      buttonTextStyle: CustomTextStyles.titleMediumTeal200,
    );
  }

  /// Section Widget
  Widget _buildSeven(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 36.h,
        vertical: 30.v,
      ),
      decoration: AppDecoration.fillTeal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.v,top: 18.v),
            child: CustomSearchView(
              hintText: "Find organization name",
              width: 150.h,
              controller: searchController,
            ),
          ),
          _buildCreateButton(context),
          CustomImageView(
            imagePath: ImageConstant.imgNotifications,
            height: 25.adaptSize,
            width: 25.adaptSize,
            margin: EdgeInsets.only(
              left: 15.h,
              top: 3.v,
              bottom: 1.v,
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEventCard(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,



        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 9.h,
            vertical: 5.v,
          ),
          decoration: AppDecoration.outlineDeepPurpleA.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (
              context,
              index,
            ) {
              return SizedBox(
                height: 14.v,
              );
            },
            itemCount: 1,
            itemBuilder: (context, index) {
              return EventcardItemWidget();
            },
          ),
        ),

    );
  }
}
