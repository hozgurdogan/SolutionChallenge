import 'dart:async';
import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore_for_file: must_be_immutable
class CreateeventpagePage extends StatelessWidget {
  CreateeventpagePage({Key? key}) : super(key: key);

  TextEditingController eventDescriptionController = TextEditingController();

  TextEditingController dDMMYYYYvalueController = TextEditingController();

  Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 24.v),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 13.h),
                          child: Text("Create Event",
                              )),
                      SizedBox(height: 17.v),
                      Padding(
                          padding: EdgeInsets.only(left: 25.h),
                          child: Text("Event Title",
                              style: theme.textTheme.titleSmall)),
                      SizedBox(height: 8.v),
                      Padding(
                          padding: EdgeInsets.only(left: 30.h),
                          child: Text("e.g Camping in Rize ",
                              style: theme.textTheme.bodyMedium)),
                      Align(
                          alignment: Alignment.center,
                          child: Divider(indent: 18.h, endIndent: 8.h)),
                      SizedBox(height: 20.v),
                      Padding(
                          padding: EdgeInsets.only(left: 22.h, right: 58.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 1.v),
                                    child: Text("Add Photos",
                                        style: theme.textTheme.titleSmall)),
                                Text("Event score",
                                    style: theme.textTheme.titleSmall)
                              ])),
                      SizedBox(height: 5.v),
                      Padding(
                          padding: EdgeInsets.only(left: 25.h, right: 62.h),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 1.v),
                                    child: Text("thumbnail",
                                        style: theme.textTheme.bodyMedium)),
                                _buildEventLocation(context,
                                    exampleText: "e.g. 25")
                              ])),
                      SizedBox(height: 5.v),
                      Padding(
                          padding: EdgeInsets.only(left: 22.h),
                          child: Row(children: [
                            Padding(
                                padding: EdgeInsets.only(top: 2.v),
                                child: CustomIconButton(
                                    height: 65.adaptSize,
                                    width: 65.adaptSize,
                                    padding: EdgeInsets.all(23.h),

                                    child: CustomImageView(
                                        imagePath: ImageConstant.imgSolarStarBold))),
                            Container(
                                height: 67.v,
                                width: 66.h,
                                margin: EdgeInsets.only(left: 9.h),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                              height: 65.adaptSize,
                                              width: 65.adaptSize,
                                              decoration: BoxDecoration(
                                                  color: appTheme.blueGray700,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.h)))),
                                      CustomImageView(
                                          imagePath:
                                              ImageConstant.imgRectangle14,
                                          height: 65.adaptSize,
                                          width: 65.adaptSize,
                                          radius: BorderRadius.circular(20.h),
                                          alignment: Alignment.center)
                                    ]))
                          ])),
                      SizedBox(height: 19.v),
                      Padding(
                          padding: EdgeInsets.only(left: 22.h),
                          child: Text("Event Detail",
                              style: theme.textTheme.titleSmall)),
                      SizedBox(height: 7.v),
                      Padding(
                          padding: EdgeInsets.only(left: 18.h, right: 8.h),
                          child: CustomTextFormField(
                              controller: eventDescriptionController,
                              hintText: "Event Description",
                              alignment: Alignment.center,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.h, vertical: 1.v),
                              // borderDecoration:
                              //     TextFormFieldStyleHelper.underLineBlueGray,
                              filled: false)),
                      SizedBox(height: 18.v),
                      Padding(
                          padding: EdgeInsets.only(left: 25.h),
                          child: Row(children: [
                            Text("Starts", style: theme.textTheme.titleSmall),
                            Padding(
                                padding: EdgeInsets.only(left: 70.h),
                                child: Text("Ends",
                                    style: theme.textTheme.titleSmall))
                          ])),
                      SizedBox(height: 6.v),
                      Padding(
                          padding: EdgeInsets.only(left: 21.h),
                          child: Row(children: [
                            Container(
                                height: 17.v,
                                width: 96.h,
                                margin: EdgeInsets.only(top: 3.v),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                              width: 96.h, child: Divider())),
                                      Align(
                                          alignment: Alignment.center,
                                          child: Text("DD\\MM\\YYYY",
                                              style:
                                                  theme.textTheme.bodyMedium))
                                    ])),
                            Padding(
                                padding: EdgeInsets.only(left: 27.h),
                                child: CustomTextFormField(
                                    width: 104.h,
                                    controller: dDMMYYYYvalueController,
                                    hintText: "DD\\MM\\YYYY",
                                    textInputAction: TextInputAction.done,
                                    // borderDecoration:

                                    filled: false))
                          ])),
                      SizedBox(height: 17.v),
                      Padding(
                          padding: EdgeInsets.only(left: 22.h),
                          child: Text("Event Location",
                              style: theme.textTheme.titleSmall)),
                      SizedBox(height: 13.v),
                      Padding(
                          padding: EdgeInsets.only(left: 21.h),
                          child: Row(children: [
                            Padding(
                                padding: EdgeInsets.only(top: 1.v),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 1.h),
                                          child: Text("City",
                                              style:
                                                  theme.textTheme.titleSmall)),
                                      SizedBox(height: 5.v),
                                      _buildEventLocation(context,
                                          exampleText: "e.g. Rize")
                                    ])),
                            Padding(
                                padding: EdgeInsets.only(left: 38.h),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 1.h),
                                          child: Text("Town",
                                              style:
                                                  theme.textTheme.titleSmall)),
                                      SizedBox(height: 6.v),
                                      SizedBox(
                                          height: 16.v,
                                          width: 113.h,
                                          child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: SizedBox(
                                                        width: 84.h,
                                                        child: Divider())),
                                                Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                        "e.g. Çamlıhemşin",
                                                        style: theme.textTheme
                                                            .bodyMedium))
                                              ]))
                                    ]))
                          ])),
                      SizedBox(height: 15.v),
                      Padding(
                          padding: EdgeInsets.only(left: 18.h),
                          child: Text("Google Maps",
                              )),
                      _buildMiniMapDetail(context),
                      SizedBox(height: 25.v),
                      CustomElevatedButton(
                          height: 30.v,
                          width: 92.h,
                          text: "Create ",
                          margin: EdgeInsets.only(left: 124.h),
                          leftIcon: Container(
                              margin: EdgeInsets.only(right: 5.h),
                              child: CustomImageView(
                                  imagePath: ImageConstant
                                      .imgOuimlcreatesinglemetricjob,
                                  height: 15.adaptSize,
                                  width: 15.adaptSize)),
                          //buttonStyle: CustomButtonStyles.fillOrangeTL15,
                      )]
                      ))));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 54.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 30.h, top: 13.v, bottom: 16.v),
            onTap: () {
              onTapArrowLeft(context);
            }),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotifications,
              margin: EdgeInsets.symmetric(horizontal: 28.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildMiniMapDetail(BuildContext context) {
    return Container(
        height: 80.v,
        width: 350.h,
        margin: EdgeInsets.only(left: 1.h),
        child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 14.4746),
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            zoomControlsEnabled: false,
            zoomGesturesEnabled: false,
            myLocationButtonEnabled: false,
            myLocationEnabled: false));
  }

  /// Common widget
  Widget _buildEventLocation(
    BuildContext context, {
    required String exampleText,
  }) {
    return SizedBox(
        height: 17.v,
        width: 84.h,
        child: Stack(alignment: Alignment.centerLeft, children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(width: 84.h, child: Divider())),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(left: 2.h),
                  child: Text(exampleText,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: appTheme.blueGray700))))
        ]));
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
