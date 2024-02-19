import 'package:ahmet_s_application2/core/app_export.dart';
import 'package:ahmet_s_application2/models/UserInfo.dart';
import 'package:ahmet_s_application2/presentation/createeventpage_page/createeventpage_page.dart';
import 'package:ahmet_s_application2/service/AuthService.dart';
import 'package:ahmet_s_application2/service/UserService.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_leading_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ahmet_s_application2/widgets/app_bar/custom_app_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_bottom_bar.dart';
import 'package:ahmet_s_application2/widgets/custom_elevated_button.dart';
import 'package:ahmet_s_application2/widgets/custom_icon_button.dart';
import 'package:ahmet_s_application2/widgets/custom_text_form_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


class EditprofileScereen extends StatefulWidget {




   EditprofileScereen();

  @override
  State<EditprofileScereen> createState() => _EditprofileScereenState();
}

class _EditprofileScereenState extends State<EditprofileScereen> {
  TextEditingController usernameFieldController = TextEditingController(text: "");
  TextEditingController surnameFieldController = TextEditingController(text: "");
  TextEditingController mailFieldController = TextEditingController(text: "");
  TextEditingController passwordFieldController = TextEditingController(text: "");
  TextEditingController nameFieldController = TextEditingController(text: "");
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  bool _isLoading = false;
  InfoUser user=InfoUser();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,()async{
      user=await  UserService().getUserInfoByEmail() ;
      ;
      setState(() {
        nameFieldController.text=user.name!;
        surnameFieldController.text=user.surname!;
        passwordFieldController.text=user.password!;
        mailFieldController.text=user.email!;
        usernameFieldController.text=user.username!;

      });
    });
  }




  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body:





    SizedBox(
                  width: SizeUtils.width,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child:  Form(
                      key: _formKey,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.h),
                          child:_isLoading ? Center(child: CircularProgressIndicator()) : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.perm_identity, size: 150.h),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'İsim',
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 130.h),
                                          child: Text(
                                            'Soyisim',
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                          ),
                                        ),

                                      ],
                                    ),

                                    SizedBox(height: 5.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            controller: nameFieldController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "The password is not be empty";
                                              }
                                            },
                                            //   initialValue: snapshot.data!.name!,
                                            decoration: InputDecoration(

                                              filled: true,
                                              fillColor: Colors.grey.shade50,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.h),
                                        Expanded(
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return "The password is not be empty";
                                              }
                                            },
                                            controller: surnameFieldController,
                                            // initialValue: snapshot.data!.surname!,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey.shade50,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mail',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 5.h),
                                    TextFormField(

                                      controller: mailFieldController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "The email is not be empty";
                                        } else if (EmailValidator.validate(value) == false) {
                                          return "Please enter a valid email";
                                        }
                                      },
                                      // initialValue: snapshot.data!.email!,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Şifre',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 5.h),
                                    TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "The password is not be empty";
                                        }
                                      },
                                      controller: passwordFieldController,

                                      //    initialValue: snapshot.data!.password!,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 35.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Kullanıcı Adı',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    SizedBox(height: 5.h),
                                    TextFormField(
                                      controller: usernameFieldController,

                                      // initialValue: snapshot.data!.username!,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade50,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //_buildBannerSection(context),
                              SizedBox(height: 10.h),
                              CustomElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    var logger =Logger();
                                    logger.d("yeni surname degeri"+nameFieldController.text);
                                    InfoUser newUser=InfoUser();
                                     newUser.name=nameFieldController.text;
                                    newUser.surname=surnameFieldController.text;
                                    newUser.username=usernameFieldController.text;
                                    newUser.password=passwordFieldController.text;
                                    newUser.email=mailFieldController.text;
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
                                      child: CustomImageView(
                                        //   imagePath: ImageConstant.imgCheckmark,
                                          height: 10.v,
                                          width: 16.h)),
                                  buttonTextStyle: theme.textTheme.labelLarge!,
                                  alignment: Alignment.center)

                            ],
                          ),
                        ),
                      ),


    ),

              ),


        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 29.h, right: 26.h),
          child: _buildBottomBar(context),
        ),
      ),
    );
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
  Widget _buildBottomBar(BuildContext context) {
    return CustomBottomBar(onChanged: (BottomBarEnum type) {
      Navigator.pushNamed(navigatorKey.currentContext!, getCurrentRoute(type));
    });
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
        return CreateEventPage();
      default:
        return DefaultWidget();
    }
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}






