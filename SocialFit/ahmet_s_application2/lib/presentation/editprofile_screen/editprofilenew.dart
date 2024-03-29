import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/presentation/award_page/award_page.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';

import '../../models/InfoUser.dart';
import '../../service/UserService.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

// ignore_for_file: must_be_immutable
class EditprofileScreen2 extends StatefulWidget {
  EditprofileScreen2();

  @override
  State<EditprofileScreen2> createState() => _EditprofileScreen2State();
}

class _EditprofileScreen2State extends State<EditprofileScreen2> {
  TextEditingController usernameFieldController =
      TextEditingController(text: "");
  TextEditingController surnameFieldController =
      TextEditingController(text: "");
  TextEditingController mailFieldController = TextEditingController(text: "");
  TextEditingController passwordFieldController =
      TextEditingController(text: "");
  TextEditingController nameFieldController = TextEditingController(text: "");
  TextEditingController cityCardController = TextEditingController();

  TextEditingController townvalueController = TextEditingController();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  InfoUser userInfo=InfoUser();
bool isGoogleSignIn=false;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    isGoogleSignIn=await AuthService().isGoogleSignIn();
    await Future.delayed(Duration.zero);
    userInfo = await UserService().getUserInfoByEmail();

    setState(() {
      nameFieldController.text = userInfo.name!;
      surnameFieldController.text = userInfo.surname!;
      passwordFieldController.text = userInfo.password!;
      mailFieldController.text = userInfo.email!;
      usernameFieldController.text = userInfo.username!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
     Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: FutureBuilder(
          future: UserService().getUserInfoByEmail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              final user = snapshot.data!;
              return SizedBox(
                width: SizeUtils.width,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          // _buildHorizontalScroll(context),
                          _buildBannerStack(context,userInfo.getProfilePicturePath()),
                          SizedBox(height:40.v),
                          _buildFifteen(context),
                          SizedBox(height: 22.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 22.h),
                              child: Text(
                                "Username",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.v),
                          _buildUsernameText(context),
                          SizedBox(height: 22.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 22.h),
                              child: Text(
                                "Email",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.v),
                          _buildEmailText(context),
                          SizedBox(height: 22.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 22.h),
                              child: Text(
                                "Password",
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ),
                          SizedBox(height: 3.v),
                          if ( isGoogleSignIn== false) ...[
                            _buildPasswordText(context),
                          ],
                          SizedBox(height: 22.v),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 22.h),
                            ),
                          ),
                          SizedBox(height: 3.v),
                          //_buildPhoneNumberText(context),
                          SizedBox(height: 22.v),
                          _buildTwentyFive(context),
                          SizedBox(height: 9.v),
                          _buildEditProfileButton(context),
                          SizedBox(height: 5.v),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 29.h, right: 26.h),
          child: _buildBottomBar(context),
        ),
      );

  }
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 54.h,
        leading: AppbarLeadingImage(
          onTap: (){

            Navigator.pop(context);

          },
          imagePath: ImageConstant.imgArrowLeft,
          margin: EdgeInsets.only(left: 30.h, top: 13.v, bottom: 16.v),
        ),
        actions: [
          AppbarTrailingImage(
              imagePath: ImageConstant.imgNotifications,
              margin: EdgeInsets.symmetric(horizontal: 28.h, vertical: 14.v))
        ],
        styleType: Style.bgFill);
  }

  /// Section Widget
  Widget _buildHorizontalScroll(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: IntrinsicWidth(
            child: SizedBox(
                height: 53.v,
                width: double.maxFinite,
                child: Stack(alignment: Alignment.center, children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: 53.v,
                          width: 390.h,
                          decoration: BoxDecoration(color: appTheme.amber500))),
                  Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 29.h, vertical: 13.v),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgArrowLeft,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                    margin: EdgeInsets.only(bottom: 2.v),
                                    onTap: () {
                                      onTapImgBackButton(context);
                                    }),
                                CustomImageView(
                                    imagePath: ImageConstant.imgNotifications,
                                    height: 25.adaptSize,
                                    width: 25.adaptSize)
                              ])))
                ]))));
  }

  /// Section Widget
  Widget _buildBannerStack(BuildContext context,String profile) {
    return SizedBox(
        height: 147.v,
        width: double.maxFinite,
        child: Stack(alignment: Alignment.topCenter, children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Container(
                    height: 200.adaptSize,
                    width: 100.adaptSize,
                    padding: EdgeInsets.only(top: 10.h),
                    decoration: AppDecoration.fillWhite
                        .copyWith(borderRadius: BorderRadiusStyle.roundedBorder5),
                    child: CustomImageView(
                        imagePath: profile,
                        height: 80,
                        width: 80,
                        radius: BorderRadius.circular(48.h),
                        alignment: Alignment.center)),
              )),
          CustomImageView(
              imagePath: ImageConstant.imgRectangle2,
              height: 90.v,
              width: 375.h,
              alignment: Alignment.topCenter),


        ]));
  }

  /// Section Widget
  Widget _buildNameCard(BuildContext context) {
    return CustomTextFormField(
        fillColor: HexColor("#CCC5B9"),
        textStyle: TextStyle(color: Colors.black),
        width: 170.h,
        controller: nameFieldController);
  }

  /// Section Widget
  Widget _buildSurnameCard(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 7.h),
            child: Column(children: [
              Text("Surname", style: theme.textTheme.titleSmall),
              SizedBox(height: 2.v),
              CustomTextFormField(
                textStyle: TextStyle(color: Colors.black),
                fillColor: HexColor("#CCC5B9"),
                width: 170.h,
                controller: surnameFieldController,
              )
            ])));
  }

  /// Section Widget
  Widget _buildFifteen(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
              child: Padding(
                  padding: EdgeInsets.only(right: 7.h),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(left: 58.h),
                            child: Text("Name",
                                style: theme.textTheme.titleSmall)),
                        SizedBox(height: 2.v),
                        _buildNameCard(context)
                      ]))),
          _buildSurnameCard(context)
        ]));
  }

  /// Section Widget
  Widget _buildUsernameText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomTextFormField(
          fillColor: HexColor("#CCC5B9"),
          textStyle: TextStyle(color: Colors.black),
          controller: usernameFieldController,
        ));
  }

  /// Section Widget
  Widget _buildEmailText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomTextFormField(
            fillColor: HexColor("#CCC5B9"),
            textStyle: TextStyle(color: Colors.black),
            controller: mailFieldController,
            textInputType: TextInputType.emailAddress));
  }

  /// Section Widget
  Widget _buildPasswordText(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: CustomTextFormField(
            textStyle: TextStyle(color: Colors.black),
            hintStyle: TextStyle(color: Colors.black),
            fillColor: HexColor("#CCC5B9"),
            controller: passwordFieldController,
            textInputType: TextInputType.visiblePassword,
            obscureText: true));
  }

  /// Section Widget

  /// Section Widget
  Widget _buildCityCard(BuildContext context) {
    return CustomTextFormField(
      textStyle: TextStyle(color: Colors.black),
      fillColor: HexColor("#CCC5B9"),
      width: 170.h,
      controller: cityCardController,
    );
  }

  /// Section Widget
  Widget _buildTownCard(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: EdgeInsets.only(left: 7.h),
            child: Column(children: [
              Text("Town", style: theme.textTheme.titleSmall),
              SizedBox(height: 2.v),
              CustomTextFormField(
                  textStyle: TextStyle(color: Colors.black),
                  fillColor: HexColor("#CCC5B9"),
                  width: 170.h,
                  controller: townvalueController,
                  textInputAction: TextInputAction.done)
            ])));
  }

  /// Section Widget
  Widget _buildTwentyFive(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [

        ]));
  }

  /// Section Widget
  Widget _buildEditProfileButton(BuildContext context) {
    return CustomElevatedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          var logger = Logger();
          logger.d("yeni surname degeri" + nameFieldController.text);
          InfoUser newUser = InfoUser();
          newUser.name = nameFieldController.text;
          newUser.surname = surnameFieldController.text;
          newUser.username = usernameFieldController.text;
          newUser.password = passwordFieldController.text;
          newUser.email = mailFieldController.text;
          await UserService().updateUser(newUser);
          setState(() {
            _isLoading = false;
          });
        },
        height: 40.v,
        width: 162.h,
        text: "Edit Profile",
        leftIcon: Container(
            margin: EdgeInsets.only(right: 16.h),
            child: Icon(Icons.check,size: 30,color: Colors.black,)
        ),
        buttonTextStyle: theme.textTheme.labelLarge!,
      buttonStyle: ElevatedButton.styleFrom(
        primary:HexColor("EB5E28"), // Arka plan rengi siyah olarak ayarlandı.
      ),
    
    );
    
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.awardScreen;
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
      case AppRoutes.awardScreen:
        return AwardPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates back to the previous screen.
  onTapImgBackButton(BuildContext context) {
    Navigator.pop(context);
  }
}
