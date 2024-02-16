import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/createeventpage_page/createeventpage_page.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

// ignore_for_file: must_be_immutable
class EditprofileScreen extends StatelessWidget {
  EditprofileScreen({Key? key}) : super(key: key);

  TextEditingController usernameFieldController = TextEditingController();

  TextEditingController passwordFieldController = TextEditingController();

  TextEditingController countryFieldController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Form(
                        key: _formKey,
                        child: SizedBox(
                            width: double.maxFinite,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildBannerSection(context),
                                  SizedBox(height: 38.v),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          left: 47.h, right: 64.h),
                                      child: Row(children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 1.v),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Name-Surname",
                                                      style: theme.textTheme
                                                          .titleMedium),
                                                  SizedBox(height: 4.v),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4.h),
                                                      child: Text("Furkan Uzun",
                                                          style: theme.textTheme
                                                              .bodyMedium)),
                                                  SizedBox(
                                                      width: 114.h,
                                                      child: Divider())
                                                ])),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 34.h),
                                            child: Column(children: [
                                              Text("Username",
                                                  style: theme
                                                      .textTheme.titleMedium),
                                              SizedBox(height: 2.v),
                                              _buildUsernameField(context)
                                            ]))
                                      ])),
                                  SizedBox(height: 14.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 47.h),
                                      child: Text("Email",
                                          style: theme.textTheme.titleMedium)),
                                  SizedBox(height: 7.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 43.h),
                                      child: Text("fuzun096@gmail.com",
                                          style: theme.textTheme.bodyMedium)),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Divider(
                                          indent: 43.h, endIndent: 40.h)),
                                  SizedBox(height: 14.v),
                                  _buildPasswordField(context),
                                  SizedBox(height: 24.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 43.h),
                                      child: Text("Phone Number",
                                          style: theme.textTheme.titleMedium)),
                                  SizedBox(height: 5.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 39.h),
                                      child: Text("+905555555555",
                                          style: theme.textTheme.labelMedium)),
                                  SizedBox(height: 6.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Divider(
                                          indent: 37.h, endIndent: 46.h)),
                                  SizedBox(height: 27.v),
                                  Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 43.h),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 1.h),
                                                          child: Text(
                                                              "Date Of Birth",
                                                              style: theme
                                                                  .textTheme
                                                                  .titleMedium)),
                                                      SizedBox(height: 3.v),
                                                      _buildCityField(context,
                                                          textValue:
                                                              "22\\22\\2002")
                                                    ]),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 34.h),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Country/Region",
                                                              style: theme
                                                                  .textTheme
                                                                  .titleMedium),
                                                          _buildCountryField(
                                                              context)
                                                        ]))
                                              ]))),
                                  SizedBox(height: 27.v),
                                  Padding(
                                      padding: EdgeInsets.only(left: 43.h),
                                      child: Row(children: [
                                        Padding(
                                            padding: EdgeInsets.only(top: 1.v),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.h),
                                                      child: Text("City",
                                                          style: theme.textTheme
                                                              .titleMedium)),
                                                  SizedBox(height: 2.v),
                                                  _buildCityField(context,
                                                      textValue: "e.g. Rize")
                                                ])),
                                        Padding(
                                            padding:
                                                EdgeInsets.only(left: 51.h),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 1.h),
                                                      child: Text("Town",
                                                          style: theme.textTheme
                                                              .titleMedium)),
                                                  SizedBox(height: 4.v),
                                                  SizedBox(
                                                      height: 17.v,
                                                      width: 113.h,
                                                      child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            Align(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: SizedBox(
                                                                    width: 84.h,
                                                                    child:
                                                                        Divider())),
                                                            Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                    "e.g. Çamlıhemşin",
                                                                    style: theme
                                                                        .textTheme
                                                                        .bodyMedium))
                                                          ]))
                                                ]))
                                      ])),
                                  SizedBox(height: 20.v),
                                  _buildEditProfileButton(context),
                                  SizedBox(height: 5.v)
                                ]))))),
            bottomNavigationBar: Padding(
                padding: EdgeInsets.only(left: 29.h, right: 26.h),
                child: _buildBottomBar(context))));
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
  Widget _buildBannerSection(BuildContext context) {
    return SizedBox(
        height: 164.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topCenter, children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 100.adaptSize,
                  width: 100.adaptSize,
                  padding: EdgeInsets.all(1.h),
                  // decoration: AppDecoration.outlineGray
                  //     .copyWith(borderRadius: BorderRadiusStyle.circleBorder50),
                  child: CustomImageView(
                     // imagePath: ImageConstant.imgEllipse2,
                      height: 96.adaptSize,
                      width: 96.adaptSize,
                      radius: BorderRadius.circular(48.h),
                      alignment: Alignment.center))),
          // CustomImageView(
          //     imagePath: ImageConstant.imgBanner,
          //     height: 100.v,
          //     width: 375.h,
          //     alignment: Alignment.topCenter),
          Padding(
              padding: EdgeInsets.only(right: 131.h, bottom: 2.v),
              child: CustomIconButton(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  padding: EdgeInsets.all(3.h),
                  // decoration: IconButtonStyleHelper.fillOrange,
                  alignment: Alignment.bottomRight,
                  child: CustomImageView(
                  //    imagePath: ImageConstant.imgArcticonsPhotoEditor
                  ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 25.h, bottom: 50.v),
              child: CustomIconButton(
                  height: 30.adaptSize,
                  width: 30.adaptSize,
                  padding: EdgeInsets.all(3.h),
                //  decoration: IconButtonStyleHelper.fillOrange,
                  alignment: Alignment.bottomRight,
                  child: CustomImageView(
                     // imagePath: ImageConstant.imgArcticonsPhotoEditor
                  )))
        ]));
  }

  /// Section Widget
  Widget _buildUsernameField(BuildContext context) {
    return CustomTextFormField(
        width: 84.h,
        controller: usernameFieldController,
        hintText: "furkanuzunz",
        //borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
        filled: false);
  }

  /// Section Widget
  Widget _buildPasswordField(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 40.h, right: 43.h),
       // child:
        // CustomFloatingTextField(
        //     controller: passwordFieldController,
        //     labelText: "Password",
        //     labelStyle: theme.textTheme.titleLarge!,
        //     hintText: "Password",
        //     textInputType: TextInputType.visiblePassword,
        //     obscureText: true,
        //     alignment: Alignment.center)
    );
  }

  /// Section Widget
  Widget _buildCountryField(BuildContext context) {
    return CustomTextFormField(
        width: 84.h,
        controller: countryFieldController,
        hintText: "Türkiye",
        textInputAction: TextInputAction.done,
        contentPadding: EdgeInsets.symmetric(horizontal: 8.h),
        //  borderDecoration: TextFormFieldStyleHelper.underLineBlueGray,
        filled: false);
  }

  /// Section Widget
  Widget _buildEditProfileButton(BuildContext context) {
    return CustomElevatedButton(
        height: 40.v,
        width: 162.h,
        text: "Edit Profile",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 16.h),
            child: CustomImageView(
             //   imagePath: ImageConstant.imgCheckmark,
                height: 10.v,
                width: 16.h)),
        buttonTextStyle: theme.textTheme.labelLarge!,
        alignment: Alignment.center);
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  /// Common widget
  Widget _buildCityField(
    BuildContext context, {
    required String textValue,
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
                  child: Text(textValue,
                      style: theme.textTheme.bodyMedium!
                          .copyWith(color: appTheme.blueGray700)
                  )))
        ]));
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.createeventpagePage;
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
      case AppRoutes.createeventpagePage:
        return CreateeventpagePage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
